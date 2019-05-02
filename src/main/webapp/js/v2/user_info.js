var userInfo = (function (jq) {
	"use strict";

	var validTel = false;
	var validBirthDate = false;
	var validSubmit = false;
	var paymentStopMsg = "STOP";

	function eventBind() {
		jq("#tfPhone").on('focus', activateInput);
		jq("#tfPhone").on('blur', inactivateInput);
		jq("#tfBirthday").on('focus', activateInput);
		jq("#tfBirthday").on('blur', inactivateInput);
		/*[-
		 *	�낅젰 �꾨뱶 蹂�寃�,keyup,遺숈뿬�ｊ린,input,cut �대깽�� ��
		 *	validate format
		 * -]*/
		jq("#tfPhone").on("change keyup paste input cut", checkTelFormat);
		jq("#tfBirthday").on("change keyup paste input cut", checkBirthdayFormat);

		/*[-
		 *	�몃뱶�곕쾲��, �앸뀈�붿씪 �쒖텧
		 * -]*/
		jq("#userPost").submit(function (e) {
			var tel = jq("#tfPhone").val();
			var birthDate = jq("#tfBirthday").val();
			e.preventDefault();
			sendUserInfo(tel, birthDate);
		});

		jq(".btn_close").on('click', function () {
            teslaBaseCommon.payConfirm(paymentStopMsg,
				function(){return teslaCommonPayment.paymentStop("a2cec757ac2db402fdbbd046edc48f425031579ca2ea28f4da7af23dacbc159b", isCancelPost, blockUserEvents, "#actionPost");}
			);
		});
	}

	function activateInput(e) {
		jq(e.target).parent().toggleClass("data_focus");
	}

	function inactivateInput(e) {
		jq(e.target).parent().removeClass("data_focus");
	}

	function isValidTel(tel) {
		var regexTel = /^0\d{9,10}$/;
		if (regexTel.test(tel)) {
			validTel = true;
		} else {
			validTel = false;
		}
	}

	function isValidBirthday(birthDay) {
		var regexBirthDay = /^\d{6}$/;
		if (regexBirthDay.test(birthDay)) {
			validBirthDate = true;
		} else {
			validBirthDate = false;
		}
	}

	function updateSubmitStatus() {
		if (validTel === true && validBirthDate === true) {
			validSubmit = true;
			jq(".btn_submit").removeAttr("disabled");
		} else {
			validSubmit = false;
			jq(".btn_submit").attr("disabled", "disabled");
		}
	}

	function checkTelFormat(e) {
		var tel = jq(this).val();
		isValidTel(tel);
		updateSubmitStatus();
	}

	function checkBirthdayFormat(e) {
		var birthDay = jq(this).val();
		isValidBirthday(birthDay);
		updateSubmitStatus();
	}

	function blockUserEvents() {
		$("#userPost").attr("disabled", "disabled");
		$(".btn_close").click(
			function (e) {
				e.preventDefault();
			}
		)
	}

	function sendUserInfo(tel, birthDate) {
		var tmsInfo = {tel: tel, birthDate: birthDate};
		jq.ajax({
			type: "POST",
			url : '/v1/a2cec757ac2db402fdbbd046edc48f425031579ca2ea28f4da7af23dacbc159b/uinfo',
			data: tmsInfo
		}).done(function (data, status) {
			/*[- *	�숈씪 url GET �붿껌 * -]*/
			location.reload(true);
		}).fail(function ($xhr, status) {
			var response = $xhr.responseJSON;

			if ($xhr.status == 500) {
                teslaBaseCommon.payAlert(response.client_message,
                    function() {return teslaCommonPayment.redirectToUrlWithMethod(isFailPost, failUrl, "#actionPost");}
                );
            }

            teslaBaseCommon.payAlert(response.client_message);
		})
	}

	return {
		"eventBind": eventBind
	}

})(jQuery);
jQuery(document).ready(function () {
	userInfo.eventBind();
});