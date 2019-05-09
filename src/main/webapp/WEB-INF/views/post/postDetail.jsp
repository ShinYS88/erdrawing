<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="icon" href="../../favicon.ico">
<link rel="stylesheet" href="/css/member/memList.css">
   
<style>
table{
	border-radius:10px;
	overflow:hidden;
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

th {
 background-color: #ccdb5c;
 color:#000000;
 font-weight:bold;
 text-align: center;
 margin-top: -100px;
}

td{
}

.table-responsive{
	/* background:#eeeeee; */
	padding:10px;
	border-radius:10px;	
}

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

#report{
	background-color: #fff;
	width: 50px;
	height: 35px;
	color:#000000;
	font-size : 14px;
	border: 0px;
	margin-left: 200px;
	border-radius:3px;
}

#cmtDelBtn{
	background-color: #F2F2F2;
	width: 50px;
	height: 30px;
	color:#000000;
	font-size : 13px;
	border: 0px;
	margin-right: 20px;
	border-radius:3px;
}


.form-horizontal .control-label {
    padding-top: 7px;
    margin-bottom: 0;
    text-align: 0;
}
</style>
   

    <div class="container-fluid">
      <div class="row">
         <%@ include file="/WEB-INF/views/post/left.jsp"%>

      
      <h3 class="page-header" style="color: #D1D1D2;">상세조회</h3>
      <div class="col-sm-10 col-md-10 main">
          <form id="frm" action="${cp}/delPost" method="post" class="form-horizontal" role="form">
         <div class="form-group" style="border-bottom: 1px solid #eee; width: 945px;">
           <!--  <label for="title" class="col-sm-1 control-label" style="color: #fff; margin-left: 20px;">글제목&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label> -->
            <div class="col-sm-7">
               <label class="control-label" style="color: #fff; font-size: 25px; margin-bottom: 10px;">&nbsp;&nbsp;${postList.postTitle}</label>
            </div>
            
<style>
   #layer_popup {display:none; border:5px solid #cccccc;margin:0;padding:5px;background-color:#ffffff;z-index:2000;}
   #layer_popup .b-close {position:absolute;top:10px;right:30px;color:#f37a20;font-weight:bold;cursor:hand;}
   #layer_popup .popupContent {margin:0;padding:0;text-align:center;border:0;width:650px;height:200px;}
   #layer_popup .popupContent iframe {border:0;padding:0px;margin:0;z-index:10;}
</style>
	
	<input type="hidden" name="boardNo" value="${boardNo}"> 
	<input type="button" id="report" onclick="layer_open()" value="신고" style="margin-left: 340px;" />
	
<!-- <input type="button" id="report" onclick="layer_open()" value="신고"> -->
<!-- <input type="button" value="레이어팝업 열기" onclick="layer_open();"  style="cursor:pointer; background-color:#663333; color:#FFF;" /> -->
<!-- 팝업 -->
<div id="layer_popup" style="display:none; ">
   <span>     
       <div class="b-close">X</div>
   </span>
   <div class="popupContent">
      <div class="modal-header">
         <label>게시글 신고</label>
      </div>
      
      <div class="modal-body">            
        <%--  <div class="form-group">
              <label class="modalLabel">작성자</label> 
              <input type="text" id="memNm" name="memNm" value="${postList.writerId}" readonly /> 
              <div id="dupleCode"></div>
           </div>  --%>
           
            <div class="form-group">
              <label class="modalLabel">신고사유</label> 
              <input type="text" id="reasonTxt" rows="10" cols="100" style="width: 450px; height: 30px;">    
           </div>   
        </div>  
           
           <div class="modal-footer">
                  <button type="button" id="reportBtn" class="btn btn-default" data-dismiss="modal">신고</button>
                  <button type="button" id="cancelBtn" class="btn btn-default" data-dismiss="modal">취소</button>
           </div>
   </div>
</div>
            
         </div>
           <div class="form-group">
            <div class="col-sm5" style="font-size: 12px;  width: 945px; margin-left: 15px;">
            <label for="writer" class="col-sm-0 control-label" style="color: #fff; margin-left: 5px;">작성자&nbsp;&nbsp;</label>
               <label class="control-label" style="color: #fff">${postList.writerId}&nbsp;&nbsp;&nbsp;</label>
            <label for="insertDate" class="col-sm-1 control-label" style="color: #fff; float: none;">작성일&nbsp;&nbsp;</label>
               <label class="control-label" style="color: #fff;"><fmt:formatDate value="${postList.postRegDt}" pattern="yyyy-MM-dd" /></label>
         
         
        
         
         
         <%-- 파일첨부 --%>
         <div class="form-group" style="color: #fff; ">
            <label for="content" class="col-sm-1 control-label" style="color: #fff;">첨부파일&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
            <div class="col-sm-7" style="padding-top: 5px;">
               
               <c:choose>
               		<c:when test="${fileList.size() =='0'}">
               			없음
               		</c:when>
               		
               		<c:otherwise>
               <c:forEach items="${fileList}" var="file">
               		 		<a href="${cp}/post/fileDownload?uploadFileNo=${file.uploadFileNo}" style="color: #fff;">${file.uploadFileNm}</a>
               </c:forEach>
               		</c:otherwise>
                  </c:choose>
            </div>
         </div>
         
          <div class="form-group">
            <!-- <label for="content" class="col-sm-1 control-label" style="color: #fff; margin-left: 20px;">글내용&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label> -->
            <br><br><br>
            <div class="col-sm-7">
               <div style="color: #fff; font-size: 16px; margin-left: 25px;">${postList.postContent}</div>
            </div>
         </div>
            <br><br><br>
         
                  <div class="form-group">
            <div class="col-sm-3" style="padding-bottom: 15px; margin-left: 25px;">
               <input type="button" id="listBtn" value="목록" class="btn btn-default" />
               <c:if test="${SESSION_MEMBERVO.memId == postList.writerId}">
                  <input type="button" id="updBtn" value="수정" class="btn btn-default" />
               </c:if>
               <c:if test="${SESSION_MEMBERVO.memId == postList.writerId}">
                  <input type="button" id="delBtn" value="삭제" class="btn btn-default" />
               </c:if>
               
               <c:choose>
				<c:when test="${boardNo == '1'}">
					<c:if test="${SESSION_MEMBERVO.memAuth == 'T'}">
						<input type = "hidden" name="boardNo" value="${boardNo}"> 
			   			<button type="button" id="replyBtn" class="btn btn-default">답글</button> 
					</c:if>
				</c:when>
				
				<c:otherwise>
					<input type = "hidden" name="boardNo" value="${boardNo}"> 
			   		<button type="button" id="replyBtn" class="btn btn-default">답글</button>
				</c:otherwise>
			</c:choose>
			
            </div>  
         </div>  
        
        
<br>        
<div style="background-color: #7A7A7A; padding-top: 20px; border-radius:10px;" >
         <div class="form-group"style="border: 1px; 
              margin-bottom: 0px;  width: 905px; height: 110px; padding-top:13px; margin-left:20px; border-radius:10px; background-color: #eeeeee;">
            <div class="col-sm-10" style="margin-left: 20px; margin-bottom: 15px;" >
            <span style="color: #000; font-size: 13px;">댓글 | 악의적인 비방글은 삼가해주세요.</span>
           
               <textarea class="form-control" id="cmtText" style="height: 60px; width: 780px;"> </textarea>
            </div>
            <div class="col-sm-1">
               <button id="cmtBtn" type="button" class="btn btn-default" style="height:60px; width:80px; margin-left: 35px; margin-top: 20px;">등록</button>
            </div>
         </div>
         

         <div class="table-responsive" style="margin-right: 20px; overflow: hidden;">
            <table class="table table-striped" style="width: 100%; height: 100px; margin: 10px;">
               <thead>
                  <tr style="height: 40px; line-height: 100px; line-height: 5px;">
                     <th style="text-align: center; color:black; width:15%;">댓글번호</th>
                     <th style="text-align: center; color:black; width:20%;">작성자</th>
                     <th style="text-align: center; color:black; width:35%;">댓글내용</th>
                     <th style="text-align: right; color:black; width:20%;">좋아요</th>
                     <th style="text-align: center; color:black; width:20%;"></th>
                  </tr>
               </thead>
               
	               <tbody id="cmtTbody">
	               </tbody>
            </table>
            
            <nav id="divNav" style="text-align: center; width: 100%;">
				<ul class="pagination" id="pagination">
				</ul>
			</nav>
         </div>
     
         
 
         </div>
         
         <input type="hidden" id="postNo" name="postNo" value="${postVo.postNo}" />
      </form></div>  
        </div>
      </div>
         
<!-- 목록 -->
<form id="listFrm" action="${cp}/post/postList" method="get">
   <input type="hidden" name="boardNo" value="${postList.boardNo}" />
</form>

<!-- 게시글 수정 -->
<form id="updFrm" action="${cp}/post/postUpdate" method="get">
   <input type="hidden" name="postNo" value="${postList.postNo}" />
   <input type="hidden" name="boardNo" value="${boardList.boardNo}" />
</form>   

<!-- 게시글 삭제 -->
<form id="delFrm" action="${cp}/post/postDel" method="get">
   <input type="hidden" name="boardNo" value="${postList.boardNo}" />
   <input type="hidden" name="postNo" value="${postList.postNo}" />
</form>

<!-- 신고 확인 -->
<form id="reportFrm" action="${cp}/post/postReport" method="get">
   <input type="hidden" name="postNo" value="${postList.postNo}" />
   <input type="hidden" name="fromMemId" value="${SESSION_MEMBERVO.memId}" />
   <input type="hidden" name="toMemId" value="${postList.writerId}" />
   <input type="hidden" id="reason" name="reason" />
</form>

<!-- 신고 취소 -->
<form id="cancelFrm" action="${cp}/post/postDetail" method="get">
   <input type="hidden" name="postNo" value="${postList.postNo}" />
</form>

<!-- 댓글 등록 -->
<form id="cmtFrm" action="${cp}/post/insertCmt" method="get">
   <input type="hidden" id="cmtContent" name="cmtContent"/>
   <input type="hidden" name="postNo" value="${postList.postNo}" />
   <input type="hidden" name="memId" value="${SESSION_MEMBERVO.memId}" />
</form>

<!-- 댓글 삭제 -->
<form id="cmtDelFrm" action="${cp}/post/deleteCmt" method="get">
   <input type="hidden" name="postNo" value="${postList.postNo}" />
   <input type="hidden" name="cmtNo" id="cmtNoDel" />
</form>

<!-- 댓글 좋아요 -->
<form id="cmtLikeFrm" action="${cp}/post/likeCmt" method="post">
   <input type="hidden" name="postNo" value="${postNo}" />
   <input type="hidden" id="cmtNo" name="cmtNo" />
   <input type="hidden" name="memId" value="${SESSION_MEMBERVO.memId}" />
</form> 

<!-- 답글 -->
<form id="replyFrm" action="${cp}/post/postReply" method="get" class="form-horizontal" role="form">
   <input type="hidden" id="postNo" name="postNo" value="${postNo}" />
   <input type="hidden" id="boardNo" name="boardNo" value="${boardNo}" />
</form>

   <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
   <script src="${cp}/js/popup/bpopup.js"></script>
      
   <script>
   //신고버튼 클릭이벤트
   function layer_open() { 
	 var toMemId = "${postList.writerId}";
  	 var fromMemId = "${SESSION_MEMBERVO.memId}";
  	 
  	 $.ajax({
			type : "get",
			url : "${cp}/post/reportCheckId",
			data : { toMemId : toMemId,
				     fromMemId : fromMemId }, 
			
			success : function(data) {
				if(data.check == "OK"){
					console.log(data);
					$("#layer_popup").bPopup();
				}else{
					alert("이미 신고한 아이디입니다.");
				}
			},
			error : function(xhr, status, error) {
				console.log("에러!: " + error);
			},
		});
   }
   </script>  
   
   <script type="text/javascript">
      $(document).ready(function() {
			
       //댓글 페이지 처리  
       cmtPage(1);
    	  
         // 목록버튼 클릭이벤트
         $("#listBtn").click(function() {
            $("#listFrm").submit();
         });
         
         //수정버튼 클릭이벤트
         $("#updBtn").click(function() {
            $("#updFrm").submit();
         });
         
         //삭제버튼 클릭이벤트
         $("#delBtn").click(function() {
        	 if(!confirm("게시글을 삭제 하시겠습니까?")){
                 return;
              }
            $("#delFrm").submit();
         });
         
         /* //신고취소버튼 클릭이벤트
         $("#cancelBtn").on("click", function() {
        	 var postNo  = "${postList.postNo}";
        	 var boardNo = "${postList.postNo}";
        	 
        	 $.ajax({
     			type : "get",
     			url : "${cp}/post/postDetail",
     			data : { postNo : postNo,
     				     boardNo : boardNo}, 
     			
     			success : function(data) {
     				$("#cancelFrm").submit();
     				}
     			},
     			error : function(xhr, status, error) {
     				console.log("에러!: " + error);
     			},
     			
     		});
      } */
      
	      //공지사항은 무조건 신고/답글 안보임
	      if("${SESSION_BOARDNO}" == 1){
	     	$("#replyBtn").hide();
	     	$("#report").hide();
	     	
	      }else{
	     	$("#replyBtn").show();
	     	$("#report").show();
	      }
        	 
         //신고확인버튼 클릭이벤트
         $("#reportBtn").click(function() {
            var reportReason = $("#reasonTxt").val();
            alert("해당 게시글을 신고하시겠습니까?");
            $("#reason").val(reportReason);
            $("#reportFrm").submit();
            //alert("${msg}");
         });
         
         //신고취소버튼 클릭이벤트
         $("#cancelBtn").click(function() {
            $("#cancelFrm").submit();
         });
         
         //답글버튼 클릭이벤트
         $("#replyBtn").click(function() {
            $("#replyFrm").submit();
         });
         
         //댓글등록버튼 클릭이벤트(ajax)
         $("#cmtBtn").click(function() {
        	 var memId = "${SESSION_MEMBERVO.memId}";
        	 if(memId==""){
        		 alert("로그인 후 이용해주세요.");
        		return;
        	 }
            cmtText = $("#cmtText").val();
            if(!confirm("댓글을 등록 하시겠습니까?")){
                return;
            }
            cmtInsert(1, "${postNo}", cmtText, "${SESSION_MEMBERVO.memId}");
            $("#cmtText").val("");
         });
         
         //댓글삭제버튼 클릭이벤트(ajax)
         $("#cmtTbody").on("click", ".btnDel", function() {
           cmtNo = $(this).data("cmtnum");
           if(!confirm("댓글을 삭제 하시겠습니까?")){
              return;
           }
           cmtDelete(1, "${postNo}", cmtNo);
         });
         
         //댓글좋아요버튼 클릭이벤트(ajax)
         $("#cmtTbody").on("click", ".btnLike", function() {
            //클릭한 cmtTr의 cmtNo값을 출력
            var cmtNo = $(this).data("cmtnum");
            cmtLike(1, "${postNo}", cmtNo, "${SESSION_MEMBERVO.memId}");
         });
         
      });
      
      //댓글 리스트 페이징 ajax
      function cmtPage(page) {
	  	$.ajax({
				url : "${cp}/post/listCmt",
				data : {
					postNo : "${postNo}",
					page : page
				},
				success : function(data) {
					var htmlArr = data.split("======================seperator======================");
					$("#cmtTbody").html(htmlArr[0]);
					$("#pagination").html(htmlArr[1]);
				}
	  	}); 
      }
      
      //댓글 등록 후 페이징 ajax
      function cmtInsert(page, postNo, cmtContent, memId) {
    	  $.ajax({
				url : "${cp}/post/insertCmt",
				data : {
					page : page,
					postNo : postNo,
					cmtContent : cmtContent,
					memId : memId
				},
				success : function(data) {
					var htmlArr = data.split("======================seperator======================");
					$("#cmtTbody").html(htmlArr[0]);
					$("#pagination").html(htmlArr[1]);
				}
	  	   }); 
	  }
	  
	  //댓글 삭제 후 페이징 ajax
      function cmtDelete(page, postNo, cmtNo) {
		  $.ajax({
					url : "${cp}/post/deleteCmt",
					data : {
						page : page,
						postNo : postNo,
						cmtNo : cmtNo
					},
					success : function(data) {
						var htmlArr = data.split("======================seperator======================");
						$("#cmtTbody").html(htmlArr[0]);
						$("#pagination").html(htmlArr[1]);
					}
		  }); 
	  }
	  
      //댓글 좋아요 후 페이징 ajax
      function cmtLike(page, postNo, cmtNo, memId) {
    	  
		  $.ajax({
					url : "${cp}/post/likeCmt",
					data : {
						page : page,
						postNo : postNo,
						cmtNo : cmtNo,
						memId : memId
					},
					success : function(data) {
						var htmlArr = data.split("======================seperator======================");
						$("#cmtTbody").html(htmlArr[0]);
						$("#pagination").html(htmlArr[1]);
						cmtPage(1);
						
					}
		  }); 
	  }

      
   </script>

    