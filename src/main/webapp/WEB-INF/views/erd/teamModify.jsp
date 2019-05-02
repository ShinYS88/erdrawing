<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
.modal_container_sys{
	border: 2px solid #fff;
   background-color : #1e1e1e;
   width : auto;
   color: #fff; 
   
   width:400px;
   position:relative;
   margin:100px auto 0;
   
   padding-bottom:30px;
 
}

.modal_container_sys input, .modal_container_sys select, .modal_container_sys textarea{
 margin-left:34px;
 width:200px;
 }

.modal_container_sys label{
margin-right:20px;
vertical-align:top;
}

#teamModifyFrm{
	padding:20px;
}

.btn-style1{
display:inline-block;
width:100px;
opacity:1;
}

.cancle-btn99{
background-color:rgba(86, 84, 84,0.9);
}

.cancle-btn99:hover{
background-color:rgba(86, 84, 84,1);
}

#teamModifyBtn{
background-color:rgba(224, 51, 122,0.9);
width:200px;
}

#teamModifyBtn:hover{
background-color:rgba(224, 51, 122,1);
}


#teamDelBtn{
background-color:rgba(124, 121, 121,0.9);
}

#teamDelBtn:hover{
background-color:rgba(124, 121, 121,1);

}



.teamMem{
margin:5px;
padding:5px;
border:2px solid #fff;
background:#000;
border-radius:10px;
}

.teamMem img{
width:20px;
height:20px;
}

.teamMem div{
display:inline-block;
}

#delBtn{
position:relative;
cursor:pointer;
}

#delBtn:after{
content:'';
position:absolute;
width:100%;
height:100%;
display:block;
top:0px;
}


</style>

<div class="modal_container_sys">

		<h1 class="erd-add h1">Modify team</h1>
		<form action="/team/teamModify" id="teamModifyFrm" method="post" enctype="multipart/form-data">
			<div class="input-box">
				<label>팀이름 : </label>
				<input type="text" id="title" name="teamNm" placeholder="팀이름">
			</div>
			<div class="input-box">
				<label>팀회원 : </label>
				<input type="text" id="autocomplete" placeholder="팀회원">
			</div>

			<div>
				<ul id="ul">
				</ul>
			</div>
			
			<input type="hidden" name="addMember" id="addMember" value="">
			<input type="hidden" name="delMember" id="delMember" value="">
			<input type="hidden" name="makerId" id="makerId" value="">
			

			<div class="input-box">
				<label>팀설명 : </label>
				<textarea style="color: black" rows="" cols="" name="teamIntro" id="teamIntro"></textarea>
			</div>
			<div class="input-box">
				<label>썸네일 이미지</label>
			<img alt="" src="" id="teamImg" width="200px"> 
			<input type="file" name="profileImg" onchange="loadImg(this)" style= "margin-left:100px; color:#fff; margin-top:10px;"> 
			</div>
			<input type="hidden" id="teamNo" name="teamNo" value="">
		</form>
		
		<div style="margin: 0 auto; text-align:center; margin-bottom:5px; ">
			<div class="btn-style1" id="teamModifyBtn">업데이트</div>
		</div>
		
		<div style="margin: 0 auto; text-align:center; ">
			<div class="btn-style1" id="teamDelBtn">팀 삭제</div>
			<div class="cancle-btn99 btn-style1">취소</div>
		</div>
		



</div>		
<script>
var addList = new Array();
var delList = new Array();

$( "#autocomplete" ).autocomplete({
    source : function( request, response ) {
         $.ajax({
                type: 'get',
                url: "/team/auto",
//                request.term = $("#autocomplete").val()
                data: { value : request.term },
                success: function(data) {
                	console.log("data:"+data.array);
                    //서버에서 json 데이터 response 후 목록에 뿌려주기 위함(view 전에 실행)
                response(
                        $.map(data.array, function(item) {
                        	console.log("item :"+item);
                            return {
                                //label: item.img,
                                value: item.id,
                                data: item.img
                            }
                        })
                    ); 
                }
           });
        },
    //조회를 위한 최소글자수
    minLength: 2,
    autoFocus: true,
    select: function( event, ui ) {
        // 만약 검색리스트에서 선택하였을때 선택한 데이터에 의한 이벤트발생
        console.log("ui.label : " + ui.item.label + " ui.value : " + ui.item.value);
        
        var html = '';
        html += '<li class="teamMem addNew" value="' + ui.item.value + '">';
        html += '	<div><img src="/member/memberImg?memId='+ui.item.value+'"></div>';
        html += '	<div>' + ui.item.value + '</div>';
        html += '	<div id="delBtn"><i class="fas fa-minus-circle"></i></div>';
        html += '</li>';
        

        $("#ul").append(html); 
        $("#autocomplete").val('');
        
        addList.push(ui.item.value);
        
        return false;	// text clear
        }
});



//추가된 회원 삭제
$(document).on("click","#delBtn", function(e){
	$(e.target).parent('li').remove();
	
	var targetId = $(e.target).parent('li').attr('value');
	
	// 이미 팀에 속해있는 멤버 중 삭제할 멤버                 	
	if($(e.target).parent('li').is('.dbLoad')){
		delList.push(targetId);
	}
	// 새로 추가한 멤버 중 삭제한 멤버 리스트에서 꺼내기
	else if($(e.target).parent('li').is('.addNew')){
		addList = jQuery.grep(addList, function(value){
			return value != targetId;
		});
	}
});

$("#teamModifyBtn").on("click", function(){
    $("#addMember").val(addList);
    $("#delMember").val(delList);
	$("#teamModifyFrm").submit();
});

$("#teamDelBtn").on("click", function(){
	$("#teamModifyFrm").attr("action", "/team/teamDelete");
	$("#teamModifyFrm").submit();
	
});

// 이미지 미리보기
function loadImg(value){
	if(value.files && value.files[0]){
		var reader = new FileReader();
		reader.onload = function(e){
			$("#teamImg").attr('src', e.target.result);
		}
		reader.readAsDataURL(value.files[0]);
	}
}




</script>
