<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    
    <!-- css와 스크립트는 여기서 작성 -->
    


<style>
.background-etc{
position:absolute;
z-index:9000;
display:none;
width:100%;
height:100%;
left:0;
top:0;
background:#000;
color:#fff;
}


.background-etc.bg-on{
	display:block;
}

.inner-add{
   /*  position: relative;
    width: 32%;
    margin-right: 2%;
    margin-bottom: 2%;
    float: left; */
    border: 2px solid #fff;
    background-color : #1e1e1e;
    width : auto;
    color: #fff; 
}

.inner-add .h1{
	position: relative;
    padding: 5px 44px 5px 10px;
    margin: 0;
    background-color: #4a4a4a;
}

.input-box{
	display: table;
	padding: 10px;
}

.input-box.text-label{
	position: relative;
	display: table-cell;
	width: 34%;
	padding: 5px 40px 5px 0;
	color: white;
	padding-right: 10px;
}

ul[id*="ui-"]{
z-index:99999;

}

ul[id*="ui-"] li{
display: block;
}

</style>



<div class="background-etc">
	<div class="inner-add">
		
	</div>
</div>


<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


<script>

	$(document).ready(function(){
		//ERD 생성버튼 클릭 시 화면 띄우기
		
		var importView;	// 적용시킬 jsp
		
		// 취소버튼 메소드
		function moduleSet(importView){
			var height = $(document).height();
			$(".background-etc").css({"display":"block", "height" : height + "px"});
			$('.inner-add').html(importView);
			
			// 취소버튼 클릭 시 화면 띄우기
			$(".cancle-btn99").on("click", function(){
 				$(".background-etc").css("display","none");
				$('.inner-add').html("");
			});
		}
		
		// erd추가 스크립트
		$(".myAdd").on("click", function(){
			importView=`<%@ include file="/WEB-INF/views/erd/erdadd.jsp"%>`;
			moduleSet(importView);
			
			$("#erdAdd").on("click", function(){
				$("#erdAddFrm").submit();
			});
		});
		
		// team추가 스크립트
		$("#teamAdd").on("click", function(){
			importView =`<%@ include file="/WEB-INF/views/erd/teamCreate.jsp"%>`;
			moduleSet(importView);

		 $(function(){
			    $( "#autocomplete" ).autocomplete({
			        source : function( request, response ) {
			             $.ajax({
			                    type: 'get',
			                    url: "/team/auto",
//			                    request.term = $("#autocomplete").val()
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
			            html += '<li class="teamMem">';
			            html += '	<div><img src="'+ ui.item.data + '"></div>';
			            html += '	<div>' + ui.item.value + '</div>';
			            html += '	<input id="delBtn" type="button" value="삭제">';
			            html += '</li>';

			            $("#ul").append(html); 
			            $("#autocomplete").val('');
			            
			            $("#teamMember").val(ui.item.value);
			            
			            //var searchId = $("input[name=searchId]").eq(1).val();
			            return false;	// text clear
			            
			            }
			    });
			})
			// 추가된 회원 삭제
			$(document).on("click","#delBtn", function(e){
				$(e.target).parent('li').remove();	
			});
			

			$("#teamCreate").on("click", function(){
				$("#teamCreateFrm").submit();
			});
		});
	});
</script>


