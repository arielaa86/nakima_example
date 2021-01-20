/*!
 * Maisonnette-admin v1.3.2
 * https://foxythemes.net
 *
 * Copyright (c) 2019 Foxy Themes
 */




var App = (function () {
    'use strict';

    App.profile = function () {

        var listeEvenement="";

        //Calendar Widget
        function calendar_widget() {
            var widget = $(".widget-calendar");
            var calNotes = $(".cal-notes", widget);
            var calNotesDay = $(".day", calNotes);
            var calNotesDate = $(".date", calNotes);


            listeEvenement = document.getElementById("listeEvenement")

            //Calculate the weekday name
            var d = new Date();
            var weekday = new Array(7);
            weekday[0] = "Dimanche";
            weekday[1] = "Lundi";
            weekday[2] = "Mardi";
            weekday[3] = "Mercredi";
            weekday[4] = "Jeudi";
            weekday[5] = "Vendredi";
            weekday[6] = "Samedi";

            var weekdayName = weekday[d.getDay()];

            calNotesDay.html(weekdayName);

            //Calculate the month name
            var month = new Array();
            month[0] = "Janvier";
            month[1] = "Février";
            month[2] = "Mars";
            month[3] = "Avril";
            month[4] = "Mai";
            month[5] = "Juin";
            month[6] = "Juillet";
            month[7] = "Août";
            month[8] = "Septembre";
            month[9] = "Octobre";
            month[10] = "Novembre";
            month[11] = "Décembre";

            var monthName = month[d.getMonth()];
            var monthDay = d.getDate();
            var year = d.getFullYear()

            var today = monthDay + " " + monthName + " " + year

            calNotesDate.html(today);



            if (typeof jQuery.ui != 'undefined') {
                $(".ui-datepicker").datepicker({
                    onSelect: function (s, o) {
                        var sd = new Date(s);
                        var weekdayName = weekday[sd.getDay()];
                        var monthName = month[sd.getMonth()];
                        var monthDay = sd.getDate();
                        var year = sd.getFullYear()

                        var selectedDate = monthDay + " " + monthName + " " + year
                        calNotesDay.html(weekdayName);
                        calNotesDate.html(selectedDate);

                        obtenirTaches(selectedDate);

                    }
                });




            }


        }



        function obtenirTaches(selectedDate) {

            var baseURL = window.location.origin;

            fetch(baseURL+'/tache/getTachesByDay/?date=' + selectedDate, {
                "method": "GET"
            })
                .then(response => {
                    return response.text()
                })
                .then(data => {

                    listeEvenement.innerHTML = data;

                })
                .catch((error) => {
                   // alert('Error:' + error);
                });

        }


        calendar_widget();

    };

    return App;
})(App || {});