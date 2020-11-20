/**
 * This file is part of SIRS-Digues 2.
 *
 * Copyright (C) 2016, FRANCE-DIGUES,
 * 
 * SIRS-Digues 2 is free software: you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the Free
 * Software Foundation, either version 3 of the License, or (at your option) any
 * later version.
 *
 * SIRS-Digues 2 is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
 * details.
 *
 * You should have received a copy of the GNU General Public License along with
 * SIRS-Digues 2. If not, see <http://www.gnu.org/licenses/>
 */
package fr.sirs.importer.v2.mapper;

import com.healthmarketscience.jackcess.Row;
import com.healthmarketscience.jackcess.Table;
import fr.sirs.core.SirsCoreRuntimeException;
import fr.sirs.importer.AccessDbImporterException;
import fr.sirs.importer.v2.AbstractImporter;
import fr.sirs.importer.v2.CorruptionLevel;
import fr.sirs.importer.v2.ErrorReport;
import fr.sirs.importer.v2.ImportContext;
import fr.sirs.util.property.Reference;
import java.beans.BeanInfo;
import java.beans.IntrospectionException;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import java.util.function.BiConsumer;
import java.util.function.Function;
import javax.annotation.PostConstruct;
import org.apache.sis.util.ArgumentChecks;
import org.apache.sis.util.Numbers;
import org.apache.sis.util.UnconvertibleObjectException;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * A general mapper which will try to convert rows accordingly to user parameters.
 * @author Alexis Manin (Geomatys)
 * @param <T> Target type of the objects which can be filled by current implementation.
 */
public abstract class GenericMapperSpi<T> implements MapperSpi<T> {

    @Autowired
    protected ImportContext context;

    protected final Class<T> outputClass;

    /**
     * Operators used by mappers to import data. Build at {@link PostConstruct} phase.
     */
    private HashMap<String, BiConsumer<Row, T>> consumers;

    public GenericMapperSpi(final Class outputClass) throws IntrospectionException {
        ArgumentChecks.ensureNonNull("Output class", outputClass);
        this.outputClass = outputClass;
    }

    /**
     * @return Map of columns to put in target objects. Key is the column name,
     * and value the name of the corresponding property in output class.
     */
    public abstract Map<String, String> getBindings();

    /**
     * Ensure current output class is compatible with given bindings.
     *
     * @throws IntrospectionException If we failed analyzing output class.
     * @throws IllegalArgumentException If given output class is incompatible
     * with input bindings.
     */
    private void createBindings() {
        final BeanInfo beanInfo;
        try {
            beanInfo = Introspector.getBeanInfo(outputClass);
        } catch (IntrospectionException ex) {
            throw new IllegalArgumentException("Mapper target class cannot be analyzed : "+outputClass.getCanonicalName());
        }

        final HashMap<String, PropertyDescriptor> properties = mapByName(beanInfo.getPropertyDescriptors());
        final Map<String, String> bindings = getBindings();
        consumers = new HashMap<>(bindings.size());
        for (final Map.Entry<String, String> binding : bindings.entrySet()) {
            final String propName = binding.getValue();
            PropertyDescriptor found = properties.get(propName);
            if (found == null) {
                throw new IllegalArgumentException("No property " + propName + " found in class " + outputClass.getCanonicalName());
            } else {
                consumers.put(binding.getKey(), createConsumer(binding.getKey(), found));
            }
        }
    }

    public HashMap<String, BiConsumer<Row, T>> getConsumers() {
        if (consumers == null) {
            createBindings();
        }
        return consumers;
    }

    @Override
    public Optional<Mapper<T>> configureInput(Table inputType) throws IllegalStateException {
        final Set<String> keySet = getBindings().keySet();
        if (MapperSpi.checkColumns(inputType, keySet.toArray(new String[keySet.size()]))) {
            getConsumers();
            return Optional.of(new GenericMapper(inputType));
        }
        return Optional.empty();
    }

    @Override
    public Class<T> getOutputClass() {
        return outputClass;
    }

    /**
     * Put property descriptors in a map, to ensure fast retrieval using their
     * name.
     *
     * @param descriptors to sort according to their name.
     * @return A map whose keys are property names, and value is the
     * corresponding property descriptor.
     */
    public static HashMap<String, PropertyDescriptor> mapByName(final PropertyDescriptor... descriptors) {
        final HashMap<String, PropertyDescriptor> result = new HashMap<>();
        for (final PropertyDescriptor p : descriptors) {
            result.put(p.getName(), p);
        }
        return result;
    }

    private BiConsumer<Row, T> createConsumer(String columnName, PropertyDescriptor targetProperty) {
        final Optional<BiConsumer<Row, T>> registered;
        registered = context.getConsumer(outputClass, targetProperty, columnName);
        if (registered.isPresent()) {
            return registered.get();
        }

        // We did not find any consumer registered. We will make a fallback binding.
        final Method readMethod = targetProperty.getReadMethod();
        if (readMethod == null) {
            throw new IllegalArgumentException("Unreadable property " + targetProperty.getName() + " from class " + outputClass.getCanonicalName());
        } else {
            readMethod.setAccessible(true);
        }
        // Check if we've got a real data or a link.
        final Reference ref = readMethod.getAnnotation(Reference.class);
        final Class<?> refClass;
        if (ref != null) {
            refClass = ref.ref();
        } else {
            refClass = null;
        }

        final Class<?> targetClass = targetProperty.getPropertyType();

        /* We create a converter to transform object returned from ms-access into
         * one of the same type as output property. If we've found out that target
         * property is a link, our converter will try to get back data pointed by
         * the input column value (which should be a foreign key).
         * Otherwise, we use standard SIS converters.
         */
        final Function converter;
        if (refClass != null) {
            final AbstractImporter tmpImporter = context.importers.get(refClass);
            converter = (input) -> {
                try {
                    return tmpImporter.getImportedId(input);
                } catch (IOException | AccessDbImporterException e) {
                    throw new UnconvertibleObjectException("Cannot find object referenced by given key " + input);
                }
            };
        } else {
            converter = (input) -> context.convertData(input, Numbers.primitiveToWrapper(targetProperty.getPropertyType()));
        }

        /**
         * Finally, we create the operator which will affect our property. If output
         * property is a collection, we simply add into. otherwise, we try to invoke
         * its write method.
         */
        if (Collection.class.isAssignableFrom(targetClass)) {
            return (input, output) -> {
                final Object inputValue = input.get(columnName);
                if (inputValue != null) {
                    try {
                        ((Collection) readMethod.invoke(output)).add(converter.apply(inputValue));
                    } catch (IllegalAccessException | InvocationTargetException ex) {
                        throw new SirsCoreRuntimeException("Invalid reflection statement !", ex);
                    }
                }
            };
        } else {
            final Method writeMethod = targetProperty.getWriteMethod();
            if (writeMethod == null) {
                throw new IllegalArgumentException("Unmodifiable property " + targetProperty.getName() + " from class " + outputClass.getCanonicalName());
            }
            writeMethod.setAccessible(true);
            return (input, output) -> {
                final Object inputValue = input.get(columnName);
                if (inputValue != null && !ImportContext.NULL_STRING.equals(inputValue)) {
                    try {
                        writeMethod.invoke(output, converter.apply(inputValue));
                    } catch (IllegalAccessException | InvocationTargetException ex) {
                        throw new SirsCoreRuntimeException("Invalid reflection statement !", ex);
                    }
                }
            };
        }
    }

    /**
     * Return a list of bindings to apply after standard registered bindings.
     * @return List of extra operations to perform, or an empty collection.
     */
    protected Collection<BiConsumer<Row, T>> getExtraBindings() {
        return Collections.EMPTY_LIST;
    }

    private class GenericMapper extends AbstractMapper<T> {

        public GenericMapper(Table table) {
            super(table);
        }

        @Override
        public void map(Row input, T output) throws IllegalStateException, IOException, AccessDbImporterException {
            final Set<Map.Entry<String, BiConsumer<Row, T>>> consumerSet = getConsumers().entrySet();
            for(final Map.Entry<String, BiConsumer<Row, T>> consumer : consumerSet) {
                try {
                    consumer.getValue().accept(input, output);
                } catch (IllegalArgumentException | IllegalStateException e) {
                    context.reportError(new ErrorReport(e, input, tableName, consumer.getKey(), output, getBindings().get(consumer.getKey()), "Cannot map a field.", CorruptionLevel.FIELD));
                }
            }

            for(final BiConsumer<Row, T> consumer : getExtraBindings()) {
                try {
                    consumer.accept(input, output);
                } catch (IllegalArgumentException | IllegalStateException e) {
                    context.reportError(new ErrorReport(e, input, tableName, null, output, null, "Cannot bind some row data", CorruptionLevel.FIELD));
                }
            }
        }
    }
}
