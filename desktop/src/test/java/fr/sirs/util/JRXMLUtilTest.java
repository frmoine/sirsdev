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
package fr.sirs.util;

import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author Samuel Andrés (Geomatys) <samuel.andres at geomatys.com>
 */
public class JRXMLUtilTest {
    
    @Test
    public void test_extractDesignation() {
        assertEquals("27", JRXMLUtil.extractDesignation("TrD - 27 : Isère RD du pont RN90 (P 549) à amont pont de Pique Pierre (P 610)"));
    }
    
    @Test
    public void test_extractLabel() {
        assertEquals("Présence de Végétation dangereuse (arbustive et/ou arborescente, ou de souches)", JRXMLUtil.extractLabel("VEG : Présence de Végétation dangereuse (arbustive et/ou arborescente, ou de souches)"));
        assertEquals("Isère RD du pont RN90 (P 549) à amont pont de Pique Pierre (P 610)", JRXMLUtil.extractLabel("TrD - 27 : Isère RD du pont RN90 (P 549) à amont pont de Pique Pierre (P 610)"));
        
        // Cas particulier observé lorsque l'utilisateur souhaite n'oberver que le nom complet/abrégé de la désignation.
        assertEquals("Ct 45", JRXMLUtil.extractLabel("1) Ct 45"));        
    }
    
    @Test
    public void test_extractLabels() {
        assertEquals("1) Maurel\n" +
                    "2) Gomes\n" +
                    "3) Cardinet\n" +
                    "4) Platz", 
                JRXMLUtil.extractLabels(
                        "1) Ct - 2 : Maurel\n" +
                        "2) Ct - 4 : Gomes\n" +
                        "3) Ct - 7 : Cardinet\n" +
                        "4) Ct - 3 : Platz", true, 1));
    }
     
     
}
