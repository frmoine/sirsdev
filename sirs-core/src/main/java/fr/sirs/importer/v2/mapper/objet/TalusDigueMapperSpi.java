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
package fr.sirs.importer.v2.mapper.objet;

import org.springframework.stereotype.Component;

import com.healthmarketscience.jackcess.Row;
import fr.sirs.core.model.TalusDigue;
import fr.sirs.importer.v2.mapper.GenericMapperSpi;
import java.beans.IntrospectionException;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.function.BiConsumer;

/**
 *
 * @author Alexis Manin (Geomatys)
 */
@Component
public class TalusDigueMapperSpi extends GenericMapperSpi<TalusDigue> {

    private final HashMap<String, String> bindings;

    public TalusDigueMapperSpi() throws IntrospectionException {
        super(TalusDigue.class);

        bindings = new HashMap<>(12);
        bindings.put(StructureColumns.ID_SOURCE.name(), "sourceId");
        bindings.put(StructureColumns.ID_TYPE_COTE.name(), "coteId");

        bindings.put(StructureColumns.ID_TYPE_MATERIAU_HAUT.name(), "materiauHautId");
        bindings.put(StructureColumns.ID_TYPE_NATURE_HAUT.name(), "natureHautId");
        bindings.put(StructureColumns.LONG_RAMP_HAUT.name(), "longueurRampantHaut");

        bindings.put(StructureColumns.ID_TYPE_MATERIAU_BAS.name(), "materiauBasId");
        bindings.put(StructureColumns.ID_TYPE_NATURE_BAS.name(), "natureBasId");
        bindings.put(StructureColumns.LONG_RAMP_BAS.name(), "longueurRampantBas");

        bindings.put(StructureColumns.ID_TYPE_FONCTION.name(), "fonctionBasId");
        bindings.put(StructureColumns.EPAISSEUR.name(), "epaisseurSommet");
        bindings.put(StructureColumns.N_COUCHE.name(), "numCouche");
        bindings.put(StructureColumns.PENTE_INTERIEURE.name(), "penteInterieure");
    }

    @Override
    public Map<String, String> getBindings() {
        return bindings;
    }

    @Override
    protected Collection<BiConsumer<Row, TalusDigue>> getExtraBindings() {
        return Collections.singleton((input, output) -> output.setFonctionHautId(output.getFonctionBasId()));
    }
}
