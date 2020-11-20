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
package fr.sirs.ui.calendar;

import javafx.scene.control.Button;
import javafx.scene.layout.Priority;

import java.util.Calendar;

/**
 * Shows the years of several decades.
 *
 * @author Christian Schudt
 */
final class DecadesView extends DatePane {

    private static final String CSS_CALENDAR_DECADES_VIEW = "calendar-decades-view";


    private final static int NUMBER_OF_DECADES = 2;

    public DecadesView(final CalendarView calendarView) {
        super(calendarView);
        getStyleClass().add(CSS_CALENDAR_DECADES_VIEW);
    }

    /**
     * {@inheritDoc}
     */
    @Override
    protected void buildContent() {

        final Calendar calendar = calendarView.getCalendar();

        for (int i = 0; i < NUMBER_OF_DECADES * 10; i++) {

            final Button button = new Button();
            button.setMaxWidth(Double.MAX_VALUE);
            button.setMaxHeight(Double.MAX_VALUE);
            setVgrow(button, Priority.ALWAYS);
            setHgrow(button, Priority.ALWAYS);

            button.getStyleClass().add("calendar-year-button");
            button.setOnAction(actionEvent -> {
                if (calendarView.currentlyViewing.get() == Calendar.ERA) {
                    calendar.set(Calendar.YEAR, (Integer) button.getUserData());
                    calendarView.currentlyViewing.set(Calendar.YEAR);
                    calendarView.calendarDate.set(calendar.getTime());
                }
            }

            );
            int rowIndex = i % 5;
            int colIndex = (i - rowIndex) / 5;

            add(button, rowIndex, colIndex);
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    protected void updateContent() {
        final Calendar calendar = calendarView.getCalendar();

        int year = calendar.get(Calendar.YEAR);
        int a = year % 10;
        if (a < 5) {
            a += 10;
        }
        int startYear = year - a;
        for (int i = 0; i < 10 * NUMBER_OF_DECADES; i++) {
            final int y = i + startYear;
            Button button = (Button) getChildren().get(i);
            button.setText(Integer.toString(y));
            button.setUserData(y);
        }

        title.set(String.format("%s - %s", startYear, startYear + 10 * NUMBER_OF_DECADES - 1));
    }
}
