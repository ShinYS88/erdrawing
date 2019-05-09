<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
select{
	color: black;
}

.modal_container_k{
	border: 2px solid #fff;
   background-color : #1e1e1e;
   width : auto;
   color: #fff; 
   
   width:800px;
   position:relative;
   margin:100px auto 0;
   
   padding-bottom:20px;
 
}

.modal_container_k input, .modal_container_k select{
margin-left:20px;
}


.btn-style1{
display:inline-block;
width:100px;
opacity:1;
}

.cancle-btn99{
background-color:rgba(94, 92, 93,0.9);
}

.cancle-btn99:hover{
background-color:rgba(94, 92, 93,1);
}

.submit-btn99{
background-color:rgba(224, 51, 122,0.9);
}

.submit-btn99:hover{
background-color:rgba(224, 51, 122,1);
}
#agree1{
height: 130px;
overflow:auto;
width:700px;
margin-bottom: 5%;
margin-left:7%;
background-color: gray;
padding-left: 20px;
}

#agree2{

padding-left: 20px;
height: 130px;
overflow:auto;
width:700px;
margin-left:7%;
background-color: gray;
margin-bottom: 10%;
}

.btn-style1 {
    opacity: 0.8;
    display: ;
    width: 200px;
    text-align: center;
    margin: 0 auto;
    background: gray;
    padding: 10px;
    border-radius: 4px;
    font-size: 16px;
    font-weight: 600;
    border: 1px solid #000;
    cursor: pointer;
}
.agreeinfo{
margin-left: 7%;}

</style>   

		<div class="modal_container_k">
			
			<h1 class="erd-add h1">Join</h1>
 			<div class="agreeinfo" style="margin-top: 8%;"><span>수집 정보 동의</span></div>
			<div id="agree1">
			<div id="test1">
					1. 수집 할 정보 및 수집 방법<br/>
					(1) 수집 할 개인 정보 항목<br/>
					회사가 수집하는 개인 정보 항목은 다음과 같습니다.<br/>
					<br/>
					사용자가 제공 한 정보
					회사는 사용자가 직접 제공 한 정보를 수집 할 수 있습니다.<br/>
					<br/>
					[개인 정보 보호 정책 부록 <1-1>의 '개인 정보 항목'선택 옵션]<br/>
					<br/>
					사용자가 서비스를 사용하는 동안 수집 된 정보<br/>
					회사는 사용자가 직접 제공 한 정보 외에도 사용자가 회사에서 제공하는 서비스를 사용하는 과정에서 정보를 수집 할 수 있습니다.<br/>
					<br/>
					[개인 정보 보호 정책 부록 <1-2>의 '개인 정보 항목'선택 옵션]<br/>
					<br/>
					(2) 수집 방법<br/>
					회사는 다음과 같은 방법으로 사용자의 정보를 수집합니다.<br/>
					<br/>
					[개인 정보 보호 정책 별첨 <2>]에서 '수집 방법'을 선택할 수있는 옵션]<br/>
					<br/>
					2. 수집 된 정보의 사용<br/>
					회사는 수집 된 사용자 정보를 다음과 같은 목적으로 사용합니다.<br/>
					<br/>
					[개인 정보 보호 정책 별첨 <3>에서 '수집 된 정보 활용'을 선택할 수있는 옵션]<br/>
					<br/>
					회사는 본 정책에서 명시 적으로 언급 한 정보 이외의 정보를 사용하고자하는 경우 사용자로부터 동의를 얻을 것에 동의합니다.<br/>
					<br/>
					3. 수집 된 정보 공유<br/>
					다음과 같은 경우를 제외하고 회사는 제 3 자와 개인 정보를 공유하지 않습니다.<br/>
					<br/>
					회사가 계열사, 파트너 및 서비스 제공 업체와 정보를 공유하는 경우<br/>
					[개인 정보 보호 정책 별첨 <4-1>에서 '수집 된 정보 공유'옵션 선택]<br/>
					<br/>
					사용자가 사전에 공유에 동의하면;<br/>
					[개인 정보 보호 정책 별첨 <4-2>의 '수집 된 정보 공유'옵션 선택]<br/>
					<br/>
					법률에 의해 공유가 요구되는 경우<br/>
					법률 및 규정에 의해 공개 될 필요가있는 경우; 또는<br/>
					법률 및 규정에 규정 된 절차 및 방법에 따라 범죄를 탐지하기 위해 수사 기관이 공개해야하는 경우<br/>
			</div>
			</div>
			
			<!-- 동의화면 2 -->
			<div class="agreeinfo" ><span>보안및 사용자권한</span></div>
			<div id="agree2">
			<div id="test2">
			보안 대책<br/>
			개인 정보의 암호화<br/>
			암호화 된 통신 영역을 사용하여 사용자의 개인 정보를 전송합니다.<br/>
			암호와 같은 중요한 정보를 암호화 한 후에 저장하십시오.<br/>
			해킹 대책<br/>
			해킹 또는 컴퓨터 바이러스에 의한 사용자의 개인 정보 유출 또는 누출을 방지하기 위해 외부 접근이 통제되는 영역에 시스템을 설치하십시오.<br/>
			내부 경영 계획 수립 및 실행<br/>
			출입 통제 시스템 설치 및 운영<br/>
			단조 또는 접근 기록 변경 방지 조치<br/>
			4. 쿠키, 비컨 및 유사한 기술<br/>
			회사는 '쿠키'또는 '웹 비콘'을 통해 집단적 또는 비 개인적인 정보를 수집 할 수 있습니다.<br/> 
			<br/>
			쿠키는 회사의 웹 사이트 운영에 사용되는 서버에 의해 사용자의 브라우저로 전송되는 아주 작은 텍스트 파일이며 사용자 컴퓨터의 하드 디스크에 저장됩니다.<br/>
			<br/>
			웹 비콘은 웹 사이트와 전자 메일에 존재하는 소량의 코드입니다. 웹 비콘을 사용하여 사용자가 특정 웹 또는 이메일 내용과 상호 작용했는지 여부를 알 수 있습니다.<br/>
			<br/>
			이러한 기능은 서비스를 평가하고 개선하며 사용자의 경험을 설정하는 데 사용되므로 회사는 사용자에게 훨씬 향상된 서비스를 제공 할 수 있습니다.<br/>
			<br/>			
			회사가 수집하는 쿠키 및 수집 목적은 다음과 같습니다.<br/>
			<br/>
			[개인 정보 보호 정책 별첨 <5>에서 '쿠키 수집'옵션 선택]<br/>
			<br/>
			사용자는 쿠키 설치 옵션을 사용할 수 있습니다. 따라서 웹 브라우저에서 옵션을 설정하여 모든 쿠키를 허용하거나, 쿠키가 저장 될 때마다 확인하거나 모든 쿠키가 저장되는 것을 거부 할 수 있습니다. 단, 사용자가 쿠키 설치를 거부하면 이용자가 회사가 제공하는 서비스의 일부를 사용할 수 있습니다.<br/>
			<br/>
			5. 사용자의 액세스 권한 및 옵션<br/>
			정보의 주요 에이전트 인 사용자 또는 그들의 법적 대리인은 회사가 개인 정보를 수집, 사용 및 공유하는 것과 관련하여 다음과 같은 옵션을 행사할 수 있습니다.<br/>
			<br/>
			개인 정보에 접근하기위한 권리 행사;<br/>
			수정 또는 삭제;<br/>
			개인 정보의 처리를 일시적으로 중단; 또는<br/>
			전에 제공된 동의 철회를 요청하십시오.<br/>
			위의 옵션을 행사하기 위해 사용자가 '웹 페이지의 회원 정보 수정'메뉴를 사용하거나 담당 부서 (또는 개인 관리 담당자)에게 대표 이메일을 사용하여 회사에 연락하십시오. 정보를 제공하는 경우) 회사는 지체없이 조치를 취할 것입니다. 단, 회사는 법령이나 동등한 사유로 정당한 사유가 존재할 경우에만 귀하의 요청을 거부 할 수 있습니다.<br/>
			<br/>
			6. 보안<br/>
			회사는 이용자의 개인 정보 보호를 매우 중요하게 생각합니다. 회사는 허가되지 않은 액세스, 해제, 사용 또는 수정으로부터 사용자의 개인 정보를 보호하기 위해 다음과 같은 보안 조치를 취합니다.<br/>
			<br/>
			[개인 정보 보호 정책 별첨 <6>의 '보안 대책'선택 옵션]<br/>
			<br/>
			7. 개인 정보 보호 정책의 변경<br/>
			회사는이 정책을 수시로 개정 또는 수정할 수있는 권리가 있으며,이 경우 회사는 웹 사이트의 게시판을 통해 (또는 서면 문서, 팩스 또는 전자 메일과 같은 개별 통지를 통해) 공개 할 것입니다. 관련 법률에 따라 필요한 경우 사용자로부터 동의를 얻으십시오.<br/>
			<br/>
			8. 회사 책임 부서<br/>
			[개인 정보 보호 정책 별첨 <7>에서 '데이터 전송'옵션 선택]<br/>
			<br/>
			[개인 정보 보호 정책 별첨 <8>] '제 3 자 사이트 및 서비스'선택 옵션<br/>
			<br/>
			[개인 정보 보호 정책의 부록 <9>에서 '캘리포니아 주 주민에 대한 지침'옵션 선택]<br/>
			<br/>				
			[개인 정보 보호 정책 별첨 <10>]에서 '한국 거주자를위한 가이드 라인'을 선택할 수있는 옵션]<br/>
			<br/>
			9. 기타<br/>
			회사는 고객의 개인 정보를 보호하고 고객의 불만 사항을 처리하기 위해 다음과 같은 개인 정보 담당 부서 및 담당자를 지정합니다.<br/>
</div>
			</div>
			
			<div style="margin: 0 auto; text-align:center; ">
				<div class="cancle-btn99 btn-style1">취소</div>
				<button class="btn-style1"  id="joinBtn">회원가입</button>
			</div>
			<form id="frm" action="${cp }/join"></form>
		</div>
		<script>
		
		var scrollValue ;	//스크롤 위치
		var divHeight ;

		var scrollValue2 ;	//스크롤 위치
		var divHeight2 ;
		
		$("#joinBtn").prop("disabled", true);
		
		$("#agree1").scroll(function () { 
		 scrollValue = $("#agree1").scrollTop();	//스크롤 위치
		 divHeight = $("#test1").prop('scrollHeight');
	
		 if( scrollValue+150>divHeight&&scrollValue2+150>divHeight2){
				$("#joinBtn").prop("disabled", false); 
				document.getElementById("joinBtn").style.backgroundColor = "#ef1c7b";
	}
		 
		});
		
		$("#agree2").scroll(function () { 
			 scrollValue2 = $("#agree2").scrollTop();	//스크롤 위치
			 divHeight2 = $("#test2").prop('scrollHeight');
			
			 if( scrollValue+150>divHeight&&scrollValue2+150>divHeight2){
					$("#joinBtn").prop("disabled", false);
					document.getElementById("joinBtn").style.backgroundColor = "#ef1c7b";
		}
			});
		
		$("#joinBtn").on("click",function(){
			if($("#joinBtn").prop("disabled", false)){
				$("#frm").submit();
			}else{
				alert("정보를 다 읽어야합니다.");
			}
		
		
		
		});


		</script>
		
