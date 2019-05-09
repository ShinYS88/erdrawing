<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" href="/css/boxErd.css">
<link rel="stylesheet" href="/css/member/modify.css">
<link rel="stylesheet" href="/css/member/mypage.css">
<link rel="stylesheet" href="/css/team/toggle-switches.css">

<style>
.profile-info{
	bottom:-130px;
}
.memberId{
	margin-bottom:10px;
}
.member-li{
 	display: inline-flex;
}
.selectMem div{
	display:inline-block;
	vertical-align: middle;
}
.member input{
	margin-left: 10px;
}
.remove-btn{
	color: white;
    background: unset;
    border: unset;
    height: 0px;
    margin-top: -5px;
}


.tag-a{
    margin: 3px;
    padding: 3px;
    background-color: #444444;
    font-size: 11px;
}


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


.member-li{
	background:#686868;
	padding:5px;
	border-radius:5px;
	margin-right:10px;
	margin-bottom:20px;
	
}

.memAuth{
padding:0 10px 4px 10px;
background:#333;
border-radius:20px;
margin-left:10px;
}

</style>

<div id="contents">
	<div class="my-bg">
		<div class="container">
			<c:if test="${teamInfo.makerId eq loginId }">
				<div class="inner-container">
					<a class="btn-style2" id="teamModify">Edit Team</a>
				</div>	
			</c:if>	
				
			<div class="profile-info">
				<div class="memberId">${teamInfo.teamNm }</div>
				<div><div class="sampleImg"><div class="exText"><img src="${cp }/team/teamImg?teamNo=${teamInfo.teamNo}"></div></div></div>
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
				<div style="background:#232323; color:#fff; min-height:50px; line-height:100px; padding-left:5px; font-size:20px; font-weight:600;">
					<ul style=" min-height:50px; line-height: 2.2">
					<c:forEach var="teamList" items="${teamInfoList }" >
						<li class="team-li" data-teamno="${teamList.teamNo }">
							<a href="/team?teamNo=${teamList.teamNo }">
								<div class="bg-box1">${fn:toUpperCase(fn:substring(teamList.teamNm,0,1 ))}</div>
								<span>${teamList.teamNm }</span>
							</a>
						</li>
					</c:forEach>
					</ul>
				</div>
			</div>
	
	
			<div class="line-title">
				<h2 class="page-title">TEAM MEMBER</h2>
			</div>
			<div class="row">
				<div style="background:#232323; color:#fff; font-size:20px; font-weight:600; padding:20px 20px 0 20px;">
					<ul style=" min-height:72px; line-height: 1.5;">
						<c:forEach var="teamMemberGet" items="${teamMember }" varStatus="status">
							<li class="member-li" data-memid="${teamMemberGet.memId }" data-teamno="${teamList[status.index].teamNo }" data-teamnm="${teamInfo.teamNm }" data-makerid="${teamInfo.makerId }"> <!-- ajax를 위한 커스텀 데이터 생성 -->
								<a class="selectMem" href="">
									<div>
										<img alt="" width="50" height="50" src="/member/memberImg?memId=${teamMemberGet.memId }">
									</div>
									<div>
										<strong>${teamMemberGet.memId }</strong>
										<span>${teamMemberGet.memMail }</span>
									</div>
								</a>
								<div>
									<span class="memAuth">${teamList[status.index].teamAuth }</span>
								</div>
								 
								 <!-- 팀 생성자이면서 권한이 creator가 아닌 것(user, admin) -->
								  <c:if test="${teamList[status.index].teamAuth ne 'creator' and teamInfo.makerId eq loginId }"> 
									<input type="checkbox" class="toggle-switch" name="authCheck" style="font-size: 1px;" value="${teamList[status.index].teamAuth }"
									<c:if test="${teamList[status.index].teamAuth eq 'admin'}">
										checked
									</c:if>
									>
									<button type="button" class="glyphicon glyphicon-remove remove-btn"></button>
								</c:if>
								
								<c:if test="${teamMemberGet.memId eq loginId and teamInfo.makerId ne loginId}"> <!-- 본인일 경우 삭제버튼 활성화(생성자는 삭제 X) -->
									<button type="button" class="glyphicon glyphicon-remove remove-btn" ></button>
									
								</c:if>

	
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
			<div class="line-title">
				<h2 class="page-title">TEAM ERD</h2>
				<a class="add-btn1 myAddTE"><i class="fas fa-plus-square"></i></a>
			</div>
			<div class="row">
						<div class="col-sm-12">
							 <ul class="erd-box-list">
							 	<c:forEach var="teamErdList" varStatus="status" items="${teamErdList }">
							  	<li class="erd-box-item">
							  		<c:if test="${myTeam.teamAuth ne 'user'}"> <!-- 권한이 유저가 아닐 때 erd 삭제 가능 -->
							  		<div style="position:absolute; width:100%; z-index:30;">
								  		<button type="button" class="btn btn-default delBtn del-div" aria-label="trash" value="${teamErdList.erdNo }">
										  <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
										</button>
									</div>
									</c:if>
								  		<a class="preview-box" onclick="erdClick(${teamErdList.erdNo})">
								  			<div class="bg-box">
							  					<img src="${cp }/erd/erdImg?erdNo=${teamErdList.erdNo }">
								  				<div class="table-bg-text">
								  					<div class="bg-text shinys">
								  						&nbsp;${teamErdList.erdTitle }
								  					</div>
									  			</div>
									  		</div>
								  		</a>
								  		<div class="description-item">
								  			<div style="float:left;">${teamErdList.erdTitle }</div>
								  			<!-- erd public / private에 따라 자물쇠 이미지 변경 -->
								  			<div style="float:right;">${teamErdList.erdScope } </div>
								  			
								  			
								  			
								  			<ul class="tagList" style="clear:both;">
								  		<c:forEach var="entry" items="${erdTagListMap }">
								  			<c:if test="${entry.key eq teamErdList.erdNo}">
								  				<c:set var="value" value="${entry.value }"/>
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
		
			</div> <!-- /row -->
			
			
			
		</div>
		
	</div>
</div>

<script>
var getTeamNo = ${teamInfo.teamNo};
	// 팀 멤버 권한 변경(user <-> admin)
	$("input[name=authCheck]").on("click", function(e){ 
		var teamAuth = this.value;
		var memId = $(e.target).closest('li').data("memid");
		var teamNo = $(e.target).closest('li').data("teamno");
		
		$.ajax({
			type : "get",
			url : "${cp}/team/authUpdate",
			data : {teamNo : teamNo,
					memId : memId,
					teamAuth : teamAuth},
			success : function(data){
				$(e.target).closest('li').find(".memAuth").html(data.auth);
				$(e.target).val(data.auth);
			},
			error : function(xhr, status, error){
				alert("에러");
			}
		});
	});
	
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
	
	// 팀 멤버 삭제
	$(".remove-btn").on("click", function(e){
		var memId = $(e.target).closest('li').data("memid");
		var teamNo = $(e.target).closest('li').data("teamno");		
		var teamNm = $(e.target).closest('li').data("teamnm");		
		var makerId = $(e.target).closest('li').data("makerid");		
		
		var result = confirm("삭제하시겠습니까?");
		if(!result){
			return;
		}
		
		$.ajax({
			type : "get",
			url : "${cp}/team/delMember",
			data : {teamNo : teamNo,
					memId : memId, 
					teamNm : teamNm,
					makerId : makerId},
			success : function(data){
				$(e.target).closest('li').remove();
			},
			error : function(xhr, status, error){
				alert("에러");
			}
		});
		
	});
	
	// 팀 수정
	$("#teamModify").on("click", function(){
		var teamNo = ${teamInfo.teamNo};
		teamModifyModal(teamNo);
	});
	// 수정에 필요한 정보 가져오는 ajax 메소드
	 function teamModifyModal(teamNo) {
		$.ajax({
			url : "${cp}/team/teamModify",
			type : "get",
			data : {
				teamNo : teamNo
			},
			success : function(data) {
				//모달창에  해당 팀의 정보 넣어주기
				insertInfoToModal(data);
			}
		});
	}
	 // 모달창에 정보 넣어주는 메소드
	 function insertInfoToModal(data){
		 var teamInfo = data.teamInfoVo;
		 var teamMember = data.teamMemberList;
		 
		 $("#title").val(teamInfo.teamNm);
		 $("#teamIntro").val(teamInfo.teamIntro);
		 $("#makerId").val(teamInfo.makerId);
		 $("#teamImg").attr("src","${cp }/team/teamImg?teamNo=${teamInfo.teamNo}");
		 
		 $("#teamNo").val(teamInfo.teamNo);
		 console.log(teamInfo.teamNo);
		 
		 var html = '';
		 for(var i in teamMember){
			 if(teamMember[i].memId != teamInfo.makerId){
				 
		        html += '<li class="teamMem dbLoad" value="' + teamMember[i].memId + '">';
		        html += '	<div><img src="/member/memberImg?memId='+teamMember[i].memId+'"></div>';
		        html += '	<div>' + teamMember[i].memId + '</div>';
		        html += '	<div id="delBtn"><i class="fas fa-minus-circle"></i></div>';
		        html += '</li>';
			 }
		 }
        $("#ul").append(html);  
	 };
	 
	 // 멤버 클릭시 유저페이지로 이동
	 $(".selectMem").on("click", function(){
		 var memId = $(this).closest('li').data('memid');
		 $(".selectMem").attr('href', "${cp}/member/memberErd?memId=" + memId);
		 
	 });
	
	 function erdClick(erdNo){
			$(location).attr('href', "${cp}/erdDrawing?erdNo="+erdNo);
	}
	 
	 
	var curTeamNo = ${teamInfo.teamNo};
	$(".team-li").each(function(item, i){
		
		var listTeamNo = $(this).data("teamno");
		if(curTeamNo === listTeamNo){
			$(this).addClass('active');
		}
	});
	
	var S_id = '${SESSION_MEMBERVO.memId}';
	$(".member-li").each(function(){
		
		var listTeamMember = $(this).data("memid");
		
		if(S_id === listTeamMember){
			$(this).addClass('active');
		}
	});
		
</script>



