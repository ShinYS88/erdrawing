


// 채팅입력 엔터
$("#sendChat").on("keydown", function(e){
	if(e.keyCode == 13){
		chatSend();
	}
});

// 채팅입력 클릭
$("#sendBtn").on("click", function(){
	chatSend();
});

// 채팅입력 보내기
function chatSend(){
	
	var chatContent = $("#sendChat").val();
	$('#sendChat').val("");
	webSocket.send("chat" + "★"+ chatContent);
	
	// 보낸 채팅 insert
	$.ajax({
		type : "post",
		url : "/erddrawing/chatInsert",
		data : {
			chatContent : chatContent,
			erdNo : erdNo,
		},
		success : function(data) {
		},
		error : function(xhr, status, error) {
			console.log(error);
		}
	});
}

$("#button42").on("click", function(){
	// 채팅 리스트 가져오기
	$.ajax({
		type : "post",
		url : "/erddrawing/chatList",
		data : {
			erdNo : erdNo
		},
		success : function(data) {
			var chatList = data.chatList;
			var html = "";
			for(var i in chatList){
	
//				html += `<ul>
//					<li><img src="/member/memberImg?memId=`+chatList[i].memId+`"></li>
//					<li>
//						<div class="msg_id">`+chatList[i].memId+`</div>
//						<div style="position:relative; padding:10px;">
//							<div class="msg_chat">`+chatList[i].chatContent+`</div>
//							<span>`+getDateFormatMS(new Date(parseInt(chatList[i].chatInDt)))+`</span>
//						</div>
//					</li>
//				</ul>`;
				
				
				if(chatList[i].memId != S_userId){
					
					html += `<ul>
									<li><img src="/member/memberImg?memId=`+chatList[i].memId+`"></li>
									<li>
										<div class="msg_id">`+chatList[i].memId+`</div>
										<div style="position:relative; padding:10px;">
											<div class="msg_chat">`+chatList[i].chatContent+`</div>
											<span>`+getDateFormatMS(new Date(parseInt(chatList[i].chatInDt)))+`</span>
										</div>
									</li>
								</ul>`;
				
				}else{
					
					html += `<ul style="float:right;">
									<li>
										<div class="msg_id" style="text-align:right; padding-right:10px;">`+chatList[i].memId+`</div>
										<div style="position:relative; padding:10px;">
											<span style="margin-right:5px;">`+getDateFormatMS(new Date(parseInt(chatList[i].chatInDt)))+`</span>
											<div class="msg_chat" style="background:#F7E04B; color:#000; font-weight:800;">`+chatList[i].chatContent+`</div>
											
										</div>
									</li>
									<li><img src="/member/memberImg?memId=`+chatList[i].memId+`"></li>
								</ul>`;
					
				}
				html += "<div style='clear:both;'></div>";

			}
			
			
			
			$("#inputTxt").html(html);
			$(".con_inner").scrollTop($('.con_inner2').height()+300);
			
		},
		error : function(xhr, status, error) {
			console.log(error);
		}
	});
});
