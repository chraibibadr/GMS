$(function() {
	var xValues = [];
	var yValues = [];
	$.ajax({
			url: "MachineController",
			data: { op: "charts" },
			type: 'POST',
			success: function(data, textStatus, jqXHR) {
				
				for (var i = 0; i < data.length; i++) {
					xValues.push(data[i].code);
					yValues.push(data[i].nbr);
				}
			}
		});
  'use strict';
  var chartData = {
    labels: xValues,
    datasets: [{
      label: 'Nombre des machines',
      data: yValues,
      backgroundColor: 'rgba(255, 100, 132, 0.2)',
      borderColor: 'rgba(255,100,132,1)',
      borderWidth: 1,
      fill: false
    }]	
  };
  var options = {
    scales: {
      yAxes: [{
        ticks: {
          beginAtZero: true
        },
        gridLines: {
          color: "rgba(204, 204, 204,0.1)"
        }
      }],
      xAxes: [{
        gridLines: {
          color: "rgba(204, 204, 204,0.1)"
        }
      }]
    },
    legend: {
      display: false
    },
    elements: {
      point: {
        radius: 0
      }
    }
  };  
  console.log(chartData);
 
 $( window ).load(function() {
  var barChartCanvas = $("#barChart").get(0).getContext("2d");
	    var barChart = new Chart(barChartCanvas, {
	      type: 'bar',
	      data: chartData,
	      options: options
	    });
	});
});
