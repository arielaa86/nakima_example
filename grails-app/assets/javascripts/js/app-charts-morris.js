
var monthNames = ["", "Janvier", "Février", "Mars", "Avril", "Mai", "Juin",
    "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"];


//Line Chart
function line_chart(values) {
    var color1 = '#2cc185';
    var color2 = '#fa6163';
    var color3 = 'rgba(255, 255, 255, 0.0)';

    var data = [];

    var texto = values.substring(1, values.length-1)
    var texteArray = texto.split(",")

    for(var i =0; i < texteArray.length; i++){

        var arr = texteArray[i].split(":");
        var period = arr[0];
        var recette = Number.parseFloat(arr[1]).toFixed(2);
        var depense = Number.parseFloat(arr[2]).toFixed(2)

        data.push( {"period": period, "recette": recette, "depense": depense, "gain": (recette - depense).toFixed(2) })
    }


    new Morris.Line({
        element: 'line-chart',
        data: data,
        xkey: 'period',
        parseTime: false,
        xLabelAngle: '0',
        pointStrokeColors: ['#ffffff', '#ffffff', color3],
        labelColor: [color1, color2, color3],
        resize: false,
        yLabelFormat: function(y) { return Number.parseFloat(y).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ');},
        ymin: 0,
        ykeys: ['recette', 'depense', 'gain'],
        labels: ['Recettes', 'Dépenses', 'Gain'],
        lineColors: [color1, color2, color3],
        xLabelFormat: function (x) {
            var index = parseInt(x.src.period);
            return monthNames[index];
        },
        xLabels: "month",
    });
}

