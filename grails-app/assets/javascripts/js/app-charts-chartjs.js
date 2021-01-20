//Set the chart colors
var color1 = "rgb(245, 108, 108)";
var color2 = "rgb(224, 94, 198)";
var color3 = "rgb(152, 22, 156)";
var color4 = "rgb(117, 129, 235)";
var color5 = "rgb(49, 147, 245)";
var color6 = "rgb(101, 209, 54)";
var color7 = "rgb(245, 196, 49)";
var color8 = "rgb(232, 135, 23)";
var color9 = "rgb(71,42,7)";


function donutChart(values){


			var ctx = document.getElementById("donut-chart");

			var data = {
			  labels: [
			  	"Il n'y a pas eu de suivi commercial",
			    "Le tarif proposé est trop onéreux par rapport au budget que je me suis fixé(e)",
			    "Les options proposées ne correspondent pas à mes attentes",
			    "Le catalogue de couleurs n’est pas suffisamment étoffé",
				"Il y a eu une mauvaise compréhension de mon besoin",
				"Je n’ai pas apprécié le contact commercial",
				"Mon projet est annulé",
				"J’ai changé d’avis",
				"Autre"
			  ],
			  datasets: [
			    {
			      data: values ,
			      backgroundColor: [
			        color1,
			        color2,
			        color3,
					color4,
					color5,
					color6,
					color7,
					color8,
					color9
			      ],
			      hoverBackgroundColor: [
			        color1,
			        color2,
			        color3,
					color4,
					color5,
					color6,
					color7,
					color8,
					color9
			      ]
			  	}]
			};

	    var pie = new Chart(ctx, {
        type: 'doughnut',
        data: data,
			options: {
				legend:{
					display: false,
					position: 'right',

					labels:{
						fontSize: 16,
						padding: 20,
						boxWidth: 15
					}


				},
				tooltips: {
					yPadding: 20,
					xPadding: 20,
					caretSize: 10,
					backgroundColor: 'rgb(255,255,255)',
					titleFontColor: 'rgb(38,37,37)',
					bodyFontColor:'rgb(38,37,37)',
					borderColor: 'rgb(203,202,202)',
					borderWidth: 1
				}
			},
      });
}


var randomScalingFactor = function() {
	return Math.round(Math.random() * 100);
};


