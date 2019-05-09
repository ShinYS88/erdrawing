<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- <link href="${cp}/css/boxErd.css" rel="stylesheet"> --%>
<link rel="icon" href="../../favicon.ico">
<link rel="stylesheet" href="/css/member/memList.css">

<style>
table{
	border-radius:10px;
	overflow:hidden;
	/* box-shadow: 2px 2px 2px 2px gray; */
	font-size: 13px;
}
tbody tr:nth-child(even) {
	background-color: #ffffff;
	height: 40px;
	
}

tbody tr:nth-child(odd) {
	background-color: #eeeeee;
	height: 40px;
}

th {
 background-color: #ccdb5c;
 color:#000000;
 font-weight:bold;
 text-align: center;
}

td{
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

.insertBtn{
	background-color: #fff;
	width: 55px;
	height: 35px;
	line-height: 16px;
	color:#000000;
	font-size : 14px;
	font-weight: normal;
	border: 0px;
	margin-left: 790px;
}

</style>

<!--  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"> -->
<!--  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script> -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script> -->
<%--<!DOCTYPE html>
<html lang="en">
 <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
   
    <!-- <link rel="stylesheet" href="/css/style.css"> -->
  </head> --%>
  
<div class="container-fluid">
	<div class="row">
		 <%@ include file="/WEB-INF/views/post/left.jsp"%> 

		<h3 class="page-header" style="color: #D1D1D2;">${boardNm}</h3>

		<div class="table-responsive" style="margin-right:20px; width: 80%;">
			<table style="width: 100%;">
				<thead>
					<tr style="height: 40px;">
						<!-- <th style="text-align: center; width:9%;">글번호</th> -->
						<th style="text-align: center; width:4%;"></th>
						<th style="text-align:center; width:35%;">글제목</th>
						<th style="text-align:center; width:20%;">작성자</th>
						<th style="text-align:center; width:20%;">등록일</th>
						<th style="text-align:center; width:10%; border-right: 0px">조회수</th>
					</tr>
				</thead>

				<tbody id="postListTbody">
				</tbody>
				
			</table>
			<div style="text-align: right; margin-top: 10px;">
				<form id="insertFrm" action="${cp}/post/postInsert" method="get">
					<c:choose>
						<c:when test="${boardNo == '1'}">
							<c:if test="${SESSION_MEMBERVO.memAuth == 'T'}">
								<input type="hidden" name="boardNo" value="${boardNo}">
								<button type="button" class="insertBtn btn-style1">등록</button>
							</c:if>
						</c:when>

						<c:otherwise>
							<input type="hidden" name="boardNo" value="${boardNo}">
							<button type="button" class="insertBtn btn-style1" style="hover : gray;">등록</button>
						</c:otherwise>
					</c:choose>
				</form>
			</div>

			<nav id="divNav" style="text-align: center; width: 100%;">
				<ul class="pagination" id="pagination">
				</ul>
			</nav>
		</div>


	</div>
	<form id="frm" action="${cp}/post/postDetail" method="get">
		<input type="hidden" name="postNo" id="postNo" />
		<input type="hidden" name="postGn" id="postGn" />
		<input type="hidden" name="boardNo" value="${boardNo}" />
	</form>

	<script type="text/javascript">
		//문서 로딩이 완료된 이후 이벤트
		$(document).ready(function() {
			//게시글 페이지 처리
			postListPage(1);

			 /* //사용자 tr태그 클릭 시 이벤트
	 			$("#postListTbody").on("click", ".postTr", function() {
		 				console.log("post click");
	
		 				//클릭한 post태그의 postNo값을 출력
		 				var flag = $(this).data("flag");
		 				if(flag == 'F'){
		 					alert("삭제된 글은 열람할 수 없습니다.")
		 					return;
		 				}
	
		 				var postNo = $(this).data("postno");
		 				var postGn = $(this).data("postgn");
	
		 				//2. form
		 				$("#postNo").val(postNo);
		 				$("#postGn").val(postGn);
		 				//console.log("postNo" +  postNo);
						//console.log("postGn" +  postGn);
		 				// $("#frm").attr("action","/userAllList"); 속성값 수정하는 방법  
		 				$("#frm").submit();
	 			}); */

		//로그인한 아이디가 블랙리스트일때 글쓰기권한 없음
		$(".insertBtn").click(function() {
				var blackMemId = "${SESSION_MEMBERVO.memBlackFlag}";

				//alert(blackMemId);
				if (blackMemId == 'T') {
					alert("글쓰기 권한이 없습니다.");
					return;
				}
				$("#insertFrm").submit();
			});
		});

		//게시글 리스트 페이징 ajax
		function postListPage(page) {
			$
					.ajax({
						url : "${cp}/post/postListHtml",
						data : {
							boardNo : "${boardNo}",
							postNo : "${postNo}",
							page : page
						},
						success : function(data) {
							var htmlArr = data
									.split("======================seperator======================");
							$("#postListTbody").html(htmlArr[0]);
							$("#pagination").html(htmlArr[1]);
						}
					});
		}

		//게시글 상세화면 이벤트
		function fnTrClick(postNo, postGn, flag) {
			console.log("post click");

			//클릭한 제목의 상세페이지로 이동
			if (flag == 'F') {
				alert("삭제된 글은 열람할 수 없습니다.")
				return;
			}

			//2. form
			//$("#postNo").val(postNo);
			document.getElementById("postNo").value = postNo;
			//$("#postGn").val(postGn);
			document.getElementById("postGn").value = postGn;
			//$("#frm").attr("action","/userAllList"); 속성값 수정하는 방법  
			//$("#frm").submit();
			document.getElementById("frm").submit();
		}
	</script>
</div>

