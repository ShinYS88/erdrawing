<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

			<c:forEach items="${memList }" var="mem">
				<tr>
					<td style="width: 120px;">
					
						<c:choose>
							<c:when test="${mem.memEmailDiv =='basic'}}">
								<a href="#"><img src="${cp }/member/memberImg?memId=${mem.memId }" class="avatar"
									alt="Avatar" width="35" height="30">$s{mem.memNm } </a>
							</c:when>
							<c:otherwise>
							
								<c:choose>
									<c:when test="${ fn:indexOf(mem.memImg,'http') > -1}">
										<a href="#"><img src="${mem.memImg}" class="avatar"
									alt="Avatar" width="35" height="30">${mem.memNm } </a>
									</c:when>
									<c:otherwise>
									
									<a href="#"><img src="${cp }/member/memberImg?memId=${mem.memId }" class="avatar"
									alt="Avatar" width="35" height="30">${mem.memNm } </a>

									</c:otherwise>
								</c:choose>
								
							</c:otherwise>
						</c:choose>
						
					</td>
					<td style="width: 300px">${mem.memId }</td>
					<td><fmt:formatDate value="${mem.memInDt }" pattern="yyyy/MM/dd" /></td>
					
					<td>
						<c:choose>
							<c:when test="${mem.memBlackFlag =='T'}">
								<span class="status text-danger">●</span> ${mem.memBlackFlag }
							</c:when>
							<c:otherwise>
								<span class="status text-success ">●</span> ${mem.memBlackFlag }
							</c:otherwise>
						</c:choose>
					</td>
					
					<td>
						<c:choose>
							<c:when test="${mem.memCancelFlag =='T'}">
								<span class="status text-danger">●</span> ${mem.memCancelFlag }
							</c:when>
							<c:otherwise>
								<span class="status text-success ">●</span> ${mem.memCancelFlag }
							</c:otherwise>
						</c:choose>
					</td>
					
					<td id="setTd"><div class="d1">
							<ul>
								<li><svg  class="btn-style3"
										xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" width="25"
										height="25" viewBox="0 0 192 192" style="fill: #000000;">
							
								<g fill="none" fill-rule="nonzero" stroke="none"
											stroke-width="1" stroke-linecap="butt"
											stroke-linejoin="miter" stroke-miterlimit="10"
											stroke-dasharray="" stroke-dashoffset="0" font-family="none"
											font-weight="none" font-size="none" text-anchor="none"
											style="mix-blend-mode: normal">
								<path d="M0,192v-192h192v192z" fill="none">
								</path>
								<g id="original-icon" fill="#565656">
								<path
											d="M83.92187,16c-3.832,0 -7.10775,2.70875 -7.84375,6.46875l-2.67188,13.71875c-6.56607,2.48291 -12.63742,5.95173 -17.96875,10.32812l-13.15625,-4.53125c-3.624,-1.248 -7.61125,0.2505 -9.53125,3.5625l-12.0625,20.90625c-1.912,3.32 -1.21612,7.53488 1.67188,10.04688l10.54687,9.17187c-0.5485,3.37082 -0.90625,6.8024 -0.90625,10.32813c0,3.52573 0.35774,6.9573 0.90625,10.32813l-10.54687,9.17187c-2.888,2.512 -3.58388,6.72687 -1.67188,10.04687l12.0625,20.90626c1.912,3.32 5.90725,4.81812 9.53125,3.57812l13.15625,-4.53125c5.32957,4.37365 11.40565,7.83071 17.96875,10.3125l2.67188,13.71875c0.736,3.76 4.01175,6.46875 7.84375,6.46875h24.15626c3.832,0 7.10774,-2.70875 7.84374,-6.46875l2.67188,-13.71875c6.56607,-2.4829 12.63742,-5.95173 17.96874,-10.32812l13.15626,4.53125c3.624,1.248 7.61125,-0.2425 9.53125,-3.5625l12.0625,-20.92188c1.91201,-3.32 1.21613,-7.51925 -1.67187,-10.03125l-10.54687,-9.17187c0.5485,-3.37082 0.90625,-6.8024 0.90625,-10.32813c0,-3.52573 -0.35774,-6.9573 -0.90625,-10.32813l10.54687,-9.17187c2.888,-2.512 3.58388,-6.72688 1.67187,-10.04688l-12.0625,-20.90625c-1.912,-3.32 -5.90725,-4.81813 -9.53125,-3.57812l-13.15626,4.53125c-5.32957,-4.37365 -11.40564,-7.83071 -17.96874,-10.3125l-2.67188,-13.71875c-0.736,-3.76 -4.01174,-6.46875 -7.84374,-6.46875zM96,64c17.672,0 32,14.328 32,32c0,17.672 -14.328,32 -32,32c-17.672,0 -32,-14.328 -32,-32c0,-17.672 14.328,-32 32,-32z"></path></g></g></svg>
									<ul>
										<li id="liMemModify" style="color: #ffffff" data-memid="${mem.memId }" data-toggle="modal" data-target="#modalEvn"><a href="#" >회원정보수정</a></li>
										<li  id="liReport" style="color: #ffffff" data-memid="${mem.memId }" data-toggle="modal" data-target="#modalReEvn"><a href="#">신고사유 조회</a></li>
									</ul></li>
							</ul>
						</div>
					</td>
					<td><img  class="delImg btn-style3" data-memid="${mem.memId }"	src="https://img.icons8.com/color/48/000000/cancel.png"	width="25" height="25" align="left"></td>
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
									href="javascript:getMemListPageListHtml(${paging.prevPageNo})" aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
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
								href="javascript:getMemListPageListHtml(${i})">${i}</a>
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
									href="javascript:getMemListPageListHtml(${paging.nextPageNo})"
									aria-label="Next"> <span aria-hidden="true">&raquo;</span>
								</a></li>
							</c:otherwise>
						</c:choose>