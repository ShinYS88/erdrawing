//웹소캣 테스트
var webSocket;
var tmp_search_text;

$(document).ready(function(){
	connectWS();
	
	//도메인 초기화 - ShinYS
	tmp_search_text = "";
	fn_init_search(tmp_search_text);
	
	//erdLoad
	$.ajax({
		type : "post",
		url : "/erddrawing/erdMaxHistSelect",
		async: false,
		data : {
			erdNo : erdNo
		},
		success : function(data) {
			if(data.erdHistVo != null){
				jsonLoad(data.erdHistVo.erdJson);
			}

		},
		error : function(xhr, status, error) {
			console.log(error);
		}
	});
	
	//스냅샷 로드
	snapshotList();
	//historyLoad
	histLoad();
	

});


function connectWS(){
	var ws = new WebSocket("ws://localhost/erdEcho?erdNo="+erdNo);
	webSocket = ws;
	
	ws.onopen = function(){
		console.log('Info: connection opened.');

		ws.onmessage = function (event){
//			var msg = JSON.parse(event.data);
			var msg = event.data.split("★");
			
//			console.log("cmd:",msg.cmd,"editor:",msg.editor,"content:",msg.content);
			//console.log("cmd:",msg[0],"editor:",msg[1],"content:",msg[2]);
			
			var cmd = msg[0];
			var senderId = msg[1];
			var receContent = msg[2];
			var sendSId = msg[3];
			var receSId = msg[4];
			
			if(msg[0].indexOf("domain") > -1){
				
				console.log(senderId," / check : ", receContent);
				fn_init_search(tmp_search_text);
				
				$.ajax({
					type : "post",
					url : "/erddrawing/erdMaxHistSelect",
					async: false,
					data : {
						erdNo : erdNo
					},
					success : function(data) {
						if(sendSId != receSId && data.erdHistVo != null){
							jsonLoad(data.erdHistVo.erdJson);
							console.log("Erd드로잉 읽어오기 완료");
						}
			
						histLoadOne(data.erdHistVo);

					},
					error : function(xhr, status, error) {
						console.log(error);
					}
				});
				
				
			//=======================채팅===============================
			}else if(msg[0].indexOf("chat") > -1){

				
				if(sendSId != receSId){
		
					var htmls = `<ul>
									<li><img src="/member/memberImg?memId=`+senderId+`"></li>
									<li>
										<div class="msg_id">`+senderId+`</div>
										<div style="position:relative; padding:10px;">
											<div class="msg_chat">`+receContent+`</div>
											<span>`+getTime()+`</span>
										</div>
									</li>
								</ul>`;
				
				}else{
					
					var htmls = `<ul style="float:right;">
									<li>
										<div class="msg_id" style="text-align:right; padding-right:10px;">`+senderId+`</div>
										<div style="position:relative; padding:10px;">
											<span style="margin-right:5px;">`+getTime()+`</span>
											<div class="msg_chat" style="background:#F7E04B; color:#000; font-weight:800;">`+receContent+`</div>
											
										</div>
									</li>
									<li><img src="/member/memberImg?memId=`+senderId+`"></li>
								</ul>`;
					
				}
				
				
				htmls += "<div style='clear:both;'></div>";
				$("#inputTxt").append(htmls);
//				$("#inputTxt").append(senderId + " : " + receContent + "<br>");
				
				$(".con_inner").scrollTop($('.con_inner2').height()+300);
				
			}
			
		}
			
		ws.onclose = function(event){console.log('Info: connection closed.');}
		ws.onerror = function(err){console.log('Error:', err);}

	}
}


function getTime(){
	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth()+1; //January is 0!
	var yyyy = today.getFullYear();
	var HH = today.getHours();
	var MM = today.getMinutes();
	var SS = today.getSeconds();

	if(dd<10) {
	    dd='0'+dd
	} 

	if(mm<10) {
	    mm='0'+mm
	} 

	return mm+'/'+dd+'<br>'+HH+':'+mm;
	
}

function getTimeS(){
	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth()+1; //January is 0!
	var yyyy = today.getFullYear();
	var HH = today.getHours();
	var MM = today.getMinutes();
	var SS = today.getSeconds();

	if(dd<10) {
	    dd='0'+dd
	} 

	if(mm<10) {
	    mm='0'+mm
	} 

	return mm+'-'+dd+'_'+HH+mm+SS;
	
}

function webSend(cmd, data1){
	//evt.preventDefault();
	if(webSocket.readyState !== 1 )
		return;
	webSocket.send(cmd+"★"+data1);
}


function jsonSave(select,msg){
	
	var url = "/erddrawing/erdHistInsert";
	var visible, snapNm, snapImg,erdTitle;
	
	if(select === null){
		return;
	}
	
	if(select === "hist"){
		visible = "T";
		erdTitle = msg;
	}else if(select === "snap"){
		visible = "F";
		snapNm = "스냅샷 이름";
		snapImg = "스냅샷 스크린샷";
	}
	
	stageClick(0);
	
	var checksave = "NotSave"; 
	json = stage.toJSON();
	json2 = mini_stage.toJSON();

	
	stageClick(zNode);
	
    json = json +'@@' +json2+'@@'+ numId;
    
    $.ajax({
		type : "post",
		url : url,
		async: false,
		data : {
			erdNo : erdNo,
			erdIsVisible : visible,
			snapNm:snapNm,
			snapImg:snapImg,
			erdJson: json,
			erdTitle:erdTitle
		},
		success : function(data) {
			checksave = "SuccessSave";
		},
		error : function(xhr, status, error) {
			console.log(error);
		}
	});

    return checksave;
}


function jsonLoad(loadData){


	//스테이지 삭제
	stage.children.each(function(item){
		 	if(item.children.length > 0){
		 		item.destroyChildren();
		 	}
	 });
	

	mini_stage.children[0].children.each(function(item2){
			if(item2.id() != "mini_red"){
				item2.destroy();
			}
		});
		
		
//	 	if(item.children.length > 0){
//	 		item.destroyChildren();
//	 	}
	//});
	
	
	
	//Json가져오기
	var arr_json=loadData.split('@@');
    stage2 = Konva.Node.create(arr_json[0], 'tmp_canvas');
    mini_stage2 = Konva.Node.create(arr_json[1], 'tmp_canvas2');
    numId =   arr_json[2];

    	 stage2.children.each(function(item1,i){
             
             while(item1.children.length > 0){   
               item1.children[0].moveTo(stage.children[i]);
               console.log("객체 추가");
             }
           
       });
    	 
    	 var tmp_mini_stage = mini_stage2.children[0];
	 while(tmp_mini_stage.children.length > 1){   
		 
		 if(tmp_mini_stage.children[0].id() != "mini_red"){
			 tmp_mini_stage.children[0].moveTo(mini_stage.children[0]);
             console.log("미니맵 객체 추가");
		 }else{
			 tmp_mini_stage.children[1].moveTo(mini_stage.children[0]);
             console.log("미니맵 객체 추가");
		 }
	 }

    	 
    	 
    	 // 드로잉준비
    	   btn_entity_group = stage.findOne('.btn_entity_group');
    	   entity_container = stage.findOne('.entity_container');
    	   old_entity = null;
       
       
       if(layer.find('.entity').length === 0){
    	   		stage.draw();
    	   		mini_layer.draw();
    	        relationLine_layer.draw();
           return;
        }
        
        
        layer.find('.entity').each(function(z){
            entity = z;
            stageClick();
        });
        
       stageClick(0);
       stage.on('click', stageClick);
       
       
     //dragEvent1
       stage.off('.dragSetup');
       stage.on('dragmove.dragSetup', function dragEvent1(evt){
           
           allNode = evt.target;
           
               if(allNode.hasName('entity')){
               console.log("entity : "+allNode.x());
               var mini_entity = mini_stage.find('.'+evt.target.id());
               
               mini_entity.x(evt.target.x()*0.048);
               mini_entity.y(evt.target.y()*0.048);
               mini_layer.draw();
               }
       }); // move end
       
       stage.draw();
       mini_layer.draw();
       relationLine_layer.draw();

}

	


//날짜 포멧
function getDateFormat(now) {
	  year = "" + now.getFullYear();
	  month = "" + (now.getMonth() + 1); if (month.length == 1) { month = "0" + month; }
	  day = "" + now.getDate(); if (day.length == 1) { day = "0" + day; }
	  hour = "" + now.getHours(); if (hour.length == 1) { hour = "0" + hour; }
	  minute = "" + now.getMinutes(); if (minute.length == 1) { minute = "0" + minute; }
	  second = "" + now.getSeconds(); if (second.length == 1) { second = "0" + second; }
	  return year + "-" + month + "-" + day + " " + hour + ":" + minute + ":" + second;
}

// 날짜 포맷 (분/초)
function getDateFormatMS(now) {
	  year = "" + now.getFullYear();
	  month = "" + (now.getMonth() + 1); if (month.length == 1) { month = "0" + month; }
	  day = "" + now.getDate(); if (day.length == 1) { day = "0" + day; }
	  hour = "" + now.getHours(); if (hour.length == 1) { hour = "0" + hour; }
	  minute = "" + now.getMinutes(); if (minute.length == 1) { minute = "0" + minute; }
	  second = "" + now.getSeconds(); if (second.length == 1) { second = "0" + second; }
	  return month + "/" + day + "<br>" + hour + ":" + minute;
}
//=======================[ 히스토리 관련 ]=============================

//Erd추가 그려주기
function histLoadOne(vo){
	
		var nowDate = new Date(parseInt(vo.erdDt));
		var times = getDateFormat(nowDate);
		var title = vo.erdTitle;
		var erdJson = this.erdJson;
		var temp_str = `<tr>
						<td>` + title +`</td>
						<td>`+ times +`</td>
						<td><div class="btn_hist_change" title>변경</div></td>
						<td name="erdJson" style="visibility:hidden;position:absolute;">`+ erdJson +`<td>
					</tr>`;
		
		if($('#history_container .con_inner tbody tr').length >= 20){
			$('#history_container .con_inner tbody tr:last').remove();
		}
		
	$('#history_container .con_inner tbody').prepend(temp_str);
	
	$('.btn_hist_change').off('click');
	
	$('.btn_hist_change').on('click',function(e){
		var jsonData = e.target.parentNode.nextElementSibling.childNodes[0].textContent+"@@"+numId;
		jsonLoad(jsonData);
	});
	
}







//선택 ErdNo 전체 히스토리 가져오기 (초기화용)
function histLoad(){
	$.ajax({
		type : "post",
		url : "/erddrawing/erdHistList",
		async: false,
		data : {
			erdNo : erdNo
		},
		success : function(data) {
			var list = data.erdHistList;
			
			var temp_str ="";

			$.each(list, function(){
				var nowDate = new Date(parseInt(this.erdDt));
				var times = getDateFormat(nowDate);
				var title = this.erdTitle;
				var erdJson = this.erdJson;

				console.log(erdJson);
				
				temp_str += `<tr>
								<td>`+ title +`</td>
								<td>`+ times +`</td>
								<td><div class="btn_hist_change" title>변경</div></td>
								<td name="erdJson" style="visibility:hidden;position:absolute;">`+ erdJson +`<td>
							</tr>`;
				
			});
			
			$('#history_container .con_inner tbody').html(temp_str);
			$('#loading').css('display','none');
			$('.btn_hist_change').on('click',function(e){
				var jsonData = e.target.parentNode.nextElementSibling.childNodes[0].textContent+"@@"+numId;
				jsonLoad(jsonData);
			});
			
			
		},
		error : function(xhr, status, error) {
			console.log(error);
		}
	});

	
}


//=======================[ 스냅샷 관련 ]=============================

$('.btn_snapshot_add').on('click',function(){
		jsonSave("snap");
		snapshotOne();
});





//스냅샷 하나 추가
function snapshotOne(vo){
//	var nowDate = new Date(parseInt(vo.erdDt));
//	var times = getDateFormat(nowDate);
	var times = "시간";
	var id = "아이디";
	var title = "스냅샷 내용";
	var temp_str = `<tr class="snap_img">
						<td colspan="3">이미지</td>
					</tr>
					<tr class="snap_group">
						<td>`+ id + " - " + title +`</td>
						<td>`+ times +`</td>
						<td><div class="btn_hist_change">변경</td>
					</tr>`;
	
	console.log($('#snapshot_container .con_inner tbody .snap_group').length);
	if($('#snapshot_container .con_inner tbody .snap_group').length >= 10){
		console.log("삭제해라");
		$('#snapshot_container .con_inner tbody .snap_img:last').remove();
		$('#snapshot_container .con_inner tbody .snap_group:last').remove();
	}
	
	$('#snapshot_container .con_inner tbody').prepend(temp_str);
}


//스냅샷 리스트 출력 (초기화용)
function snapshotList(){
	$.ajax({
		type : "post",
		url : "/erddrawing/erdSnapList",
		async: false,
		data : {
			erdNo : erdNo
		},
		success : function(data) {
			var list = data.erdSnapList;
			
			var temp_str ="";

			$.each(list, function(){
				
				var nowDate = new Date(parseInt(this.erdDt));
				var times = getDateFormat(nowDate);
				var id = "아이디";
				var title = "스냅샷 내용";
				temp_str += `<tr class="snap_img">
								<td colspan="3">이미지</td>
							</tr>
							<tr class="snap_group">
								<td>`+ id + " - " + title +`</td>
								<td>`+ times +`</td>
								<td><div class="btn_hist_change">변경</td>
							</tr>`;
			});
			
			$('#snapshot_container .con_inner tbody').html(temp_str);
			$('#loading').css('display','none');
			
			
			
		},
		error : function(xhr, status, error) {
			console.log(error);
		}
	});
}


//=======================[ 도메인 관련 ]=============================



//도메인 검색 <클릭 이벤트> - ShinYS
$('.btn_search').on('click', function(){
	var tmp_search_text = $('.box_search').val();
	fn_init_search(tmp_search_text);
});

//도메인 검색 <엔터 입력 이벤트> - ShinYS
$('.box_search').on('keydown', function(e){
	if(e.keyCode == 13){
		var tmp_search_text = $('.box_search').val();
		fn_init_search(tmp_search_text);
	}
});

//도메인 초기화 & 검색 함수 - ShinYS
function fn_init_search(tmp_search_text){
	$.ajax({
		type : "get",
		url : "/erddrawing/domainSearch",
		data : {
			domainNm : tmp_search_text,
			erdNo : erdNo
		},
		success : function(data) {

			var tmp_inner="";
			if(data.domainVoList != null){
				$.each(data.domainVoList, function(){
					
					var domainDefaultValue = (this.domainDefaultValue === null) ? '' : this.domainDefaultValue;
					var domainDataType = (this.domainDataType === null) ? '' : this.domainDataType;
					tmp_inner += `
						<tr class="domainTr" data-domainno="`+this.domainNo+`">
						    <td><input class="domainNm input_box" type="text" value="`+this.domainNm+`"/></td>
						    <td><input class="domainDataType input_box" type="text" value="`+domainDataType+`"/></td>
						    <td><input class="domainDefaultValue input_box" type="text" value="`+ domainDefaultValue +`"/></td>
						    <td class="btn_d_update"><div class="btn_inner"><i class="fas fa-sync-alt"></i></div></td>
						    <td class="btn_d_delete"><i class="fas fa-trash"></i></td>
						</tr>`;
				});
			}
			$('.under_list_box tbody').html("");
			$('.under_list_box tbody').append(tmp_inner);
			
		},
		error : function(xhr, status, error) {
			console.log(error);
		}
	});
	
	
	$('.under_list_box').off('click', '.btn_d_delete');
	$('.under_list_box').on('click', '.btn_d_delete', fn_domainRemove);
	
	$('.under_list_box').off('click', '.btn_d_update');
	$('.under_list_box').on('click', '.btn_d_update', function(evt){
		fn_domainUpdate(evt);
//		webSend('domain',jsonSave());
	});
	
	
}




//도메인 row추가 - ShinYS
$('.btn_domain').on('click', function(){
	
	var tmp_inner = `
	<tr class="domainTr" data-domainno="0">
	    <td><input class="domainNm input_box" type="text"/></td>
	    <td><input class="domainDataType input_box" type="text"/></td>
	    <td><input class="domainDefaultValue input_box" type="text"/></td>
	    <td class="btn_d_update"><div class="btn_inner"><i class="fas fa-sync-alt"></i></div></td>
	    <td class="btn_d_delete"><i class="fas fa-trash"></i></td>
	</tr>`;
	
	$('.under_list_box tbody').append(tmp_inner);
	
	$('.under_list_box').off('click', '.btn_d_delete');
	$('.under_list_box').on('click', '.btn_d_delete', fn_domainRemove);
	
	$('.under_list_box').off('click', '.btn_d_update');
	$('.under_list_box').on('click', '.btn_d_update', function(evt){
		fn_domainUpdate(evt);
		
//		webSend('domain',jsonSave());

	});

	
	$('.under_list_box tbody tr').last().find('.domainNm').focus();
	
});


//도메인 row삭제 - ShinYS
function fn_domainRemove(){
	var domainTr = $(this).closest('.domainTr');
	var domainNo = domainTr.data('domainno');
	
	if(domainTr.find('.domainNm').val() != "" || domainTr.data('domainno') != 0){
		if (confirm("정말 삭제하시겠습니까??") == false){
			return;
		}
	}
	
	if(domainTr.data('domainno') != 0){
		
		$.ajax({
			type : "get",
			url : "/erddrawing/domainDelete",
			data : {
				domainNo : domainNo
			},
			success : function(data) {
				webSend('domain 삭제',jsonSave("hist"));
				histLoad();
			},
			error : function(xhr, status, error) {
				console.log(error);
			}
		});
	}

	domainTr.remove();
}


//도메인 업데이트(추가,수정) - ShinYS
function fn_domainUpdate(evt){
	var target = evt.target;
	var domainTr = $(target).closest('.domainTr');
	var domainNo = domainTr.data('domainno');
	var domainNm = domainTr.find('.domainNm').val();
	var domainDataType = domainTr.find('.domainDataType').val();
	var domainDefaultValue = domainTr.find('.domainDefaultValue').val();
	
	if(domainNm === ""){
		alert('도메인 이름을 작성하시고 업데이트를 진행해주세요.');
		domainTr.find('.domainNm').focus();
		return;
	}
	
	var angle = 0;
	var btn_rotate = setInterval(function(){
	      angle+=10;
	      domainTr.find('.btn_d_update .btn_inner').css('-webkit-transform','rotate('+angle+'deg)');
	},40);
	
	$.ajax({
		type : "get",
		url : "/erddrawing/domainUpdate",
		data : {
			erdNo : erdNo,
			domainNo : domainNo,
			domainNm : domainNm,
			domainDataType : domainDataType,
			domainDefaultValue : domainDefaultValue
		},
		success : function(data) {
			domainTr.data('domainno',data.domainVo.domainNo);

			setTimeout(() => {
				clearInterval(btn_rotate);
				domainTr.find('.btn_d_update .btn_inner').css('-webkit-transform','rotate(0deg)');
				domainTr.find('.btn_d_update .btn_inner').html('<i class="fas fa-check-circle" style="color:#00ff08"></i>');
				domainTr.find('.btn_d_update .btn_inner').hide().fadeIn(400).delay( 500 ).fadeOut(400, function(){
					domainTr.find('.btn_d_update .btn_inner').html('<i class="fas fa-sync-alt"></i>');
					domainTr.find('.btn_d_update .btn_inner').show();
					
					
					var msg = S_userId+ " updated domain"
					webSend('domain 추가/수정 domain 추가/수정',jsonSave("hist",msg));
					//histLoad();
				});
			}, 500);
		},
		error : function(xhr, status, error) {
			console.log(error);
		}
	});
}


