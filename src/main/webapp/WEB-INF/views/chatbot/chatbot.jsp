<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <style>
 
body {
  font-family: 'Poppins', sans-serif;
  margin: 0;
  background-color: #DDE0E5;
}
a
{
  text-decoration:none;
  color:#827DCF;
  -webkit-transition: 0.3s ease-out;
	transition: 0.3s ease-out;
}
a:hover
{
  color:black
}

h2
{
  text-align:center;
  font-weight:100;
  font-size:24px;
  margin-top:20px;
}
.card {
  z-index: 1;
  position: relative;
  width: 490px;
  height: 650px;
  margin: 0 auto;
  margin-top: 20px;
  background-color: white;
  border-radius: 10px;
  -webkit-box-shadow: 0px 51px 82px -21px rgba(0, 0, 0, 0.61);
  -moz-box-shadow: 0px 51px 82px -21px rgba(0, 0, 0, 0.61);
  box-shadow: 0px 51px 82px -21px rgba(0, 0, 0, 0.61);
}

.banner {
  position: absolute;
  border-top-left-radius: 10px;
  border-top-right-radius: 10px;
  height: 67px;
  width: 100%;
  background-color: #827DCF;
  font-family: 'Quicksand', sans-serif;
}

.banner h1 {
  color: white;
  font-size: 25px;
  margin-left: 65px;
  margin-top: 17.5px;
  font-weight: 400;
}

.banner h1 b {
  font-weight: 800;
}

.cog {
  fill: white;
  stroke: black;
  height: 27px;
  width: 27px;
  position: absolute;
  top: 21px;
  right: 15px;
}

.contact-photo {
  position: absolute;
  top: 15.5px;
  left: 15px;
  height: 35px;
  width: 35px;
  border-radius: 50%;
  background-color: white;
  background-image: url("https://img.icons8.com/ultraviolet/40/000000/bot.png");
  
  background-size: cover;
  background-position: center;
}

.main-text-area {
    overflow-y: auto;
  position: absolute;
  top: 67px;
     height: 500px;
  width: 100%;
}

.time-stamp {
  position: relative;
  width: 100%;
  text-align: center;
  margin-top: 20px;
  margin-bottom: 19px;
  font-size: 12px;
  font-weight: normal;
  color: #7C7C7C;
}

.message {
  position: relative;
  display: block;
  font-weight: 400;
  border-radius: 10px;
  height: auto;
    width: 200px;
    font-size: 17px;
}

.message.from {
  color: white;
  width: 300px;
  background-color: #827DCF;
  margin-left: 26px;
}

.message.to {
  color: #7C7C7C;
  background-color: #F1F1F1;
  margin-left: 50%;
  /* 
  margin-right: 26px;
  float: right; */
}

.message p {
  text-align: left;
    padding: 10px;
  margin: 15;
}

.message:after {
  position: absolute;
  width: 0;
  height: 0;
  background-color: transparent;
  content: "";
  margin-top: -9px;
}

.message.from:after {
  border-right: 16px solid #827DCF;
  border-top-left-radius: 20px;
  margin-left: -14px;
}

.message.to:after {
  border-left: 16px solid #F1F1F1;
  border-top-right-radius: 20px;
  margin-left: 366px;
}

.delivered {
  float: right;
  display: block;
  clear: both;
  color: #d3d3d3;
  font-weight: 400;
  margin-right: 26px;
  margin-top: 9px;
  font-size: 14px;
}

.input-bar {
  position: absolute;
  bottom: 0;
  height: 80px;
  width: 100%;
  border-bottom-left-radius: 10px;
  border-bottom-right-radius: 10px;
  background-color: #F1F1F1;
}

.input-bar-inner {
  margin: 15px;
  height: 49px;
  border-radius: 7px;
  background-color: white;
}

.input-bar-inner i {
  color: #d3d3d3;
  font-size: 25px;
  margin-top: 12px;
  margin-left: 20px;
  -moz-transform: scaleX(-1);
  -o-transform: scaleX(-1);
  -webkit-transform: scaleX(-1);
  transform: scaleX(-1) rotate(-180deg);
}

.input-bar-inner h6 {
  float: right;
  font-size: 20px;
  margin-top: 10px;
  margin-right: 27px;
  color: #827DCF;
  width: 59px;
  font-weight: 400;
    padding-top: 2px;
  -webkit-transition: all 0.3s ease-in-out;
  -moz-transition: all 0.3s ease-in-out;
  -o-transition: all 0.3s ease-in-out;
  -ms-transition: all 0.3s ease-in-out;
}

.input-bar-inner h6,
.input-bar-inner i,
.cog {
  -webkit-transition: all 0.3s ease-in-out;
  -moz-transition: all 0.3s ease-in-out;
  -o-transition: all 0.3s ease-in-out;
  -ms-transition: all 0.3s ease-in-out;
}

.input-bar-inner h6:hover,
.input-bar-inner i:hover,
.cog:hover {
  opacity: 0.3;
  cursor: pointer;
}

#input-text {
  /*    padding: 10px;*/
  height: 45px;
  font-size: 17px;
  vertical-align: middle;
  margin-left: 10px;
  margin-bottom: 8px;
  width: 300px;
  font-family: inherit;
  font-weight: 400;
  border: none;
  border-right: solid 2px #F1F1F1;
}

#input-text:focus {
  outline: none;
}
 </style>   
  <div class="card">
    <div class="banner">
      <div class="contact-photo"></div>
      <h1><b>ChatBot</b> (1:1 Q&A)</h1>

    </div>
    <div class="main-text-area">
      <div class="time-stamp"></div>
      <div class="message from" style="width: 80%;margin-bottom: 20px;">
        <p>안녕하세요. ERDrawing가상채팅봇입니다.
        	ERDrawing의 사용방법에 대하여 도와드리겠습니다 :)	</p>
      </div>
    </div>
    <div class="input-bar">
      <div class="input-bar-inner">
        <input id="input-text" value="" placeholder="Message"></input>
        <h6 id="send">Send</h6>
      </div>
    </div><%-- 
    <form id="frm" action="${cp }/chatbot/chatbotAnswer">
    	<input type="hidden" id="question" name="question">
    </form> --%>
  </div>
  <script>
 
			var userStr = "";
			var mm ;
			var h ;
			var ap;
			
			time();
			$(".time-stamp").html("<b>" + getTodayLabel() + "  </b> "+h+":"+mm+" "+ap);

			$("#input-text").on("keydown", function(e) {
				if (e.keyCode == 13) {
					inputAction();
				}
			});

			$("#send").on("click", function() {
				inputAction();

			});

			//날짜 구하기
			function getTodayLabel() {

				var week = new Array('일요일', '월요일', '화요일', '수요일', '목요일', '금요일',
						'토요일');

				var today = new Date().getDay();
				var todayLabel = week[today];

				return todayLabel;
			}
			
			function time() {
				var now = new Date();
				 h = now.getHours(); //시간
	            
	            if(h > 12)
	            {
	                ap="pm";
	               
	                h = h-12;
	                if(h>=10);
		            else
		             h = "0" +h;
	                
	            }
	            else if(hour < 24)
	            {
	                ap="am";
	                if(h>=10);
		            else
		             h = "0" +h;
	            }
	             mm = now.getMinutes();
	            if(mm>=10);
	            else
	             mm = "0" +mm;
				
			}

			function inputAction() {
				userStr = $("#input-text").val();
				var userDiv = "<div class='message to'>" + "<p>" + userStr
						+ "</p>" + "</div>";

				$(".main-text-area").append(userDiv);

				chatBotAnswer(userStr);

				$("#input-text").val("");

			}

			function chatBotAnswer(userStr) {
				$.ajax({
					url : "${cp}/chatbot/chatbotAnswer",
					data : {
						userStr : userStr

					},
					success : function(data) {
						console.log(data.answer);
						//로봇답
						var chbotBotstr = "<div class='message from'>" + "<p>"
								+ data.answer + "</p>" + "</div>"
								+ "<div style='clear:both;'></div>";

						$(".main-text-area").append(chbotBotstr);

						$(".main-text-area").scrollTop(99999);
					}
				});

			}
		</script>
