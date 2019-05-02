<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<nav id="header" class="navbar navbar-inverse navbar-fixed-top">
	<div class="container" style="background:#232323;">


		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#navbar" aria-expanded="false"
				aria-controls="navbar">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>

			<ul class="left-menu">
				<li class="navbar-brand" style="padding:7px 30px 3px 15px;"><a href="/"><img height="40" src="/image/erdlogo2.png"></a></li>
				<li class="navbar-brand"><a href="/library">Library</a></li>
				<li class="navbar-brand communityHover"><a href="/">Community</a>
					<%@ include file="/WEB-INF/views/template/module/communityMenu.jsp"%>
				</li>
<!-- 				<li class="navbar-brand"><a href="/erdDrawing?erdNo=1098">ErdTest</a></li> -->
				<li class="navbar-brand"><a href="/ticket/ticketList">Ticket</a></li>
				
				<c:if test="${SESSION_MEMBERVO.memAuth == 'T' }">
				<li class="navbar-brand communityHover"><a href="/">Admin</a>
					<%@ include file="/WEB-INF/views/template/module/adminMenu.jsp"%>
					<%-- <li class="navbar-brand"><a href="${cp }/member/memberList">MemberList</a></li>
					<li class="navbar-brand"><a href="${cp }/member/memberList">TicketChart</a></li> --%>
					</li>
				</c:if>
				
			</ul>

		</div>

		<div id="navbar" class="collapse navbar-collapse">
			<ul class="nav navbar-nav">
				<!-- <li class="active"><a href="#">ERD생성</a></li> -->
				<li><a class="myAdd">ERD생성</a></li>

				<c:choose>

					<c:when test="${SESSION_MEMBERVO == null }">
						<li><a href="${cp }/login">로그인</a></li>
						<%-- <li><a href="${cp }/join">회원가입</a></li> --%>
						 <li><a id="join">회원가입</a></li> 
					</c:when>
					<c:otherwise>
						<li><a href="${cp }/mypage" style="padding:7px 15px 7px 15px;">
					 	<c:choose>
									<c:when test="${SESSION_MEMBERVO.memEmailDiv =='basic'}">
										<img alt=""
											src="${cp }/member/memberImg?memId=${SESSION_MEMBERVO.memId }"
											width="36" height="36">
									</c:when>
									<c:otherwise>

										<c:choose>
											<c:when
												test="${ fn:indexOf(SESSION_MEMBERVO.memImg,'http') > -1}">
												<img alt="" src="${SESSION_MEMBERVO.memImg }" width="36"
													height="36">

											</c:when>
											<c:otherwise>

												<img alt=""
													src="${cp }/member/memberImg?memId=${SESSION_MEMBERVO.memId }"
													width="36" height="36">

											</c:otherwise>
										</c:choose>

									</c:otherwise>
								</c:choose>
						</a></li>
						<%-- 						<li><a href="${cp }/message/messageView">메세지</a></li> --%>
						<li><a id="message" style="cursor:pointer">메세지<span class="badge" id="msgCnt"></span></a></li>
						<li><a id="logout" href="#" hidden="">로그아웃</a></li>
					</c:otherwise>
				</c:choose>

				<li><a id="searchModal" style="cursor:pointer" data-toggle="modal" data-target="#modalEvnTest">검색</a></li>
			</ul>
		</div>	
		<!--/.nav-collapse -->
		
		<div id="modals">
			<%@ include file="/WEB-INF/views/erd/search.jsp"%>
		</div>

		<input type="hidden" id="memEmailDiv"
			value="${SESSION_MEMBERVO.memEmailDiv}">

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="https://apis.google.com/js/platform.js" async defer></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.3.0/sockjs.min.js"></script>
<script>



		var abc;
		$("#logout").click(function() {
		if ($("#memEmailDiv").val() == "google") {
						abc = window.open('https://accounts.google.com/logout',
								'ot', 'width=300,height=300,left=650,top=300');

						setTimeout(function() {
							abc.close();
							window.location.href = '/logout';
						}, 1500);
					}	//구글로그인한 경우

		else if ($("#memEmailDiv").val() == "kakao") {
						Kakao.init('8eded83f4085ba344e793801d05f3722');
					     Kakao.API.request({
					          url: '/v1/user/unlink',
					       //   /v1/api/talk/profile
					          success: function(res) {
						            alert("로그아웃");
						            location.href = '/logout';
						          },
					          fail: function(error) {
					            alert("로그인 실패");
					          }
					        });
					}

					else {
						$("#logout").attr("href", "/logout");
					}//기본 로그인한 경우
				});
		
		var msgWebSocket;
		
		$(document).ready(function(){
			connectMsgWs();
		});
		
		function connectMsgWs(){
			var msgWs = new WebSocket("ws://localhost:8080/msgEcho");
			msgWebSocket = msgWs;
			
			msgWs.onopen = function(){
				console.log("접속");
				setTimeout(() => {
					connectMsgWs();
				}, 100000000);
				
				msgWs.onmessage = function(event){
					var msg = event.data;
					$("#msgCnt").html(msg);
				}
				msgWs.onclose = function(event){console.log('Info: connection closed.');}
			}
			msgWs.onerror = function(err){console.log('Error:', err);
			}
		}
		
 
	</script>
</nav>