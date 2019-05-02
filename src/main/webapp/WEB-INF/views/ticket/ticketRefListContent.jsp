<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<link href="/js/ticket/mdi-font/css/material-design-iconic-font.min.css" rel="stylesheet" media="all">
    <link href="/js/ticket/daterangepicker.css" rel="stylesheet" media="all">
    <link href="/css/ticket.css" rel="stylesheet" media="all"> 
    <link href="/js/ticket/select2.min.css" rel="stylesheet" media="all">
    <div style="padding-top: 100px"></div>
<style>

.labelContext{
    font-weight: 100;
}

.modal-dialog, .modal-content {
    height: auto;
}
.modal{
 color: #000;

}

.modalLabels{
margin-left:2%;
width: 130px;
}

#divNav {
    margin-left: 0px;
     width: 123%; 
}

#footer h4 {
    font-weight: 700;
}

#divNav {
    margin-left: 0px;
     width: 123%; 
}

#footer h4 {
    font-weight: 700;
}

#refTb {
    font-size: 13px;
    text-align: center;
    border-radius:10px;
	overflow:hidden;
	width: 100%;
	/* box-shadow: 2px 2px 2px 2px gray; */
  
}

tbody tr:nth-child(even) {
	background-color: #ffffff;
	height: 40px;
	
}

tbody tr:nth-child(odd) {
	background-color: #eeeeee;
	height: 40px;
}

.refTh {
 background-color: #ccdb5c;
 color:#000000;
 font-weight:bold;
 text-align: center;
 height: 40px;
}

td{
	color:#000000;
}

.table-responsive{
	/* background:#eeeeee; */
	padding:20px;
	border-radius:10px;
	
}

/* #contents{background:#eee;} */

.pagination {
  border:0px;
}

.pagination > .active > a,
.pagination > .active > span,
.pagination > .active > a:hover,
.pagination > .active > span:hover,
.pagination > .active > a:focus,
.pagination > .active > span:focus {
  z-index: 2;
  color: #000000;
  cursor: default;
  background-color: #ccdb5c;
  border-color: #ccdb5c;
}
</style>

<div class="tab-content" >
	<div class="tab-pane active" id="tab1">
		<form method="POST" action="">

			<div class="row row-space">
				<div class="col-2">
					<div class="input-group">
						<label class="label">to:</label> <input class="input--style-1"
							type="text" name="check-in" placeholder="mm/dd/yyyy"
							id="input-start" width="100px">
							
					</div>
					<div id="ticketradio">
					            <c:forEach var="ticket"  items="${ticketList }">
					            <label ><input type="radio" name="ticketNo" value="${ticket.ticketNo }" onclick="radioBtn_ch()"   >${ticket.ticketContent }권</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					            </c:forEach>
						
					</div>
					<div id="refradio">
					<label ><input type="radio" name="refnull" value="refNull" onclick="radioBtn_ch()">환불가능</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<label><input type="radio" name="refnull" value="refNotNull" onclick="radioBtn_ch()">환불완료</label>
					</div>
				</div>
				<div class="col-2">
					<div class="input-group">
						<label class="label">end:</label> <input class="input--style-1"
							type="text" name="check-out" placeholder="mm/dd/yyyy"
							id="input-end">
					</div>
				</div>
			
				<div class="input-group input-group-big">
				<label class="label">검색 조건:</label>
						<div class="rs-select2 js-select-simple select--no-search" style="width: 100px">
							<select name="searchgroup" onchange="selectCh()">
								<option selected="selected">날짜</option>
								<option>구매자</option>
								<option>티켓</option>
								<option>환불여부</option>
							</select>
							<div class="select-dropdown"></div>
						</div>
				
				
					<label class="label" style="padding-left: 30px">where:</label> 
					<input name="memId" id="memId" class="input--style-1" required="required" type="text" style="width: 260px"placeholder="검색조건을 입력해주세요"> 
						<i class="zmdi zmdi-search input-group-symbol" style="cursor: pointer;" id="searchBtn"></i>
				</div>

			</div>

		</form>
	</div>

</div>


<!-- ===============환불내역 테이블=================  -->
<div>
    	<table id="refTb">
    		<thead>
	    		<tr>
	    			<th class="refTh">티켓</th>
	    			<th class="refTh" >티켓구매일</th>
	    			<th class="refTh">구매자</th>
	    			<th class="refTh">은행명</th>
	    			<th class="refTh">계좌번호</th>
	    			<th class="refTh">예금주명</th>
	    			<th class="refTh">상태</th>
	    		</tr>
	    	</thead>
    		
    		<tbody id="ticketRefListTbody"> 		</tbody>
    	</table>

			<nav id="divNav" style="text-align: center; width: 100%;">
				<ul class="pagination" id="pagination">
				</ul>
			</nav>
</div>
    
<!-- ===================tr클릭시 해당 정보 모달띄우기==================== -->
	<div class="modal modal-center fade" id="ticketRefModal" tabindex="1"
		role="dialog" aria-labelledby="my80sizeCenterModalLabel">
		<div class="modal-dialog modal-80size modal-center" role="document">
			<div class="modal-content modal-80size">
				<div class="modal-header">
					<label>| 환불신청 내역</label>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
				
				<div class="form-group">
						<label class="modalLabels">User</label> 
						<label class="labelContext" id="modalMemId">내용</label> 
					</div>
					
					
				<div class="form-group">
						<label class="modalLabels">UserInfo</label> 
						<label class="labelContext" id="tel">휴대폰</label></br>
						<label class="labelContext" id="email" style="padding-left: 134px;">이메일</label> 
					</div>
				
					<div class="form-group">
						<label class="modalLabels">Ticket</label> 
						<label class="labelContext" id="TicketText">내용s</label>
					</div>

					<div class="form-group">
						<label class="modalLabels">TicketPrice</label>
						<label class="labelContext" id="TicketMoney">내용</label> 
					</div>

					<div class="pass form-group">
						<label class="modalLabels">TicketBuyDate</label> 
						<label class="labelContext" id="TicketbuyDt">내용</label> 
					</div>
					
					<div class="pass form-group">
						<label class="modalLabels">RefApplyDate</label> 
						<label class="labelContext" id="TicketRefDt">내dfdf용</label> 
					</div>
					
					<div class="pass form-group">
						<label class="modalLabels">RefBank</label> 
						<label class="labelContext" id="bankNm">은행명</label></br>
						<label class="labelContext" id="accountHolder" style="padding-left: 134px;">예금주</label></br>
						<label class="labelContext" id="account" style="padding-left: 134px;">계좌번호</label> 
					</div>



				</div>
				<div id="modalBtn" class="modal-footer">
					<button type="button" id="updateBtn" class="btn btn-default" data-dismiss="modal">확인</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				</div>
			</div>
			
		</div>
		
	</div>
	
<form id="frm" action="${cp }/ticket/updateTicketRefDt" method="post">
<input type="hidden" id="ticbuyNo" name="ticbuyNo">
</form>

<script src="/js/ticket/select2.min.js" type="08a3d66d4e4ffeca331a2908-text/javascript"></script>
    <script src="/js/ticket/moment.min.js" type="08a3d66d4e4ffeca331a2908-text/javascript"></script>
    <script src="/js/ticket/daterangepicker.js" type="08a3d66d4e4ffeca331a2908-text/javascript"></script>
    <script src="/js/ticket/global.js" type="08a3d66d4e4ffeca331a2908-text/javascript"></script>
	<script src="https://ajax.cloudflare.com/cdn-cgi/scripts/a2bd7673/cloudflare-static/rocket-loader.min.js" data-cf-settings="08a3d66d4e4ffeca331a2908-|49" defer=""></script></body><!-- This templates was made by Colorlib (https://colorlib.com) -->
	<script>
	
	var radioValtic ="" ;	
	var radioValref =""
	var inputstart = "";
	var inputend   = "";
	var searchgroup = "";
	var memId = "";
	var ticbuyNo= "";
	
	$(document).ready(function() {
		getTicketRefPageListHtml(1);	//페이징 아작스
		$("#ticketradio").hide();
		$("#refradio").hide();
		
		$("#searchBtn").on("click",function(){
			 inputstart = $("#input-start").val();
			 inputend   = $("#input-end").val();
			 searchgroup = $("select[name=searchgroup]").val();
			 
 			 if(searchgroup=="날짜" && inputstart==""){
 				searchgroup="searchNo";	 
 			 }
			 memId = $("#memId").val();
			 
			getTicketRefPageListHtml(1);
		});
		
		$("#ticketRefListTbody").on("click",".ticketRefTr",function(){
			
			ticbuyNo = $(this).data("ticketbuyno");
			ticketRefInfo($(this).data("ticketbuyno"));
		})
		
		$("#updateBtn").on("click",function(){
			if (confirm("환불 승인을 하시겠습니까??") == true) {
				$("#ticbuyNo").val(ticbuyNo);
				$("#frm").submit();
			} else { //취소
				return false;
			}
		})
		
	});
	
	//전체 테이블 Ajax처리
	function getTicketRefPageListHtml(page) {
		$.ajax({
					url : "${cp}/ticket/ticketRefAjaxList",
					data : {
						page : page,
						inputstart : inputstart,
						inputend   : inputend,
						searchgroup: searchgroup,
						memId	   : memId,
						radioValtic: radioValtic,
						radioValref: radioValref
					},
					success : function(data) {
						var htmlArr = data.split("======================seperator==========================");
						$("#ticketRefListTbody").html(htmlArr[0]);
						$("#pagination").html(htmlArr[1]);
					}
				});
	}
	
	function selectCh() {
		console.log("값변경")
		var searchgroup = $("select[name=searchgroup]").val();
		if(searchgroup=="티켓"){
			$("#ticketradio").show();
			$("#refradio").hide();
		}else if(searchgroup=="환불여부"){
			$("#ticketradio").hide();
			$("#refradio").show();
		}else{
			$("#ticketradio").hide();
			$("#refradio").hide();
		}
		
	}
	
	function radioBtn_ch() {
		 radioValtic = $('input[name="ticketNo"]:checked').val();	//티켓라디오값
		 radioValref = $('input[name="refnull"]:checked').val();	//환불여부 라디오값
		console.log("티켓~"+radioValtic)
		console.log("환df불~"+radioValref)
	}

	//모달창에 환불정보 띄우기
	function ticketRefInfo(ticketBuyNo) {
		$.ajax({
			url : "${cp}/ticket/ticketRefInfo",
			data : {
				ticketBuyNo : ticketBuyNo
			},
			success : function(data) {
				console.log(data.ticketbuyVo);
				
				 $.each(data, function(idx, val) {      
					 console.log(idx)
					 
					 $("#modalMemId").html(val.MEMID+"("+val.MEMNM  +")");
					 if(val.MEMTEL==null){
						 val.MEMTEL=" x ";
						 }
					 $("#tel").html("휴대폰 : " + val.MEMTEL);
					 $("#email").html("이메일 : " + val.MEMEMAIL);
					 $("#TicketText").html(val.ticketContext);
					 $("#TicketMoney").html(val.TICKETFEE + "원");
					 $("#TicketbuyDt").html(val.TICKETBUYDT);
					 $("#TicketRefDt").html(val.REFUNDREQDT);
					 $("#bankNm").html("은행명 : " + val.BANKNM);
					 $("#accountHolder").html("예금주 : " + val.ACCOUNTHOLDER);
					 $("#account").html("계좌번호 : " + val.ACCOUNT);
					 
				 }); 
			}
		});
	}
	

	</script>
     