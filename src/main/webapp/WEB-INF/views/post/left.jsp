<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<div class="navbar-header" style="padding-right: 50px;">
	<ul class="left-menu" style="margin-top: 100px; color: #D1D1D2;">
		<li class="navbar-brand" style="font-size: 18px; font-weight: bold;"><a href="${cp}/post/postList?boardNo=1" onmouseover="fnOver(this);" onmouseout="fnOut(this);">공지사항</a></li>
	</ul>
	
	<ul class="left-menu" style="color: #D1D1D2;">
		<li  class="navbar-brand" style="font-size: 18px; font-weight: bold;"><a href="${cp}/post/postList?boardNo=2" onmouseover="fnOver(this);" onmouseout="fnOut(this);">자유게시판</a></li>
	</ul>
	
	<ul class="left-menu" style="color: #D1D1D2;">
		<li  class="navbar-brand" style="font-size: 18px; font-weight: bold;"><a href="${cp}/post/postList?boardNo=3" onmouseover="fnOver(this);" onmouseout="fnOut(this);">질문게시판</a></li>
	</ul>
</div>

<script type="text/javascript">
	function fnOver(obj) {
		obj.style.color = "#fff";
	}
	
	function fnOut(obj) {
		obj.style.color = "#D1D1D2";
	}
</script>
	
