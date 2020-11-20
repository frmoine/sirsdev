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
package fr.sirs;

import com.vividsolutions.jts.geom.Geometry;
import static fr.sirs.SIRS.CRS_WGS84;
import static fr.sirs.SIRS.DATE_DEBUT_FIELD;
import static fr.sirs.SIRS.DATE_FIN_FIELD;
import static fr.sirs.SIRS.DEFAULT_TRONCON_GEOM_WGS84;
import static fr.sirs.SIRS.SIRSDOCUMENT_REFERENCE;
import fr.sirs.core.SirsCore;
import static fr.sirs.core.SirsCore.MODEL_PACKAGE;
import fr.sirs.core.TronconUtils;
import fr.sirs.core.component.DatabaseRegistry;
import fr.sirs.core.component.TronconDigueRepository;
import fr.sirs.core.model.AbstractPositionDocument;
import fr.sirs.core.model.AbstractPositionDocumentAssociable;
import fr.sirs.core.model.ArticleJournal;
import fr.sirs.core.model.BorneDigue;
import fr.sirs.core.model.Crete;
import fr.sirs.core.model.Desordre;
import fr.sirs.core.model.Deversoir;
import fr.sirs.core.model.Digue;
import fr.sirs.core.model.DocumentGrandeEchelle;
import fr.sirs.core.model.EchelleLimnimetrique;
import fr.sirs.core.model.Element;
import fr.sirs.core.model.Epi;
import fr.sirs.core.model.Fondation;
import fr.sirs.core.model.GardeTroncon;
import fr.sirs.core.model.LabelMapper;
import fr.sirs.core.model.LaisseCrue;
import fr.sirs.core.model.LargeurFrancBord;
import fr.sirs.core.model.LigneEau;
import fr.sirs.core.model.Marche;
import fr.sirs.core.model.MonteeEaux;
import fr.sirs.core.model.OuvertureBatardable;
import fr.sirs.core.model.OuvrageFranchissement;
import fr.sirs.core.model.OuvrageHydrauliqueAssocie;
import fr.sirs.core.model.OuvrageParticulier;
import fr.sirs.core.model.OuvrageRevanche;
import fr.sirs.core.model.OuvrageTelecomEnergie;
import fr.sirs.core.model.OuvrageVoirie;
import fr.sirs.core.model.PiedDigue;
import fr.sirs.core.model.PositionDocument;
import fr.sirs.core.model.PositionProfilTravers;
import fr.sirs.core.model.Positionable;
import fr.sirs.core.model.Prestation;
import fr.sirs.core.model.Preview;
import fr.sirs.core.model.ProfilLong;
import fr.sirs.core.model.ProfilTravers;
import fr.sirs.core.model.ProprieteTroncon;
import fr.sirs.core.model.RapportEtude;
import fr.sirs.core.model.RefTypeDesordre;
import fr.sirs.core.model.ReseauHydrauliqueCielOuvert;
import fr.sirs.core.model.ReseauHydrauliqueFerme;
import fr.sirs.core.model.ReseauTelecomEnergie;
import fr.sirs.core.model.SIRSDocument;
import fr.sirs.core.model.SommetRisberme;
import fr.sirs.core.model.StationPompage;
import fr.sirs.core.model.SystemeEndiguement;
import fr.sirs.core.model.TalusDigue;
import fr.sirs.core.model.TalusRisberme;
import fr.sirs.core.model.TronconDigue;
import fr.sirs.core.model.VoieAcces;
import fr.sirs.core.model.VoieDigue;
import fr.sirs.digue.DiguesTab;
import fr.sirs.migration.HtmlRemoval;
import fr.sirs.migration.upgrade.v2and23.UpgradeLink1NtoNN;
import fr.sirs.migration.upgrade.v2and23.UpgradePrestationsCoordinates;
import fr.sirs.migration.upgrade.v2and23.Upgrades1NtoNNSupported;
import fr.sirs.theme.ContactsTheme;
import fr.sirs.theme.DocumentTheme;
import fr.sirs.theme.EvenementsHydrauliquesTheme;
import fr.sirs.theme.GlobalPrestationTheme;
import fr.sirs.theme.PositionDocumentTheme;
import fr.sirs.theme.Theme;
import fr.sirs.theme.TronconTheme;
import fr.sirs.util.FXFreeTab;
import java.awt.Color;
import java.beans.PropertyDescriptor;
import java.io.IOException;
import java.io.InputStream;
import java.net.URISyntaxException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.function.Function;
import java.util.logging.Level;
import javafx.concurrent.Task;
import javafx.event.ActionEvent;
import javafx.scene.control.ComboBox;
import javafx.scene.control.MenuItem;
import javafx.scene.image.Image;
import org.apache.sis.measure.Units;
import org.apache.sis.referencing.CRS;
import org.apache.sis.referencing.CommonCRS;
import org.apache.sis.storage.DataStoreException;
import org.apache.sis.util.ArraysExt;
import org.ektorp.CouchDbConnector;
import org.geotoolkit.cql.CQLException;
import org.geotoolkit.data.FeatureCollection;
import org.geotoolkit.data.FeatureStore;
import org.geotoolkit.data.bean.BeanFeature;
import org.geotoolkit.data.bean.BeanFeatureSupplier;
import org.geotoolkit.data.bean.BeanStore;
import org.geotoolkit.data.query.QueryBuilder;
import org.geotoolkit.display2d.GO2Utilities;
import org.geotoolkit.display2d.ext.graduation.GraduationSymbolizer;
import org.geotoolkit.filter.DefaultLiteral;
import org.geotoolkit.geometry.jts.JTS;
import org.geotoolkit.map.FeatureMapLayer;
import org.geotoolkit.map.MapBuilder;
import org.geotoolkit.map.MapItem;
import org.geotoolkit.map.MapLayer;
import org.geotoolkit.style.MutableFeatureTypeStyle;
import org.geotoolkit.style.MutableRule;
import org.geotoolkit.style.MutableStyle;
import org.geotoolkit.style.MutableStyleFactory;
import org.geotoolkit.style.RandomStyleBuilder;
import org.geotoolkit.style.StyleConstants;
import static org.geotoolkit.style.StyleConstants.DEFAULT_ANCHOR_POINT;
import static org.geotoolkit.style.StyleConstants.DEFAULT_DESCRIPTION;
import static org.geotoolkit.style.StyleConstants.DEFAULT_DISPLACEMENT;
import static org.geotoolkit.style.StyleConstants.DEFAULT_FILL_COLOR;
import static org.geotoolkit.style.StyleConstants.DEFAULT_FONT;
import static org.geotoolkit.style.StyleConstants.DEFAULT_GRAPHIC_ROTATION;
import static org.geotoolkit.style.StyleConstants.LITERAL_ONE_FLOAT;
import static org.geotoolkit.style.StyleConstants.LITERAL_ZERO_FLOAT;
import static org.geotoolkit.style.StyleConstants.STROKE_CAP_BUTT;
import static org.geotoolkit.style.StyleConstants.STROKE_CAP_ROUND;
import static org.geotoolkit.style.StyleConstants.STROKE_CAP_SQUARE;
import static org.geotoolkit.style.StyleConstants.STROKE_JOIN_BEVEL;
import org.opengis.filter.Filter;
import org.opengis.filter.FilterFactory2;
import org.opengis.filter.FilterVisitor;
import org.opengis.filter.expression.Expression;
import org.opengis.geometry.MismatchedDimensionException;
import org.opengis.referencing.operation.TransformException;
import org.opengis.style.Fill;
import org.opengis.style.Graphic;
import org.opengis.style.GraphicStroke;
import org.opengis.style.GraphicalSymbol;
import org.opengis.style.LineSymbolizer;
import org.opengis.style.Mark;
import org.opengis.style.PointSymbolizer;
import org.opengis.style.Stroke;
import org.opengis.style.TextSymbolizer;
import org.opengis.util.FactoryException;
import org.opengis.util.GenericName;

/**
 *
 * @author Johann Sorel (Geomatys)
 */
public class CorePlugin extends Plugin {

    public static final String TRONCON_LAYER_NAME = "Tronçons";
    public static final String BORNE_LAYER_NAME = "Bornes";
    private static final FilterFactory2 FF = GO2Utilities.FILTER_FACTORY;
    private static final MutableStyleFactory SF = GO2Utilities.STYLE_FACTORY;

    /**
     * Expression renvoyant un segment à partir des positions ponctuelles
     * de début et de fin de l'élément {@link Positionable} sur lequel
     * l'expression s'applique.
     */
    private static final PointsToLine POINTS_TO_LINE  = new PointsToLine(FF.property(SirsCore.POSITION_DEBUT_FIELD),  FF.property(SirsCore.POSITION_FIN_FIELD));

    /**
     * Expression renvoyant le centroïd du segment formé par les positions
     * ponctuelles de début et de fin de l'élément {@link Positionable} sur
     * lequel l'expression s'applique.
     */
    private static final Expression POINTS_TO_CENTER = new PointsToCenter(POINTS_TO_LINE);

    /**
     * Plugin correspondant au desktop et au launcher.
     */
    public static final String NAME = "core";

    private static final Class[] VALID_CLASSES = new Class[]{
        byte.class,
        short.class,
        int.class,
        long.class,
        float.class,
        double.class,
        boolean.class,
        Boolean.class,
        Byte.class,
        Short.class,
        Integer.class,
        Long.class,
        Float.class,
        Double.class,
        String.class,
        LocalDateTime.class,
        LocalDate.class
    };

    public static final org.geotoolkit.data.bean.Predicate<PropertyDescriptor> MAP_PROPERTY_PREDICATE =
            (PropertyDescriptor t) -> {
                final Class c = t.getReadMethod().getReturnType();
                return ArraysExt.contains(VALID_CLASSES, c) || Geometry.class.isAssignableFrom(c);
            };

    private final HashMap<Class, BeanFeatureSupplier> suppliers = new HashMap<>();

    public CorePlugin() {
        name = NAME;
    }

    private synchronized void loadDataSuppliers() {
        suppliers.clear();
        final TronconDigueRepository repository = (TronconDigueRepository) getSession().getRepositoryForClass(TronconDigue.class);

        final Function<Class<? extends Element>, StructBeanSupplier> getDefaultSupplierForClass = (Class<? extends Element> c) ->{
            return new StructBeanSupplier(c, () -> getSession().getRepositoryForClass(c).getAllStreaming());
        };

        //troncons
        suppliers.put(TronconDigue.class, new StructBeanSupplier(TronconDigue.class,() -> repository::getAllLightIterator));

        //bornes
        suppliers.put(BorneDigue.class, getDefaultSupplierForClass.apply(BorneDigue.class));

        //structures
        suppliers.put(Crete.class, getDefaultSupplierForClass.apply(Crete.class));
        suppliers.put(OuvrageRevanche.class, getDefaultSupplierForClass.apply(OuvrageRevanche.class));
        suppliers.put(TalusDigue.class, getDefaultSupplierForClass.apply(TalusDigue.class));
        suppliers.put(SommetRisberme.class, getDefaultSupplierForClass.apply(SommetRisberme.class));
        suppliers.put(TalusRisberme.class, getDefaultSupplierForClass.apply(TalusRisberme.class));
        suppliers.put(PiedDigue.class, getDefaultSupplierForClass.apply(PiedDigue.class));
        suppliers.put(Fondation.class, getDefaultSupplierForClass.apply(Fondation.class));
        suppliers.put(Epi.class, getDefaultSupplierForClass.apply(Epi.class));
        suppliers.put(Deversoir.class, getDefaultSupplierForClass.apply(Deversoir.class));

        // Franc-bords
        suppliers.put(LargeurFrancBord.class, getDefaultSupplierForClass.apply(LargeurFrancBord.class));

        // Réseaux de voirie
        suppliers.put(VoieAcces.class, getDefaultSupplierForClass.apply(VoieAcces.class));
        suppliers.put(OuvrageFranchissement.class, getDefaultSupplierForClass.apply(OuvrageFranchissement.class));
        suppliers.put(OuvertureBatardable.class, getDefaultSupplierForClass.apply(OuvertureBatardable.class));
        suppliers.put(VoieDigue.class, getDefaultSupplierForClass.apply(VoieDigue.class));
        suppliers.put(OuvrageVoirie.class, getDefaultSupplierForClass.apply(OuvrageVoirie.class));

        // Réseaux et ouvrages
        suppliers.put(StationPompage.class, getDefaultSupplierForClass.apply(StationPompage.class));
        suppliers.put(ReseauHydrauliqueFerme.class, getDefaultSupplierForClass.apply(ReseauHydrauliqueFerme.class));
        suppliers.put(OuvrageHydrauliqueAssocie.class, getDefaultSupplierForClass.apply(OuvrageHydrauliqueAssocie.class));
        suppliers.put(ReseauTelecomEnergie.class, getDefaultSupplierForClass.apply(ReseauTelecomEnergie.class));
        suppliers.put(OuvrageTelecomEnergie.class, getDefaultSupplierForClass.apply(OuvrageTelecomEnergie.class));
        suppliers.put(ReseauHydrauliqueCielOuvert.class, getDefaultSupplierForClass.apply(ReseauHydrauliqueCielOuvert.class));
        suppliers.put(OuvrageParticulier.class, getDefaultSupplierForClass.apply(OuvrageParticulier.class));
        suppliers.put(EchelleLimnimetrique.class, getDefaultSupplierForClass.apply(EchelleLimnimetrique.class));

        // Désordres
        suppliers.put(Desordre.class, getDefaultSupplierForClass.apply(Desordre.class));

        // Prestations
        suppliers.put(Prestation.class, getDefaultSupplierForClass.apply(Prestation.class));

        // Mesures d'évènements
        suppliers.put(LaisseCrue.class, getDefaultSupplierForClass.apply(LaisseCrue.class));
        suppliers.put(MonteeEaux.class, getDefaultSupplierForClass.apply(MonteeEaux.class));
        suppliers.put(LigneEau.class, getDefaultSupplierForClass.apply(LigneEau.class));

        // Documents positionnés
        suppliers.put(PositionDocument.class, getDefaultSupplierForClass.apply(PositionDocument.class));
        suppliers.put(PositionProfilTravers.class, getDefaultSupplierForClass.apply(PositionProfilTravers.class));
        suppliers.put(ProfilLong.class, getDefaultSupplierForClass.apply(ProfilLong.class));

        // Propriétés et gardiennages de troncons
        suppliers.put(ProprieteTroncon.class, getDefaultSupplierForClass.apply(ProprieteTroncon.class));
        suppliers.put(GardeTroncon.class, getDefaultSupplierForClass.apply(GardeTroncon.class));
    }

    @Override
    public synchronized List<MapItem> getMapItems() {
        final List<MapItem> items = new ArrayList<>();

        final MapItem sirsGroup = MapBuilder.createItem();
        sirsGroup.setName("Description des ouvrages");
        sirsGroup.setUserProperty(Session.FLAG_SIRSLAYER, Boolean.TRUE);
        items.add(sirsGroup);

        try{
            final Map<String,String> nameMap = new HashMap<>();
            for(Class elementClass : suppliers.keySet()) {
                final LabelMapper mapper = LabelMapper.get(elementClass);
                nameMap.put(elementClass.getSimpleName(), mapper.mapClassName());
            }
            final Map<Class<? extends AbstractPositionDocument>, List<Class>> mapDesTypesDeDocs = new HashMap<>();
            final List<Class> positionDocumentList = new ArrayList<>();
            positionDocumentList.add(ArticleJournal.class);
            positionDocumentList.add(Marche.class);
            positionDocumentList.add(RapportEtude.class);
            positionDocumentList.add(DocumentGrandeEchelle.class);

            for(final Class elementClass : positionDocumentList){
                final LabelMapper mapper = LabelMapper.get(elementClass);
                nameMap.put(elementClass.getSimpleName(), mapper.mapClassName());
            }
            final List<Class> positionProfilTraversList = new ArrayList<>();
            positionProfilTraversList.add(ProfilTravers.class);
            for(final Class elementClass : positionProfilTraversList){
                final LabelMapper mapper = LabelMapper.get(elementClass);
                nameMap.put(elementClass.getSimpleName(), mapper.mapClassName());
            }
            final List<Class> profilLongList = new ArrayList<>();
            profilLongList.add(ProfilLong.class);
            for(final Class elementClass : profilLongList){
                final LabelMapper mapper = LabelMapper.get(elementClass);
                nameMap.put(elementClass.getSimpleName(), mapper.mapClassName());
            }
            mapDesTypesDeDocs.put(PositionDocument.class, positionDocumentList);
            mapDesTypesDeDocs.put(PositionProfilTravers.class, positionProfilTraversList);
            mapDesTypesDeDocs.put(ProfilLong.class, profilLongList);

            final Color[] colors = new Color[]{
                Color.BLACK,
                Color.BLUE,
                Color.CYAN,
                Color.RED,
                Color.DARK_GRAY,
                Color.GREEN,
                Color.MAGENTA,
                Color.ORANGE,
                Color.PINK,
                Color.RED
            };

            //troncons
            BeanFeatureSupplier tronconFeatureSupplier = suppliers.get(TronconDigue.class);
            /*
             * This supplier for troncon is not supposed to be null, because the method #loadDataSuppliers() is launched
             * before and put it in the suppliers map. So it usually never happens but a user reports a NullPointerException
             * on the BeanStore creation for this supplier...
             * So relaunch the initial loading and it should be found this time in the map. If it is still not found, then
             * there is nothing we can do. A NullPointerException will be propagated, cause we don't want to go further in
             * this current state of the application.
             */
            if (tronconFeatureSupplier == null) {
                SIRS.LOGGER.log(Level.WARNING, "Troncon supplier was not found although it was previously loaded. Retrying loading core plugin...");
                load();
                tronconFeatureSupplier = suppliers.get(TronconDigue.class);
                // By the way, refill the names map with possibly forgotten items.
                for(Class elementClass : suppliers.keySet()) {
                    final LabelMapper mapper = LabelMapper.get(elementClass);
                    nameMap.put(elementClass.getSimpleName(), mapper.mapClassName());
                }
            }
            final BeanStore tronconStore = new BeanStore(tronconFeatureSupplier);
            sirsGroup.items().addAll(buildLayers(tronconStore,TRONCON_LAYER_NAME,createTronconStyle(),createTronconSelectionStyle(false),true));

            //bornes
            final BeanStore borneStore = new BeanStore(suppliers.get(BorneDigue.class));
            sirsGroup.items().addAll(buildLayers(borneStore,BORNE_LAYER_NAME,createBorneStyle(),createBorneSelectionStyle(),true));

            //structures
            final BeanStore structStore = new BeanStore(
                    suppliers.get(Crete.class),
                    suppliers.get(OuvrageRevanche.class),
                    suppliers.get(TalusDigue.class),
                    suppliers.get(SommetRisberme.class),
                    suppliers.get(TalusRisberme.class),
                    suppliers.get(PiedDigue.class),
                    suppliers.get(Epi.class),
                    suppliers.get(Deversoir.class),
                    suppliers.get(Fondation.class));
            final MapItem structLayer = MapBuilder.createItem();
            structLayer.setName("Structures");
            structLayer.items().addAll( buildLayers(structStore, nameMap, colors, createDefaultSelectionStyle(),false));
            structLayer.setUserProperty(Session.FLAG_SIRSLAYER, Boolean.TRUE);
            sirsGroup.items().add(structLayer);

            // Franc-bords
            final BeanStore fbStore = new BeanStore(
                    suppliers.get(LargeurFrancBord.class));
            final MapItem fbLayer = MapBuilder.createItem();
            fbLayer.setName("Francs-bords");
            fbLayer.items().addAll( buildLayers(fbStore, nameMap, colors, createDefaultSelectionStyle(),false) );
            fbLayer.setUserProperty(Session.FLAG_SIRSLAYER, Boolean.TRUE);
            sirsGroup.items().add(fbLayer);

            // Réseaux de voirie
            final BeanStore rvStore = new BeanStore(
                    suppliers.get(VoieAcces.class),
                    suppliers.get(OuvrageFranchissement.class),
                    suppliers.get(OuvertureBatardable.class),
                    suppliers.get(VoieDigue.class),
                    suppliers.get(OuvrageVoirie.class));
            final MapItem rvLayer = MapBuilder.createItem();
            rvLayer.setName("Réseaux de voirie");
            rvLayer.items().addAll( buildLayers(rvStore, nameMap, colors, createDefaultSelectionStyle(),false) );
            rvLayer.setUserProperty(Session.FLAG_SIRSLAYER, Boolean.TRUE);
            sirsGroup.items().add(rvLayer);

            // Réseaux et ouvrages
            final BeanStore roStore = new BeanStore(
                    suppliers.get(StationPompage.class),
                    suppliers.get(ReseauHydrauliqueFerme.class),
                    suppliers.get(OuvrageHydrauliqueAssocie.class),
                    suppliers.get(ReseauTelecomEnergie.class),
                    suppliers.get(OuvrageTelecomEnergie.class),
                    suppliers.get(ReseauHydrauliqueCielOuvert.class),
                    suppliers.get(OuvrageParticulier.class),
                    suppliers.get(EchelleLimnimetrique.class));
            final MapItem roLayer = MapBuilder.createItem();
            roLayer.setName("Réseaux et ouvrages");
            roLayer.items().addAll( buildLayers(roStore, nameMap, colors, createDefaultSelectionStyle(),false) );
            roLayer.setUserProperty(Session.FLAG_SIRSLAYER, Boolean.TRUE);
            sirsGroup.items().add(roLayer);

            // Désordres
            final BeanStore desordreStore = new BeanStore(suppliers.get(Desordre.class));
            final MapItem desordresLayer = MapBuilder.createItem();
            desordresLayer.setName("Désordres");
            desordresLayer.items().addAll( buildLayers(desordreStore, nameMap, colors, createDefaultSelectionStyle(),false) );
            desordresLayer.setUserProperty(Session.FLAG_SIRSLAYER, Boolean.TRUE);
            sirsGroup.items().add(desordresLayer);

            // Prestations
            final BeanStore prestaStore = new BeanStore(suppliers.get(Prestation.class));
            final MapItem prestaLayer = MapBuilder.createItem();
            prestaLayer.setName("Prestations");
            prestaLayer.items().addAll( buildLayers(prestaStore, nameMap, colors, createDefaultSelectionStyle(),false) );
            prestaLayer.setUserProperty(Session.FLAG_SIRSLAYER, Boolean.TRUE);
            sirsGroup.items().add(prestaLayer);

            // Mesures d'évènements
            final BeanStore mesuresStore = new BeanStore(
                    suppliers.get(LaisseCrue.class),
                    suppliers.get(MonteeEaux.class),
                    suppliers.get(LigneEau.class));
            final MapItem mesuresLayer = MapBuilder.createItem();
            mesuresLayer.setName("Mesures d'évènements");
            mesuresLayer.items().addAll( buildLayers(mesuresStore, nameMap, colors, createDefaultSelectionStyle(),false) );
            mesuresLayer.setUserProperty(Session.FLAG_SIRSLAYER, Boolean.TRUE);
            sirsGroup.items().add(mesuresLayer);

            // Positionnement des documents
            final BeanStore documentsStore = new BeanStore(
                    suppliers.get(PositionDocument.class),
                    suppliers.get(PositionProfilTravers.class),
                    suppliers.get(ProfilLong.class));
            final MapItem documentsLayer = MapBuilder.createItem();
            documentsLayer.setName("Documents");
            documentsLayer.items().addAll(buildLayers(documentsStore, mapDesTypesDeDocs, nameMap, colors, createDefaultSelectionStyle(),false) );
            documentsLayer.setUserProperty(Session.FLAG_SIRSLAYER, Boolean.TRUE);
            sirsGroup.items().add(documentsLayer);

            // Proprietes et gardes
            final BeanStore periodesLocaliseesTroncon = new BeanStore(
                    suppliers.get(ProprieteTroncon.class),
                    suppliers.get(GardeTroncon.class));
            final MapItem periodesLocaliseesLayer = MapBuilder.createItem();
            periodesLocaliseesLayer.setName("Propriétés et gardiennages");
            periodesLocaliseesLayer.items().addAll(buildLayers(periodesLocaliseesTroncon, nameMap, colors, createDefaultSelectionStyle(), false));
            periodesLocaliseesLayer.setUserProperty(Session.FLAG_SIRSLAYER, Boolean.TRUE);
            sirsGroup.items().add(periodesLocaliseesLayer);

            // Emprises communales
            //final BeanStore communesStore = new BeanStore(suppliers.get(CommuneTroncon.class));

        }catch(Exception ex){
            SIRS.LOGGER.log(Level.WARNING, ex.getMessage(), ex);
        }

        return items;
    }

    @Override
    public boolean handleTronconType(final Class<? extends Element> element){
        return TronconDigue.class.equals(element)
                || Digue.class.equals(element)
                || SystemeEndiguement.class.equals(element);
    }

    @Override
    public FXFreeTab openTronconPane(final Element element){
        final DiguesTab diguesTab = Injector.getSession().getFrame().getDiguesTab();
        diguesTab.getDiguesController().displayElement(element);
        return diguesTab;
    }

    private static class DocumentFilter<T> implements Filter{

        private final Class<T> clazz;
        private List<Preview> previews;
        private Map<String, String> cache;

        public DocumentFilter(final Class<T> clazz) {
            this.clazz = clazz;

            // Si la classe fournie est un sirsDocument, on aura besoin du cache dans la méthode evaluate(), donc on l'initialise.
            if(SIRSDocument.class.isAssignableFrom(clazz)){
                previews = Injector.getSession().getPreviews().getByClass(clazz);
                cache = new HashMap<>();
                for(final Preview preview : previews){
                    cache.put(preview.getElementId(), preview.getElementClass());
                }
            }
        }

        @Override
        public boolean evaluate(Object o) {

            final BeanFeature beanFeature = (BeanFeature) o;
            // Si la classe fournie est un sirsDocument, on doit pouvoir trouver la propriété qui pointe dessus
            if(SIRSDocument.class.isAssignableFrom(clazz)
                    && beanFeature.getProperty(SIRSDOCUMENT_REFERENCE)!=null){
                final Object documentId = beanFeature.getPropertyValue(SIRSDOCUMENT_REFERENCE);
                if(documentId!=null && documentId instanceof String){
                    return clazz.getName().equals(cache.get((String) documentId));
                }
            }

            // Sinon il doit s'agir d'une position de document, mais qui ne réfère pas un document.
            else if(AbstractPositionDocument.class.isAssignableFrom(clazz)
                    && !AbstractPositionDocumentAssociable.class.isAssignableFrom(clazz)){
                return clazz.getSimpleName().equals(beanFeature.getType().getName().tip().toString());
            }
            return false;
        }

        @Override
        public Object accept(FilterVisitor fv, Object o) {
            throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
        }

    }

    public static List<MapLayer> buildLayers(FeatureStore store, String layerName, MutableStyle baseStyle, MutableStyle selectionStyle, boolean visible) throws DataStoreException{
        final List<MapLayer> layers = new ArrayList<>();
        final org.geotoolkit.data.session.Session symSession = store.createSession(false);
        for(GenericName name : store.getNames()){
            final FeatureCollection col = symSession.getFeatureCollection(QueryBuilder.all(name));
            final MutableStyle style = (baseStyle==null) ? RandomStyleBuilder.createRandomVectorStyle(col.getFeatureType()) : baseStyle;
            final FeatureMapLayer fml = MapBuilder.createFeatureLayer(col, style);

            if(col.getFeatureType().getDescriptor(DATE_DEBUT_FIELD)!=null && col.getFeatureType().getDescriptor(DATE_FIN_FIELD)!=null){
                final FeatureMapLayer.DimensionDef datefilter = new FeatureMapLayer.DimensionDef(
                        CommonCRS.Temporal.JAVA.crs(),
                        GO2Utilities.FILTER_FACTORY.property(DATE_DEBUT_FIELD),
                        GO2Utilities.FILTER_FACTORY.property(DATE_FIN_FIELD)
                );
                fml.getExtraDimensions().add(datefilter);
            }
            fml.setVisible(visible);
            fml.setName(layerName);
            fml.setUserProperty(Session.FLAG_SIRSLAYER, Boolean.TRUE);

            if(selectionStyle!=null) fml.setSelectionStyle(selectionStyle);

            layers.add(fml);
        }
        return layers;
    }

    public static List<MapLayer> buildLayers(BeanStore store, Map<String,String> nameMap, Color[] colors, MutableStyle selectionStyle, boolean visible) throws DataStoreException{
        final List<MapLayer> layers = new ArrayList<>();
        final org.geotoolkit.data.session.Session symSession = store.createSession(false);
        int i=0;
        for(GenericName name : store.getNames()){
            final FeatureCollection col = symSession.getFeatureCollection(QueryBuilder.all(name));
            final int d = (int)((i%colors.length)*1.5);
            final MutableStyle baseStyle = createDefaultStyle(colors[i%colors.length]);
            final MutableStyle style = (baseStyle==null) ? RandomStyleBuilder.createRandomVectorStyle(col.getFeatureType()) : baseStyle;
            final FeatureMapLayer fml = MapBuilder.createFeatureLayer(col, style);

            if(col.getFeatureType().getDescriptor(DATE_DEBUT_FIELD)!=null && col.getFeatureType().getDescriptor(DATE_FIN_FIELD)!=null){
                final FeatureMapLayer.DimensionDef datefilter = new FeatureMapLayer.DimensionDef(
                        CommonCRS.Temporal.JAVA.crs(),
                        GO2Utilities.FILTER_FACTORY.property(DATE_DEBUT_FIELD),
                        GO2Utilities.FILTER_FACTORY.property(DATE_FIN_FIELD)
                );
                fml.getExtraDimensions().add(datefilter);
            }
            fml.setVisible(visible);
            fml.setUserProperty(Session.FLAG_SIRSLAYER, Boolean.TRUE);

            final String str = nameMap.get(name.tip().toString());
            fml.setName(str!=null ? str : name.tip().toString());

            if(selectionStyle!=null) fml.setSelectionStyle(selectionStyle);

            layers.add(fml);
            i++;
        }
        return layers;
    }

    /**
     * Build {@link AbstractPositionDocument} layers for each provided {@link SIRSDocument} class.
     * @param store Data store providing {@link AbstractPositionDocument} objects.
     * @param documentClasses Document types referenced by document positions.
     * @param nameMap Map containing layer titles (key : document class simple name, value : title).
     * @param colors Set of colors to use for style creation.
     * @param selectionStyle Style to use when an object is selected in a layer.
     * @param visible True if layer must be visible by default. False otherwise.
     * @return List of created map layers.
     * @throws DataStoreException If an error occcurs while reading in input store.
     */
    public static List<MapLayer> buildLayers(BeanStore store, Map<Class<? extends AbstractPositionDocument>, List<Class>> documentClasses, Map<String,String> nameMap, Color[] colors, MutableStyle selectionStyle, boolean visible) throws DataStoreException{
        final List<MapLayer> layers = new ArrayList<>();
        final org.geotoolkit.data.session.Session symSession = store.createSession(false);
        int i=0;
        for(GenericName name : store.getNames()){
            final Class<? extends AbstractPositionDocument> positionDocumentClass;
            try {
                positionDocumentClass = (Class<? extends AbstractPositionDocument>) Class.forName(MODEL_PACKAGE+"."+name.tip().toString(), true, Thread.currentThread().getContextClassLoader());
                for(final Class documentClass : documentClasses.get(positionDocumentClass)){
                    final FeatureCollection col = symSession.getFeatureCollection(QueryBuilder.filtered(name, new DocumentFilter(documentClass)));
                    if(col.getFeatureType()!=null){
                        final MutableStyle baseStyle = createDefaultStyle(colors[i%colors.length]);
                        final MutableStyle style = (baseStyle==null) ? RandomStyleBuilder.createRandomVectorStyle(col.getFeatureType()) : baseStyle;
                        final FeatureMapLayer fml = MapBuilder.createFeatureLayer(col, style);

                        if(col.getFeatureType().getDescriptor(DATE_DEBUT_FIELD)!=null && col.getFeatureType().getDescriptor(DATE_FIN_FIELD)!=null){
                            final FeatureMapLayer.DimensionDef datefilter = new FeatureMapLayer.DimensionDef(
                                    CommonCRS.Temporal.JAVA.crs(),
                                    GO2Utilities.FILTER_FACTORY.property(DATE_DEBUT_FIELD),
                                    GO2Utilities.FILTER_FACTORY.property(DATE_FIN_FIELD)
                            );
                            fml.getExtraDimensions().add(datefilter);
                        }
                        fml.setVisible(visible);
                        fml.setUserProperty(Session.FLAG_SIRSLAYER, Boolean.TRUE);

                        final String str = nameMap.get(documentClass.getSimpleName());
                        fml.setName(str!=null ? str : documentClass.getSimpleName());

                        if(selectionStyle!=null) fml.setSelectionStyle(selectionStyle);

                        layers.add(fml);
                        i++;
                    }
                }
            } catch (ClassNotFoundException ex) {
                SIRS.LOGGER.log(Level.WARNING, null, ex);
            }
        }
        return layers;
    }

    @Override
    public List<MenuItem> getMapActions(Object obj) {
        final List<MenuItem> lst = new ArrayList<>();

        if(obj instanceof Element) {
            lst.add(new ViewFormItem((Element)obj));
        }

        return lst;
    }

    @Override
    public void load() {
        loadDataSuppliers();
        themes.add(new TronconTheme("Structure", Crete.class, OuvrageRevanche.class, TalusDigue.class, SommetRisberme.class, TalusRisberme.class, PiedDigue.class, Fondation.class, Epi.class, Deversoir.class));
        themes.add(new TronconTheme("Franc-bord", LargeurFrancBord.class));
        themes.add(new TronconTheme("Réseau de voirie", VoieAcces.class, OuvrageFranchissement.class, OuvertureBatardable.class, VoieDigue.class, OuvrageVoirie.class));
        themes.add(new TronconTheme("Réseau et ouvrage", StationPompage.class, ReseauHydrauliqueFerme.class, OuvrageHydrauliqueAssocie.class, ReseauTelecomEnergie.class, OuvrageTelecomEnergie.class, ReseauHydrauliqueCielOuvert.class, OuvrageParticulier.class, EchelleLimnimetrique.class));
        themes.add(new TronconTheme("Désordre", Desordre.class));
        themes.add(new TronconTheme("Prestation", Prestation.class));
        themes.add(new TronconTheme("Mesure d'événement hydraulique", LaisseCrue.class, MonteeEaux.class, LigneEau.class));
        themes.add(new PositionDocumentTheme());
        themes.add(new ContactsTheme());
        themes.add(new EvenementsHydrauliquesTheme());
        themes.add(new DocumentTheme<>("Profil en travers", ProfilTravers.class));
        themes.add(new DocumentTheme<>("Article de presse", ArticleJournal.class));
        themes.add(new DocumentTheme<>("Marché", Marche.class));
        themes.add(new DocumentTheme<>("Rapport d'étude", RapportEtude.class));
        themes.add(new DocumentTheme<>("Document à grande échelle", DocumentGrandeEchelle.class));
        themes.add(new GlobalPrestationTheme());
    }

    @Override
    public CharSequence getTitle() {
        return NAME;
    }

    @Override
    public Image getImage() {
        return null;
    }

    private static MutableStyle createTronconStyle() throws CQLException, URISyntaxException{
        final Stroke stroke1 = SF.stroke(SF.literal(Color.BLACK),LITERAL_ONE_FLOAT,FF.literal(9),
                STROKE_JOIN_BEVEL, STROKE_CAP_SQUARE, null,LITERAL_ZERO_FLOAT);
        final LineSymbolizer line1 = SF.lineSymbolizer("symbol",
                (String)null,DEFAULT_DESCRIPTION,Units.POINT,stroke1,LITERAL_ONE_FLOAT);

        final Stroke stroke2 = SF.stroke(SF.literal(new Color(0.9f, 0.9f,0.9f)),LITERAL_ONE_FLOAT,FF.literal(7),
                STROKE_JOIN_BEVEL, STROKE_CAP_SQUARE, null,LITERAL_ZERO_FLOAT);
        final LineSymbolizer line2 = SF.lineSymbolizer("symbol",
                (String)null,DEFAULT_DESCRIPTION,Units.POINT,stroke2,LITERAL_ONE_FLOAT);

        final Stroke stroke3 = SF.stroke(SF.literal(Color.BLACK),LITERAL_ONE_FLOAT,FF.literal(1),
                STROKE_JOIN_BEVEL, STROKE_CAP_SQUARE, null,LITERAL_ZERO_FLOAT);
        final LineSymbolizer line3 = SF.lineSymbolizer("symbol",
                (String)null,DEFAULT_DESCRIPTION,Units.POINT,stroke3,LITERAL_ONE_FLOAT);

        return SF.style(line1,line2,line3);
    }

    public static MutableStyle createTronconSelectionStyle(boolean graduation) throws URISyntaxException{
        final Stroke stroke1 = SF.stroke(SF.literal(Color.GREEN),LITERAL_ONE_FLOAT,FF.literal(13),
                STROKE_JOIN_BEVEL, STROKE_CAP_BUTT, null,LITERAL_ZERO_FLOAT);
        final LineSymbolizer line1 = SF.lineSymbolizer("symbol",
                (String)null,DEFAULT_DESCRIPTION,Units.POINT,stroke1,LITERAL_ONE_FLOAT);


        final Expression size = GO2Utilities.FILTER_FACTORY.literal(18);
        final List<GraphicalSymbol> symbols = new ArrayList<>();
        final GraphicalSymbol external = SF.externalGraphic(
                    SF.onlineResource(CorePlugin.class.getResource("/fr/sirs/arrow-green.png").toURI()),
                    "image/png",null);
        symbols.add(external);
        final Graphic graphic = SF.graphic(symbols, LITERAL_ONE_FLOAT,
                size, DEFAULT_GRAPHIC_ROTATION, DEFAULT_ANCHOR_POINT, DEFAULT_DISPLACEMENT);

        final Expression initialGap = FF.literal(10);
        final Expression strokeGap = FF.literal(200);
        final GraphicStroke graphicStroke = SF.graphicStroke(graphic,strokeGap,initialGap);

        final Stroke gstroke = SF.stroke(graphicStroke,DEFAULT_FILL_COLOR,LITERAL_ONE_FLOAT,LITERAL_ONE_FLOAT,
                STROKE_JOIN_BEVEL,STROKE_CAP_ROUND,null,LITERAL_ZERO_FLOAT);
        final LineSymbolizer direction = SF.lineSymbolizer("",(Expression)null,null,null,gstroke,null);

        if (graduation) {
            final GraduationSymbolizer bigGrad = new GraduationSymbolizer();
            //tous les 100metres
            final GraduationSymbolizer.Graduation g1 = new GraduationSymbolizer.Graduation();
            g1.setUnit(new DefaultLiteral("m"));
            g1.setStep(FF.literal(100));
            g1.setStroke(SF.stroke(Color.RED, 3));
            g1.setFont(SF.font(12));
            g1.setSize(FF.literal(12));
            bigGrad.getGraduations().add(g1);
            //tous les 10metres
            final GraduationSymbolizer littleGrad = new GraduationSymbolizer();
            final GraduationSymbolizer.Graduation g2 = new GraduationSymbolizer.Graduation();
            g2.setUnit(new DefaultLiteral("m"));
            g2.setStep(FF.literal(10));
            g2.setStroke(SF.stroke(Color.BLACK, 1));
            g2.setFont(SF.font(10));
            g2.setSize(FF.literal(4));
            littleGrad.getGraduations().add(g2);

            final MutableRule ruleClose = SF.rule(littleGrad);
            ruleClose.setMaxScaleDenominator(3000);

            final MutableRule ruleDistant = SF.rule(bigGrad);
            ruleDistant.setMinScaleDenominator(3000);

            // For graduation symbolizer, green wide stroke is desactivated, to ease edition.
            MutableRule others = SF.rule(direction);

            MutableFeatureTypeStyle ftStyle = SF.featureTypeStyle();
            ftStyle.rules().add(ruleClose);
            ftStyle.rules().add(ruleDistant);
            ftStyle.rules().add(others);

            MutableStyle style = SF.style();
            style.featureTypeStyles().add(ftStyle);

            return style;
        }else{
            return SF.style(line1,direction);
        }
    }

    @Override
    public List<Theme> getThemes() {
        if (themes == null || themes.isEmpty()) {
            load();
        }
        return super.getThemes();
    }



    private static MutableStyle createBorneStyle() throws URISyntaxException{
        final Expression size = GO2Utilities.FILTER_FACTORY.literal(10);

        final List<GraphicalSymbol> symbols = new ArrayList<>();
        final Stroke stroke = SF.stroke(SF.literal(Color.DARK_GRAY),LITERAL_ONE_FLOAT,LITERAL_ONE_FLOAT,
                STROKE_JOIN_BEVEL, STROKE_CAP_BUTT, null,LITERAL_ZERO_FLOAT);
        final Fill fill = SF.fill(Color.LIGHT_GRAY);

        //final Mark mark = SF.mark(StyleConstants.MARK_CIRCLE, fill, stroke);
        final Expression external = FF.literal("ttf:Dialog?char=0x2A");
//        final ExternalMark external = SF.externalMark(
//                    SF.onlineResource(IconBuilder.FONTAWESOME.toURI()),
//                    "ttf",FontAwesomeIcons.ICON_ASTERISK.codePointAt(0));
        final Mark mark = SF.mark(external, fill, stroke);
        symbols.add(mark);
        final Graphic graphic = SF.graphic(symbols, LITERAL_ONE_FLOAT,
                size, LITERAL_ONE_FLOAT, DEFAULT_ANCHOR_POINT, DEFAULT_DISPLACEMENT);

        final PointSymbolizer pointSymbolizer = SF.pointSymbolizer("symbol",(String)null,DEFAULT_DESCRIPTION,Units.POINT,graphic);

        final TextSymbolizer ts = SF.textSymbolizer(
                SF.fill(Color.BLACK), DEFAULT_FONT,
                SF.halo(Color.WHITE, 2),
                FF.property("libelle"),
                SF.pointPlacement(SF.anchorPoint(0, 0.25), SF.displacement(5, 0), FF.literal(0)), null);

        final MutableRule ruleClose = SF.rule(pointSymbolizer, ts);
        ruleClose.setMaxScaleDenominator(70000);

        final MutableFeatureTypeStyle fts = SF.featureTypeStyle();
        fts.rules().add(ruleClose);
        final MutableStyle style = SF.style();
        style.featureTypeStyles().add(fts);
        return style;
    }

    private static MutableStyle createBorneSelectionStyle(){
        final Expression size = GO2Utilities.FILTER_FACTORY.literal(10);

        final List<GraphicalSymbol> symbols = new ArrayList<>();
        final Stroke stroke = SF.stroke(Color.BLACK, 1);
        final Fill fill = SF.fill(Color.GREEN);
        final Mark mark = SF.mark(StyleConstants.MARK_CIRCLE, fill, stroke);
        symbols.add(mark);
        final Graphic graphic = SF.graphic(symbols, LITERAL_ONE_FLOAT,
                size, LITERAL_ONE_FLOAT, DEFAULT_ANCHOR_POINT, DEFAULT_DISPLACEMENT);

        final PointSymbolizer pointSymbolizer = SF.pointSymbolizer("symbol",(String)null,DEFAULT_DESCRIPTION,Units.POINT,graphic);

        final TextSymbolizer ts = SF.textSymbolizer(
                SF.fill(Color.BLACK), SF.font(13),
                SF.halo(Color.GREEN, 2),
                FF.property("libelle"),
                SF.pointPlacement(SF.anchorPoint(0, 0.25), SF.displacement(5, 0), FF.literal(0)), null);

        final MutableRule ruleClose = SF.rule(pointSymbolizer, ts);
        ruleClose.setMaxScaleDenominator(50000);

        final MutableFeatureTypeStyle fts = SF.featureTypeStyle();
        fts.rules().add(ruleClose);
        final MutableStyle style = SF.style();
        style.featureTypeStyles().add(fts);
        return style;
    }

    public static MutableStyle createDefaultSelectionStyle(){
        return createDefaultSelectionStyle(false);
    }

    public static MutableStyle createDefaultSelectionStyle(final boolean withRealPosition){
        // Stroke to use for lines and point perimeter
        final Stroke stroke = SF.stroke(SF.literal(Color.GREEN),LITERAL_ONE_FLOAT,FF.literal(13),
                STROKE_JOIN_BEVEL, STROKE_CAP_BUTT, null,LITERAL_ZERO_FLOAT);
        final LineSymbolizer line1 = SF.lineSymbolizer("symbol",
                (String)null,DEFAULT_DESCRIPTION,Units.POINT,stroke,LITERAL_ONE_FLOAT);

        // Definition of point symbolizer
        final Expression size = GO2Utilities.FILTER_FACTORY.literal(24);
        final List<GraphicalSymbol> symbols = new ArrayList<>();
        final Fill fill = SF.fill(new Color(0, 0, 0, 0));
        final Mark mark = SF.mark(StyleConstants.MARK_CIRCLE, fill, stroke);
        symbols.add(mark);
        final Graphic graphic = SF.graphic(symbols, LITERAL_ONE_FLOAT,
                size, LITERAL_ONE_FLOAT, DEFAULT_ANCHOR_POINT, DEFAULT_DISPLACEMENT);

        final PointSymbolizer pointSymbolizer = SF.pointSymbolizer("symbol",(String)null,DEFAULT_DESCRIPTION,Units.POINT,graphic);

        final MutableRule ruleLongObjects = SF.rule(line1);
        ruleLongObjects.setFilter(
                FF.greater(
                        FF.function("length", FF.property("geometry")),
                        FF.literal(2.0)
                )
        );

        final MutableRule ruleSmallObjects = SF.rule(pointSymbolizer);
        ruleSmallObjects.setFilter(
                FF.less(
                        FF.function("length", FF.property("geometry")),
                        FF.literal(2.0)
                )
        );

        final MutableFeatureTypeStyle fts = SF.featureTypeStyle();
        if(withRealPosition) {

            addRealPositionStyles(fts,  Color.GREEN);
        }
        fts.rules().add(ruleLongObjects);
        fts.rules().add(ruleSmallObjects);

        final MutableStyle style = SF.style();
        style.featureTypeStyles().add(fts);
        return style;
    }

    public static MutableStyle createDefaultStyle(Color col) {
        return createDefaultStyle(col, null, false);
    }

    /**
     * Création d'un style permettant d'afficher les positions dites "réelles"
     * de la couleur indiquée par le paramètre.
     *
     * @param color : couleur à affecter au style
     * @return
     */
    public static MutableStyle createRealPositionStyle(final Color color) {

        final MutableFeatureTypeStyle fts = SF.featureTypeStyle();
        addRealPositionStyles(fts, color);

        final MutableStyle style = SF.style();
        style.featureTypeStyles().add(fts);
        return style;
    }

    public static MutableStyle createDefaultStyle(final Color color, final String geometryName, final boolean withRealPosition) {

        final Stroke line1Stroke = SF.stroke(SF.literal(color),LITERAL_ONE_FLOAT,GO2Utilities.FILTER_FACTORY.literal(8),
                STROKE_JOIN_BEVEL, STROKE_CAP_ROUND, null,LITERAL_ZERO_FLOAT);
        final LineSymbolizer line1 = SF.lineSymbolizer("symbol",
                geometryName,DEFAULT_DESCRIPTION,Units.POINT,line1Stroke,LITERAL_ZERO_FLOAT);

        final Stroke line2Stroke = SF.stroke(SF.literal(Color.BLACK),LITERAL_ONE_FLOAT,GO2Utilities.FILTER_FACTORY.literal(1),
                STROKE_JOIN_BEVEL, STROKE_CAP_ROUND, null,LITERAL_ZERO_FLOAT);
        final LineSymbolizer line2 = SF.lineSymbolizer("symbol",
                geometryName,DEFAULT_DESCRIPTION,Units.POINT,line2Stroke,LITERAL_ZERO_FLOAT);

        //the visual element
        final Expression size = GO2Utilities.FILTER_FACTORY.literal(16);

        final List<GraphicalSymbol> symbols = new ArrayList<>();
        final Stroke stroke = null;
        final Fill fill = SF.fill(color);
        final Mark mark = SF.mark(StyleConstants.MARK_TRIANGLE, fill, stroke);
        symbols.add(mark);
        final Graphic graphic = SF.graphic(symbols, LITERAL_ONE_FLOAT,
                size, LITERAL_ONE_FLOAT, DEFAULT_ANCHOR_POINT, DEFAULT_DISPLACEMENT);

        final PointSymbolizer pointSymbolizer = SF.pointSymbolizer("symbol",geometryName,DEFAULT_DESCRIPTION,Units.POINT,graphic);

        final MutableRule ruleLongObjects = SF.rule(line1,line2);
        ruleLongObjects.setFilter(
                FF.greater(
                        FF.function("length", FF.property("geometry")),
                        FF.literal(SirsCore.LINE_MIN_LENGTH)
                )
        );

        final MutableRule ruleSmallObjects = SF.rule(pointSymbolizer);
        ruleSmallObjects.setFilter(
                FF.lessOrEqual(
                        FF.function("length", FF.property("geometry")),
                        FF.literal(SirsCore.LINE_MIN_LENGTH)
                )
        );

        final MutableFeatureTypeStyle fts = SF.featureTypeStyle();
//        // test et préparation pour SYM-1776
        if(withRealPosition) {
            addRealPositionStyles(fts, color);
        }

        fts.rules().add(ruleLongObjects);
        fts.rules().add(ruleSmallObjects);

        final MutableStyle style = SF.style();
        style.featureTypeStyles().add(fts);
        return style;
    }

    /**
     * Ajout des règles de styles associées aux positions dites "réelles".
     * La {@linkplain MutableRule règle} 'short' sert à représenter les éléments
     * ponctuels; la {@linkplain MutableRule règle} 'long' sert à représenter
     * les éléments linéaires.
     *
     * @param fts
     * @param color
     */
    private static void addRealPositionStyles(final MutableFeatureTypeStyle fts, final Color color) {
        try {

            final MutableRule shortRule = createExactShortRule(SirsCore.POSITION_DEBUT_FIELD, color, StyleConstants.MARK_TRIANGLE);
            final MutableRule longRule  = createExactLongRule(SirsCore.POSITION_DEBUT_FIELD, SirsCore.POSITION_FIN_FIELD, color, StyleConstants.MARK_TRIANGLE);

            longRule.setFilter(
                    FF.greater(
                            FF.function("length", FF.property("geometry")),
                            FF.literal(SirsCore.LINE_MIN_LENGTH)
                    )
            );

            shortRule.setFilter(
                    FF.lessOrEqual(
                            FF.function("length", FF.property("geometry")),
                            FF.literal(SirsCore.LINE_MIN_LENGTH)
                    )
            );

            fts.rules().add(shortRule);
            fts.rules().add(longRule);

        } catch (Exception e) {
            SirsCore.LOGGER.log(Level.WARNING, NAME, e);
        }
    }

    private static PointSymbolizer createExactPointSymbolizer(final String pointName, final String geometryProperty, final Color color, final Expression wellKnownName){
        return SF.pointSymbolizer(pointName, geometryProperty, DEFAULT_DESCRIPTION, Units.POINT,
                        SF.graphic(Arrays.asList(SF.mark(wellKnownName, SF.fill(Color.WHITE), SF.stroke(color, 2))),
                                LITERAL_ONE_FLOAT, GO2Utilities.FILTER_FACTORY.literal(20), LITERAL_ONE_FLOAT, DEFAULT_ANCHOR_POINT, DEFAULT_DISPLACEMENT));
    }

    public static MutableRule createExactLongRule(final String geometryStartProperty, final String geometryEndProperty, final Color color, final Expression wellKnownName){

        final Stroke realLineStroke = SF.stroke(SF.literal(color), LITERAL_ONE_FLOAT, GO2Utilities.FILTER_FACTORY.literal(5),
                STROKE_JOIN_BEVEL, STROKE_CAP_ROUND, new float[]{15.f, 15.f}, LITERAL_ZERO_FLOAT);

        final LineSymbolizer lineReal = SF.lineSymbolizer("symbol",
                POINTS_TO_LINE,
                DEFAULT_DESCRIPTION, Units.POINT, realLineStroke, LITERAL_ZERO_FLOAT);

        final TextSymbolizer centeredDesignation = SF.textSymbolizer("designation", POINTS_TO_CENTER, DEFAULT_DESCRIPTION, null,
                FF.property("designation"), DEFAULT_FONT, StyleConstants.DEFAULT_POINTPLACEMENT, SF.halo(Color.WHITE, 2), SF.fill(color));

        return SF.rule(
                lineReal,
                createExactPointSymbolizer("start", geometryStartProperty, color, wellKnownName),//Point de départ
                createExactPointSymbolizer(  "end", geometryEndProperty, color, wellKnownName),//Point de fin
                centeredDesignation
        );
    }

    public static MutableRule createExactShortRule(final String geometryStartProperty, final Color color, final Expression wellKnownName){

        return SF.rule(
                createExactPointSymbolizer("start", geometryStartProperty, color, wellKnownName),
                SF.textSymbolizer(SF.fill(color), DEFAULT_FONT, SF.halo(Color.WHITE, 1), FF.property("designation"),
                        StyleConstants.DEFAULT_POINTPLACEMENT, geometryStartProperty)
        );
    }

    private class ViewFormItem extends MenuItem {

        private final Element candidate;

        public ViewFormItem(Element candidate) {
            this.candidate = candidate;
            setText(Session.generateElementTitle(candidate));

            setOnAction(this::showEditor);
        }

        private void showEditor(final ActionEvent evt) {
            getSession().showEditionTab(candidate);
        }
    }

    /**
     * Méthode d'initialisation des comboboxes de types de désordres
     * de manière à préserver la cohérence des choix qu'elles proposent en
     * fonction d'un choix de catégorie de désordre.
     *
     * @param categorieId catégorie de désordres pour laquelle on veut charger les types de désordres
     * @param typeIdToSelect type de désordre à sélectionner
     * @param allTypePreviews liste de previews des types de désordres de toutes les catégories.
     * @param types types de désordres indexés par leur id.
     * @param comboBox combobox à remplir
     */
    public static void initComboTypeDesordre(final String categorieId,
            final String typeIdToSelect,
            final List<Preview> allTypePreviews,
            final Map<String, RefTypeDesordre> types, final ComboBox comboBox){

        Preview selectedPreview = null;
        final List<Preview> typePreviews = new ArrayList<>();

        // 1- si la catégorie est nulle, on charge les types qui n'ont pas de catégorie
        if(categorieId == null){

            // On trie de manière à ne récupérer que les previews de la catégorie
            for(final Preview typePreview : allTypePreviews){
                final String typeId = typePreview.getElementId();
                if(typeId!=null){
                    final RefTypeDesordre typeDesordre = types.get(typeId);
                    if(typeDesordre.getCategorieId()==null){
                        typePreviews.add(typePreview);
                    }

                    if(typeId.equals(typeIdToSelect)) selectedPreview = typePreview;
                }
            }
        }

        // 2- sinon on va chercher ses éventuels types
        else {

            // On trie de manière à ne récupérer que les previews de la catégorie
            for(final Preview typePreview : allTypePreviews){
                final String typeId = typePreview.getElementId();
                if(typeId!=null){
                    final RefTypeDesordre typeDesordre = types.get(typeId);
                    if(categorieId.equals(typeDesordre.getCategorieId())){
                        typePreviews.add(typePreview);
                    }

                    if(typeId.equals(typeIdToSelect)) selectedPreview = typePreview;
                }
            }
        }

        SIRS.initCombo(comboBox, SirsCore.observableList(typePreviews), selectedPreview);
    }

    public static void initTronconDigue(final TronconDigue troncon, final Session session){

        try {
            //on crée un géométrie au centre de la france
            final Geometry geom = JTS.transform(DEFAULT_TRONCON_GEOM_WGS84,
                    CRS.findOperation(CRS_WGS84, session.getProjection(), null).getMathTransform()
            );
            troncon.setGeometry(geom);
        } catch (FactoryException | TransformException | MismatchedDimensionException ex) {
            SIRS.LOGGER.log(Level.WARNING, ex.getMessage(),ex);
            troncon.setGeometry((Geometry) DEFAULT_TRONCON_GEOM_WGS84.clone());
        }

        session.getRepositoryForClass((Class) troncon.getClass()).update(troncon);
        //mise en place du SR élémentaire
        TronconUtils.updateSRElementaire(troncon, session);
    }

    @Override
    public Optional<Image> getModelImage() throws IOException {
        final Image image;

        try (final InputStream in = Thread.currentThread().getContextClassLoader().getResourceAsStream("fr/sirs/coreModel.png")) {
            image = new Image(in);
        }
        return Optional.of(image);
    }


    @Override
    public void afterImport() throws Exception {
        if (suppliers.isEmpty()) {
            loadDataSuppliers();
        }
    }

    @Override
    public void findUpgradeTasks(final int fromMajor, final int fromMinor, final CouchDbConnector dbConnector, final LinkedHashSet<Task> upgradeTasks, final DatabaseRegistry... dbRegistry) {

        if (fromMajor < 2 || (fromMajor == 2 && fromMinor < 7)) {
            upgradeTasks.add(new HtmlRemoval(dbConnector, "commentaire"));
            findUpgradeTasks(2, 7, dbConnector, upgradeTasks); //Reccursive call to findUpgradeTasks from the 2.7 version of the plugin reached with the previous Task.
            return;
        } else if (fromMajor < 2 || (fromMajor == 2 && fromMinor < 23)) {
            upgradeTasks.add(new UpgradeLink1NtoNN(dbRegistry[0], dbConnector.getDatabaseName(), Upgrades1NtoNNSupported.DESORDRE));
            upgradeTasks.add(new UpgradePrestationsCoordinates(dbRegistry[0], dbConnector.getDatabaseName(), 2,23));
            findUpgradeTasks(2, 23, dbConnector, upgradeTasks); //Reccursive call to findUpgradeTasks from the 2.23 version of the plugin reached with the previous Task.
            return;

        }

        super.findUpgradeTasks(fromMajor, fromMinor, dbConnector, upgradeTasks);
    }
}
