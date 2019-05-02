<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


		<h1 class="erd-add h1">Create team</h1>
		<form action="/team/teamCreate" id="teamCreateFrm" method="post" enctype="multipart/form-data">
			<div class="input-box">
				<label>팀이름</label>
				<input type="text" id="title" name="teamNm" placeholder="팀이름">
			</div>
			<div class="input-box">
				<label>팀회원</label>
				<input type="text" id="autocomplete" placeholder="팀회원">
			</div>

			<div>
				<ul id="ul">
				</ul>
			</div>
			
			<input type="hidden" name="teamMember" id="teamMember" value="">

			<div class="input-box">
				<label>팀설명</label>
				<textarea rows="" cols="" name="teamIntro"></textarea>
			</div>
			<div class="input-box">
				<label>썸네일 이미지</label>
				<input type="image" src="${cp }/image/no_img.jpg">
				<input type="file" name="profileImg"> 
			</div>
			
		</form>
		<div class="cancle-btn99 btn-style1">취소</div>
		<div class="btn-style1" id="teamCreate">만들기</div>
		

<!-- css와 script는 moduleControl에서 작성 -->
