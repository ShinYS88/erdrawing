<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/css/member/login.css">

<style>
#contents{
background:#4B4B4B;
}

	
.join-title{
	margin-top:50px;
	margin-bottom:50px;
	
}

.join-btn{
	margin-left:5px;
	margin-right:5px;
}

.btn-style1 {
    opacity: 0.8;
    display: block;
    width: 200px;
    text-align: center;
    margin: 0 auto;
    background: #ef1c7b;
    padding: 10px;
    border-radius: 4px;
    font-size: 16px;
    font-weight: 600;
    border: 1px solid #000;
    cursor: pointer;
    margin-top: 13%;
}

#sh{
margin-top: 0%;
}

</style>
 <div class="member">
 
 <div class="row">
	<div class="join-title col-sm-4 col-sm-offset-1">
		<h1>비밀번호 찾기</h1>
	</div>
</div>

<form id="frm" class="col-sm-4 col-sm-offset-2" action="${cp }/member/pwSearch" method="post">
		
		<span >아이디</span>
		<input	type="text" id="memIds" name="memIds" />  
		
		<span>이메일</span> 
		<input	type="text" id="memMail" name="memMail" /> 
		
		</form>
		
<div class="searchBtn btn-style1">찾기</div>
<div id="sh" class="cancle-btn99 btn-style1">취소</div>

<script >

var checkInput=0;
var checkEmail=0;
$(document).ready(function () {
	
		
	//이메일 인증보내기 클릭시
	$(".searchBtn").on("click", function() {
		
		if($("#memMail").val().trim()==""  ){
			//$("#memId").val().trim()
			
			alert("이메일을 입력해 주세요");
			$("#memMail").focus();
			return;
		}
		
		var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
		if($("#memMail").val().trim()==""  || exptext.test($("#memMail").val())==false){
			//$("#memId").val().trim()
			alert(" 메일형식이 올바르지 않습니다");
			$("#memMail").focus();
			return;
		}
		
		
		var email = $("#memMail").val();
		$.ajax({
		type : "get",
		url : "${cp}/member/sendMailPw",
		data : { email: email,
			memId: $("#memIds").val() }, 
		
		success : function(data) {
		if(data.check=="ok"){
				alert("메일로 임시비밀번호를 보냈습니다.");
				$(".background-etc").css("display","none");
				$('.inner-add').html("");	
		}
				
		else if(data.check=="bx"){
			alert("카카오 또는 google계정으로 로그인을 해주세요");
			$(".background-etc").css("display","none");
				$('.inner-add').html("");	
		}
		else {
			alert("존재하지 않는 아이디 입니다.");
			$(".background-etc").css("display","none");
			$('.inner-add').html("");	
			}
		},
		error : function(xhr, status, error) {
			console.log("에러!: " + error);
		},
		
	});
	});
	
	
	});

</script>
</div>

