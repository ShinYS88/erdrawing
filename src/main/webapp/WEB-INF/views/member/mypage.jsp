<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" href="/css/boxErd.css">
<link rel="stylesheet" href="/css/member/modify.css">
<link rel="stylesheet" href="/css/member/mypage.css">

<style>
.team-li{
	text-align: center;
    margin: 10px;
    padding-top: 12px;
}
.team-li > a > div{
	background-color: #686868;
	font-size: 20px;
	line-height:35px;
	width:35px;
	height:35px;
	margin:0 auto;
	border-radius:5px;
}
.team-li span{
    font-size: 12px;
}


</style>

<div id="contents">

	<div class="my-bg">
		<div class="container">
			<div class="inner-container" >
				<a href="${cp}/ticket/myTicket" class="btn-style2" style="margin-right: 10%;" >My Ticket</a>
			</div>
		
			<div class="inner-container">
				<a href="/modify?memId=${SESSION_MEMBERVO.memId  }" class="btn-style2">프로필 수정</a>
			</div>


			<div class="profile-info">
				<div class="memberId">${SESSION_MEMBERVO.memId }</div>
				<div class="memberEmail">${SESSION_MEMBERVO.memMail }</div>
				<%-- 				<div><div class="sampleImg"><div class="exText">${SESSION_MEMBERVO.memImg }Profile Image</div></div></div> --%>
				<div>
					<div class="sampleImg">
						<div class="exText">
								<c:choose>
									<c:when test="${SESSION_MEMBERVO.memEmailDiv =='basic'}">
										<img alt=""
											src="${cp }/member/memberImg?memId=${SESSION_MEMBERVO.memId }"
											 width="95" height="95">
									</c:when>
									<c:otherwise>

										<c:choose>
											<c:when
												test="${ fn:indexOf(SESSION_MEMBERVO.memImg,'http') > -1}">
												<img alt="" src="${SESSION_MEMBERVO.memImg }"  width="95" height="95">

											</c:when>
											<c:otherwise>

												<img alt=""
													src="${cp }/member/memberImg?memId=${SESSION_MEMBERVO.memId }"  width="95" height="95">

											</c:otherwise>
										</c:choose>

									</c:otherwise>
								</c:choose>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>




	<div class="container">
		<div class="member">


			<div class="line-title">
				<h2 class="page-title">TEAM</h2>
				<a class="add-btn1" id="teamAdd"><i class="fas fa-plus-square"></i></a>
			</div>

			<div class="row">
				<div
					style="background: #232323; color: #fff; height: 100px; line-height: 100px; padding-left: 20px; font-size: 20px; font-weight: 600;">
					<ul style="min-height: 72px; line-height: 2.2">
						<c:forEach var="teamList" items="${teamInfoList }">
							<li class="team-li">
							<a href="/team?teamNo=${teamList.teamNo }">
								<div class="bg-box1">${fn:toUpperCase(fn:substring(teamList.teamNm,0,1 ))}</div>
								<span>${teamList.teamNm }</span>
							</a></li>
						</c:forEach>
					</ul>

				</div>
			</div>


			<div class="line-title">
				<h2 class="page-title">MY-ERD</h2>
				<a class="add-btn1 myAdd"><i class="fas fa-plus-square"></i></a>
			</div>

			<div class="row">


				<div class="col-sm-12">
					<ul class="erd-box-list">

						<c:forEach var="myErdList" varStatus="status" items="${myErdList }">
							<li class="erd-box-item">
							
								<div style="position:absolute; width:100%; z-index:30;">
									<div class="stats-box">
										<i class="fas fa-eye"></i>
										<label>${myErdList.erdReadCnt }</label>
									</div>
									<div class="stats-box">
										<i class="fas fa-thumbs-up"></i>
										<label>${myErdList.likeCnt }</label>
									</div>
									<div class="stats-box del-div" >
										<button type="button" class="btn btn-default delBtn "
											aria-label="trash" value="${myErdList.erdNo }">
											<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
										</button>
									</div> 
								</div>
								
								<a class="preview-box" onclick="erdClick(${myErdList.erdNo})">
									<div class="bg-box">
										<img src="${cp }/erd/erdImg?erdNo=${myErdList.erdNo}">
										<div class="table-bg-text">
											<div class="bg-text shinys">&nbsp;${myErdList.erdTitle }
											</div>
										</div>
									</div>
								</a>
								<div class="description-item">
									<div style="float: left;">${myErdList.erdTitle }</div>
									<!-- erd public / private에 따라 자물쇠 이미지 변경 -->
									<div style="float: right;">${myErdList.erdScope }</div>



									<ul class="tagList" style="clear: both;">
										<c:forEach var="entry" items="${erdTagListMap }">
											<c:if test="${entry.key eq myErdList.erdNo}">
												<c:set var="value" value="${entry.value }" />
												<c:forEach var="tagVo" items="${value}">
													<a class="tag-a" href="${cp}/library?tagContent=${tagVo.tagContent }" title="" class="tagSearch">${tagVo.tagContent }</a>
												</c:forEach>

											</c:if>
										</c:forEach>
									</ul>
								</div>

							</li>



						</c:forEach>

					</ul>
				</div>

			</div>
			<!-- /row -->

		</div>

	</div>
</div>
<%-- <input type="hidden" id="alertMsg" value="${alertMsg }"> --%>
<script>
	// erd 삭제
	$(".delBtn").on("click", function(e) {
		var result = confirm("삭제하시겠습니까?");
		if (!result) {
			return;
		}

		var erdNo = $(this).val();
		$.ajax({
			type : "get",
			url : "${cp}/erd/delErd",
			data : {
				erdNo : erdNo
			},
			success : function(data) {
				$(e.target).closest('li').remove();
			},
			error : function(xhr, status, error) {
				alert("에러");
			}
		});
	});
	
	function erdClick(erdNo){
		$(location).attr('href', "${cp}/erdDrawing?erdNo="+erdNo);
	}
	
	
// 	if($("#alertMsg").val() != ""){
// 		alert($("#alertMsg").val());
// 		$("#alertMsg").val("");
// 	} 




</script>



