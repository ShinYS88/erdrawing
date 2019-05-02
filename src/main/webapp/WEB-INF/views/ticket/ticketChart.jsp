<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.page-header {
    padding-bottom: 9px;
    margin: 40px 0 20px;
    border-bottom: 1px solid #eee;
}
.navbar-brand1 {
    float: left;
    height: 50px;
    padding: 3px 3px;
    font-size: 18px;
    line-height: 20px;
}
.left-menu1 .navbar-brand1 {
    padding: 3px;
}
</style>
<br/><br/>
<div class="navbar-header" style="padding-right: 10px;">
	<ul class="left-menu1" style="margin-top: 100px; color: #D1D1D2;">
		<li class="navbar-brand1" style="font-size: 18px; font-weight: bold;"><a href="/ticket/ticketChart" >Total Sales</a></li>
	</ul>
	
	<ul class="left-menu1" style="color: #D1D1D2;">
		<li class="navbar-brand1" style="font-size: 18px; font-weight: bold;"><a href="/ticket/ticketPie?yyyy=2019">Sales by Product</a></li>
	</ul>
</div>
<br/><br/><br/>	
<div id="chartContainer" style="height: 450px; width: 87%;"></div>

<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
<script>

	window.onload = function() {

	
		var dps =[[],[],[],[],[],[],[],[],[],[],[],[]];
		var dps2 =[[],[],[],[],[],[],[],[],[],[],[],[]];
		var dps3 =[[],[],[],[],[],[],[],[],[],[],[],[]];
		//var dps3 =new Array();
		var chart = new CanvasJS.Chart("chartContainer", {
			animationEnabled : true,
			theme : "dark2", //light2
			title : {
				text : "Total Sales"
			},
			axisX : {
				valueFormatString : "MMM YYYY",
				intervalType : "month",
				interval : 1,
				crosshair : {
					enabled : true,
					snapToDataPoint : true
				}
			},
			axisY : {
				title : "Sales Amount",
				crosshair : {
					enabled : true
				}
			},
			toolTip : {
				shared : true
			},
			legend:{
				cursor:"pointer",
				verticalAlign: "bottom",
				horizontalAlign: "left",
				dockInsidePlotArea: true,
				itemclick: toogleDataSeries
			},
			data : [ {
				type : "line",
				name: "6개월권",
				showInLegend : dps2[0],
				xValueType : "dateTime",
				markerType : "square",
				xValueFormatString : "MMM, YYYY",
				color : "#F08080",
				dataPoints : dps[0]

			} ,
			{
				type : "line",
				name: "1년권",
				xValueType : "dateTime",
				showInLegend : true,
				markerType : "square",
				xValueFormatString : "MMM, YYYY",
				dataPoints : dps[1]

			} ,
		
			{
				type : "line",
				xValueType : "dateTime",
				name: "3개월권",
				color :"#96b850",
				showInLegend : true,
				markerType : "square",
				xValueFormatString : "MMM, YYYY",
				dataPoints : dps[2]

			} ,
			
			{
				type : "line",
				xValueType : "dateTime",
				name: "권",
				showInLegend : true,
				markerType : "square",
				xValueFormatString : "MMM, YYYY",
				dataPoints : dps[3]

			} ,
			
			
			
			]
		});

		var yValue;
		var xValue;
		var nameValue;
		var showInLegendValue;
		var indexs;
		
		
		<c:forEach items="${ticketBuyHistList}" var="ticket" varStatus="i">
		console.log("${ticketBuyHistList}")
		<c:forEach items="${dataPointsList}" var="dataPoints" varStatus="loop">
		<c:forEach items="${dataPoints}" var="dataPoint">
		
		<c:set var="x" value="x${i.index}" />
		<c:set var="y" value="y${i.index}" />
		<c:set var="name" value="name${i.index}" />
		<c:set var="showInLegend" value="showInLegend${i.index}" />
		
		xValue = parseInt("${dataPoint[x]}");
		yValue = parseFloat("${dataPoint[y]}");
		nameValue   = "${dataPoint[name]}";
		showInLegendValue   = "${dataPoint[showInLegend]}";
		
		dps[parseInt("${i.index}")].push({
			x 	 : xValue,
			y 	 : yValue,
			name : nameValue
		});
	
		</c:forEach>
		</c:forEach>
		</c:forEach>
		

		chart.render();

		$(".canvasjs-chart-credit").html("");
		function toogleDataSeries(e) {
			if (typeof (e.dataSeries.visible) === "undefined"
					|| e.dataSeries.visible) {
				e.dataSeries.visible = false;
			} else {
				e.dataSeries.visible = true;
			}
			chart.render();
		}
	}
</script>