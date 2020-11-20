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
package fr.sirs.importer.v2.mapper.document.profil;

import com.healthmarketscience.jackcess.Row;
import com.healthmarketscience.jackcess.Table;
import fr.sirs.core.model.LeveProfilTravers;
import fr.sirs.core.model.Organisme;
import fr.sirs.core.model.RefOrigineProfilTravers;
import fr.sirs.core.model.RefSystemeReleveProfil;
import fr.sirs.core.model.RefTypeProfilTravers;
import fr.sirs.importer.AccessDbImporterException;
import fr.sirs.importer.v2.AbstractImporter;
import fr.sirs.importer.v2.ImportContext;
import fr.sirs.importer.v2.mapper.AbstractMapper;
import fr.sirs.importer.v2.mapper.Mapper;
import fr.sirs.importer.v2.mapper.MapperSpi;
import java.io.IOException;
import java.time.LocalDate;
import java.util.Date;
import java.util.Optional;
import org.springframework.stereotype.Component;

/**
 *
 * @author Alexis Manin (Geomatys)
 */
public class LeveProfilTraversMapper extends AbstractMapper<LeveProfilTravers> {

    private final AbstractImporter<Organisme> orgImporter;
//    private final AbstractImporter<ProfilTravers> pTraversImporter;
    private final AbstractImporter<RefSystemeReleveProfil> TypeSystemeImporter;
    private final AbstractImporter<RefTypeProfilTravers> TypeProfilImporter;
    private final AbstractImporter<RefOrigineProfilTravers> TypeOriginImporter;

    private enum Columns {
//        ID_PROFIL_EN_TRAVERS_LEVE,
//        ID_PROFIL_EN_TRAVERS,
        DATE_LEVE,
        ID_ORG_CREATEUR,
        ID_TYPE_SYSTEME_RELEVE_PROFIL,
        REFERENCE_CALQUE,
        ID_TYPE_PROFIL_EN_TRAVERS,
        ID_TYPE_ORIGINE_PROFIL_EN_TRAVERS
    }

    public LeveProfilTraversMapper(Table table) {
        super(table);
        orgImporter = context.importers.get(Organisme.class);
        TypeSystemeImporter = context.importers.get(RefSystemeReleveProfil.class);
        TypeProfilImporter = context.importers.get(RefTypeProfilTravers.class);
        TypeOriginImporter = context.importers.get(RefOrigineProfilTravers.class);
    }

    @Override
    public void map(Row input, LeveProfilTravers output) throws IllegalStateException, IOException, AccessDbImporterException {

//        final Object profilId = input.get(Columns.ID_PROFIL_EN_TRAVERS.name());
//        if (profilId == null) {
//            throw new AccessDbImporterException("No ID set for foreign key "+Columns.ID_PROFIL_EN_TRAVERS.name() + "in table "+table.getName());
//        }
//        final String importedId = pTraversImporter.getImportedId(profilId);
//        if (importedId == null) {
//            throw new AccessDbImporterException("No imported object found for foreign key "+Columns.ID_PROFIL_EN_TRAVERS.name()+" with value "+profilId);
//        }
        final Date date = input.getDate(Columns.DATE_LEVE.name());
        if (date != null) {
            output.setDateLeve(context.convertData(date, LocalDate.class));
        }

        final String calque = input.getString(Columns.REFERENCE_CALQUE.name());
        if (calque != null) {
            output.setReferenceCalque(calque);
        }

        final Object orgId = input.get(Columns.ID_ORG_CREATEUR.name());
        if (orgId != null) {
            final String newOrgId = orgImporter.getImportedId(orgId);
            if (newOrgId == null) {
                throw new AccessDbImporterException("No imported organism for ID "+orgId);
            }
            output.setOrganismeCreateurId(newOrgId);
        }

        final Object typeSysId = input.get(Columns.ID_TYPE_SYSTEME_RELEVE_PROFIL.name());
        if (typeSysId != null) {
            final String newId = TypeSystemeImporter.getImportedId(typeSysId);
            if (newId == null) {
                throw new AccessDbImporterException("No imported system type for ID "+typeSysId);
            }
            output.setTypeSystemesReleveId(newId);
        }

        final Object typeProfilId = input.get(Columns.ID_TYPE_PROFIL_EN_TRAVERS.name());
        if (typeProfilId != null) {
            final String newId = TypeProfilImporter.getImportedId(typeProfilId);
            if (newId == null) {
                throw new AccessDbImporterException("No imported profil type for ID "+typeProfilId);
            }
            output.setTypeProfilId(newId);
        }

        final Object originId = input.get(Columns.ID_TYPE_ORIGINE_PROFIL_EN_TRAVERS.name());
        if (originId != null) {
            final String newId = TypeOriginImporter.getImportedId(originId);
            if (newId == null) {
                throw new AccessDbImporterException("No imported origin for ID "+originId);
            }
            output.setOriginesProfil(newId);
        }
    }

    @Component
    public static class Spi implements MapperSpi<LeveProfilTravers> {

        @Override
        public Optional<Mapper<LeveProfilTravers>> configureInput(Table inputType) throws IllegalStateException {
            for (final Columns c : Columns.values()) {
                if (!ImportContext.columnExists(inputType, c.name())) {
                    return Optional.empty();
                }
            }
            return Optional.of(new LeveProfilTraversMapper(inputType));
        }

        @Override
        public Class<LeveProfilTravers> getOutputClass() {
            return LeveProfilTravers.class;
        }
    }
}
