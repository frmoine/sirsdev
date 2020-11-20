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
package fr.sirs.plugin.lit;

import fr.sirs.theme.ui.AbstractPluginsButtonTheme;
import javafx.scene.Parent;
import javafx.scene.image.Image;
import javafx.scene.layout.BorderPane;

/**
 *
 * @author guilhem
 */
public class StructureDescriptionTheme extends AbstractPluginsButtonTheme {
    private static final Image BUTTON_IMAGE = new Image(
            StructureDescriptionTheme.class.getResourceAsStream("images/lit-description.png"));
    
    public StructureDescriptionTheme() {
        super("Description du lit", "Descriptions du lit", BUTTON_IMAGE);
        getSubThemes().add(new OuvragesLitTheme());
        getSubThemes().add(new IleBancTheme());
        getSubThemes().add(new ReseauxVoirieTheme());
        getSubThemes().add(new ReseauxOuvrageTheme());
        getSubThemes().add(new DesordresTheme());
        getSubThemes().add(new PrestationsTheme());
        getSubThemes().add(new DocumentTheme());
    }

    @Override
    public Parent createPane() {
        final BorderPane borderPane = new BorderPane();

        return borderPane;
    }
}
