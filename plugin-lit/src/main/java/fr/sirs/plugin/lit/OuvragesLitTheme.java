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

import fr.sirs.core.model.AutreOuvrageLit;
import fr.sirs.core.model.PlageDepotLit;
import fr.sirs.core.model.SeuilLit;
import fr.sirs.plugin.lit.ui.AbstractDescriptionPane;
import fr.sirs.plugin.lit.util.TabContent;
import java.util.ArrayList;
import java.util.List;
import javafx.scene.Parent;
import javafx.scene.layout.BorderPane;

/**
 *
 * @author Guilhem Legal (Geomatys)
 */
public class OuvragesLitTheme extends AbstractDescriptionTheme {
    
    public OuvragesLitTheme() {
        super("Ouvrages dans le lit", "Ouvrages dans le lit");
    }
    
    @Override
    public Parent createPane() {
        List<TabContent> content = new ArrayList<>();
        content.add(new TabContent("Seuils", "Tableau des seuils", SeuilLit.class));
        content.add(new TabContent("Plage de depôt", "Tableau des plages de depôt", PlageDepotLit.class));
        content.add(new TabContent("Autres ouvrages", "Tableau des ouvrages complementaire", AutreOuvrageLit.class));
        
        final BorderPane borderPane = new AbstractDescriptionPane(content);
        return borderPane;
    }
}
