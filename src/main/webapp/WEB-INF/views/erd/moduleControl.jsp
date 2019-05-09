<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    
<style>
.background-etc{
position:absolute;
z-index:9000;
display:none;
width:100%;
height:100%;
left:0;
top:0;
background-color:rgba(0, 0, 0, 0.8);;
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
/*     border: 2px solid #fff; */
/*     background-color : #1e1e1e; */
/*     width : auto; */
/*     color: #fff;  */
    
/*     width:500px; */
/*     position:relative; */
/*     margin:100px auto 0; */
    
    
    
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
		
			var page;
	
			$(".myAdd").on("click", function(){
				page = "erdAdd";
				gogogo1(page);
			});
			
			$(".myAddTE").on("click", function(){
				page = "erdAdd";
				
				gogogo1(page);
				
				$("#selTeam").show();
		    		clickTeam = true;
		    		
		    		$('input[name=erdScope][value="team"]').prop("checked",true);
		    		$('select[name="teamNo"]').val(getTeamNo);
			});
			
			
			// team추가 스크립트
			$("#teamAdd").on("click", function(){
				page = "createTeam";
				gogogo1(page);

			});
			
			// team 수정 스크립트
			$("#teamModify").on("click", function(){
				page = "teamModify";
				gogogo1(page);

			});
			
			$("#message").on("click", function(){
				page = "message";
				gogogo1(page);
			});
			
			 $("#searchModal").on("click", function(){
				page = "searchModal";
				//gogogo1(page);
			}); 
			
			 $("#erdModify").on("click", function(){
					page = "erdModify";
					gogogo1(page);
			});
			 
			//회원가입 클릭시
			 $("#join").on("click", function(){
			 	page = "joinAgree";
			 	gogogo1(page);
			 });
			 
			function gogogo1(page){
				 $.ajax({
	                    type: 'get',
	                    url: "/pageViewAjax",
	                    data: { value : page },
	                    async:false,
	                    success: function(data) {
	                    	$(document).scrollTop(0);
	               			// 모달 띄우기
	                    	var height = $(document).height();
	            			$(".background-etc").css({"display":"block", "height" : height + "px"});
	                    	$('.inner-add').html(data);
	                    	
	                        
	                    	// 취소버튼 클릭 시 화면 띄우기
	            			$(".cancle-btn99").on("click", function(){
	             				$(".background-etc").css("display","none");
	            				$('.inner-add').html("");
	            			});
	                        
	                    } 
				 });
			}	
 		});

</script>


