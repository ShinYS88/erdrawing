<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="/css/message/messageModal.css">


			<c:if test="${empty msgPagingList }">
				<div id="noMsg">알림이 없습니다.</div>
			</c:if>
			<!-- 리스트 출력 -->
			<c:forEach items="${msgPagingList }" var="msgVo">
				
			<li class="msg-items liClass" data-teamno="${msgVo.teamNo }" data-senderid="${msgVo.senderId }" data-msgno="${msgVo.msgNo }">
				<a>${msgVo.msgContent }</a>
				
				<div class="info">
					<div class="nd-box">
						<div class="userId">${msgVo.senderId }</div>
						<div class="dateTime"><fmt:formatDate value="${msgVo.sendDt }" pattern="yy.MM.dd HH:mm" /></div>
					</div>
				</div>
				<div class="btns2">
					<c:choose>
						<c:when test="${msgVo.msgType eq 'y'}">
							<button class="btn btn-success" value="yes">예</button>
							<button class="btn btn-danger" value="no">아니오</button>
						</c:when>
						<c:otherwise>
							<button class="btn glyphicon glyphicon-trash" value="del" style="background: transparent;"></button>
						</c:otherwise>
					</c:choose>
				</div>
			</li>
			</c:forEach>
		
======================seperator==========================

						<c:choose>
							<c:when test="${paging.pageNo eq 1}">
								<li class="disabled"><a ria-label="Previous"> <span
										aria-hidden="true">&laquo;</span>
								</a></li>
							</c:when>
							<c:otherwise>
								<li><a
									href="javascript:getMessagePagingHtml(${paging.prevPageNo})" aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
								</a></li>
							</c:otherwise>
						</c:choose>
						<c:forEach begin="${paging.startPageNo}" end="${paging.endPageNo}" var="i">
							<c:set var="active" value="" />
						<!-- 	초기화 과정 값이 계속 남기때문에 -->
							<c:if test="${i eq paging.pageNo}">
								<c:set var="active" value="active" />
							<!-- 	현재 페이지일 때 활성화를 위해서 -->
							</c:if>
							<li class="${active}"><a
<%-- 								href="${cp}/postList?boardNo=${boardNo}&boardNm=${boardNm}&page=${i}">${i}</a> --%>
								href="javascript:getMessagePagingHtml(${i})">${i}</a>
							</li>
						</c:forEach>

						<c:choose>
							<c:when test="${paging.finalPageNo eq paging.pageNo}">
								<li class="disabled"><a ria-label="Next"> <span
										aria-hidden="true">&raquo;</span>
								</a></li>
							</c:when>
							<c:otherwise>
							
								<li><a
									<%-- href="${cp}/postList?boardNo=${boardNo}&boardNm=${boardNm}&page=${paging.nextPageNo}" --%>
									href="javascript:getMessagePagingHtml(${paging.nextPageNo})"
									aria-label="Next"> <span aria-hidden="true">&raquo;</span>
								</a></li>
							</c:otherwise>
						</c:choose>

