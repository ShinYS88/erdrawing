<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="/css/boxErd.css">

<style>
.tag-a {
	margin: 3px;
	padding: 3px;
	background-color: #444444;
	font-size: 11px;
	margin-bottom:-20px;
}

.notice {
	width: 100%;
	height: 55px;
	overflow: hidden;
	background-color: #232323;
	text-align: center;
	margin-top:20px;
  
}

.rolling {
	position: relative;
	width: 100%;
	height: auto;
}

.rolling li {
	width: 100%;
	height: 50px;
	line-height: 50px;
}
</style>

<div id="contents">

	<div class="mov">
		<div class="container">

			<div class="notice">
				<ul class="rolling">
					<li>
						<h2>ERDrawing은 DB 모델링 도구 입니다.</h2>
					</li>
					<li>
						<h2>팀원들과 함께 ERD를 그려보세요.</h2>
					</li>
					<li>
						<h2>그리는 화면은 실시간으로 공유됩니다.</h2>
					</li>
				</ul>
			</div>
			<div class="youtube-bg">
				<div class="youtube">
					<span><iframe width="100%" height="400"
							src="https://www.youtube.com/embed/aBoIKR6gtnU" frameborder="0"
							allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"
							allowfullscreen></iframe></span>
				</div>
			</div>
			<div class="youtube-btn btn-style1 myAdd">ERDrawing 사용해보기</div>
		</div>
	</div>
	<c:if test=""></c:if>

	<div class="container">

		<div class="best-erd-title">
			<h1>MOST POPULAR ERD</h1>
			<p class="lead">ERD List</p>
		</div>
		<div style="color: black; margin-bottom: 10px;">
			<select name="order-sel" id="order-sel">
				<option value="erdLike">좋아요 순</option>
				<option value="erdRead">조회수 순</option>
			</select>
		</div>


		<div class="best-erd-list">
			<div class="inner-container">
				<div class="col-sm-12">
					<ul class="erd-box-list">
						<c:forEach var="erdList" varStatus="status" items="${erdList }">
							<li class="erd-box-item erdClick">
								<div style="position: absolute; z-index: 30;">
									<div class="stats-box">
										<i class="fas fa-eye"></i> <label>${erdList.erdReadCnt }</label>
									</div>
									<div class="stats-box">
										<i class="fas fa-thumbs-up"></i> <label>${erdList.likeCnt }</label>
									</div>
								</div> <a class="preview-box" onclick="erdClick(${erdList.erdNo})">
									<div class="bg-box">
										<img src="${cp }/erd/erdImg?erdNo=${erdList.erdNo}">
										<div class="table-bg-text">
											<div class="bg-text shinys">&nbsp;${erdList.erdTitle }
											</div>
										</div>
									</div>
							</a>
								<div class="description-item">
									<div style="float: left;">${erdList.erdTitle }</div>
									<!-- erd public / private에 따라 자물쇠 이미지 변경 -->
									<div style="float: right;">${erdList.erdScope }</div>



									<ul class="tagList" style="clear: both;">
										<c:forEach var="entry" items="${erdTagListMap }">
											<c:if test="${entry.key eq erdList.erdNo}">
												<c:set var="value" value="${entry.value }" />
												<c:forEach var="tagVo" items="${value}">
													<a class="tag-a"
														href="${cp}/library?tagContent=${tagVo.tagContent }"
														title="" class="tagSearch">${tagVo.tagContent }</a>
												</c:forEach>

											</c:if>
										</c:forEach>
									</ul>
								</div>

							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
	</div>

</div>

<script>
$(document).ready(function(){
	var height =  $(".notice").height();
	var num = $(".rolling li").length;
	var max = height * num;
	var move = 0;
	function noticeRolling(){
		move += height;
		$(".rolling").animate({"top":-move},800,function(){
			if( move >= max ){
				$(this).css("top",0);
				move = 0;
			};
		});
	};
	noticeRollingOff = setInterval(noticeRolling,2000);
	$(".rolling").append($(".rolling li").first().clone());

});
	var orderKind = $("#order-sel option:selected").val();
	$("#order-sel").on("change", function(){
		orderKind = $("#order-sel option:selected").val();
		orderChange(orderKind);
	});
	
	
	function orderChange(orderKind){
		$.ajax({
			type : "post",
			url : "${cp}/",
			data : {orderKind : orderKind},
			success : function(data){
				var erdList = data.erdList;
				var erdTagMap = data.erdTagListMap;
				var erdTagMapKey = Object.keys(erdTagMap);	// 맵의 키를 따로 저장
				var erdTagMapNew = new Map(); //erdTagMapKey를 맵타입으로 바꾸기 위해서. 
				//스크립트에서 맵 안에 있는 맵을 배열로 인식.
		
				// 맵 형식으로 다시 만들어 줌
				for(var z = 0; z < erdTagMapKey.length; z++){
					erdTagMapNew.set(erdTagMapKey[z], erdTagMap[erdTagMapKey[z]]);
				}
				
				var html ="";
				for(var i = 0; i < erdList.length; i++){
					html += '<li class="erd-box-item">';
					html += '	<div style="position:absolute; z-index:30;">';
					html += '		<div class="stats-box">';
					html += '			<i class="fas fa-eye"></i>';
					html += '			<label>' + erdList[i].erdReadCnt + '</label>';
					html += '		</div>';
					html += '		<div class="stats-box">';
					html += '			<i class="fas fa-thumbs-up"></i>';
					html += '			<label>' + erdList[i].likeCnt + '</label>';
					html += '		</div>';
					html += '	</div>';
					html += '	<a class="preview-box" onclick="erdClick(' + erdList[i].erdNo + ')">';
					html += '		<div class="bg-box">';
					html += '			<img src="${cp }/erd/erdImg?erdNo=' + erdList[i].erdNo + '">';
					html += '			<div class="table-bg-text">';
					html += '				<div class="bg-text shinys">&nbsp;' + erdList[i].erdTitle + '</div>';
					html += '			</div>';
					html += '		</div>';
					html += '	</a>';
					html += '	<div class="description-item">';
					html += '		<div style="float: left;">' + erdList[i].erdTitle + '</div>';
					html += '		<div style="float: right;">' + erdList[i].erdScope + '</div>';
					html += '		<ul class="tagList" style="clear: both;">';
					
					  for(var [key, value] of erdTagMapNew){
						 if(key == erdList[i].erdNo){
							 for(var j = 0; j < value.length; j++){
								 html += '<a class="tag-a" href="${cp}/library?tagContent=' + value[j].tagContent + '" title="" class="tagSearch">' + value[j].tagContent + '</a>';
							 }
						 }
					 }  
					html += '		</ul>';
					html += '	</div>';
					html += '</li>';
				}
				$(".erd-box-list").html(html);
			},
		});
	}
	
	function erdClick(erdNo){
		$(location).attr('href', "${cp}/erdDrawing?erdNo="+erdNo);
	}
	
</script>