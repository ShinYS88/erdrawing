<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


		<c:forEach items="${cmtList}" var="cmt">
			<tr class="cmtTr" data-cmtno="${cmt.cmtNo}">
				<td style="text-align: center; color:black; height:10px; line-height: 25px;">${cmt.cmtNo}</td>
				<td style="text-align: center; color:black; height:10px; line-height: 25px;">${cmt.memId}</td>
				
				<c:if test="${cmt.flag eq 'T'}">
					<td style="color:black; height:10px; vertical-align: bottom; line-height: 25px;">
					<!-- <img src="https://img.icons8.com/material/24/000000/fairytale.png"> -->
					<svg  xmlns="http://www.w3.org/2000/svg" x="0px" y="100px" width="20" height="20" viewBox="0 0 192 192" style="fill: #000000;">
						<g xmlns="http://www.w3.org/2000/svg" font-family="none"
						   font-size="none" font-weight="none" style="mix-blend-mode: normal"
						   fill="none" fill-rule="nonzero" stroke="none" stroke-dasharray=""
						   stroke-dashoffset="0" stroke-linecap="butt" stroke-linejoin="miter" 
						   stroke-miterlimit="10" stroke-width="1" text-anchor="none">
							<path fill="none" d="M 0 192 v -192 h 192 v 192 Z" />
						<g fill="#ffed08">
					<path d="M 32 24 c -8.83656 0 -16 7.16344 -16 16 c 0.00452 5.71173 3.05349 10.9879 8 13.8438 v 114.156 h 144 v -114.172 c 4.94169 -2.85307 7.98992 -8.122 8 -13.8282 c 0 -8.83656 -7.16344 -16 -16 -16 c -8.83656 0 -16 7.16344 -16 16 c -0.00119 7.68068 5.45554 14.2786 13 15.7187 l -29 28.9997 l -29.016 -29.0153 c 7.54505 -1.43228 13.0082 -8.02333 13.016 -15.7031 c 0 -8.83656 -7.16344 -16 -16 -16 c -8.83656 0 -16 7.16344 -16 16 c -0.00119 7.68068 5.45554 14.2786 13 15.7187 l -29 28.9997 l -29.0156 -29.0153 c 7.54489 -1.43245 13.0079 -8.02345 13.0156 -15.7031 c 0 -8.83656 -7.16344 -16 -16 -16 Z" /></g></g>
					</svg>
					&nbsp;${cmt.cmtContent}</td>
				</c:if>
				<c:if test="${cmt.flag eq 'F'}">
					<td style="color:black; height:10px; line-height: 25px;">&nbsp;${cmt.cmtContent}</td>
				</c:if>
				
				
				<td style="text-align: center; color:black; height:10px; line-height: 25px;">( ${cmt.cnt} 건 )
					<%-- <button type="button" id="likeBtn" class="btnLike btn-default" data-cmtnum="${cmt.cmtNo}">좋아요</button> --%> 
					<img src="https://img.icons8.com/ios-glyphs/30/000000/facebook-like.png" id="likeBtn" width="24" height="24" class="btnLike btn-default" data-cmtnum="${cmt.cmtNo}" style="cursor: pointer;  vertical-align: middle;" />
					<%-- <c:if test="${SESSION_MEMBERVO.memId == cmt.memId}">
					<button type="button" class="btnDel btn-default" data-cmtnum="${cmt.cmtNo}">삭제</button>
						 <c:choose>
								<c:when test="${SESSION_MEMBERVO.memId ne null}">
									<a href="javascript: like_func();"><img src="">좋아요</a>
								</c:when>
							  </c:choose>
					</c:if> --%>
				</td>
				<td>
				<c:if test="${SESSION_MEMBERVO.memId == cmt.memId}">
					<button type="button" id="cmtDelBtn" class="btnDel btn-default" data-cmtnum="${cmt.cmtNo}">삭제</button>
						<%--  <c:choose>
								<c:when test="${SESSION_MEMBERVO.memId ne null}">
									<a href="javascript: like_func();"><img src="">좋아요</a>
								</c:when>
							  </c:choose> --%>
					</c:if></td>
			</tr>
		</c:forEach>		


				
		======================seperator======================
		<c:choose>
			<c:when test="${paging.pageNo eq 1}">
				<li class="disabled"><a ria-label="Previous"> <span aria-hidden="true">&laquo;</span>
				</a></li>
			</c:when>
			<c:otherwise>
				<li><a href="javascript:cmtPage(${paging.prevPageNo})" aria-label="Previous"> 
					<span aria-hidden="true">&laquo;</span>
				</a></li>
			</c:otherwise>
		</c:choose>
		<c:forEach begin="${paging.startPageNo}" end="${paging.endPageNo}" var="i">
			<c:set var="active" value="" />
			<!-- 초기화 과정 값이 계속 남기때문에 -->
			<c:if test="${i eq paging.pageNo}">
				<c:set var="active" value="active" />
				<!-- 현재 페이지일 때 활성화를 위해서 -->
			</c:if>
			<li class="${active}"><a href="javascript:cmtPage(${i})">${i}</a>
			</li>
		</c:forEach>
		
		<c:choose>
			<c:when test="${paging.finalPageNo eq paging.pageNo}">
				<li class="disabled">
					<a ria-label="Next"> 
						<span aria-hidden="true">&raquo;</span>
					</a>
				</li>
			</c:when>
			<c:otherwise>
		
				<li><a href="javascript:cmtPage(${paging.nextPageNo})" aria-label="Next">
					<span aria-hidden="true">&raquo;</span>
				</a></li>
			</c:otherwise>
		</c:choose>