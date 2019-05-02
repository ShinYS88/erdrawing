<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="/css/boxErd.css">


<style>
.erd-search {
	display: block;
	padding: 20px 0 20px;
}

.erd-search-txt {
	display: inline-block;
	margin-right: 10px;
	height: 30px;
}

.erd-search-btn {
	display: inline-block;
	padding: 5px 10px;
	background: #fff;
	color: #000;
}
</style>

<div class="erd-search">
	<input name="erd-search-txt" class="erd-search-txt" type="text" />
	<div class="erd-search-btn">검색</div>
</div>



<div class="best-erd-list">
	<div class="inner-container">
		<div class="col-sm-12">
			<ul class="erd-box-list">

				<c:forEach var="erdList" varStatus="status" items="${erdList }">
					<c:if test="${erdList.erdScope eq 'public' }">
						<li class="erd-box-item"><a class="preview-box">
								<div class="bg-box">
									<div class="bg-img">&nbsp;Image</div>
									<div class="table-bg-text">
										<div class="bg-text shinys">&nbsp;${erdList.erdTitle }</div>
									</div>
								</div>
						</a>
							<div class="description-item">
								<div style="float: left;">${erdList.erdTitle }</div>
								<!-- erd public / private에 따라 자물쇠 이미지 변경 -->
								<div style="float: right;">${erdList.erdScope }</div>



								<ul class="tagList" style="clear: both;">
									<c:forEach var="entry" items="${erdTagListMap }">
										<c:if test="${entry.key eq myErdList.erdNo}">
											<c:set var="value" value="${entry.value }" />
											<c:forEach var="tagVo" items="${value}">
												<li>${tagVo.tagContent }</li>
											</c:forEach>
										</c:if>
									</c:forEach>
								</ul>
							</div></li>
					</c:if>
				</c:forEach>
			</ul>
		</div>
	</div>
</div>