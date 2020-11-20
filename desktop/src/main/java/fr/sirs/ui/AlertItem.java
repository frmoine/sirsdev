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
package fr.sirs.ui;


import static fr.sirs.ui.AlertItem.AlertItemLevel.NORMAL;
import java.time.LocalDate;

/**
 *
 * @author Cédric Briançon (Geomatys)
 */
public class AlertItem implements Comparable<AlertItem> {
    /**
     * Titre de l'alerte.
     */
    private final String title;

    /**
     * Date de l'alerte.
     */
    private final LocalDate date;

    /**
     * Objet déclenchant l'alerte.
     */
    private final Object parent;

    /**
     * Niveau de l'alerte.
     */
    private final AlertItemLevel level;

    /**
     * Niveaux possibles d'alerte.
     */
    public enum AlertItemLevel{
        INFORMATION(0),
        NORMAL(1),
        WARNING(2),
        HIGH(3);
        
        private final int priority;
        private AlertItemLevel(final int priority) {
            this.priority = priority;
        }
    }

    /**
     * Création d'une alerte.
     *
     * @param title  Titre de l'alerte
     * @param date   Date de l'alerte
     * @param parent Parent, objet déclenchant l'alerte
     * @param level  Niveau de l'alerte
     */
    public AlertItem(final String title, final LocalDate date, final Object parent, final AlertItemLevel level) {
        this.title = title;
        this.date = date;
        this.level = level;
        this.parent = parent;
    }

    /**
     * Création d'une alerte. Par défaut au niveau {@linkplain AlertItem.AlertItemLevel#NORMAL normal}.
     *
     * @param title  Titre de l'alerte
     * @param date   Date de l'alerte
     * @param parent Parent, objet déclenchant l'alerte
     */
    public AlertItem(final String title, final LocalDate date, final Object parent) {
        this(title, date, parent, NORMAL);
    }

    public String getTitle() {
        return title;
    }

    public LocalDate getDate() {
        return date;
    }
    
    public AlertItemLevel getLevel(){
        return level;
    }

    public Object getParent() {
        return parent;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        AlertItem alertItem = (AlertItem) o;

        if (title != null ? !title.equals(alertItem.title) : alertItem.title != null) return false;
        if (date != null ? !date.equals(alertItem.date) : alertItem.date != null) return false;
        return level == alertItem.level;

    }

    @Override
    public int hashCode() {
        int result = title != null ? title.hashCode() : 0;
        result = 31 * result + (date != null ? date.hashCode() : 0);
        result = 31 * result + (level != null ? level.hashCode() : 0);
        return result;
    }

    @Override
    public int compareTo(AlertItem o) {
        if (o == null) return -1;

        // First, sort by priority
        int priority = level == null? 
                (o.level == null? 0 : 1)
                : o.level.priority - level.priority;
        if (priority != 0)
            return priority;

        // then sort by date
        priority = date == null?
                (o.date == null? 0 : 1)
                : date.compareTo(o.date);
        if (priority != 0)
            return priority;

        // finally, sort by title
        return title == null? 
                (o.title == null? 0 : 1)
                : title.compareTo(o.title);
    }
}
