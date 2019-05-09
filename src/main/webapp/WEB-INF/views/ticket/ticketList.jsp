<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="/css/member/modify.css">
<link rel="stylesheet" href="/css/member/mypage.css">
<link rel="stylesheet" href="/css/boxErd.css">

<style>

.filebox input[type="file"] {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  border: 0;
}
.filebox label {
  display: inline-block;
  color: #fff;
  font-size: inherit;
  line-height: normal;
  vertical-align: middle;
  background-color: #FA4358;
  cursor: pointer;
  border: 1px solid #FA4358;
  border-radius: .25em;
}
.filebox label:hover {
  background-color: #FA4358;
}
.filebox label:active {
  background-color: #FA4358;
}
.modal{
 color: #000;

}
.modal-dialog, .modal-content {
    height: auto;
}

#ticketModalEvnTest{
 height: auto;
}
.modalLabels{
width: 100px;
}

#add{
margin-right: 8%;
    margin-left: 84%;
    position: relative;
    padding: 10px;
    font-weight: 100;
    font-size: 16px;
    top: 20px;
    right: 0;
    border: 3px solid #fff;
    border-radius: 5px;
    opacity: 0.8;
    cursor: pointer;
}
.modal-backdrop {
    position: absolute;
    height: 500%;
    top: 0;
    right: 0;
    left: 0;
    background-color: #000;
}

#add:hover {
    opacity: 1;
    background: #fff;
    color: #000;
}

.tickets .bg-img1{
color:#fff;
}
.bg-box {
    position: absolute;
    display: block;
    background: #3b3b3b;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    width: 100%;
    height: 100%;
    overflow: hidden;
}

.page-header {
    padding-bottom: 12px;
    margin:  0 ; 
    border-bottom: 1px solid #eee;
}
</style>
<br />
<br />
<c:if test="${SESSION_MEMBERVO.memAuth == 'F' || SESSION_MEMBERVO.memAuth == null}">
<div style="text-align: center;">
    <h3 class="page-header" style="color: #fff;  font-weight: bold;">Ticket</h3>
   </div>
   <div style="margin-bottom: 50px"></div>
</c:if>



<c:if test="${SESSION_MEMBERVO.memAuth == 'T' }">

      <div style="" id="add" class="modifyModal" data-toggle="modal" data-ticketno="insert" data-target="#ticketModalEvnTest" data-ticketno="insert" >티켓 추가</div>
      <br/>   <br/>
   
</c:if>


<c:forEach var="ticket" varStatus="status" items="${ticketList }">
	<div style="display: block; margin-bottom: 27px ;margin-left: 8%;margin-right: 8% ;">
		<div
			style="border: 2px solid darkgray; display: inline-block; width: 100%; background-color: #5d5d5d;">

			<div
				style="display: inline-block; background-color: #ccdb5c; width: 27%; text-align: center;">
				<h4 style="display: inline-block; color:#000; padding: 30px; font-size: 28px; ">${ticket.ticketContent }&nbsp;권</h4>
			</div>

			<div style="display: inline-block; margin-left: 10%; width: 47%; text-align: center;     margin-right: 20px;">
				<%-- <label style="display: inline-block; margin-left: 10%;">${ticket.ticketContent }</label> --%>
				<label style="font-size: 18px; margin-top: 3px; margin-bottom: 20px'" >${ticket.ticketPrice }&nbsp;원</label><br/>
					<label>	${ticket.ticketPeriod }일 동안 ERD생성 시 비공개설정을 더 많이 사용할수있는 이용권입니다.</label>
			</div>
			<c:if test="${SESSION_MEMBERVO.memAuth == 'T' }">
				
			</c:if>
			<div  style="display: inline-block; cursor: pointer;"
				data-ticketno="${ticket.ticketNo }" class="modifyModal buyTicketBtn"
				data-toggle="modal" data-target="#modifyBuyModal">
				<button  class="btn btn-default" style="">구매</button></div>
				
			<c:if test="${SESSION_MEMBERVO.memAuth == 'T' }"> 
			<div
				style="display: inline-block; margin-left: 10%; color: ccdbaa; border-radius: 3px; padding: 3px; margin: 5px; cursor: pointer;"
				data-toggle="modal" data-target="#ticketModalEvnTest"
				data-ticketno="${ticket.ticketNo }" class="modifyModal">
				<button class="btn btn-default" style="">수정</button>
			</div>
		
			</c:if>	
		
		</div>
	</div>

</c:forEach>

<%@ include file="/WEB-INF/views/ticket/ticketModal.jsp"%>
   
   
   <script type="text/javascript">
   
   
   var ticketNo = "";
   var regex= /^[0-9]+$/;
   $(document).ready(function() {
      
	   $(".imgDiv").hide();
	   
       $("#input_img").on("change", handleImgFileSelect);

      var msg = "${msg}"
      if(msg !=""){
         alert(msg);
      }
   
      //티켓 클릭시
      $(".buyTicketBtn").on('click', function() {
         ticketNo = $(this).data("ticketno");
         getModifyInfo(ticketNo);
           $("#sinbuy").hide();  
            $("#mobuy").hide();
      });
      
      //티켓리스트의 수정클릭시
      $(".modifyModal").on('click', function() {
            ticketNo = $(this).data("ticketno");
            
            //수정버튼
            if(ticketNo!="insert"){
             $("#insertBtn").hide();
            $("#modifyBtn").show();
            $("#deleteBtn").show();
            getModify(ticketNo);
            }
            
            //추가버튼
            else{
               
               $("#insertBtn").show();
               $("#modifyBtn").hide();
               $("#deleteBtn").hide();
               getModifys();      
            }
         });

      //모달창 수정클릭시
      $("#modifyBtn").on('click', function() {
         
         if (confirm("수정 하시겠습니까??") == true) {
            
            if($("#ticketPrice").val().trim()==""){
               //$("#memId").val().trim()
               alert("가격을 입력해 주세요");
               $("#ticketPrice").focus();
               return false;
            }
            
            if($("#ticketPrice").val().trim()==""  || regex.test($("#ticketPrice").val())==false){
               alert("가격은 숫자만 입력 가능합니다.");
               $("#ticketPrice").focus();
               return false;
            }
            
            if($("#ticketContent").val().trim()==""){
               //$("#memId").val().trim()
               alert("이용권 내용을 입력해주세요");
               $("#ticketContent").focus();
               return false;
            }
            
            if($("#ticketContent").val().trim()==""){
               //$("#memId").val().trim()
               alert("이용권 내용을 입력해주세요");
               $("#ticketContent").focus();
               return false;
            }
            
            $("#frm").attr("action", "/ticket/modifyTicket");
            $("#frm").submit();
         }else{
        	 return false;
         }
         });

         $("#deleteBtn").on('click', function() {
            
            if (confirm("삭제 하시겠습니까??") == true) {
               $("#frm").attr("action", "/ticket/deleteTicket");
               $("#frm").submit();
            }
         });
         
         //모달창 추가클릭시
         $("#insertBtn").on('click', function() {
            
            if (confirm("추가 하시겠습니까??") == true) {
               
               if($("#ticketPrice").val().trim()==""){
                  //$("#memId").val().trim()
                  alert("가격을 입력해 주세요");
                  $("#ticketPrice").focus();
                  return false;
               }
               if($("#ticketPrice").val().trim()==""  || regex.test($("#ticketPrice").val())==false){
                  alert("가격은 숫자만 입력 가능합니다.");
                  $("#ticketPrice").focus();
                  return false;
               }
               
               if($("#ticketContent").val().trim()==""){
                  //$("#memId").val().trim()
                  alert("이용권 내용을 입력해주세요");
                  $("#ticketContent").focus();
                  return false;
               }
               
               if($("#ticketContent").val().trim()==""){
                  //$("#memId").val().trim()
                  alert("이용권 내용을 입력해주세요");
                  $("#ticketContent").focus();
                  return false;
               }
               $("#frm").attr("action", "/ticket/insertTicket");
               $("#frm").submit();
            }
            });
         
         //결제모달창 제어
         //동의 체크박스 제어
         $("#all-agree").on("click", function(){
             if (! $('#all-agree').prop('checked')) {
                 $('.checkSelect1').prop('checked', false);          
             }else{
                 $('.checkSelect1').prop('checked', 'checked');
             }
         });
         
         
          $("#age").on("keyup", function(e) {
                 $(this).val($(this).val().replace(/[^0-9]/g,""));
             });
         $("#licenseNumber").on("keyup", function(e) {
              $(this).val($(this).val().replace(/[^0-9]/g,""));
           });
           $("#cardpwd").on("keyup", function(e) {
               $(this).val($(this).val().replace(/[^0-9]/g,""));
           });
           $(".ipt_cardnumber").on("keyup", function(e) {
               $(this).val($(this).val().replace(/[^0-9]/g,""));
           })
         
      });

   //해당 티켓 정보 가져오기 
      function getModify(ticketNo) {
         $.ajax({
            url : "${cp}/ticket/ticketModify",
            data : {
               ticketNo : ticketNo
            },
            success : function(data) {
               console.log(data);
               $("#ticketNo").val(data.ticketVo.ticketNo);
               $("#ticketPrice").val(data.ticketVo.ticketPrice);
               $("#ticketContent").val(data.ticketVo.ticketContent);
               $("#profileImg").attr("src", "${cp }/ticket/ticketImg?ticketNo="+data.ticketVo.ticketNo);
               $("#ticketPeriod").val(data.ticketVo.ticketPeriod);
            }
         });
      }
      
      function getModifys() {
         $("#ticketNo").val("");
         $("#ticketPrice").val("");
         $("#ticketContent").val("");
         $("#ticketPeriod").val("");
         $("#profileImg").attr("src","/image/noImg.png");
      }
      
      

         function handleImgFileSelect(e) {
             var files = e.target.files;
             var filesArr = Array.prototype.slice.call(files);
             filesArr.forEach(function(f) {
                 if(!f.type.match("image.*")) {
                     alert("확장자는 이미지 확장자만 가능합니다.");
                     return;
                 }

                 sel_file = f;

                 var reader = new FileReader();
                 reader.onload = function(e) {
                     $("#profileImg").attr("src", e.target.result);
                 }
                 reader.readAsDataURL(f);
             });
         }
         
         function radioBtn_ch() {
            var radioVal = $('input[name="buychoose"]:checked').val();
            if(radioVal=="sin"){
             $("#sinbuy").show();  
             $("#mobuy").hide();  
             
            }else{

                $("#sinbuy").hide();  
                $("#mobuy").show();
            }
      }
         function cardBuyCk() {
            if($("#cardno1").val().trim()=="")
               {
                   alert("카드 번호를 입력해 주세요.");
                   $("#cardno1").val() = "";
                   $("#cardno1").focus();
                   return false;
               }
      }
         //해당 티켓 정보 가져오기 
         function getModifyInfo(ticketNo) {
            $.ajax({
               url : "${cp}/ticket/ticketModify",
               data : {
                  ticketNo : ticketNo
               },
               success : function(data) {
                  console.log(data);
                 $("#price").html(data.ticketVo.ticketPrice);
                }

            });
         }
         
         
         //신용카드 유효성 체크 
         function fnSubmit(form)
         { 
        	 var radioVal = $('input[name="buychoose"]:checked').val();         
             if(radioVal =="sin"){
          if(form.cardno1.value.length < 4)
           {
                 alert("카드 번호를 입력해 주세요.");
                 form.cardno1.value = "";
                 form.cardno1.focus();
                 return;
             }
             if(form.cardno2.value.length < 4)
             {
                 alert("카드 번호를 입력해 주세요.");
                 form.cardno2.value = "";
                 form.cardno2.focus();
                 return;
             }
             if(form.cardno3.value.length < 4)
             {
                 alert("카드 번호를 입력해 주세요.");
                 form.cardno3.value = "";
                 form.cardno3.focus();
                 return;
             }
             if(form.cardno4.value.length < 2)
             {
                 alert("카드 번호를 입력해 주세요.");
                 form.cardno4.value = "";
                 form.cardno4.focus();
                 return;
             }
             if(form.expmon.value == "MM")
             {
                 alert("유효기간을 확인해 주세요.");                
                 form.expmon.focus();
                 return;
             }
             if(form.expyear.value == "YYYY")
             {
                 alert("유효기간을 확인해 주세요.");                
                 form.expyear.focus();
                 return;
             }
         
                 if(form.age.value.length != 6)
                 {
                     alert("생년월일 6자리를 입력해 주세요.");
                     form.age.value = "";
                     form.age.focus();
                     return;
                 }
             
                 if(form.cardpwd.value.length < 2)
                 {
                     alert("카드 비밀번호를 입력해 주세요.");
                     form.cardpwd.value = "";
                     form.cardpwd.focus();
                     return;
                 }
             
             if (form.confirm.checked == false)
             {
                 alert("결제 내용 확인 및 동의하셔야 결제가 진행됩니다.");
                 form.confirm.focus();
                 return;
             }
             
             if(!form.agree01.checked)
             {
                 alert("전자금융거래 이용약관에 동의해 주십시오.");
                 form.agree01.focus();
                 return;
             }
             if(!form.agree02.checked)
             {
                 alert("개인정보 수집/이용 안내에 동의해 주십시오.");
                 form.agree02.focus();
                 return;
             }
             if(!form.agree03.checked)
             {
                 alert("개인정보 제공/위탁 안내에 동의해 주십시오.");
                 form.agree03.focus();
                 return;
             }
             $("#modalticketNo").val(ticketNo);
             console.log($("#ticketNo").val());
             console.log($("#memId").val());
             $("#cardFrm").submit();
             }else if(radioVal== "mo"){
            	 if($("#vcdbank").val()=="")
                 {
                     alert("은행을 선택해주세요");
                     $("#vcdbank").focus();
                     return;
                 }
            	 $("#modalticketNo").val(ticketNo);
                 console.log($("#ticketNo").val());
                 console.log($("#memId").val());
                 $("#cardFrm").submit();
             }
             else if(radioVal =="" || radioVal ==null){
            	 alert("결제방법을 선택하여주세요");
             } 
             
            
         }
         
      
   </script>
