<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
.modal-dialog,
.modal-content {
    /* 80% of window height */
    height: 80%;
}

.modal-body {
	 overflow-y:auto;
     max-height:90%;
}

.list-contents{
	display: inline-flex;
}

.glyphicon{
    line-height: inherit;
}

.form-inline{
	padding-bottom: 10px;
}
.erd-title{
	align-self: center;
	padding-left: 10px;
}
.modal-header{
	color: black;
}
.input-txt{
	width: 93%;
	padding-left: 10px;
}
.background-etc {
    position: absolute;
    z-index: 9000;
    display: none;
    width: 100%;
    height: 100%;
    left: 0;
    top: 0;
    background-color:0;
    color: #fff;
}
</style>

<div class="modal modal-center fade navbar-example" id="modalEvnTest" tabindex="1" role="dialog" aria-labelledby="my80sizeCenterModalLabel" >
<div class="modal-dialog modal-80size modal-center" role="document" >
   <div class="modal-content modal-80size">
      <div class="modal-header">
      <label>| ERD 검색</label>
         <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
         </button>
      </div>
      <div class="modal-body">
			<div>
				<div class="form-inline">
					<input type="text" class="input-txt" id="searchTxt_modal" value="">
					<button class="glyphicon glyphicon-search" id="searchBtn_modal"></button>
				</div>
				<ul class="list-group erd-list">
					
				</ul>
			</div>

              <div class="modal-footer">
                 <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
              </div>
           </div>
        </div>
     </div>
</div>

<script>
$(document).ready(function(){
	$('body').scrollspy({ target: '.navbar-example' });
}); 
$("#searchBtn_modal").on("click", function(){
	var searchTxt_modal = $("#searchTxt_modal").val();
	
	$.ajax({
		type : "get",
		url : "${cp}/erd/erdSearch",
		data : {searchTxt_modal : searchTxt_modal},
		success : function(data){
			console.log(data.erdVoList.length);
		    var erdVoList = data.erdVoList;
			var html ="";
			for(var i = 0; i < erdVoList.length; i++){
				console.log(erdVoList.erdNo);
				html += '<li class="list-group-item" onclick="erdClick(' + erdVoList[i].erdNo + ')">';
				html += '	<a class="">';
				html += '		<div class="list-contents">';
				html += '			<div class="modal_search"><img src="${cp }/erd/erdImg?erdNo=' + erdVoList[i].erdNo + '"></div>';
				html += '			<div class="erd-title">' + erdVoList[i].erdTitle + '</div>';
				html += '		</div>';
				html += '	</a>';
				html += '</li>';
			}
			$(".erd-list").html(html);
		}
	});
});


function erdClick(erdNo){
	$(location).attr('href', "${cp}/erdDrawing?erdNo="+erdNo);
}

</script>

<style>
.modal_search{
background:#3b3b3b;
border-radius:5px;
overflow:hidden;
}
.modal_search img{
width:110px;
height:62px;
}
</style>

      



