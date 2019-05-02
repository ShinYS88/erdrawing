<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" href="/css/member/memList.css">
<link
	href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css"
	rel="stylesheet">
<script
	src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
<link rel="stylesheet" href="/css/boxErd.css">

<style>
#contents {
	color: #000000;
}

.modal-dialog, .modal-content {
	height: auto;
}

table {
	border-radius: 10px;
	overflow: hidden;
	/* box-shadow: 2px 2px 2px 2px gray; */
	font-size: 13px;
}

tbody tr:nth-child(even) {
	background-color: #ffffff;
	height: 40px;
}

tbody tr:nth-child(odd) {
	background-color: #eeeeee;
	height: 40px;
}

th {
	background-color: #ccdb5c;
	color: #000000;
	font-weight: bold;
	text-align: center;
	height: 40px;
}
.modalLabel{
margin-left: 2%;}

td {
	text-align: center;
}

.table-responsive {
	/* background:#eeeeee; */
	padding: 20px;
	border-radius: 10px;
}

/* #contents{background:#eee;} */
.pagination {
	border: 0px;
}

.pagination>.active>a, .pagination>.active>span, .pagination>.active>a:hover,
	.pagination>.active>span:hover, .pagination>.active>a:focus,
	.pagination>.active>span:focus {
	z-index: 2;
	color: #000000;
	cursor: default;
	background-color: #ccdb5c;
	border-color: #ccdb5c;
}

.sizeModify {
	width: 180px;
}
</style>

<div class="youtube-title">
	<h2>회원정보 리스트</h2>
</div>
<!-- 	<br /> -->
<br />

<!-- ------------------------회원정보 모달창-------------------- -->
<form id="modalFrm" action="${cp }/member/memModalModify" method="post">
	<div class="modal modal-center fade" id="modalEvn" tabindex="1"
		role="dialog" aria-labelledby="my80sizeCenterModalLabel">
		<div class="modal-dialog modal-80size modal-center" role="document">
			<div class="modal-content modal-80size">
				<div class="modal-header">
					<label>| 회원정보 수정</label>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">

					<div class="form-group">
						<label class="modalLabel">회원 이미지</label> <img alt="" src=""
							name="memImg" id="memImg" width="100px" height="100px">
					</div>


					<div class="form-group">
						<!-- 여기부터 로직작성 -->
						<label class="modalLabel">회원 이름</label> <input type="text"
							id="memNm" name="memNm" class="sizeModify">

						<div id="dupleCode"></div>
					</div>

					<div class="form-group">
						<label class="modalLabel">회원 아이디</label> <input class="sizeModify"
							type="text" name="memId" id="memId">
					</div>

					<div class="pass form-group">
						<label class="modalLabel">회원 비밀번호</label> <input type="password"
							class="memPass sizeModify" id="memPass" oninput="checkPwd()" />
					</div>

					<div class="pass form-group">
						<label class="modalLabel">회원 비밀번호 확인</label> <input
							type="password" class="memPass sizeModify" id="reMemPass"
							name="memPass" oninput="checkPwd()" />
					</div>

					<div class="form-group">
						<label class="modalLabel">회원 이메일</label> <input class="sizeModify"
							type="text" name="memMail" id="memMail">
					</div>


					<div class="form-group">
						<label class="modalLabel">회원 소개</label><br />
						<!-- <input class="sizeModify"  type="text"
							name="memIntro" id="memIntro"><br/> -->
						<textarea style="width: 180px; height: 100px; margin-left: 29%"
							name="memIntro" id="memIntro"></textarea>
					</div>

					<div class="form-group">
						<label class="modalLabel">회원 전화번호</label> <input
							class="sizeModify" type="text" name="memTel" id="memTel">
					</div>

					<div class="form-group">
						<label class="modalLabel">회원 가입날짜</label> <input
							class="sizeModify" type="text" name="memInDts" id="memInDts">
					</div>

					<div class="form-group">
						<label class="modalLabel">블랙리스트 여부</label> <input type="checkbox"
							name="chMemBlackFlag" id="chMemBlackFlag" data-toggle="toggle"
							data-on="O" data-off="X" /> <input type="hidden"
							name="memBlackFlag" id="memBlackFlag" /> <label
							class="modalLabel" style="width: 30px"> </label> <label
							class="modalLabel" style="width: 70px">탈퇴 여부</label> <input
							type="checkbox" name="chMemCancelFlag" id="chMemCancelFlag"
							data-toggle="toggle" data-on="O" data-off="X" /> <input
							type="hidden" name="memCancelFlag" id="memCancelFlag" />

					</div>



				</div>
				<div class="modal-footer">
					<button type="button" id="insertBtn" class="btn btn-default"
						data-dismiss="modal">수정</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>

</form>

<!-- ------------------------신고사유 모달창-------------------- -->
<form id="modalReportFrm" action="${cp }/member/memReportList"
	method="post">
	<div class="modal modal-center fade" id="modalReEvn" tabindex="1"
		role="dialog" aria-labelledby="my80sizeCenterModalLabel">
		<div class="modal-dialog modal-80size modal-center" role="document">
			<div class="modal-content modal-80size">
				<div class="modal-header">
					<label>| 신고사유</label>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>

				<div class="modal-body">

					<!-- 여기부터 로직작성 -->
					<div class="form-group">
						<label class="modalLabel">신고 내역</label>
						<table>
							<thead id="modalTh">
								<tr>
									<th>신고한 회원</th>
									<th>신고 사유</th>
									<th>신고 당한 날짜</th>
								</tr>
							</thead>
							<tbody id="modalTd">

							</tbody>
						</table>

					</div>

					<div class="form-group">
						<label class="modalLabel">신고당한 횟수</label> <label id="cnt"></label>
						<input type="hidden" name="cnt">

						<div id="dupleCode"></div>
					</div>

				</div>
				<div class="modal-footer">
					<button type="button" id="insertBtn" class="btn btn-default"
						data-dismiss="modal">확인</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>

</form>

<!----------------------------- 회원정보 테이블 -------------------------->
<form id="frm" action="${cp }/member/memberDel">
	<table>
		<thead>
			<tr>
				<th>Name</th>
				<th>Id</th>
				<th>Date Created</th>
				<th>Black List</th>

				<!-- <th>Status</th> -->
				<th>Secession</th>
				<th style="text-align: right;">Action</th>
				<th></th>
			</tr>
		</thead>

		<tbody id="memListTbody">
		</tbody>
	</table>

	<nav id="divNav" style="text-align: center; width: 100%;">
		<ul class="pagination" id="pagination">
		</ul>
	</nav>

</form>




<script type="text/javascript">
	var memId = "";

	$(document)
			.ready(
					function() {
						getMemListPageListHtml(1);

						$("#memListTbody").on('click', ".d1 ul li", function() {
							$(this).find("ul").stop().fadeToggle(350);
						});

						//이미지 x표시 클릭시 사용자 삭제
						$("#memListTbody").on("click", ".delImg", function() {
							if (confirm("정말 삭제하시겠습니까??") == true) {
								memId = $(this).data("memid");

								getMemListPageListHtmlDel(1, memId);
							} else { //취소
								return false;
							}
						});

						//회원정보수정시 
						$("#insertBtn")
								.on(
										"click",
										function() {
											if (confirm("수정 하시겠습니까??") == true) {

												if ($("#memNm").val().trim() == "") {
													//$("#memId").val().trim()
													alert("이름을 입력해 주세요");
													$("#memNm").focus();
													return false;
												}

												if ($("#memId").val().trim() == "") {
													//$("#memId").val().trim()
													alert("아이디를 입력해 주세요");
													$("#memId").focus();
													return false;
												}

												if ($("#memMail").val().trim() == "") {
													//$("#memId").val().trim()

													alert("이메일을 입력해 주세요");
													$("#memMail").focus();
													return false;
												}

												var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
												if ($("#memMail").val().trim() == ""
														|| exptext.test($(
																"#memMail")
																.val()) == false) {
													//$("#memId").val().trim()
													alert(" 메일형식이 올바르지 않습니다");
													$("#memMail").focus();
													return false;
												}

												if ($("#memTel").val().trim() == "") {
													//$("#memId").val().trim()
													alert("핸드폰 번호를 입력해 주세요");
													$("#memTel").focus();
													return false;
												}

												if ($("#memPass").is(
														":disabled") == false) {
													if ($("#memPass").val()
															.trim() == "") {
														alert("비밀번호를 입력해주세요");
														return false;
													}
												}
												if ($("#reMemPass").is(
														":disabled") == false) {
													if ($("#reMemPass").val()
															.trim() == "") {
														alert("비밀번호를 입력해주세요");
														return false;
													}
												}

												if ($("#reMemPass").is(
														":disabled") == false) {
													if (!/^[a-zA-Z0-9!@#$%^&*()?_~]{6,15}$/
															.test($(
																	"#reMemPass")
																	.val())) {
														alert("비밀번호는 숫자, 영문, 특수문자 조합으로 6~15자리를 사용해야 합니다.");
														return false;
													}
												}

												if ($("#chMemBlackFlag").is(
														':checked')) {
													$("#memBlackFlag").val("T");
												} else {
													$("#memBlackFlag").val("F");
												}

												if ($("#chMemCancelFlag").is(
														':checked')) {
													$("#memCancelFlag")
															.val("T");
												} else {
													$("#memCancelFlag")
															.val("F");
												}

												$("#modalFrm").submit();
											} else { //취소
												return false;
											}
										});

						//회원정보클릭시
						$("#memListTbody").on('click', "#liMemModify",
								function() {
									memId = $(this).data("memid");
									getMemberModifyModal(memId);
								});

						//신고사유 클릭시
						$("#memListTbody").on('click', "#liReport", function() {
							memId = $(this).data("memid");
							getMemberReportList($(this).data("memid"));
						});

					});

	//삭제후 Ajax처리
	function getMemListPageListHtmlDel(page, memId) {
		$
				.ajax({
					url : "${cp}/member/memberDel",
					data : {
						memId : memId,
						page : page
					},
					success : function(data) {
						var htmlArr = data
								.split("======================seperator==========================");
						$("#memListTbody").html(htmlArr[0]);
						$("#pagination").html(htmlArr[1]);
					}
				});
	}

	//전체 테이블 Ajax처리
	function getMemListPageListHtml(page) {
		$
				.ajax({
					url : "${cp}/member/memberAjaxList",
					data : {
						page : page
					},
					success : function(data) {
						var htmlArr = data
								.split("======================seperator==========================");
						$("#memListTbody").html(htmlArr[0]);
						$("#pagination").html(htmlArr[1]);
					}
				});
	}

	function getMemberModifyModal(memId) {
		$.ajax({
			url : "${cp}/member/memModifyModal",
			data : {
				memId : memId
			},
			success : function(data) {
				console.log(data.memVo);
				//모달창에  해당 회원의 값 넣어주기
				modalResult(data);
			}
		});
	}

	function modalResult(data) {

		var src = data.memVo.memImg;
		var black = data.memVo.memBlackFlag;
		var cancel = data.memVo.memCancelFlag;

		//구글 카카오는 비밀번호 변경불가 /이미지 값
		if (data.memVo.memEmailDiv != "basic") {
			$("#memPass").attr("disabled", true);
			$("#reMemPass").attr("disabled", true);

			//이미지
			if (data.memVo.memImg == null) {
				$("#memImg").attr("src",
						"${cp }/member/memberImg?memId=" + data.memVo.memId);
			} else {
				$("#memImg").attr("src", data.memVo.memImg);
			}
		} else {
			$("#memPass").attr("disabled", false);
			$("#reMemPass").attr("disabled", false);

			//이미지
			$("#memImg").attr("src",
					"${cp }/member/memberImg?memId=" + data.memVo.memId);
		}

		if (black == 'T') {
			$("input[name=chMemBlackFlag]").prop("checked", true).change();
		} else {
			$("input[name=chMemBlackFlag]").prop("checked", false).change();
		}

		if (cancel == 'T') {
			$("input[name=chMemCancelFlag]").prop("checked", true).change();
		} else {
			$("input[name=chMemCancelFlag]").prop("checked", false).change();
		}

		$("#memId").val(data.memVo.memId);
		$("#memNm").val(data.memVo.memNm);
		$("#memIntro").val(data.memVo.memIntro);
		$("#memImg").val(data.memVo.memImg);
		$("#memInDts").val(data.inDate);

		$("#memTel").val(data.memVo.memTel);
		$("#memMail").val(data.memVo.memMail);
		$("#memPeriods").val(data.memVo.memPeriod);

	}

	var pwdCheck = 0;
	function checkPwd() {
		var inputed = $(".memPass").val();
		var reinputed = $("#reMemPass").val();
		console.log(inputed);

		if (reinputed == "" && (inputed != reinputed || inputed == reinputed)) {
			$("#reMemPass").css("background-color", "#FFCECE");
		} else if (inputed == reinputed) {
			$("#reMemPass").css("background-color", "#B0F6AC");
			pwdCheck = 1;
		} else if (inputed != reinputed) {
			pwdCheck = 0;
			$("#reMemPass").css("background-color", "#FFCECE");

		}

	}

	function getMemberReportList(memId) {

		$("#modalTd").html("");
		$("#cnt").html("");

		$.ajax({
			url : "${cp}/member/memRepotList",
			data : {
				memId : memId
			},
			success : function(data) {
				console.log(data.reportList);
				console.log(data.inDate);
				if (data.reportList.length > 0) {
					$("#modalTh").show();
					var str = "";
					for (var i = 0; i < data.reportList.length; i++) {
						str += "<tr><td>" + data.reportList[i].fromMemId
								+ "</td>" + "<td>"
								+ data.reportList[i].reportReason + "</td>	"
								+ "<td>" + data.inDate[i] + "</td></tr>"
					}

					$("#modalTd").append(str);
					$("#cnt").html(data.reportList[0].cnt);

				}

				else {
					$("#modalTh").hide();
					$("#cnt").html("0");
				}
			}

		});
	}
</script>


