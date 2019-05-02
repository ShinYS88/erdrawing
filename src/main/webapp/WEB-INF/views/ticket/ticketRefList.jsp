<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<link href="/js/ticket/mdi-font/css/material-design-iconic-font.min.css" rel="stylesheet" media="all">
    <link href="/js/ticket/daterangepicker.css" rel="stylesheet" media="all">
    <link href="/css/ticket.css" rel="stylesheet" media="all"> 
    <link href="/js/ticket/select2.min.css" rel="stylesheet" media="all">
    

<div style="padding-top: 100px"></div>
<div class="tab-content">
	<div class="tab-pane active" id="tab1">
		<form method="POST" action="#">

			<div class="row row-space">
				<div class="input-group input-group-big">
					<label class="label">where:</label> <input name="address"
						class="input--style-1" required="required" type="text"
						placeholder="검색조건을 입력해주세요"> <i
						class="zmdi zmdi-search input-group-symbol"></i>
				</div>


				<div class="col-2">
					<div class="input-group">
						<label class="label">검색 조건:</label>
						<div class="rs-select2 js-select-simple select--no-search">
							<select name="car-group">
								<option selected="selected">날짜</option>
								<option>구매자</option>
								<option>티켓</option>
								<option>환불여부</option>
							</select>
							<div class="select-dropdown"></div>
						</div>
					</div>
				</div>


				<div class="col-2">
					<div class="input-group">
						<label class="label">to:</label> <input class="input--style-1"
							type="text" name="check-in" placeholder="mm/dd/yyyy"
							id="input-start" width="100px">
					</div>
				</div>
				<div class="col-2">
					<div class="input-group">
						<label class="label">end:</label> <input class="input--style-1"
							type="text" name="check-out" placeholder="mm/dd/yyyy"
							id="input-end">
					</div>
				</div>
			</div>

		</form>
	</div>

	<button id="btn">클릭</button>
</div>


<!-- ===============환불내역 테이블=================  -->
<div>
    	<table border="1">
    		<thead>
	    		<tr>
	    			<th>티켓</th>
	    			<th>티켓구매일</th>
	    			<th>구매자</th>
	    			<th>은행명</th>
	    			<th>계좌번호</th>
	    			<th>예금주명</th>
	    			<th>상태</th>
	    		</tr>
	    	</thead>
    		
    		<tbody>
    			<c:forEach items="${ticketRefList }" var="ticket">
    				<tr>	
    					<td style="text-align: center;">${ticket.get("TICKETCONTENT") }&nbsp;권</td>	
    					<td style="text-align: center;">
    					 <fmt:formatDate value="${ticket.get('TICKETBUYDT') }" pattern="yy-MM-dd"/>
    					</td>	
    					<td style="text-align: center;">${ticket.get("MEMID") }</td>	
    					<td style="text-align: center;">${ticket.get("BANKNM") }</td>	
    					<td style="text-align: center;">${ticket.get("ACCOUNT") }</td>	
    					<td style="text-align: center;">${ticket.get("ACCOUNTHOLDER") }</td>
    					<c:choose>
    						<c:when test="${ticket.get('REFUND_RESPDT') == null }">
    							<td style="text-align: center;">환불가능</td>
    						</c:when>
    						<c:otherwise>
    							<td style="text-align: center;">환불완료</td>
    						</c:otherwise>
    					
    					</c:choose>	
    						
    				</tr>
    			</c:forEach>
    			
    		</tbody>
    		
    		
    		
    	</table>
    </div>
    
    <script src="/js/ticket/select2.min.js" type="08a3d66d4e4ffeca331a2908-text/javascript"></script>
    <script src="/js/ticket/moment.min.js" type="08a3d66d4e4ffeca331a2908-text/javascript"></script>
    <script src="/js/ticket/daterangepicker.js" type="08a3d66d4e4ffeca331a2908-text/javascript"></script>
    <script src="/js/ticket/global.js" type="08a3d66d4e4ffeca331a2908-text/javascript"></script>
	<script src="https://ajax.cloudflare.com/cdn-cgi/scripts/a2bd7673/cloudflare-static/rocket-loader.min.js" data-cf-settings="08a3d66d4e4ffeca331a2908-|49" defer=""></script></body><!-- This templates was made by Colorlib (https://colorlib.com) -->
	<script>
	$("#btn").on("click",function(){
		console.log($("#input-start").val());
	});
	</script>
    