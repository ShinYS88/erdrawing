<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


    			<c:forEach items="${ticketRefList }" var="ticket">
    				<tr data-ticketbuyno="${ticket.get("TICKETBUYNO") }" class="ticketRefTr"  data-target="#ticketRefModal" class="modifyModal" data-toggle="modal" >	
    					<td style="text-align: center;">${ticket.get("TICKETCONTENT") }&nbsp;권</td>	
    					<td style="text-align: center;">
    					 <fmt:formatDate value="${ticket.get('TICKETBUYDT') }" pattern="yy-MM-dd"/>
    					</td>	
    					<td style="text-align: center;">${ticket.get("MEMID") }</td>	
    					<td style="text-align: center; width: 200px;">${ticket.get("BANKNM") }</td>	
    					<td style="text-align: center;width: 200px;">${ticket.get("ACCOUNT") }</td>	
    					<td style="text-align: center;">${ticket.get("ACCOUNTHOLDER") }</td>
    					<c:choose>
    						<c:when test="${ticket.get('REFUND_RESPDT') == null }">
    							<td style="text-align: center;">환불가능</td>
    						</c:when>
    						<c:otherwise>
    							<td style="text-align: center;">환불완료</td>
    						</c:otherwise>
    					
    					</c:choose>	
    						
    				</tr>
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
									href="javascript:getTicketRefPageListHtml(${paging.prevPageNo})" aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
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
							<li class="${active}"><a href="javascript:getTicketRefPageListHtml(${i})">${i}</a>
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
									href="javascript:getTicketRefPageListHtml(${paging.nextPageNo})"
									aria-label="Next"> <span aria-hidden="true">&raquo;</span>
								</a></li>
							</c:otherwise>
						</c:choose>
    		