<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   

		<h1 class="erd-add h1">Create ERD</h1>
		<form action="/erd/erdAdd" id="erdAddFrm" method="post">
			<div class="input-box">
				<label>제목</label>
				<input type="text" id="title" name="erdTitle" placeholder="제목">
			</div>
			<div class="input-box">
				<label>태그</label>
				<input type="text" placeholder="태그" name="tag">
			</div>
			<div class="input-box">
				<label>공유</label>
				<div>
					<div>
						<input type="radio" name="erdScope" value="public" checked="checked">
						<label>공개</label>
					</div>
					<div>
						<input type="radio" name="erdScope" value="private">
						<label>비공개</label>
					</div>
					<div>
						<input type="radio" name="erdScope" value="team">
						<label>팀</label>
						
					</div>
				</div>
			</div>
			
			<!-- 팀 라디오 버튼 선택 시 나타나야 함 -->
			<div class="input-box">
				<label>팀</label>
				<select name="teamNo">
					<c:forEach var="teamInfoList" items="${teamInfoList}">
						<option value="${teamInfoList.teamNo }">${teamInfoList.teamNm }</option>
					</c:forEach>
				</select>
			</div>
		</form>
		<div class="cancle-btn99 btn-style1">취소</div>
		<div class="submit-btn99 btn-style1" id="erdAdd">만들기</div>

<!-- css와 script는 moduleControl에서 작성 -->
