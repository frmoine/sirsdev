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
package fr.sirs.importer.v2.mapper.objet.reseau;

import org.springframework.stereotype.Component;

import fr.sirs.core.model.ReseauTelecomEnergie;
import fr.sirs.importer.v2.mapper.GenericMapperSpi;
import java.beans.IntrospectionException;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author Alexis Manin (Geomatys)
 */
@Component
public class ReseauTelecomEnergieMapperSpi extends GenericMapperSpi<ReseauTelecomEnergie> {

    private final HashMap<String, String> bindings = new HashMap<>();

    public ReseauTelecomEnergieMapperSpi() throws IntrospectionException {
        super(ReseauTelecomEnergie.class);
        bindings.put(ObjetReseauMapperSpi.Columns.ID_TYPE_POSITION.name(), "positionId");
        bindings.put(ObjetReseauMapperSpi.Columns.ID_IMPLANTATION.name(), "implantationId");
        bindings.put(ObjetReseauMapperSpi.Columns.ID_TYPE_RESEAU_COMMUNICATION.name(), "typeReseauTelecomEnergieId");
        bindings.put(ObjetReseauMapperSpi.Columns.HAUTEUR.name(), "hauteur");
    }

    @Override
    public Map<String, String> getBindings() {
        return bindings;
    }
}
