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
package fr.sirs.importer.v2.mapper;

import com.healthmarketscience.jackcess.Row;
import fr.sirs.core.model.Contact;
import static fr.sirs.importer.DbImporter.cleanNullString;
import java.beans.IntrospectionException;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.function.BiConsumer;
import org.springframework.stereotype.Component;

/**
 *
 * @author Alexis Manin (Geomatys)
 */
@Component
public class ContactMapperSpi extends GenericMapperSpi<Contact> {

    private enum Columns {
        NOM_INTERVENANT,
        PRENOM_INTERVENANT,
        ADRESSE_PERSO_INTERV,
        ADRESSE_L1_PERSO_INTERV,
        ADRESSE_L2_PERSO_INTERV,
        ADRESSE_L3_PERSO_INTERV,
        ADRESSE_CODE_POSTAL_PERSO_INTERV,
        ADRESSE_NOM_COMMUNE_PERSO_INTERV,
        TEL_PERSO_INTERV,
        FAX_PERSO_INTERV,
        MAIL_INTERV,
        SERVICE_INTERV,
        FONCTION_INTERV
    }

    private final HashMap<String, String> bindings;
    public ContactMapperSpi() throws IntrospectionException {
        super(Contact.class);

        bindings = new HashMap<>(9);
        bindings.put(Columns.NOM_INTERVENANT.name(), "nom");
        bindings.put(Columns.PRENOM_INTERVENANT.name(), "prenom");
        bindings.put(Columns.ADRESSE_CODE_POSTAL_PERSO_INTERV.name(), "codePostal");
        bindings.put(Columns.ADRESSE_NOM_COMMUNE_PERSO_INTERV.name(), "commune");
        bindings.put(Columns.TEL_PERSO_INTERV.name(), "telephone");
        bindings.put(Columns.MAIL_INTERV.name(), "email");
        bindings.put(Columns.FAX_PERSO_INTERV.name(), "fax");
        bindings.put(Columns.SERVICE_INTERV.name(), "service");
        bindings.put(Columns.FONCTION_INTERV.name(), "fonction");
    }

    @Override
    public Map<String, String> getBindings() {
        return bindings;
    }

    @Override
    protected Collection<BiConsumer<Row, Contact>> getExtraBindings() {
        return Collections.singleton((input, output) -> {
            output.setAdresse(cleanNullString(input.getString(Columns.ADRESSE_PERSO_INTERV.name()))
                    + cleanNullString(input.getString(Columns.ADRESSE_L1_PERSO_INTERV.name()))
                    + cleanNullString(input.getString(Columns.ADRESSE_L2_PERSO_INTERV.name()))
                    + cleanNullString(input.getString(Columns.ADRESSE_L3_PERSO_INTERV.name())));
        });
    }


}
