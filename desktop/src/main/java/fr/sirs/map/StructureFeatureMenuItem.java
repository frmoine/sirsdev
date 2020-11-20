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

import fr.sirs.SIRS;
import java.lang.ref.WeakReference;
import java.util.List;
import javafx.embed.swing.SwingFXUtils;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.ButtonBar;
import javafx.scene.control.MenuItem;
import javafx.scene.control.TreeItem;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.BorderPane;
import javafx.stage.Modality;
import javafx.stage.Stage;
import org.geotoolkit.data.FeatureStore;
import org.geotoolkit.data.bean.BeanStore;
import org.geotoolkit.data.query.Selector;
import org.geotoolkit.data.query.Source;
import org.geotoolkit.font.FontAwesomeIcons;
import org.geotoolkit.font.IconBuilder;
import org.geotoolkit.gui.javafx.contexttree.TreeMenuItem;
import org.geotoolkit.gui.javafx.layer.FXFeatureTypePane;
import org.geotoolkit.map.FeatureMapLayer;

/**
 *
 * @author Johann Sorel (Geomatys)
 */
public class StructureFeatureMenuItem extends TreeMenuItem {

    private static final Image ICON = SwingFXUtils.toFXImage(
            IconBuilder.createImage(FontAwesomeIcons.ICON_COG, 16, FontAwesomeIcons.DEFAULT_COLOR), null);

    private WeakReference<TreeItem> itemRef;

    public StructureFeatureMenuItem() {

        menuItem = new FeatureStructureMenuItem();
        menuItem.setGraphic(new ImageView(ICON));
    }

    @Override
    public MenuItem init(List<? extends TreeItem> selection) {
        boolean valid = uniqueAndType(selection,FeatureMapLayer.class);
        if(valid && selection.get(0).getParent()!=null){
            //test if it's not a application layer
            final TreeItem treeItem = selection.get(0);
            final FeatureMapLayer layer = (FeatureMapLayer) treeItem.getValue();
            final Source source = layer.getCollection().getSource();
            if(source instanceof Selector){
                final Selector selector = (Selector) source;
                final FeatureStore fs = selector.getSession().getFeatureStore();
                if(fs instanceof BeanStore) return null;
            }

            itemRef = new WeakReference<>(selection.get(0));
            return menuItem;
        }
        return null;
    }


    private class FeatureStructureMenuItem extends MenuItem {

        public FeatureStructureMenuItem() {
            super("Géoréférencement");

            setOnAction(new EventHandler<javafx.event.ActionEvent>() {
                @Override
                public void handle(javafx.event.ActionEvent event) {
                    if(itemRef == null) return;
                    final TreeItem treeItem = itemRef.get();
                    if(treeItem == null) return;
                    final FeatureMapLayer layer = (FeatureMapLayer) treeItem.getValue();
                    FXFeatureTypePane pane = new FXFeatureTypePane();
                    pane.init(layer);


                    final Stage dialog = new Stage();
                    dialog.getIcons().add(SIRS.ICON);
                    dialog.setTitle("Géoréférencement");
                    dialog.setResizable(true);
                    dialog.initModality(Modality.NONE);

                    final Button cancelBtn = new Button("Fermer");
                    cancelBtn.setCancelButton(true);

                    final ButtonBar bbar = new ButtonBar();
                    bbar.setPadding(new Insets(5, 5, 5, 5));
                    bbar.getButtons().addAll(cancelBtn);

                    final BorderPane dialogContent = new BorderPane();
                    dialogContent.setCenter(pane);
                    dialogContent.setBottom(bbar);
                    dialog.setScene(new Scene(dialogContent));
                    dialog.sizeToScene();

                    cancelBtn.setOnAction((ActionEvent e) -> {
                        dialog.close();
                    });

                    dialog.show();

                }
            });
        }

    }

}
