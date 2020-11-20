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

import fr.sirs.SIRS;
import fr.sirs.core.model.report.ExterneSectionRapport;
import fr.sirs.util.FXFileTextField;
import javafx.beans.value.ObservableValue;
import javafx.fxml.FXML;
import javafx.scene.control.TextField;
import javafx.scene.layout.BorderPane;

/**
 *
 * @author Alexis Manin (Geomatys)
 */
public class FXExterneSectionRapportPane extends AbstractFXElementPane<ExterneSectionRapport> {

    @FXML private TextField uiTitle;
    @FXML private BorderPane uiPathContainer;
    private final FXFileTextField uiPathEditor;

    @Override
    public void preSave() throws Exception {
        elementProperty.get().setChemin(uiPathEditor.getText());
    }

    public FXExterneSectionRapportPane() {
        super();
        SIRS.loadFXML(this);

        uiPathEditor = new FXFileTextField();
        uiPathContainer.setCenter(uiPathEditor);
        elementProperty.addListener(this::elementChanged);

        uiTitle.disableProperty().bind(disableFieldsProperty());
        uiPathEditor.disableProperty().bind(disableFieldsProperty());
    }

    public FXExterneSectionRapportPane(final ExterneSectionRapport rapport) {
        this();
        setElement(rapport);
    }


    /**
     * Called when element edited change. We must update all UI to manage the new one.
     * @param obs
     * @param oldValue
     * @param newValue
     */
    private void elementChanged(ObservableValue<? extends ExterneSectionRapport> obs, ExterneSectionRapport oldValue, ExterneSectionRapport newValue) {
        if (oldValue != null) {
            uiTitle.textProperty().unbindBidirectional(oldValue.libelleProperty());
        }

        if (newValue == null) {
            uiPathEditor.setText(null);
        } else {
            uiTitle.textProperty().bindBidirectional(newValue.libelleProperty());
            uiPathEditor.setText(newValue.getChemin());
        }
    }
}
