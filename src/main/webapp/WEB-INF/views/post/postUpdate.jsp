<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="icon" href="../../favicon.ico">
<link rel="stylesheet" href="/css/member/memList.css">
<%--
<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- Custom styles for this template -->
<link href="${cp}/css/dashboard.css" rel="stylesheet">
--%>

	<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/views/post/left.jsp"%>
		<!-- <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main"> -->
		<div class="col-sm-10 col-md-10 main">
			<h3 class="page-header" style="color: #fff;">게시글 수정</h3>
			<form id="frm" action="${cp}/post/postUpdate" method="post"
				  class="form-horizontal" role="form" enctype="multipart/form-data">
				  
				<div class="form-group">
					<label for="postTitle" class="col-sm-1 control-label" style="color: #fff;">글제목&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<div class="col-sm-7">
						<input type="text" class="form-control" id="postTitle" name="postTitle" placeholder="글제목" value="${postVo.postTitle}"  />
					</div>
				</div>
				
				<div class="form-group">
					<label for="writerId" class="col-sm-1 control-label" style="color: #fff;">작성자&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<div class="col-sm-7">
						<input type="text" class="form-control" id="writerId" name="writerId" placeholder="작성자" value="${postVo.writerId}" readonly/>
					</div>
				</div>
				
				<div class="form-group">
					<label for="postRegDt" class="col-sm-1 control-label" style="color: #fff;">등록일&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<div class="col-sm-7">
						<input type="text" class="form-control" id="postRegDt" name="postRegDt" placeholder="등록일" value='<fmt:formatDate value="${postVo.postRegDt}" pattern="yyyy-MM-dd"/>' readonly/>
					</div>
				</div>

				<div class="form-group">
					<label for="postContent" class="col-sm-1 control-label" style="color: #fff;">글내용&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<div class="col-sm-10" style="background: white;">
						<textarea name="postContent" id="postContent" rows="10" cols="100" style="width: 795px; height: 420px;">
							${postVo.postContent}
						</textarea>
					</div>
				</div>

				<div class="form-group">
					<label for="files" class="col-sm-2 control-label" style="color: #fff;">첨부파일&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<div id="fileUpload" class="col-sm-7">
						<c:forEach items="${fileList}" var="file">
							<input id="uploadFileNo${file.uploadFileNo}" type="text" class="form-control" value="${file.uploadFileNm}" readonly />
						</c:forEach>
					</div>
					
					<div class="col-sm-1" style="text-align: right;" >
						<c:forEach items="${fileList}" var="file">
							<button data-fileno="${file.uploadFileNo}" type="button" class="delFileBtn btn btn-default">삭제</button>
						</c:forEach> 
						<button id="addFileBtn" type="button" class="btn btn-default">추가</button>
					</div>
				</div>

				<div class="form-group">
					<div class="col-sm-offset-5 col-sm-10">
						<button id="cancelBtn" type="button" class="btn btn-default">취소</button>
						<button id="saveBtn" type="button" class="btn btn-default">저장</button>
					</div>
				</div>
				

				<div id="saveInfo">
					<input type="hidden" id="postNo" name="postNo" value="${postVo.postNo}" />
				</div>
			</form>
			
			
		</div>
	</div>
</div>
<form id="cancelFrm" action="${cp}/post/postDetail" method="get">
	<input type="hidden" name="postNo" value="${postVo.postNo}" />
</form>

	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script src="/SE2/js/HuskyEZCreator.js"></script>
	<script>
		var oEditors = [];
		$(document).ready(function() {
			// Editor Setting
			nhn.husky.EZCreator.createInIFrame({
				oAppRef : oEditors, // 전역변수 명과 동일해야 함.
				elPlaceHolder : "postContent", // 에디터가 그려질 textarea ID 값과 동일 해야 함.
				sSkinURI : "../SE2/SmartEditor2Skin.html", // Editor HTML
				fCreator : "createSEditor2", // SE2BasicCreator.js 메소드명이니 변경 금지 X
				htParams : {
					// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
					bUseToolbar : true,
					// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
					bUseVerticalResizer : true,
					// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
					bUseModeChanger : true, 
				}
			});
			
			// 취소버튼 클릭이벤트
			$("#cancelBtn").click(function() {
				$("#cancelFrm").submit();
			});

			// 전송버튼 클릭이벤트
			$("#saveBtn").click(function(){
				if(confirm("게시글을 저장하시겠습니까?")) {
					// id가 smarteditor인 textarea에 에디터에서 대입
					oEditors.getById["postContent"].exec("UPDATE_CONTENTS_FIELD", []);

					// 이부분에 에디터 validation 검증
					if(validation()) {
						$("#frm").submit();
					}
				}
			});
		});
		
		// 필수값 Check
		function validation(){
			if($("#postTitle").val() == '') {
				alert("제목을 입력하세요.");
				$("#postTitle").focus();
				return false;
			}
			
			var contents = $.trim(oEditors[0].getContents());
			if(contents == '<p>&nbsp;</p>' || contents == ''){ // 기본적으로 아무것도 입력하지 않아도 <p>&nbsp;</p> 값이 입력되어 있음. 
				alert("내용을 입력하세요.");
				oEditors.getById['postContent'].exec('FOCUS');
				return false;
			}

			return true;
		}
		
		var file_size = ${fileList.size()};
		var file_cnt = 1;
		// 파일 추가 버튼 클릭이벤트
		$("#addFileBtn").click(function(){
			if (file_size >= 5) {
				alert("첨부파일은 최대 5개까지 첨부 가능합니다.");
			} else {
				$("#fileUpload").append("<input type='file' class='form-control' name='file' />");
				file_size++;
				file_cnt++;
			}
		});
		
		$(".delFileBtn").click(function(){
			var uploadFileNo = $(this).data("fileno");
			$("#uploadFileNo" + uploadFileNo).remove();
			$(this).remove();

			file_size--;

			$("#saveInfo").append("<input type='hidden' name='delFile' value='" + uploadFileNo + "'/>");
		});
	</script>