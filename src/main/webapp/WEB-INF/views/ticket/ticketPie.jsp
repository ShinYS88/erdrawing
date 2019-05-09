<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="/css/member/memList.css">
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

.d1 ul li {
    display: block;
    width: auto;
    text-align: center;
    opacity: 0.8;
}
.yearBtn{
background-color: rgb(102, 102, 102);  
   border: none;
    color: rgb(245, 245, 245);
    font-size: 15px;
}


</style>
<div class="navbar-header d1" style="padding-right: 10px;">
	<ul class="left-menu1" style="margin-top: 100px; color: #D1D1D2;">
		<li class="navbar-brand1" style="font-size: 18px; font-weight: bold;"><a href="/ticket/ticketChart">Total Sales</a></li>
	</ul>

	
	<ul  class="left-menu1" style="color: #D1D1D2;" > 
		<li class="navbar-brand1" style="font-size: 18px; font-weight: bold; cursor: pointer;" >Sales by Product
			<ul>
			<c:forEach items="${ticketList }" var="ticket">
			<li class="liClick" data-ticketno="${ticket.ticketNo }" style="cursor: pointer; font-size: 13px; border-bottom:1px solid #efefef;">${ticket.ticketContent }권</li>
			</c:forEach>
			</ul></li>
	</ul>
</div> 
<div style="text-align: center;"><h3 class="page-header" style="color: #D1D1D2;">Ticket별 매출 </h3></div>


<form id="frm">
<button class="yearBtn" value="2019" >2019</button>	
<button class="yearBtn" value="2018">2018</button>	
<button class="yearBtn" value="2017">2017</button>	
<input type="hidden" name="yyyy" id="yyyy">
<input type="hidden" name="ticketNo" id="ticketNo">
</form>
<div id="chartContainerPie" style="height: 450px; width: 87%;"></div>

									
									
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>


<script type="text/javascript">


var ticketNo = "";
var yyyy;



$(".d1 ul li").on('click',function() {
	$(this).find("ul").stop().fadeToggle(400);
});
$(".liClick").on('click',function() {
	ticketNo=$(this).data("ticketno");
	$("#yyyy").val(yyyy);
	$("#ticketNo").val(ticketNo);
	$("#frm").submit();
	
});
$(".yearBtn").on('click',function() {
	 yyyy =$(this).val();
	$("#yyyy").val(yyyy);
	$("#ticketNo").val("${ticketNo}");
	$("#frm").submit();
});


window.onload = function() {
	
var dpsPie = [[]];
var chart = new CanvasJS.Chart("chartContainerPie", {
	exportEnabled: true,
	animationEnabled: true,
	theme: "dark2", // "light1", "dark1", "dark2"
	title: {
		text: "Sales by Product"
	},
	subtitles: [{
		text: "${ticketTitle}권"+"  (${yyyy})"
	}],
	data: [{
		type: "pie",
		yValueFormatString: "#,##0\"원\"",
		indexLabel: "{label} - {y}",
		dataPoints: dpsPie[0]
	}]
});
 
var yValuePie;
var labelPie;
 
<c:forEach items="${dataPointsListPie}" var="dataPointsPie" varStatus="loopPie">
	<c:forEach items="${dataPointsPie}" var="dataPointPie">
	yValuePie = parseFloat("${dataPointPie.y}");
		labelPie = "${dataPointPie.label}";
		dpsPie[parseInt("${loopPie.index}")].push({
			label : labelPie,
			y : yValuePie,
		});
	</c:forEach>
</c:forEach>
chart.render();

$(".canvasjs-chart-credit").html("");
}
</script>
