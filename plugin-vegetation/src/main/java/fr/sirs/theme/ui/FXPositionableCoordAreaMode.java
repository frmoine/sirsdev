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
package fr.sirs.theme.ui;

import com.vividsolutions.jts.geom.Coordinate;
import com.vividsolutions.jts.geom.Geometry;
import com.vividsolutions.jts.geom.LineString;
import com.vividsolutions.jts.geom.Point;
import com.vividsolutions.jts.geom.Polygon;
import fr.sirs.Injector;
import fr.sirs.core.LinearReferencingUtilities;
import static fr.sirs.core.LinearReferencingUtilities.buildSegmentFromDistance;
import fr.sirs.core.TronconUtils;
import fr.sirs.core.model.GeometryType;
import fr.sirs.core.model.Positionable;
import fr.sirs.core.model.PositionableVegetation;
import fr.sirs.core.model.TronconDigue;
import fr.sirs.core.model.ZoneVegetation;
import static fr.sirs.plugin.vegetation.PluginVegetation.computeRatio;
import static fr.sirs.plugin.vegetation.PluginVegetation.toPoint;
import static fr.sirs.plugin.vegetation.PluginVegetation.toPolygon;
import fr.sirs.util.ConvertPositionableCoordinates;
import java.util.Map;
import java.util.stream.Stream;
import javafx.beans.binding.StringBinding;
import javafx.beans.property.BooleanProperty;
import javafx.beans.property.SimpleBooleanProperty;
import javafx.beans.value.ChangeListener;
import javafx.beans.value.ObservableValue;
import javafx.fxml.FXML;
import javafx.scene.control.Label;
import javafx.scene.control.Spinner;
import javafx.scene.control.SpinnerValueFactory;
import org.geotoolkit.display2d.GO2Utilities;
import org.geotoolkit.geometry.jts.JTS;
import org.geotoolkit.internal.GeotkFX;
import org.apache.sis.referencing.CRS;
import org.geotoolkit.referencing.LinearReferencing.ProjectedPoint;
import org.geotoolkit.referencing.LinearReferencing.SegmentInfo;
import static org.geotoolkit.referencing.LinearReferencing.asLineString;
import static org.geotoolkit.referencing.LinearReferencing.buildSegments;
import static org.geotoolkit.referencing.LinearReferencing.projectReference;
import org.opengis.geometry.MismatchedDimensionException;
import org.opengis.referencing.crs.CoordinateReferenceSystem;
import org.opengis.referencing.operation.MathTransform;
import org.opengis.referencing.operation.TransformException;
import org.opengis.util.FactoryException;
import org.apache.sis.util.Utilities;

/**
 * Edition des coordonées géographique d'un {@link Positionable}.
 *
 * @author Johann Sorel (Geomatys)
 */
public class FXPositionableCoordAreaMode extends FXPositionableAbstractCoordMode {

    private static final String MODE = "COORD_AREA";

    //area
    @FXML private Spinner<Double> uiStartNear;
    @FXML private Spinner<Double> uiStartFar;
    @FXML private Spinner<Double> uiEndNear;
    @FXML private Spinner<Double> uiEndFar;

    // Libellés à cacher si c'est un ponctuel
    @FXML private Label lblFin;
    @FXML private Label lblStartNear;
    @FXML private Label lblStartFar;
    @FXML private Label lblEndNear;
    @FXML private Label lblEndFar;

    private final String originalLblStartNear;

    private final BooleanProperty pctProp = new SimpleBooleanProperty(false);

    final ChangeListener<String> typeCoteChangeListener = (ObservableValue<? extends String> observable, String oldValue, String newValue) -> buildGeometry();

    public FXPositionableCoordAreaMode() {
        super();

        uiStartNear.disableProperty().bind(disableProperty);
        uiStartFar.disableProperty().bind(disableProperty);
        uiEndNear.disableProperty().bind(disableProperty);
        uiEndFar.disableProperty().bind(disableProperty);
        uiStartNear.setEditable(true);
        uiStartFar.setEditable(true);
        uiEndNear.setEditable(true);
        uiEndFar.setEditable(true);

        uiStartNear.setValueFactory(new SpinnerValueFactory.DoubleSpinnerValueFactory(0, Double.MAX_VALUE, 0,1));
        uiStartFar.setValueFactory(new SpinnerValueFactory.DoubleSpinnerValueFactory(0, Double.MAX_VALUE, 0,1));
        uiEndNear.setValueFactory(new SpinnerValueFactory.DoubleSpinnerValueFactory(0, Double.MAX_VALUE, 0,1));
        uiEndFar.setValueFactory(new SpinnerValueFactory.DoubleSpinnerValueFactory(0, Double.MAX_VALUE, 0,1));

        final ChangeListener chgListener = (ChangeListener) (ObservableValue observable, Object oldValue, Object newValue) -> coordChange();
        uiStartNear.valueProperty().addListener(chgListener);
        uiStartFar.valueProperty().addListener(chgListener);
        uiEndNear.valueProperty().addListener(chgListener);
        uiEndFar.valueProperty().addListener(chgListener);

        //on cache certain elements quand c'est un ponctuel
        lblFin.visibleProperty().bind(pctProp);
        uiLongitudeEnd.visibleProperty().bind(pctProp);
        uiLatitudeEnd.visibleProperty().bind(pctProp);
        uiEndNear.visibleProperty().bind(pctProp);
        uiEndFar.visibleProperty().bind(pctProp);
        lblStartFar.visibleProperty().bind(pctProp);
        uiStartFar.visibleProperty().bind(pctProp);
        lblEndNear.visibleProperty().bind(pctProp);
        lblEndFar.visibleProperty().bind(pctProp);
        lblFin.managedProperty().bind(pctProp);
        uiLongitudeEnd.managedProperty().bind(pctProp);
        uiLatitudeEnd.managedProperty().bind(pctProp);
        uiEndNear.managedProperty().bind(pctProp);
        uiEndFar.managedProperty().bind(pctProp);
        lblStartFar.managedProperty().bind(pctProp);
        uiStartFar.managedProperty().bind(pctProp);
        lblEndNear.managedProperty().bind(pctProp);
        lblEndFar.managedProperty().bind(pctProp);

        originalLblStartNear = lblStartNear.getText();
        lblStartNear.textProperty().bind(new StringBinding() {
            {bind(pctProp);}
            @Override
            protected String computeValue() {
                if(pctProp.get()){
                    return originalLblStartNear;
                }
                else return "Point unique";
            }
        });

        positionableProperty().addListener(new ChangeListener<Positionable>() {

            @Override
            public void changed(ObservableValue<? extends Positionable> observable, Positionable oldValue, Positionable newValue) {
                if(newValue instanceof ZoneVegetation){
                    ((ZoneVegetation) newValue).typeCoteIdProperty().addListener(typeCoteChangeListener);
                }
                if(oldValue instanceof ZoneVegetation){
                    ((ZoneVegetation) newValue).typeCoteIdProperty().removeListener(typeCoteChangeListener);
                }
            }
        });
    }

    @Override
    public String getID() {
        return MODE;
    }

    @Override
    public void updateFields(){
        setReseting(true);

        //selectionner RGF93 par defaut
        uiCRSs.getSelectionModel().clearAndSelect(1);

        final PositionableVegetation pos = (PositionableVegetation) positionableProperty().get();
        final String mode = pos.getGeometryMode();


        if(MODE.equals(mode)){
            //on assigne les valeurs sans changement
            //on peut réutiliser les points enregistré dans la position
            final Point startPos = pos.getPositionDebut();
            final Point endPos = pos.getPositionFin();
            if (startPos != null) {
                uiLongitudeStart.getValueFactory().valueProperty().set(startPos.getX());
                uiLatitudeStart.getValueFactory().valueProperty().set(startPos.getY());
            }else{
                uiLongitudeStart.getValueFactory().setValue(null);
                uiLatitudeStart.getValueFactory().setValue(null);
            }
            if (endPos != null) {
                uiLongitudeEnd.getValueFactory().valueProperty().set(endPos.getX());
                uiLatitudeEnd.getValueFactory().valueProperty().set(endPos.getY());
            }else{
                uiLongitudeEnd.getValueFactory().setValue(null);
                uiLatitudeEnd.getValueFactory().setValue(null);
            }
            uiStartNear.getValueFactory().setValue(pos.getDistanceDebutMin());
            uiStartFar.getValueFactory().setValue(pos.getDistanceDebutMax());
            uiEndNear.getValueFactory().setValue(pos.getDistanceFinMin());
            uiEndFar.getValueFactory().setValue(pos.getDistanceFinMax());

        }else if(pos.getGeometry()!=null){
            //on calcule les valeurs en fonction des points de debut et fin

            //on refait les points a partir de la géométrie
            final TronconDigue t = ConvertPositionableCoordinates.getTronconFromPositionable(pos);
            final TronconUtils.PosInfo ps = new TronconUtils.PosInfo(pos, t);
            final Point geoPointStart = ps.getGeoPointStart();
            final Point geoPointEnd = ps.getGeoPointEnd();

            uiLongitudeStart.getValueFactory().setValue(geoPointStart==null ? null : geoPointStart.getX());
            uiLatitudeStart.getValueFactory().setValue(geoPointStart==null ? null : geoPointStart.getY());
            uiLongitudeEnd.getValueFactory().setValue(geoPointEnd==null ? null : geoPointEnd.getX());
            uiLatitudeEnd.getValueFactory().setValue(geoPointEnd==null ? null : geoPointEnd.getY());

            uiStartNear.getValueFactory().setValue(pos.getDistanceDebutMin());
            uiStartFar.getValueFactory().setValue(pos.getDistanceDebutMax());
            uiEndNear.getValueFactory().setValue(pos.getDistanceFinMin());
            uiEndFar.getValueFactory().setValue(pos.getDistanceFinMax());
        }else{
            //pas de geometrie
            uiLongitudeStart.getValueFactory().setValue(null);
            uiLatitudeStart.getValueFactory().setValue(null);
            uiLongitudeEnd.getValueFactory().setValue(null);
            uiLatitudeEnd.getValueFactory().setValue(null);

            uiStartNear.getValueFactory().setValue(0.0);
            uiStartFar.getValueFactory().setValue(0.0);
            uiEndNear.getValueFactory().setValue(0.0);
            uiEndFar.getValueFactory().setValue(0.0);
        }

        //on cache certains champs si c'est un ponctuel
        pctProp.unbind();
        pctProp.bind(pos.geometryTypeProperty().isNotEqualTo(GeometryType.PONCTUAL));

        setReseting(false);
    }


    @Override
    public void buildGeometry(){

        final ZoneVegetation zone = (ZoneVegetation) positionableProperty().get();

        // On ne met la géométrie à jour depuis ce panneau que si on est dans son mode.
        if(!getID().equals(zone.getGeometryMode())) return;

        zone.setDistanceDebutMin(uiStartNear.getValue());
        zone.setDistanceDebutMax(uiStartFar.getValue());
        zone.setDistanceFinMin(uiEndNear.getValue());
        zone.setDistanceFinMax(uiEndFar.getValue());


        // Si un CRS est défini, on essaye de récupérer les positions géographiques depuis le formulaire.
        final CoordinateReferenceSystem crs = uiCRSs.getSelectionModel().getSelectedItem();
        if(crs==null) return;

        Point startPoint = null;
        Point endPoint = null;
        if(uiLongitudeStart.getValue()!=null && uiLatitudeStart.getValue()!=null){
            startPoint = GO2Utilities.JTS_FACTORY.createPoint(new Coordinate(
                    uiLongitudeStart.getValue(), uiLatitudeStart.getValue()));
            JTS.setCRS(startPoint, crs);
        }

        if(uiLongitudeEnd.getValue()!=null && uiLatitudeEnd.getValue()!=null){
            endPoint = GO2Utilities.JTS_FACTORY.createPoint(new Coordinate(
                    uiLongitudeEnd.getValue(), uiLatitudeEnd.getValue()));
            JTS.setCRS(endPoint, crs);
        }

        if(startPoint==null && endPoint==null) return;
        if(startPoint==null) startPoint = endPoint;
        if(endPoint==null) endPoint = startPoint;

        final TronconDigue troncon = ConvertPositionableCoordinates.getTronconFromPositionable(zone);


        //on calcule le ratio on fonction de la rive et du coté
        double ratio = computeRatio(troncon, zone);

        //on extrude avec la distance
        Geometry geometry;
        final LineString linear;

        if(GeometryType.PONCTUAL.equals(zone.getGeometryType())){

            final LineString tronconLineString = asLineString(troncon.getGeometry());
            final SegmentInfo[] segments = buildSegments(tronconLineString);

            // Projection du point géographique sur le troncon pour obtenir une distance depuis le début du tronçon jusqu'au point projeté.
            final ProjectedPoint projected = projectReference(segments, startPoint);

            /*
            Pour un point, il faut récupérer à partir de la géométrie du tronçon
            le segment sur lequel se trouve le point, car pour mesurer la
            direction du décalage perpendiculaire au tronçon, un point seul ne
            suffit pas.
            */
            final Map.Entry<LineString, Double> pointAndSegment = buildSegmentFromDistance(
                    segments, projected.distanceAlongLinear);
            linear = pointAndSegment.getKey();
            if(ratio==0.) ratio=1.;// On ne met pas un arbre des deux côtés.
            geometry = toPoint(linear,
                zone.getDistanceDebutMin() * ratio,
                pointAndSegment.getValue());
        }
        else {
            /*
            Si on n'a pas à faire à un ponctuel, on peut utiliser la géométrie
            de la structure plutôt que celle du tronçon.
            */
            linear = LinearReferencingUtilities.buildGeometryFromGeo(troncon.getGeometry(), startPoint, endPoint);
            if(ratio==0){
                //des 2 cotés
                ratio = 1;
                final Polygon left = toPolygon(linear,
                    zone.getDistanceDebutMin() * ratio,
                    zone.getDistanceDebutMax() * ratio,
                    zone.getDistanceFinMin() * ratio,
                    zone.getDistanceFinMax() * ratio);
                ratio = -1;
                final Polygon right = toPolygon(linear,
                    zone.getDistanceDebutMin() * ratio,
                    zone.getDistanceDebutMax() * ratio,
                    zone.getDistanceFinMin() * ratio,
                    zone.getDistanceFinMax() * ratio);
                geometry = GO2Utilities.JTS_FACTORY.createMultiPolygon(new Polygon[]{left,right});
                geometry.setSRID(linear.getSRID());
                geometry.setUserData(linear.getUserData());

            }else{
                //1 coté
                geometry = toPolygon(linear,
                    zone.getDistanceDebutMin() * ratio,
                    zone.getDistanceDebutMax() * ratio,
                    zone.getDistanceFinMin() * ratio,
                    zone.getDistanceFinMax() * ratio);
            }
        }

        //on sauvegarde les points dans le crs de la base
        zone.setGeometry(geometry);
        if(!Utilities.equalsIgnoreMetadata(crs, Injector.getSession().getProjection())){
            try{
                final MathTransform trs = CRS.findOperation(crs, Injector.getSession().getProjection(), null).getMathTransform();
                startPoint = (Point) JTS.transform(startPoint, trs);
                endPoint = (Point) JTS.transform(endPoint, trs);
            }catch(FactoryException | MismatchedDimensionException | TransformException ex){
                GeotkFX.newExceptionDialog("La conversion des positions a échouée.", ex).show();
                throw new RuntimeException("La conversion des positions a échouée.", ex);
            }
        }
        zone.setPositionDebut(startPoint);
        zone.setPositionFin(endPoint);
        zone.geometryModeProperty().set(getID());
        zone.geometryProperty().set(geometry);
    }

    @Override
    protected Stream<Spinner> getSpinners() {
        return Stream.concat(
                super.getSpinners(),
                Stream.of(uiStartNear, uiStartFar, uiEndNear, uiEndFar)
        );
    }
}
