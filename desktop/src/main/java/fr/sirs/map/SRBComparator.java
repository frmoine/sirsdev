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

import com.vividsolutions.jts.geom.LineString;
import com.vividsolutions.jts.geom.Point;
import fr.sirs.Injector;
import fr.sirs.core.LinearReferencingUtilities;
import fr.sirs.core.component.AbstractSIRSRepository;
import fr.sirs.core.model.BorneDigue;
import fr.sirs.core.model.SystemeReperageBorne;
import java.util.Comparator;

/**
 *
 * @author Johann Sorel (Geomatys)
 */
public class SRBComparator implements Comparator<SystemeReperageBorne>{

    private final LineString linear;
    private final LinearReferencingUtilities.SegmentInfo[] segments;
    private final AbstractSIRSRepository<BorneDigue> repo;

    public SRBComparator(LineString line) {
        this.linear = line;
        this.segments = LinearReferencingUtilities.buildSegments(linear);
        this.repo = Injector.getSession().getRepositoryForClass(BorneDigue.class);
    }
    
    @Override
    public int compare(SystemeReperageBorne o1, SystemeReperageBorne o2) {
        final BorneDigue borne1 = repo.get(o1.getBorneId());
        final BorneDigue borne2 = repo.get(o2.getBorneId());
        final Point point1 = borne1.getGeometry();
        final Point point2 = borne2.getGeometry();
        final LinearReferencingUtilities.ProjectedPoint ref1 = LinearReferencingUtilities.projectReference(segments, point1);
        final LinearReferencingUtilities.ProjectedPoint ref2 = LinearReferencingUtilities.projectReference(segments, point2);
        
        return Double.compare(ref1.distanceAlongLinear, ref2.distanceAlongLinear);
    }
    
}
