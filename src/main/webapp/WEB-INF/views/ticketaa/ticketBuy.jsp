<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
   <script src="/js/chart/Chart.min.js"></script>
   <script src="/js/chart/utils.js"></script>
   <style>
   canvas{
      -moz-user-select: none;
      -webkit-user-select: none;
      -ms-user-select: none;
   }
   </style>
   <div style="width:80%;">
      <canvas id="canvas"></canvas>
   </div>
   <br>
   <br>
   <button id="randomizeData">Randomize Data</button>
   <button id="addDataset">Add Dataset</button>
   <button id="removeDataset">Remove Dataset</button>
   <button id="addData">Add Data</button>
   <button id="removeData">Remove Data</button>
   <script>
      var MONTHS = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
      var config = {
         type: 'line',
         data: {
            labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
            datasets: [{
               label: '30일권',
               backgroundColor: window.chartColors.red,
               borderColor: window.chartColors.red,
               //데이터가 들어감 
               data: [
                  randomScalingFactor(),
                  randomScalingFactor(),
                  randomScalingFactor(),
                  randomScalingFactor()
               ],
               fill: false,
            }, {
               label: '1일권',
               fill: false,
               backgroundColor: window.chartColors.blue,
               borderColor: window.chartColors.blue,
               data: [
                  randomScalingFactor(),
                  randomScalingFactor(),
                  randomScalingFactor(),
                  randomScalingFactor(),
                  randomScalingFactor(),
                  randomScalingFactor(),
                  randomScalingFactor()
               ],
            }]
         },
         options: {
        	 cursor:"pointer",
         
            responsive: true,
            title: {
               display: true,
               text: 'Chart.js Line Chart'
            },
            tooltips: {
               mode: 'index',
               intersect: false,
            },
            hover: {
               mode: 'nearest',
               intersect: true
            },
            scales: {
               xAxes: [{
                  display: true,
                  scaleLabel: {
                     display: true,
                     labelString: 'Month'
                  }
               }],
               yAxes: [{
                  display: true,
                  scaleLabel: {
                     display: true,
                     labelString: 'Value'
                  }
               }]
            }
         }
      };

      window.onload = function() {
         var ctx = document.getElementById('canvas').getContext('2d');
         window.myLine = new Chart(ctx, config);
      };

      document.getElementById('randomizeData').addEventListener('click', function() {
         config.data.datasets.forEach(function(dataset) {
            dataset.data = dataset.data.map(function() {
               return randomScalingFactor();
            });

         });

         window.myLine.update();
      });

      //데이터 추가 
      var colorNames = Object.keys(window.chartColors);
      document.getElementById('addDataset').addEventListener('click', function() {
         var colorName = colorNames[config.data.datasets.length % colorNames.length];
         var newColor = window.chartColors[colorName];
         var newDataset = {
            label: 'Dataset ' + config.data.datasets.length,
            backgroundColor: newColor,
            borderColor: newColor,
            data: [],
            fill: false
         };

         for (var index = 0; index < config.data.labels.length; ++index) {
            newDataset.data.push(randomScalingFactor());
         }

         config.data.datasets.push(newDataset);
         window.myLine.update();
      });

      document.getElementById('addData').addEventListener('click', function() {
         if (config.data.datasets.length > 0) {
            var month = MONTHS[config.data.labels.length % MONTHS.length];
            config.data.labels.push(month);

            config.data.datasets.forEach(function(dataset) {
               dataset.data.push(randomScalingFactor());
            });

            window.myLine.update();
         }
      });

      document.getElementById('removeDataset').addEventListener('click', function() {
         config.data.datasets.splice(0, 1);
         window.myLine.update();
      });

      document.getElementById('removeData').addEventListener('click', function() {
         config.data.labels.splice(-1, 1); // remove the label first

         config.data.datasets.forEach(function(dataset) {
            dataset.data.pop();
         });

         window.myLine.update();
      });
   </script>