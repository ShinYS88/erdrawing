<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="/css/member/login.css">

<style>
#contents {
	background: #4B4B4B;
}

.join-title {
	margin-top: 50px;
	margin-bottom: 50px;
}

.join-btn {
	margin-left: 5px;
	margin-right: 5px;
}
.submit-btn {
    display: inline-block;
    margin: 10px 0 10px 0;
    width: 100px;
}
#loginBtns{
width: 100%;}
#fmdiv{
margin-left: 35%;}
</style>

<div class="member">

	<div class="row">
		<div class="join-title col-sm-4 col-sm-offset-1">
			<h1>Login</h1>
			
			<div id="fmdiv" style="display: none;">
			<div class="g-recaptcha"
				data-sitekey="6LfnUpoUAAAAAMtKydIehTmTDdm7JZUubAfHHVuf"></div>
			<br />
		</div>
		</div>
	</div>

	<div class="row">

		<form id="erdFrm" class="col-sm-4 col-sm-offset-2"
			action="${cp }/login" method="post">
			<span>이메일</span> <input type="text" id="memId" name="memId" /> <span>비밀번호</span>
			<input type="password" id="memPass" name="memPass" />
			
			<div id="loginBtns">
			<div class="submit-btn btn-style1" >로그인</div>

			<div class="IdSearch btn-style3">아이디/ &nbsp;</div>
			<div class="pwSearch btn-style3">비밀번호를  잊으셨나요?</div>
			
			</div>
			
			<br/>
			
			<br/>
			
			
			
			<input type="hidden" id="capResponse" name="capResponse" />
		</form>


		
<br/>

<br/>
		<form action="${cp }/logins" id="apiFrm" method="post"
			class="col-sm-3 col-sm-offset-1">
<!-- data-onsuccess="onSignIn" -->
			<div class="g-signin2" data-onsuccess="onSignIn"  data-width="220" data-height="47" data-longtitle="true"></div>
			<br/>
			
			
			<input type="hidden" name="info" id="info" /> <a
				id="kakao-login-btn"></a>
		</form>

	</div>

	<div class="lable-style1 col-sm-10 col-sm-offset-1">
		계정이 필요하세요?
		<div class="join-btn btn-style3" onclick="join()">지금 회원가입을 하세요.</div>
		
		
	</div>


</div>



<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>



<script>	
var on =0;
var count=	"${count }";
	$(document).ready(function () {
		 on =0;
		if(count>=3){
			on=1;
			$("#fmdiv").show();
			
		}
		
	
		 Kakao.init('8eded83f4085ba344e793801d05f3722');
		    // 카카오 로그인 버튼을 생성합니다.
		    
		    Kakao.Auth.createLoginButton({
		    
		      container: '#kakao-login-btn',
		      success: function(authObj) {
		        // 로그인 성공시, API를 호출합니다.
		    	  Kakao.Auth.loginForm({
					    success: function (authObj) {
					        Kakao.API.request({
					            url: '/v1/user/me',
					            success: function (res) {
						$("#apiFrm").attr("action","${cp}/kakaoLogin");	
			            $("#info").val(JSON.stringify(res));
			            $("#apiFrm").submit();	
					            }
					        });
					    },
					});
		      },
		      
		      fail: function(err) {
		        alert(JSON.stringify(err));
		      }
		    });
		
		
		<c:if  test="${msg != null}">
		alert("${msg}");
	</c:if>
  		
		//로그인버튼 클릭시
		$(".submit-btn").on("click",function(){
			loginAction();
		});
	
		
		//비밀번호 찾기 클리깃 
		$(".pwSearch").on("click",function(){
			 var page = "pwSearch";
			gogogo1(page); 
		    });
		
		$(".IdSearch").on("click",function(){
			 var page = "IdSearch";
			gogogo1(page); 
		    });
		

		$(".g-signin2").on("click",function(){
			var on = $(this).data("onsuccess");
			onSignIn(on);
		    });
		
		$("#memPass").on("keydown",function(e){
			  if(e.keyCode == 13){
				  loginAction();
			   }
		    });
		
		
		
		
		});
		
		
	function onSignIn(googleUser) {
		  var info = new Array();
		  var profile = googleUser.getBasicProfile();
		  console.log('ID: ' + profile); // Do not send to your backend! Use an ID token instead.
		  console.log('ID: ' + profile.getId()); // Do not send to your backend! Use an ID token instead.
		  console.log('Name: ' + profile.getName());
		  console.log('Image URL: ' + profile.getImageUrl());
		  console.log('Email: ' + profile.getEmail()); // This is null if the 'email' scope is not present.
		
		  info.push(profile.getId());
		  info.push(profile.getName());
		  info.push(profile.getImageUrl());
		  info.push(profile.getEmail());
		  $("#info").val(info);
			 $("#apiFrm").submit();
		}   
	
	
	function join() {
		location.href = '${cp }/join';
	}
	
	
	function loginAction() {

		if ($("#memId").val().trim() == "") {
			alert("ID를 입력해주세요");
			$("#memId").focus();
			return false;
		}
		if ($("#memPass").val().trim() == "") {
			alert("비밀번호를 입력해주세요");
			$("#memPass").focus();
			return false;
		}
		
		
	var sst=$("#g-recaptcha-response").val();
	if(on==1){
		if(sst==''){
			alert("리캡챠를 먼저해주세요 ");
			return;
		}
	}
		
		$("#capResponse").val(sst);
		$("#erdFrm").submit();
		
	}
	function gogogo1(page){
		 $.ajax({
               type: 'get',
               url: "/pageViewAjax",
               data: { value : page },
               success: function(data) {

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
	


</script>

