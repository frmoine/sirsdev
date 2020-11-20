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
package fr.sirs.map;

import fr.sirs.Plugin;
import fr.sirs.Plugins;
import java.awt.geom.Rectangle2D;
import javafx.event.EventHandler;
import javafx.scene.control.ContextMenu;
import javafx.scene.input.MouseButton;
import javafx.scene.input.MouseEvent;
import org.geotoolkit.data.bean.BeanFeature;
import org.geotoolkit.display.VisitFilter;
import org.geotoolkit.display2d.canvas.AbstractGraphicVisitor;
import org.geotoolkit.display2d.canvas.RenderingContext2D;
import org.geotoolkit.display2d.primitive.ProjectedCoverage;
import org.geotoolkit.display2d.primitive.ProjectedFeature;
import org.geotoolkit.display2d.primitive.SearchAreaJ2D;
import org.geotoolkit.gui.javafx.render2d.FXCanvasHandler;
import org.geotoolkit.gui.javafx.render2d.FXMap;
import org.geotoolkit.gui.javafx.render2d.navigation.FXPanHandler;
import org.geotoolkit.gui.javafx.render2d.navigation.FXZoomInHandler;
import org.geotoolkit.gui.javafx.render2d.navigation.FXZoomOutHandler;

/**
 * Ce Handler est utilisé sur un control FXMap.
 * Lors d'un click, celui ci récupère les objets de la carte présent sous la souris
 * puis parcourt la liste des plugins afin de créer un menu contextuel.
 * Si des actions sont disponible alors le menu est affiché.
 * 
 * @author Johann Sorel (Geomatys)
 */
final class MapActionHandler implements EventHandler<MouseEvent>{

    private final FXMap map;
    private final ContextMenu menu = new ContextMenu();
    
    MapActionHandler(FXMap map){
        this.map = map;
        menu.setAutoHide(true);
    }
    
    @Override
    public void handle(final MouseEvent event) {
        if(event.getButton()!=MouseButton.SECONDARY || map == null) return;

        final FXCanvasHandler handler = map.getHandler();
        //handle event only if it's a navigation handler
        if(!(handler instanceof FXZoomInHandler || handler instanceof FXZoomOutHandler || handler instanceof FXPanHandler)){
            return;
        }
        
        menu.hide();
        menu.getItems().clear();
        
        //recherche des objets sous la souris
        final Rectangle2D clickArea = new Rectangle2D.Double(event.getX()-2, event.getY()-2, 4, 4);
        map.getCanvas().getGraphicsIn(clickArea, new AbstractGraphicVisitor() {

            @Override
            public void visit(ProjectedFeature graphic, RenderingContext2D context, SearchAreaJ2D area) {
                final Object bean = graphic.getCandidate().getUserData().get(BeanFeature.KEY_BEAN);
                if(bean!=null){
                    //recherche des actions disponibles pour l'object selectionné
                    final Plugin[] plugins = Plugins.getPlugins();   
                    for(Plugin plugin : plugins){
                        menu.getItems().addAll(plugin.getMapActions(bean));
                    }     
                }
            }

            @Override
            public void visit(ProjectedCoverage coverage, RenderingContext2D context, SearchAreaJ2D area) {
            }

            @Override
            public void endVisit() {
                super.endVisit();
                if(!menu.getItems().isEmpty()){
                    menu.show(map, event.getScreenX(), event.getScreenY());
                } 
            }

        }, VisitFilter.INTERSECTS);
    }
    
}
