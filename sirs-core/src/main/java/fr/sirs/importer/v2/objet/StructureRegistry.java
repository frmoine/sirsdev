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
package fr.sirs.importer.v2.objet;

import com.healthmarketscience.jackcess.Row;
import fr.sirs.core.model.Crete;
import fr.sirs.core.model.Epi;
import fr.sirs.core.model.Fondation;
import fr.sirs.core.model.Objet;
import fr.sirs.core.model.OuvrageRevanche;
import fr.sirs.core.model.PiedDigue;
import fr.sirs.core.model.SommetRisberme;
import fr.sirs.core.model.TalusDigue;
import fr.sirs.core.model.TalusRisberme;
import fr.sirs.importer.DbImporter;
import static fr.sirs.importer.DbImporter.TableName.TYPE_ELEMENT_STRUCTURE;
import static fr.sirs.importer.DbImporter.TableName.valueOf;
import fr.sirs.importer.v2.ImportContext;
import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 *
 * @author Samuel Andres (Geomatys)
 * @author Alexis Manin (Geomatys)
 */
@Component
public class StructureRegistry {

    private enum Columns {

        ID_TYPE_ELEMENT_STRUCTURE,
        NOM_TABLE_EVT
    };

    private final HashMap<Object, Class<? extends Objet>> types = new HashMap<>(8);

    @Autowired
    private StructureRegistry(ImportContext context) throws IOException {
        Iterator<Row> iterator = context.inputDb.getTable(TYPE_ELEMENT_STRUCTURE.name()).iterator();

        while (iterator.hasNext()) {
            final Row row = iterator.next();
            try {
                final Class clazz;
                final DbImporter.TableName table = valueOf(row.getString(Columns.NOM_TABLE_EVT.toString()));
                switch (table) {
                    case SYS_EVT_CRETE:
                        clazz = Crete.class;
                        break;
                    case SYS_EVT_TALUS_DIGUE:
                        clazz = TalusDigue.class;
                        break;
                    case SYS_EVT_SOMMET_RISBERME:
                        clazz = SommetRisberme.class;
                        break;
                    case SYS_EVT_TALUS_RISBERME:
                        clazz = TalusRisberme.class;
                        break;
                    case SYS_EVT_PIED_DE_DIGUE:
                        clazz = PiedDigue.class;
                        break;
//                    case SYS_EVT_TALUS_FRANC_BORD:
//                        clazz = FrontFrancBord.class;
//                        break;
//                    case SYS_EVT_PIED_FRONT_FRANC_BORD:
//                        clazz = PiedFrontFrancBord.class;
//                        break;
                    case SYS_EVT_FONDATION:
                        clazz = Fondation.class;
                        break;
//                case SYS_EVT_OUVRAGE_PARTICULIER: // Les ouvrages particuliers sont en fait des éléments de réseau
//                    clazz = OuvrageParticulier.class; break;
//                    case SYS_EVT_BRISE_LAME: // Les brise-lames n'existent pas dans le modèle car ils feront partie d'un module "ouvrages à la mer" en 2015
//                        clazz = BriseLame.class; break;
                    case SYS_EVT_EPIS:
                        clazz = Epi.class;
                        break;
//                    case SYS_EVT_VEGETATION: // La végétation est un module à part.
//                        clazz = Vegetation.class; break;
                    case SYS_EVT_OUVRAGE_REVANCHE:
                        clazz = OuvrageRevanche.class;
                        break;
                    default:
                        // Dans la table de l'Isère, on trouve SYS_EVT_FRONT_FRANC_BORD qui n'existe pas et qui semble correspondre à SYS_EVT_TALUS_FRANC_BORD
//                        if("SYS_EVT_FRONT_FRANC_BORD".equals(row.getString(Columns.NOM_TABLE_EVT.toString()))){
//                            clazz = FrontFrancBord.class;
//                        }
//                        else {
//                            System.out.println(row.getString(Columns.NOM_TABLE_EVT.toString()));
                        clazz = null;
//                        }
                }

                if (clazz == null) {
                    //context.reportError(new ErrorReport(null, row, TYPE_ELEMENT_STRUCTURE.name(), Columns.NOM_TABLE_EVT.name(), null, null, "Unrecognized structure type", null));
                } else {
                    types.put(row.get(Columns.ID_TYPE_ELEMENT_STRUCTURE.name()), clazz);
                }
            } catch (IllegalArgumentException e) {
                //context.reportError(new ErrorReport(null, row, TYPE_ELEMENT_STRUCTURE.name(), Columns.NOM_TABLE_EVT.name(), null, null, "Unrecognized structure type", null));
            }
        }
    }

    /**
     * @param typeId An id found in {@link Columns#ID_TYPE_ELEMENT_STRUCTURE} column.
     * @return document class associated to given document type ID, or null, if
     * given Id is unknown.
     */
    public Class<? extends Objet> getElementType(final Object typeId) {
        return types.get(typeId);
    }

    public Class<? extends Objet> getElementType(final Row input) {
        final Object typeId = input.get(Columns.ID_TYPE_ELEMENT_STRUCTURE.name());
        if (typeId != null) {
            return getElementType(typeId);
        }
        return null;
    }

    public Collection<Class<? extends Objet>> allTypes() {
        return types.values();
    }
}
