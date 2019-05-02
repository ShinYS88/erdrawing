<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="/css/message/messageModal.css">

<div class="message" style="overflow: scroll;">
	<h1>
		<div class="massage-title">알림</div>
		<button class="btn glyphicon glyphicon-trash" value="delAll"></button>
		<button class="glyphicon glyphicon-remove cancle-btn99"></button>
	</h1>
	
	<div class="msg-listBox">
		<ul id="ul">
			<c:if test="${empty MSGLIST }">
				<div id="noMsg">알림이 없습니다.</div>
			</c:if>
			<!-- 리스트 출력 -->
			<c:forEach items="${MSGLIST }" var="msgVo">
				
			<li class="msg-items liClass" data-teamno="${msgVo.teamNo }" data-senderid="${msgVo.senderId }" data-msgno="${msgVo.msgNo }">
				<a>${msgVo.msgContent }</a>
				
				<div class="info">
					<div class="nd-box">
						<div class="userId">${msgVo.senderId }</div>
						<div class="dateTime"><fmt:formatDate value="${msgVo.sendDt }" pattern="yy.MM.dd HH:mm" /></div>
					</div>
				</div>
				<div class="btns2">
					<c:choose>
						<c:when test="${msgVo.msgType eq 'y'}">
							<button class="btn btn-success" value="yes">예</button>
							<button class="btn btn-danger" value="no">아니오</button>
						</c:when>
						<c:otherwise>
							<button class="btn glyphicon glyphicon-trash" value="del" style="background: transparent;"></button>
						</c:otherwise>
					</c:choose>
				</div>
			</li>
			</c:forEach>
		</ul>
	</div>
</div>

<script>
$(".btn").on("click", function(e){
	var senderId = $(e.target).closest('li').data("senderid");
	var teamNo = $(e.target).closest('li').data("teamno");	
	var msgNo = $(e.target).closest('li').data("msgno");	
	var value = $(e.target).val();
	
	// 알림 전송 / 삭제 ajax
	$.ajax({
		type : "get",
		url : "${cp}/message/insertMsg",
		data : {senderId : senderId,
				teamNo : teamNo,
				msgNo : msgNo,
				value : value},
		success : function(data){
			if(e.target.value == "delAll"){
				$(".liClass").remove();
				$("#ul").append("<div>알림이 없습니다.</div>");
			}
			$(e.target).closest('li').remove();
		},
		error : function(xhr, status, error){
			alert("에러");
		}
	});
});

$(document).scroll(function(){
	console.log($(document).height());
});



</script>

