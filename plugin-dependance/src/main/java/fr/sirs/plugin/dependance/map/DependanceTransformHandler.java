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
package fr.sirs.plugin.dependance.map;

import com.vividsolutions.jts.geom.Geometry;
import fr.sirs.Injector;
import fr.sirs.SIRS;
import fr.sirs.Session;
import fr.sirs.core.component.AbstractSIRSRepository;
import fr.sirs.core.model.AbstractDependance;
import fr.sirs.core.model.AireStockageDependance;
import fr.sirs.core.model.AutreDependance;
import fr.sirs.core.model.CheminAccesDependance;
import fr.sirs.core.model.OuvrageVoirieDependance;
import javafx.scene.Cursor;
import javafx.scene.control.ChoiceDialog;
import javafx.scene.input.MouseEvent;
import javafx.scene.input.ScrollEvent;
import org.geotoolkit.display.VisitFilter;
import org.geotoolkit.display2d.GraphicVisitor;
import org.geotoolkit.display2d.canvas.AbstractGraphicVisitor;
import org.geotoolkit.display2d.canvas.RenderingContext2D;
import org.geotoolkit.display2d.primitive.ProjectedCoverage;
import org.geotoolkit.display2d.primitive.ProjectedFeature;
import org.geotoolkit.display2d.primitive.SearchAreaJ2D;
import org.geotoolkit.feature.Feature;
import org.geotoolkit.geometry.jts.JTS;
import org.geotoolkit.gui.javafx.render2d.AbstractNavigationHandler;
import org.geotoolkit.gui.javafx.render2d.FXMap;
import org.geotoolkit.gui.javafx.render2d.FXPanMouseListen;
import org.geotoolkit.gui.javafx.render2d.shape.FXGeometryLayer;
import org.apache.sis.referencing.CRS;
import org.opengis.referencing.operation.TransformException;
import org.opengis.util.FactoryException;

import java.awt.geom.Rectangle2D;
import java.util.Optional;
import java.util.logging.Level;


/**
 * @author Cédric Briançon (Geomatys)
 */
public class DependanceTransformHandler extends AbstractNavigationHandler {
    private final MouseListen mouseInputListener = new MouseListen();
    private final FXGeometryLayer geomLayer = new FXGeometryLayer();

    public DependanceTransformHandler() {
        super();
    }

    @Override
    public void install(FXMap component) {
        super.install(component);
        map.addEventHandler(MouseEvent.ANY, mouseInputListener);
        map.addEventHandler(ScrollEvent.ANY, mouseInputListener);
        map.setCursor(Cursor.CROSSHAIR);
        map.addDecoration(0, geomLayer);
    }

    @Override
    public boolean uninstall(FXMap component) {
        super.uninstall(component);
        component.removeEventHandler(MouseEvent.ANY, mouseInputListener);
        component.removeEventHandler(ScrollEvent.ANY, mouseInputListener);
        component.removeDecoration(geomLayer);
        return true;
    }


    private class MouseListen extends FXPanMouseListen {
        public MouseListen() {
            super(DependanceTransformHandler.this);
        }

        @Override
        public void mouseClicked(final MouseEvent e) {
            final GraphicVisitor visitor = new AbstractGraphicVisitor() {

                @Override
                public void visit(ProjectedFeature feature, RenderingContext2D context, SearchAreaJ2D area) {
                    final Feature f = feature.getCandidate();
                    // Choix du type de dépendance à créer
                    final ChoiceDialog<String> dialog = new ChoiceDialog<>("Aires de stockage", "Aires de stockage", "Autres", "Chemins d'accès", "Ouvrages de voirie");
                    dialog.setTitle("Création de dépendance");
                    dialog.setContentText("Choisir un type de dépendance");
                    Optional<String> result = dialog.showAndWait();
                    result.ifPresent(type -> {
                        final Class clazz;
                        switch (type) {
                            case "Aires de stockage":
                                clazz = AireStockageDependance.class;
                                break;
                            case "Autres":
                                clazz = AutreDependance.class;
                                break;
                            case "Chemins d'accès":
                                clazz = CheminAccesDependance.class;
                                break;
                            case "Ouvrages de voirie":
                                clazz = OuvrageVoirieDependance.class;
                                break;
                            default:
                                clazz = AireStockageDependance.class;
                        }

                        final Session session = Injector.getSession();
                        final AbstractSIRSRepository<AbstractDependance> repodep = session.getRepositoryForClass(clazz);
                        final AbstractDependance dependance = repodep.create();

                        Geometry geom = (Geometry) f.getDefaultGeometryProperty().getValue();

                        //conversion du CRS de la donnée vers le CRS de la base
                        try {
                            geom = JTS.transform(geom, CRS.findOperation(
                                    f.getDefaultGeometryProperty().getType().getCoordinateReferenceSystem(),
                                    session.getProjection(), null).getMathTransform());
                            JTS.setCRS(geom, session.getProjection());
                        } catch (TransformException | FactoryException ex) {
                            SIRS.LOGGER.log(Level.WARNING, ex.getLocalizedMessage(), ex);
                        }

                        dependance.setGeometry(geom);
                        repodep.add(dependance);

                        map.getCanvas().repaint();
                    });
                }

                @Override
                public void visit(ProjectedCoverage coverage, RenderingContext2D context, SearchAreaJ2D area) {}
            };

            final Rectangle2D clickArea = new Rectangle2D.Double(e.getX()-2, e.getY()-2, 4, 4);
            map.getCanvas().getGraphicsIn(clickArea, visitor, VisitFilter.INTERSECTS);
        }
    }
}
