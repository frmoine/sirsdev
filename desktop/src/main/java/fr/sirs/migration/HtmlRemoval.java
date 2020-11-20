package fr.sirs.migration;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectReader;
import fr.sirs.core.SirsCore;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicLong;
import java.util.function.Consumer;
import java.util.logging.Level;
import java.util.regex.Pattern;
import javafx.concurrent.Task;
import org.apache.sis.util.ArgumentChecks;
import org.ektorp.CouchDbConnector;
import org.ektorp.DocumentOperationResult;
import org.ektorp.StreamingViewResult;
import org.ektorp.ViewQuery;
import org.ektorp.ViewResult;
import org.jsoup.parser.Parser;
import org.jsoup.nodes.Node;
import org.jsoup.nodes.TextNode;
import org.jsoup.select.NodeTraversor;
import org.jsoup.select.NodeVisitor;

/**
 *
 * @author Alexis Manin (Geomatys)
 */
public class HtmlRemoval extends Task {

    private static final Pattern NEW_LINE_MARK = Pattern.compile("(br)|(h\\d)|p|(d(d|t))|(tr)", Pattern.CASE_INSENSITIVE);

    private static final int BULK_SIZE = 100;

    final CouchDbConnector connector;
    final Set<String> fields;
    final boolean recursive;

    final ArrayBlockingQueue bulkQueue;

    final AtomicLong updateCount;

    public HtmlRemoval(final CouchDbConnector connector, final String... fieldsToUpdate) {
        this(connector, true, fieldsToUpdate);
    }

    public HtmlRemoval(final CouchDbConnector connector, final boolean recursive, final String... fieldsToUpdate) {
        ArgumentChecks.ensureNonNull("Database connector", connector);
        ArgumentChecks.ensureNonNull("Fields to update", fieldsToUpdate);
        ArgumentChecks.ensureStrictlyPositive("Number of fields to update", fieldsToUpdate.length);
        this.connector = connector;
        this.recursive = recursive;
        fields = new HashSet<>(Arrays.asList(fieldsToUpdate));

        bulkQueue = new ArrayBlockingQueue<>(BULK_SIZE);
        updateCount = new AtomicLong();
    }

    @Override
    protected Object call() throws Exception {
        updateTitle("Suppression des balises HTML");
        final ObjectReader reader = new ObjectMapper().reader(Map.class);
        final ViewQuery allDocs = new ViewQuery().allDocs().includeDocs(true);

        final ExecutorService executor = Executors.newCachedThreadPool();

        updateMessage("Connexion à la base de données");
        try (StreamingViewResult result = connector.queryForStreamingView(allDocs)) {
            int docCount = result.getTotalRows();
            final Consumer progressIncrementer;
            if (docCount < 0) {
                progressIncrementer = in -> {};
                updateProgress(-1, -1);
            } else {
                final AtomicInteger currentProgress = new AtomicInteger();
                if (docCount <= 100) {
                    progressIncrementer = in -> updateProgress(currentProgress.incrementAndGet(), docCount);
                } else {
                    progressIncrementer = in -> updateProgress(currentProgress.incrementAndGet() * 100 / docCount, 100);
                }
            }

            updateMessage("Analyse des éléments/Suppression des textes HTML");
            final Iterator<ViewResult.Row> it = result.iterator();
            while (it.hasNext()) {
                final ViewResult.Row next = it.next();
                final Map doc = reader.readValue(next.getDocAsNode());

                CompletableFuture.supplyAsync(() -> removeHtml(doc), executor)
                        .thenApply(this::addToBulk)
                        .thenAccept(this::consumeBulkErrors)
                        .thenAccept(progressIncrementer)
                        .whenComplete(this::checkError);
            }
        } catch (Exception|Error e) {
            try {
                executor.shutdownNow();
            } catch (Throwable bis) {
                e.addSuppressed(bis);
            }

            throw e;
        }

        executor.shutdown();
        if (executor.awaitTermination(1, TimeUnit.DAYS)) {
            updateMessage("Mise à jour de la base de données");
            final ArrayList bulk = new ArrayList(BULK_SIZE);
            bulkQueue.drainTo(bulk);
            consumeBulkErrors(executeBulk(bulk));
        } else {
            throw new RuntimeException("upgrade takes too much time to complete.");
        }

        SirsCore.LOGGER.info(String.format("HTML REMOVAL : %d documents updated.", updateCount.get()));
        return true;
    }

    /**
     * Add a document to the list of objects to update in a further bulk operation.
     * Note that if inner bulk buffer is full, a bulk operation will be triggered
     * immediately.
     *
     * @param doc Document to update.
     * @return Report about updates which have failed. Only if bulk buffer was full.
     */
    protected List<DocumentOperationResult> addToBulk(final Map doc) {
        if (doc == null)
            return Collections.EMPTY_LIST;

        boolean over = false;
        while (!over) {
            over = bulkQueue.offer(doc);
            if (!over) {
                final ArrayList bulk = new ArrayList(BULK_SIZE + 1);
                bulkQueue.drainTo(bulk);
                if (!bulk.isEmpty()) {
                    return executeBulk(bulk);
                }
            }
        }

        return Collections.EMPTY_LIST;
    }

    private List<DocumentOperationResult> executeBulk(final Collection bulk) {
        if (!bulk.isEmpty()) {
            final List<DocumentOperationResult> errors = connector.executeBulk(bulk);
            updateCount.addAndGet(bulk.size() - errors.size());
            return errors;
        }

        return Collections.EMPTY_LIST;
    }

    protected void consumeBulkErrors(final Collection<DocumentOperationResult> errors) {
        for (final DocumentOperationResult r : errors) {
            SirsCore.LOGGER.log(Level.WARNING, format(r));
        }
    }

    protected void checkError(final Object possibleResult, final Object possibleError) {
        if (possibleError instanceof Exception) {
            SirsCore.LOGGER.log(Level.WARNING, "An update has gone wrong", possibleError);
        } else if (possibleError instanceof Throwable) {
            setException((Throwable)possibleError);
            cancel();
        }
    }

    protected String format(final DocumentOperationResult r) {
        return String.format(
                "A document update has failed.%n"
                        + "Id : %s%n"
                        + "Revision : %s%n"
                        + "Error : %s%n"
                        + "Reason : %s%n",
                r.getId(), r.getRevision(), r.getError(), r.getReason()
        );
    }

    protected String removeHtml(String htmlText) {
        htmlText = htmlText.trim();
        if (htmlText.isEmpty())
            return htmlText;

        final Formatter formatter = new Formatter();
        new NodeTraversor(formatter)
                .traverse(Parser.parse(htmlText, ""));
        return formatter.toString();
    }

    /**
     * Remove all html content from this document. Note that only the fields
     * passed at built will be analyzed/updated.
     *
     * @param document The structure to browse/update.
     * @return The same document (no copy), after update. If no change has been
     * done on the object, a null value is returned.
     */
    protected Map removeHtml(final Map document) {
        final boolean change;
        if (recursive)
            change = recursiveStrategy(document);
        else
            change = flatStrategy(document);
        return change? document : null;
    }

    /**
     * Browse document and ALL its sub-documents in searcb for html fields.
     * @param document The root document to analyze.
     * @return True if input document has been modified, false otherwise
     */
    protected boolean recursiveStrategy(final Map<String, Object> document) {
        boolean change = false;
        Set<? extends Map.Entry<String, Object>> entries = document.entrySet();
        for (final Map.Entry<String, Object> entry : entries) {
            final Object value = entry.getValue();
            if (value instanceof Map) {
                change |= recursiveStrategy((Map) value);
            } else if (value instanceof String && fields.contains(entry.getKey())) {
                final String removeHtml = removeHtml((String) value);
                if (!removeHtml.equals(value)) {
                    SirsCore.LOGGER.info(String.format("%noriginal: |%s|%nrefactored: |%s|", value, removeHtml));
                    entry.setValue(removeHtml);
                    change = true;
                }
            }
        }

        return change;
    }

    /**
     * Take the queried fields of a document to update them. We will browse sub-
     * documents only for analyzed fields which are objects. It means that if all
     * fields to treat are simple values, no recursive analysis is done. If one
     * field is an object, we'll browse only this subdocument. And if one of the
     * fields we must update in it is a sub-document, we will analyze it but
     * won't check for other sub-structures in the document.
     *
     * @param document The document to update.
     * @return True if input document has been modified, false otherwise
     */
    protected boolean flatStrategy(final Map<String, Object> document) {
        boolean change = false;
        for (final String key : fields) {
            final Object value = document.get(key);
            if (value instanceof String) {
                final String changedField = removeHtml((String)value);
                if (!changedField.equals(value)) {
                    SirsCore.LOGGER.fine(String.format("%noriginal: |%s|%nrefactored: |%s|", value, changedField));
                    document.put(key, changedField);
                    change = true;
                }
            } else if (value instanceof Map) {
                change |= flatStrategy((Map)value);
            }
        }

        return change;
    }

    private static class Formatter implements NodeVisitor {

        /**
         * Contains refactored text.
         */
        private final StringBuilder formatted = new StringBuilder();

        @Override
        public void head(Node node, int depth) {
            String name = node.nodeName();
            if (node instanceof TextNode)
                formatted.append(((TextNode) node).getWholeText());
            else if (name.equals("li"))
                formatted.append(System.lineSeparator()).append(" - ");
            else if (NEW_LINE_MARK.matcher(name).matches())
                formatted.append(System.lineSeparator());
        }

        @Override
        public void tail(Node node, int depth) {
            String name = node.nodeName();
            if (NEW_LINE_MARK.matcher(name).matches())
                formatted.append(System.lineSeparator());
            else if (name.equals("a"))
                formatted.append(" (lien : ").append(node.attr("href")).append(")");
        }

        @Override
        public String toString() {
            return formatted.toString();
        }
    }
}
