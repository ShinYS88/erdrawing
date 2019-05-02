<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

		<c:forEach items="${postList}" var="post">
			<tr class='postTr' data-postno="${post.postNo}" data-postgn="${post.postGn}" data-flag="${post.postDelFlag}" >
				<%-- <td style="text-align: center;  color:black; height:10px;">${post.postNo}</td> --%>
				<td style="text-align: center;  color:black; height:10px;"></td>
				<c:choose>
					<c:when test="${post.level gt 1}"> <!--레벨에 따른 공백주기  -->
					<a href="javascript:void(0);" onclick="fnTrClick('${post.postNo}', '${post.postGn}', '${post.postDelFlag}');"> ${post.postTitle}</a>
					
					<td style="color:black; height:10px;">
						<c:forEach begin="1" end="${post.level-1}">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</c:forEach>
					 	<span style="color: red">└[RE]: </span>
						<c:choose>
							<c:when test="${post.postDelFlag eq 'T'}">
							<a href="javascript:void(0);" onclick="fnTrClick('${post.postNo}', '${post.postGn}', '${post.postDelFlag}');"> ${post.postTitle}</a>
							</c:when>
							<c:otherwise>
								<span style="color: red;">삭제된 답글입니다.</span>
							</c:otherwise>								
						</c:choose>
					 </td>
					</c:when>
					
					<c:otherwise>
					<td style="padding-left: 15px; color: black;  height:10px;">
					<c:choose>
							<c:when test="${post.postDelFlag eq 'T'}">
							<a href="javascript:void(0);" onclick="fnTrClick('${post.postNo}', '${post.postGn}', '${post.postDelFlag}');"> ${post.postTitle}</a>
							</c:when>
							<c:otherwise>
							<span style="color: red;">삭제된 게시글입니다.</span>
							</c:otherwise>								
						</c:choose>
					</td>
					</c:otherwise>
				</c:choose>		
					
					<c:choose>
						<c:when test="${fn:contains(post.writerId, '@')}">
						<c:set var="keywordArr" value="${fn:split(post.writerId, '@')}"></c:set>
						<td style="text-align: center;  color:black;">${keywordArr[0] }</td>
						</c:when>
						<c:otherwise>
						<td style="text-align: center;  color:black;">${post.writerId}</td></c:otherwise>
					</c:choose>
					
					
					<td style="text-align: center; color:black;"><fmt:formatDate value="${post.postRegDt}" pattern="yyyy-MM-dd" /></td>
					<td style="text-align: center; color:black;">${post.viewCnt}</td>
				</tr>
			</c:forEach>
			
	    ======================seperator======================
		<c:choose>
			<c:when test="${paging.pageNo eq 1}">
				<li class="disabled"><a ria-label="Previous"> <span aria-hidden="true">&laquo;</span>
				</a></li>
			</c:when>
			<c:otherwise>
				<li><a href="javascript:postListPage(${paging.prevPageNo})" aria-label="Previous"> 
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
			<li class="${active}"><a href="javascript:postListPage(${i})">${i}</a>
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
		
				<li><a href="javascript:postListPage(${paging.nextPageNo})" aria-label="Next">
					<span aria-hidden="true">&raquo;</span>
				</a></li>
			</c:otherwise>
		</c:choose>