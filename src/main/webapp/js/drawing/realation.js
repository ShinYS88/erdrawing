/**
 * erdDrawing.jsp relation 기능에 관련된 스크립트 입니다.
 */
// entity배열중에  중에 id()가 일치하는entity를 리턴하는  메서드
function findEntity(findEntityArr, id){
	id = parseInt(id);
	for(var i =0; i<findEntityArr.length; i++){
		if(findEntityArr[i].id() == id){
			return findEntityArr[i]; 
		}
	}
}


function findLine(arr, id){ //해당 아이디 값을  seocondEntity로 참조하는 배열 선택
	for(var i =0; i<arr.length; i++){
		if(arr[i].attrs.lastPos == id){
			return arr[i]; 
		}
	}
}

function findLineAtName(arr,id){
	for(var i =0; i<arr.length; i++){
		if(arr[i].attrs.name == id){
			return arr[i]; 
		}
	}
}


// 라인 객체 중에 해당 id를 pos으로 가지고 있는 라인을 가지고 옴
function findLineRefPos(id){
	var arr_Line = new Array();
	for(var i =0; i<relationLine_layer.children.length; i++){
		if(relationLine_layer.children[i].attrs.lastPos == id){
			arr_Line.push(relationLine_layer.children[i]);
		}
	}
	return arr_Line; 
}



//2개의 entity에서 2개이상의 관계선이 나온 경우 좌표값을 변경해주는 메서드 (생성 할 때) 
function sameEntityRelationLineaboutCreate(arr_XY,type){
	firstEntity
	secondEntity
	var cnt =0;
	for(var i = 0;i<relationLine_layer.children.length; i++){
		
		if(relationLine_layer.children[i].attrs.name == firstEntity.id()
				&& relationLine_layer.children[i].attrs.lastPos == secondEntity.id()){
			cnt++;
		}
		else if(relationLine_layer.children[i].attrs.name== secondEntity.id()
				&& relationLine_layer.children[i].attrs.lastPos == firstEntity.id()){
			cnt++;
		}
	}
		console.log('==== cnt:'+ cnt);
				switch(type){
				case 0:
				case 2:
					arr_XY[1] = arr_XY[1] - (cnt*10);//startY-=10;
					arr_XY[3] = arr_XY[3] - (cnt*10);//entY-=10;
				break;	
				
				case 1:
				case 3:
					arr_XY[0]= arr_XY[0] - (cnt*10);//startX-=10;
					arr_XY[2]= arr_XY[2] - (cnt*10);//startY-=10;
					break;
				}
				
				return arr_XY;
}





//2개의 entity에서 2개이상의 관계선이 나온 경우 좌표값을 변경해주는 메서드
function sameEntityRelationLine(arr_XY,arr_line_To,type){
	
	//전체 관계선에서 자기자신과 같은 객체를 참조하는 관계선이 있는 지 검사한다.  //자기자신도 포함되므로 무조건 1개이상 나옴
	for(var i = 0;i<relationLine_layer.children.length; i++){
		var temp_i;
		if(arr_line_To.parent.children[arr_line_To.index].id() ==relationLine_layer.children[i].id()){ //자기자신과 만났을 때 
			console.log('자기자신을 참조');
			temp_i = i;
			continue;
		}
		
		if(arr_line_To.parent.children[arr_line_To.index].attrs.name == relationLine_layer.children[i].attrs.name
		&& arr_line_To.parent.children[arr_line_To.index].attrs.lastPos == relationLine_layer.children[i].attrs.lastPos){
			console.log('arr_line_To.index : '+ arr_line_To.index);
			console.log('같은 객체를 참조');
		if(arr_line_To.index < i){//위와같이 진행하면 같은 객체 2개가 둘다 좌표값이 변하기 때문에 처음에 나온 애는 뺴준다.
			continue;
			}
		switch(type){
		case 0:
		case 2:
			arr_XY[1]-=10;//startY-=10;
			arr_XY[3]-=10;//endY-= 10; 
		break;	
		
		case 1:
		case 3:
			arr_XY[0]-=10;//startX-=10;
			arr_XY[2]-=10;//endX-= 10;
			break;
		}
			}
		}
}

		

function makeArrow(e) {
	if (isRRelationClick) { // 관계연결선 버튼을 클릭한 했을 경우만 실행
		// 화살표를 생성
		var pos = stage.getPointerPosition();
		console.log(pos.x);
		console.log(pos.y);

		var p_x = allNode.findAncestor('.entity').x();
		var p_y = allNode.findAncestor('.entity').y();
		firstEntity = allNode.findAncestor('.entity');
		var click_target = allNode.findAncestor('.entity').children[0];
		console.log('click_target :' + click_target);

		plus_width = click_target.width() / 2;
		plus_height = click_target.height() / 2;

		temp_arrow = new Konva.Arrow({
			points : [ p_x + plus_width, p_y + plus_height, pos.x, pos.y ],
			pointerLength : 10,
			pointerWidth : 10,
			stroke : '#ffd400',
			strokeWidth : 2
		});

		console.log('create temp_arrow');
		temp_arrow_layer.add(temp_arrow);

		console.log('adjustPoint 호출');

		// 나중에 끌일이 생길 듯
		stage.on('mousemove', adjustPoint);

		function adjustPoint(e) {
			console.log('adjustPoint 호출됨');
			
			
				//가이드선 절대경로 만들기
	            var transform = layer.getAbsoluteTransform().copy();
	
	            transform.invert();

	            var circlePos = stage.getPointerPosition();
		        pos = transform.point(circlePos);
	          
	         // pos = stage.getPointerPosition();


			// 원래 temp_arrow의 x,y 값을 가져옴
			var x = temp_arrow.attrs.points[0];
			var y = temp_arrow.attrs.points[1];
			var point = [ x, y, pos.x - 10, pos.y - 10 ]; // -10을 안하면 빈 스테이지를
															// 찍으면 arrow객체가 클릭 됨
			
			temp_arrow.setPoints(point);
			temp_arrow_layer.draw();

		}
	}
};

function getAngle(compareX,compareY) { // 두 점 사이의 각도를 구하는 함수 (firstEntity 기준)
	var r = Math.atan2(compareX, compareY);
	if (r < 0) r += Math.PI * 2;
	var degree = r * 180 / Math.PI;
	while (degree < 0){ 
		degree += 360; 
	}
	return degree;
}

/*  -1.firstEntity  범위값에 해당하는 inputLIne과 outputLine의 라인배열을 가져온다.
 *  -2. 1.에서 구한 배열들이 가지고 있는 secondEntity에 있는 X또는Y값을 비교하여 오름차순으로 정렬한다.
 *  -3. 오름차순에 순서에 맞게 해당 라인에 start(inputLIne)값과 end(outputLine)값을 바꿔준다.
 *  -4. SecondEntity에 관한 작업도 해줘야한다. 
 */  

	function extractLineXY(temp_line){ //라인객체의 startXstartYendXendY 값을 추출하는 메서드 
		var startXYendXY = new Array();
		var pointLength = temp_line.attrs.points.length;
		
		startXYendXY.push(temp_line.attrs.points[0]);
		startXYendXY.push(temp_line.attrs.points[1]); 
		startXYendXY.push(temp_line.attrs.points[pointLength-2]); 
		startXYendXY.push(temp_line.attrs.points[pointLength-1]);
		
		return startXYendXY; 
	}	

	function calculatestartXY(arr_first_totalEntity,j){
		var center_index = Math.ceil(arr_first_totalEntity.length/2);
 		var changeValue = 10;
 		var result = 0;
		if(arr_first_totalEntity.length%2 == 0){ //짝수일 때 
				var center_index_2 = Math.ceil(arr_first_totalEntity.length/2)+1;   //짝수일 경우 기준값이 2개여야 한다.
				
				 if(j<center_index-1){
					var step = (center_index-1)-j;
//					startXYendXY[1] = xy[1]-(changeValue*step)-changeValue/2;
					result = -((changeValue*step)+changeValue/2);
				 }	 
				 else if(j>center_index_2-1){
					var step = j-(center_index_2-1);
//					startXYendXY[1] = xy[1]+(changeValue*step) +changeVal1ue/2;
					result = ((changeValue*step)+changeValue/2);
				 }
				else if(j == center_index-1){
//					startXYendXY[1] = xy[1]-changeValue/2;  
					result = -changeValue/2;
			 }
				else if(j == center_index_2-1){
//					startXYendXY[1] = xy[1]+changeValue/2;  	
					result = changeValue/2;
			 }
				
			}
			else{ //홀수 일 때
				if(j == center_index-1){
//					startXYendXY[1] = xy[1];  	 
					result = 0;
				}
				
				else if(j <center_index-1){
					var step = (center_index-1)-j;
//					startXYendXY[1] = xy[1]-(changeValue*step);
					result = -(changeValue*step);
				}
				else if(j >center_index-1){
					var step = j-(center_index-1);
//					startXYendXY[1] = xy[1]+(changeValue*step);
					result = (changeValue*step);
				}
			}
		return result;
	}
	
	
	//firstEntity에 속해있는 outputLine과 inPutLine를 배열에 담음
	function selectLine(arr_outputLine,arr_inputLine,arr_range,type){  // 해당객체에
		for(var i = 0; i<relationLine_layer.children.length; i++){
			var pointLength = relationLine_layer.children[i].attrs.points.length;
			
			switch(type){
			case 0 : //45~134도 
			case 2 : //225~314도
 			// firstEntity에 범위에 속해있는 outputLine을 검색
			if(relationLine_layer.children[i].attrs.points[0] == arr_range[0] && 
			   (relationLine_layer.children[i].attrs.points[1] >arr_range[1] &&
			    relationLine_layer.children[i].attrs.points[1] <arr_range[3]))
					{
				arr_outputLine.push(relationLine_layer.children[i]);	
					}
			
			// firstEntity에 범위에 속해있는 inPutLine을 검색
			if(relationLine_layer.children[i].attrs.points[pointLength-2] == arr_range[0] && 
					   (relationLine_layer.children[i].attrs.points[pointLength-1] >=arr_range[1] &&
					    relationLine_layer.children[i].attrs.points[pointLength-1] <=arr_range[3]))
					{
				arr_inputLine.push(relationLine_layer.children[i]);	
					}
			break;
			
			case 1 : //135~224도
			case 3 : //315~360도
	 			// firstEntity에 범위에 속해있는 outputLine을 검색
				if(relationLine_layer.children[i].attrs.points[1] == arr_range[1] && 
				   (relationLine_layer.children[i].attrs.points[0] >arr_range[0] &&
				    relationLine_layer.children[i].attrs.points[0] <arr_range[2]))
						{
					arr_outputLine.push(relationLine_layer.children[i]);	
						}
				
				// firstEntity에 범위에 속해있는 inPutLine을 검색
				if(relationLine_layer.children[i].attrs.points[pointLength-1] == arr_range[1] && 
						   (relationLine_layer.children[i].attrs.points[pointLength-2] >=arr_range[0] &&
						    relationLine_layer.children[i].attrs.points[pointLength-2] <=arr_range[2]))
						{
					arr_inputLine.push(relationLine_layer.children[i]);	
						}
				break;
			
				}
			}
		}
	
	function drawUpdLine(startXYendXY,temp_line,type){
		var	startX = startXYendXY[0];
		var	startY = startXYendXY[1];
		var	endX = startXYendXY[2];
		var	endY = startXYendXY[3];

		switch(type){
		case 0 :
				if(temp_line.attrs.points.length == 22){ // 1대 1
					temp_line.points([startX,startY,startX-10,startY,startX-10,startY-5,startX-10,startY+5,startX-10,startY,endX+15,endY,endX+10,endY,endX+10,endY-5,endX+10,endY+5,endX+10,endY,endX,endY]);	
				}
				else if(temp_line.attrs.points.length == 24){ //1대 다
					temp_line.points([startX,startY,startX-10,startY,startX-10,startY-5,startX-10,startY+5,startX-10,startY,endX+15,endY,endX+10,endY,endX,endY+5,endX+10,endY,endX,endY-5,endX+10,endY,endX,endY]);
				}
		break;
		
		case 1 :
			if(temp_line.attrs.points.length == 22){ // 1대 1
				temp_line.points([startX,startY,startX,startY+10,startX-5,startY+10,startX+5,startY+10,startX,startY+10,endX,endY-15,endX,endY-10,endX-5,endY-10,endX+5,endY-10,endX,endY-10,endX,endY]);	
			}
			else if(temp_line.attrs.points.length == 24){ //1대 다
				temp_line.points([startX,startY,startX,startY+10,startX-5,startY+10,startX+5,startY+10,startX,startY+10,endX,endY-15,endX,endY-10,endX+5,endY,endX,endY-10,endX-5,endY,endX,endY-10,endX,endY]);
			}
			break;
			
		case 2 :
		  if(temp_line.attrs.points.length == 22){ // 1대 1
			  temp_line.points([startX,startY,startX+10,startY,startX+10,startY-5,startX+10,startY+5,startX+10,startY,endX-15,endY,endX-10,endY,endX-10,endY-5,endX-10,endY+5,endX-10,endY,endX,endY]);	
			}
		   else if(temp_line.attrs.points.length == 24){ //1대 다
			   temp_line.points([startX,startY,startX+10,startY,startX+10,startY-5,startX+10,startY+5,startX+10,startY,endX-15,endY,endX-10,endY,endX,endY+5,endX-10,endY,endX,endY-5,endX-10,endY,endX,endY]);	
			}
			
			break;
			
		case 3 :
			  if(temp_line.attrs.points.length == 22){ // 1대 1
				  temp_line.points([startX,startY,startX,startY-10,startX-5,startY-10,startX+5,startY-10,startX,startY-10,endX,endY+15,endX,endY+10,endX-5,endY+10,endX+5,endY+10,endX,endY+10,endX,endY]);	
			  }
			   else if(temp_line.attrs.points.length == 24){ //1대 다
				   temp_line.points([startX,startY,startX,startY-10,startX-5,startY-10,startX+5,startY-10,startX,startY-10,endX,endY+15,endX,endY+10,endX+5,endY,endX,endY+10,endX-5,endY,endX,endY+10,endX,endY])
			   }
			break;
		}
	}
	
	
	
	function  totalEntitysort(arr_first_totalEntity,type){  //각도에 따라 x ,y로 정렬해주는 메서드
		switch(type){
		case 0:
		case 2:
 		arr_first_totalEntity.sort(function (a,b){
 			return a.attrs.y<b.attrs.y?-1 : a.attrs.y>b.attrs.y?1:0;   //현재 이 배열에는 내가 선택한 곳에 포함되는 객체들이 모두 들어있다.
 		});
 		break;
 		
		case 1:
		case 3:
	 		arr_first_totalEntity.sort(function (a,b){
	 			return a.attrs.x<b.attrs.x?-1 : a.attrs.x>b.attrs.x?1:0;   //현재 이 배열에는 내가 선택한 곳에 포함되는 객체들이 모두 들어있다.
	 		});
	 		break;

		}
	}
	
	
	//flag = true : 최조 관계선 생성 , false : 관계선의 위치수정
	function rePositioning(arr_first_range,arr_second_range,xy,secondEntity,type,flag){
		var newLineXY = xy; //새로만들 라인의 좌표값을 담아주는 배열
		
		var arr_first_outputLine = new Array(); // firstEntity에서 나온 outputLine 배열
		var arr_first_inputLine = new Array(); // firstEntity에 들어오는 inputLine 배열
		
		var arr_second_outputLine = new Array(); // secondEntity에서 나온 outputLine 배열
		var arr_second_inputLine = new Array(); // secondEntity에 들어오는 inputLine 배열
		
	  	var EntityArr  = stage.find('.entity'); //entity 객체가 들어있는 배열 
	  	
 	  	var arr_first_outputEntity = new Array(); //firstEntity에 들어오는 inputLine의 참조값들이 들어있는 배열
 	  	var arr_first_inputEntity = new Array(); //firstEntity에 나가는 inputLine의 참조값들이 들어있는 배열
 	  	
 	  	var arr_second_outputEntity = new Array(); //secondEntity에 들어오는 outputLine의 참조값들이 들어있는 배열
 	  	var arr_second_inputEntity = new Array(); //secondEntity에 나가는 inputLine의 참조값들이 들어있는 배열
 	  	
 	  	
 	  	var arr_first_totalEntity//   arr_first_outputEntity + arr_first_inputEntity
 	  	var arr_second_totalEntity//   arr_second_outputEntity + arr_second_inputEntity
 	  	
 	  	var secondType;
 	  	
		if(type ==0 || type == 2){
			secondType = Math.abs(type-2);
		}
		else if(type == 1 || type==3){
			secondType =  (type>2)?secondType=1:secondType=3;
		}
 	  	
 	  	//firstEntity에 속해있는 outputLine과 inPutLine를 배열에 담음
 	  	selectLine(arr_first_outputLine,arr_first_inputLine,arr_first_range,type);

 	  	//secondEntity에 속해있는 속해있는 outputLine과 inPutLine를 배열에 담음
 	  	selectLine(arr_second_outputLine,arr_second_inputLine,arr_second_range,type);
 	  	
 	  	
 	  	
 		//해당범위 참조하는 라인이 없으면 리턴
 		if(arr_first_outputLine.length == 0 && arr_first_inputLine.length == 0 
 		&& arr_second_outputLine.length == 0 && arr_second_inputLine.length == 0  ){ 
 			return newLineXY;
 		}
 		
 		//arr_first_outputLine이 참조하는 객체를 구함
 		for(var i =0; i<arr_first_outputLine.length; i++){
 			var temp_Entity = findEntity(EntityArr,arr_first_outputLine[i].attrs.lastPos);
 			arr_first_outputEntity.push(temp_Entity);
 		}
 		
 		//새로 연결된 라인도 계산해야 함으로 arr_first_outputEntity에 넣어준다.(관계선 생성 시 만 사용)
 		if(flag){
			arr_first_outputEntity.push(secondEntity); 
 		}
 		
 		//arr_second_outputLine이 참조하는 객체를 구함
 		for(var i =0; i<arr_second_outputLine.length; i++){
 			var temp_Entity = findEntity(EntityArr,arr_second_outputLine[i].attrs.lastPos);
 			arr_second_outputEntity.push(temp_Entity);
 		}
 		
 		//arr_first_inputLine 참조하는 객체를 구함
 		for(var i =0; i<arr_first_inputLine.length; i++){
 			var temp_Entity = findEntity(EntityArr,arr_first_inputLine[i].attrs.name);
 			arr_first_inputEntity.push(temp_Entity);
 		}
 		
 		//arr_second_inputLine 참조하는 객체를 구함
 		for(var i =0; i<arr_second_inputLine.length; i++){
 			var temp_Entity = findEntity(EntityArr,arr_second_inputLine[i].attrs.name);
 			arr_second_inputEntity.push(temp_Entity);
 		}
 		
 		//새로 연결된 라인도 계산해야 함으로 second_inputEntity에 넣어준다. (관계선 생성 시 만 사용)
 		if(flag){
 		arr_second_inputEntity.push(firstEntity);
 		}
 		//배열 합치기
 		  arr_first_totalEntity = arr_first_outputEntity.concat(arr_first_inputEntity);
 		  arr_second_totalEntity = arr_second_outputEntity.concat(arr_second_inputEntity);
 		  
 		  
 		 //y값을 기준으로 오름차순 (각도에 따라 x가 될 수도 있음)
 		 totalEntitysort(arr_first_totalEntity,type);
 		totalEntitysort(arr_second_totalEntity,type);
 		 
 		
 		//선택한 객체에서 outLine의 위치를 재조정해주는 부분 (firstEntity 관련)
 		for(var i =0; i<arr_first_outputEntity.length; i++ ){
 			for(var j=0; j<arr_first_totalEntity.length; j++){
 				if(arr_first_outputEntity[i]  == arr_first_totalEntity[j]){
 					//var result=0;	
 					//서로 같은 엔터티에서 참조할 경우 예외가 일어날 확률이 높다...
 					if(flag){  // (관계선 생성 시 만 사용)
 					if(arr_first_totalEntity[j] == secondEntity){
 					var result = calculatestartXY(arr_first_totalEntity,j);
 					
 					 if(type==0 || type == 2){
 						newLineXY[1] = xy[1]+result;  
 					 }
 					 else if(type==1 || type == 3){
 						newLineXY[0] = xy[0]+result;  
 					 }
 					continue;	
 					}
 					}
 					var temp_line = findLine(arr_first_outputLine,arr_first_outputEntity[i].id());
 					var startXYendXY = extractLineXY(temp_line); //해당 객체의 좌표정보를 얻어온다.
 					
 					 var result = calculatestartXY(arr_first_totalEntity,j);
 					
 					 if(type==0 || type == 2){
 						startXYendXY[1] = xy[1]+result;  
  					 }
  					 else if(type==1 || type == 3){
  						startXYendXY[0] = xy[0]+result;  
  					 }
 					
 					drawUpdLine(startXYendXY,temp_line,type);
 					}
 				}
 			}
 		
 		//선택한 객체에서 inLine의 위치를 재조정해주는 부분
 		for(var i =0; i<arr_first_inputEntity.length; i++ ){
 			for(var j=0; j<arr_first_totalEntity.length; j++){
 				if(arr_first_inputEntity[i]  == arr_first_totalEntity[j]){
 					
 					var temp_line = findLineAtName(arr_first_inputLine,arr_first_inputEntity[i].id());
 					var startXYendXY = extractLineXY(temp_line); //해당 객체의 좌표정보를 얻어온다.
 					
 					var result = calculatestartXY(arr_first_totalEntity,j);
 					if(type==0 || type == 2){
 						startXYendXY[3] = xy[1]+result;  
   					 }
   					 else if(type==1 || type == 3){
   						startXYendXY[2] = xy[0]+result;  
   					 }
 					drawUpdLine(startXYendXY,temp_line,secondType);
 					}
 				}
 			}
 		
 		
 		//선택한 객체에서 outLine의 위치를 재조정해주는 부분 (secondEntity 관련)
 		for(var i =0; i<arr_second_outputEntity.length; i++ ){
 			for(var j=0; j<arr_second_totalEntity.length; j++){
 				if(arr_second_outputEntity[i]  == arr_second_totalEntity[j]){
 					//var result=0;	
 					//서로 같은 엔터티에서 참조할 경우 예외가 일어날 확률이 높다...
 					
 					
 					var temp_line = findLine(arr_second_outputLine,arr_second_outputEntity[i].id());
 					var startXYendXY = extractLineXY(temp_line); //해당 객체의 좌표정보를 얻어온다.
 					
 					 var result = calculatestartXY(arr_second_totalEntity,j);
 					
 					 if(type==0 || type == 2){
 						startXYendXY[1] = xy[3]+result;  
  					 }
  					 else if(type==1 || type == 3){
  						startXYendXY[0] = xy[2]+result;  
  					 }
 					 
 					
 					 
 					drawUpdLine(startXYendXY,temp_line,secondType);
 					}
 				}
 			}
 		
 		//선택한 객체에서 inLine의 위치를 재조정해주는 부분 (secondEntity)
 		for(var i =0; i<arr_second_inputEntity.length; i++ ){
 			for(var j=0; j<arr_second_totalEntity.length; j++){
 				if(arr_second_inputEntity[i]  == arr_second_totalEntity[j]){
 					if(flag){
 					if(arr_second_totalEntity[j] == firstEntity){ //(관계선 생성 시 만 사용)
 	 					var result = calculatestartXY(arr_second_totalEntity,j);
 	 					
 	 					 if(type==0 || type == 2){
 	 						newLineXY[3] = xy[3]+result;  
 	 					 }
 	 					 else if(type==1 || type == 3){
 	 						newLineXY[2] = xy[2]+result;  
 	 					 }
 	 					continue;	
 	 					}
 					}
 					var temp_line = findLineAtName(arr_second_inputLine,arr_second_inputEntity[i].id());
 					var startXYendXY = extractLineXY(temp_line); //해당 객체의 좌표정보를 얻어온다.
 					
 					var result = calculatestartXY(arr_second_totalEntity,j);
 					if(type==0 || type == 2){
 						startXYendXY[3] = xy[3]+result;  
   					 }
   					 else if(type==1 || type == 3){
   						startXYendXY[2] = xy[2]+result;  
   					 }
 					drawUpdLine(startXYendXY,temp_line,type);
 					}
 				}
 			}
 		return newLineXY;
	}
	
 	
//flag : alter할 경우 테이블의 속성을 복사할 필요가 없기 때문에 구분값을 준 것
 function compareEntityPosition(flag) {
	 
	// 라인객체 생성 좌표값은 switch에서 결정
	 relationLine = new Konva.Line({  
		 	strokeWidth:3,
			lineCap : 'round',
			linerJoin: 'round',
			name:firstEntity.id()+'',   // 첫번째 엔터티에 관한 ID값을 참조
			lastPos : secondEntity.id(), // 두번째 엔터티에 관한 ID값을 참조
			id : get_numId()
		});
	 
	 //컬럼을 추가한 뒤에  x,y 좌표값을 구해야 선이 정확히 가운데에 그려진다.
	if(flag){
	 if(!relationType){
			moveColumnIdentifying(false,relationLine.id()); // pk값을 속성값으로 복사 //비식별
		}
		else{
			moveColumnIdentifying(true,relationLine.id()); //pk값을 fk값으로 복사 //식별
			}
	}
	 
	compareX = firstEntity.x() - secondEntity.x();
	compareY = firstEntity.y() - secondEntity.y();
	
	var degree = getAngle(compareX,compareY);
	
	var startX, startY, endX, endY;   // 선에 관한 좌표 값을 담을 변수들
	
	var arr_first_range = new Array(); //firstEntity 범위 값에 관한 좌표를 담을 변수
	var arr_second_range = new Array();//SecondEntity 범위 값에 관한 좌표를 담을 변수
	var xy = new Array();//firstEntity와 SecondEntity의 좌표 정보를 담은 변수
	degree = degree-45;
	
	var firstEntityWidth = firstEntity.children[0].attrs.width;
	var firstEntityheight = firstEntity.children[0].attrs.height;
	var secondEntitywidth = secondEntity.children[0].attrs.width;
	var secondEntityheight = secondEntity.children[0].attrs.height;
	
	startX = firstEntity.x();
	startY = firstEntity.y();
	endX   = secondEntity.x();
	endY   = secondEntity.y();
	
		
	
	switch(Math.floor(degree/90)){
	case 0 : 	 // 45~134 도
		console.log('case0');
		startY+=(firstEntityheight/2);
		endX += (secondEntitywidth);
		endY += (secondEntityheight/2);
		
		//범위값을 정해준다.
		arr_first_range[0] = firstEntity.x();
		arr_first_range[1] = firstEntity.y();
		arr_first_range[2] = firstEntity.x();
		arr_first_range[3] = firstEntity.y()+firstEntityheight;
		
		arr_second_range[0] = secondEntity.x()+secondEntitywidth;
		arr_second_range[1] = secondEntity.y();
		arr_second_range[2] = secondEntity.x()+secondEntitywidth;
		arr_second_range[3] = secondEntity.y()+secondEntityheight;
		
		xy.push(startX);
		xy.push(startY);
		xy.push(endX);
		xy.push(endY);
		
		 var newLineXY= rePositioning(arr_first_range,arr_second_range,xy,secondEntity,0,true);
		
		
		//arr_XY = sameEntityRelationLineaboutCreate(newLineXY,0);
		
		startX = newLineXY[0];
		startY = newLineXY[1];
		endX   = newLineXY[2];
		endY   = newLineXY[3];
	
		if(cardinality=='single'){
			relationLine.stroke('#e08ba3'), // 핑크
			relationLine.points([startX,startY,startX-10,startY,startX-10,startY-5,startX-10,startY+5,startX-10,startY,endX+15,endY,endX+10,endY,endX+10,endY-5,endX+10,endY+5,endX+10,endY,endX,endY]);	
		}
		else if(cardinality=='multi'){
			relationLine.stroke('#86f5e5'), // 청록
			relationLine.points([startX,startY,startX-10,startY,startX-10,startY-5,startX-10,startY+5,startX-10,startY,endX+15,endY,endX+10,endY,endX,endY+5,endX+10,endY,endX,endY-5,endX+10,endY,endX,endY]);
		}
	break;
	case 1 :   // 135~224
		console.log('case1');
		startX += (firstEntityWidth/2);
		startY += (firstEntityheight);
		endX += (secondEntitywidth/2);
		
		//범위값을 정해준다.
		arr_first_range[0] = firstEntity.x();
		arr_first_range[1] = firstEntity.y()+firstEntityheight;
		arr_first_range[2] = firstEntity.x()+firstEntityWidth;
		arr_first_range[3] = firstEntity.y()+firstEntityheight;
		
		arr_second_range[0] = secondEntity.x();
		arr_second_range[1] = secondEntity.y();
		arr_second_range[2] = secondEntity.x()+secondEntitywidth;
		arr_second_range[3] = secondEntity.y();
		
		xy.push(startX);
		xy.push(startY);
		xy.push(endX);
		xy.push(endY);
		
		 var newLineXY= rePositioning(arr_first_range,arr_second_range,xy,secondEntity,1,true);
		
		
		//arr_XY = sameEntityRelationLineaboutCreate(arr_XY,1);
		startX = newLineXY[0];
		startY = newLineXY[1];
		endX   = newLineXY[2];
		endY   = newLineXY[3];
		
		if(cardinality=='single'){
			relationLine.stroke('#e08ba3'),
			relationLine.points([startX,startY,startX,startY+10,startX-5,startY+10,startX+5,startY+10,startX,startY+10,endX,endY-15,endX,endY-10,endX-5,endY-10,endX+5,endY-10,endX,endY-10,endX,endY]);	
		}
		else if(cardinality=='multi'){
			relationLine.stroke('#86f5e5'),
			relationLine.points([startX,startY,startX,startY+10,startX-5,startY+10,startX+5,startY+10,startX,startY+10,endX,endY-15,endX,endY-10,endX+5,endY,endX,endY-10,endX-5,endY,endX,endY-10,endX,endY]);
		}
		
	break;
	
	case 2 :   // 225~314
		console.log('case2');
		startX += (firstEntityWidth);
		startY += (firstEntityheight/2);
		endY   += (secondEntityheight/2);
		
		//범위값을 정해준다.
		arr_first_range[0] = firstEntity.x()+firstEntityWidth;
		arr_first_range[1] = firstEntity.y();
		arr_first_range[2] = firstEntity.x()+firstEntityWidth;
		arr_first_range[3] = firstEntity.y()+firstEntityheight;
		
		arr_second_range[0] = secondEntity.x();
		arr_second_range[1] = secondEntity.y();
		arr_second_range[2] = secondEntity.x();
		arr_second_range[3] = secondEntity.y()+secondEntityheight;
		
		xy.push(startX);
		xy.push(startY);
		xy.push(endX);
		xy.push(endY);
		
		var newLineXY= rePositioning(arr_first_range,arr_second_range,xy,secondEntity,2,true);
		
		//arr_XY = sameEntityRelationLineaboutCreate(arr_XY,2);
		
		startX = newLineXY[0];
		startY = newLineXY[1];
		endX   = newLineXY[2];
		endY   = newLineXY[3];
		
		if(cardinality=='single'){
			relationLine.stroke('#e08ba3'),
			relationLine.points([startX,startY,startX+10,startY,startX+10,startY-5,startX+10,startY+5,startX+10,startY,endX-15,endY,endX-10,endY,endX-10,endY-5,endX-10,endY+5,endX-10,endY,endX,endY]);	
		}
		else if(cardinality=='multi'){
		relationLine.stroke('#86f5e5'),
		relationLine.points([startX,startY,startX+10,startY,startX+10,startY-5,startX+10,startY+5,startX+10,startY,endX-15,endY,endX-10,endY,endX,endY+5,endX-10,endY,endX,endY-5,endX-10,endY,endX,endY]);
		}
	break;	
	
	default :  	// 315<X이거나 45>X
		console.log('default');
	startX += (firstEntityWidth/2); // 첫번 째 객체의 가운데 위에서 선이 출발 (Y값 변화 X)
	endX   += (secondEntitywidth/2); // 두번 째 객체의 가운데 아래에서 선이 종료
	endY   += secondEntityheight; 
	
	//범위값을 정해준다.
	arr_first_range[0] = firstEntity.x();
	arr_first_range[1] = firstEntity.y();
	arr_first_range[2] = firstEntity.x()+firstEntityWidth;
	arr_first_range[3] = firstEntity.y();
	
	arr_second_range[0] = secondEntity.x();
	arr_second_range[1] = secondEntity.y()+secondEntityheight;
	arr_second_range[2] = secondEntity.x()+secondEntitywidth;
	arr_second_range[3] = secondEntity.y()+secondEntityheight;
	
	xy.push(startX);
	xy.push(startY);
	xy.push(endX);
	xy.push(endY);
	
	var newLineXY= rePositioning(arr_first_range,arr_second_range,xy,secondEntity,3,true);
	
	//arr_XY = sameEntityRelationLineaboutCreate(arr_XY,3);
	
	startX = newLineXY[0];
	startY = newLineXY[1];
	endX   = newLineXY[2];
	endY   = newLineXY[3];
	
	if(cardinality=='single'){
		relationLine.stroke('#e08ba3'),
		relationLine.points([startX,startY,startX,startY-10,startX-5,startY-10,startX+5,startY-10,startX,startY-10,endX,endY+15,endX,endY+10,endX-5,endY+10,endX+5,endY+10,endX,endY+10,endX,endY]);	
	}
	else if(cardinality=='multi'){
	relationLine.stroke('#86f5e5'),
	relationLine.points([startX,startY,startX,startY-10,startX-5,startY-10,startX+5,startY-10,startX,startY-10,endX,endY+15,endX,endY+10,endX+5,endY,endX,endY+10,endX-5,endY,endX,endY+10,endX,endY])
	}
	break;	
	}
	
	if(!relationType){
		relationLine.dash([5,5]); //점선으로 바꿈
	}

	 relationLine_layer.add(relationLine);
     relationLine_layer.draw();

     
     
};




//entity 이동 시 라인의 위치를 업데이트 해주는 메서드
function updLinePosition(firstEntity,secondEntity,relationLine) {
	console.log('update');
	compareX = firstEntity.x() - secondEntity.x();
	compareY = firstEntity.y() - secondEntity.y();
	
	var degree = getAngle(compareX,compareY);
	
	var startX, startY, endX, endY;   // 선에 관한 좌표 값을 담을 변수들
	
	var arr_first_range = new Array(); //firstEntity 범위 값에 관한 좌표를 담을 변수
	var arr_second_range = new Array();//SecondEntity 범위 값에 관한 좌표를 담을 변수
	var xy = new Array();//firstEntity와 SecondEntity의 좌표 정보를 담은 변수
	degree = degree-45;
	
	var firstEntityWidth = firstEntity.children[0].attrs.width;
	var firstEntityheight = firstEntity.children[0].attrs.height;
	var secondEntitywidth = secondEntity.children[0].attrs.width;
	var secondEntityheight = secondEntity.children[0].attrs.height;
	
	startX = firstEntity.x();
	startY = firstEntity.y();
	endX   = secondEntity.x();
	endY   = secondEntity.y();
	
	
	switch(Math.floor(degree/90)){
	case 0 : 	 // 45~134 도
		console.log('case0');
		startY+=(firstEntityheight/2);
		endX += (secondEntitywidth);
		endY += (secondEntityheight/2);
	
		if(relationLine.attrs.stroke =='#e08ba3'){
			relationLine.points([startX,startY,startX-10,startY,startX-10,startY-5,startX-10,startY+5,startX-10,startY,endX+15,endY,endX+10,endY,endX+10,endY-5,endX+10,endY+5,endX+10,endY,endX,endY]);	
		}
		else if(relationLine.attrs.stroke == '#86f5e5'){
			relationLine.points([startX,startY,startX-10,startY,startX-10,startY-5,startX-10,startY+5,startX-10,startY,endX+15,endY,endX+10,endY,endX,endY+5,endX+10,endY,endX,endY-5,endX+10,endY,endX,endY]);
		}
	break;
	case 1 :   // 135~224
		console.log('case1');
		startX += (firstEntityWidth/2);
		startY += (firstEntityheight);
		endX += (secondEntitywidth/2);
		
		if(relationLine.attrs.stroke =='#e08ba3'){
			relationLine.points([startX,startY,startX,startY+10,startX-5,startY+10,startX+5,startY+10,startX,startY+10,endX,endY-15,endX,endY-10,endX-5,endY-10,endX+5,endY-10,endX,endY-10,endX,endY]);	
		}
		else if(relationLine.attrs.stroke == '#86f5e5'){
			relationLine.points([startX,startY,startX,startY+10,startX-5,startY+10,startX+5,startY+10,startX,startY+10,endX,endY-15,endX,endY-10,endX+5,endY,endX,endY-10,endX-5,endY,endX,endY-10,endX,endY]);
		}
	break;
	
	case 2 :   // 225~314
		console.log('case2');
		startX += (firstEntityWidth);
		startY += (firstEntityheight/2);
		endY   += (secondEntityheight/2);
		
		
		if(relationLine.attrs.stroke =='#e08ba3'){
			relationLine.points([startX,startY,startX+10,startY,startX+10,startY-5,startX+10,startY+5,startX+10,startY,endX-15,endY,endX-10,endY,endX-10,endY-5,endX-10,endY+5,endX-10,endY,endX,endY]);	
		}
		else if(relationLine.attrs.stroke == '#86f5e5'){
		relationLine.points([startX,startY,startX+10,startY,startX+10,startY-5,startX+10,startY+5,startX+10,startY,endX-15,endY,endX-10,endY,endX,endY+5,endX-10,endY,endX,endY-5,endX-10,endY,endX,endY]);
		}
	break;	
	
	default :  	// 315<X이거나 45>X
		console.log('default');
	startX += (firstEntityWidth/2); // 첫번 째 객체의 가운데 위에서 선이 출발 (Y값 변화 X)
	endX   += (secondEntitywidth/2); // 두번 째 객체의 가운데 아래에서 선이 종료
	endY   += secondEntityheight; 
	
	if(relationLine.attrs.stroke =='#e08ba3'){
		relationLine.points([startX,startY,startX,startY-10,startX-5,startY-10,startX+5,startY-10,startX,startY-10,endX,endY+15,endX,endY+10,endX-5,endY+10,endX+5,endY+10,endX,endY+10,endX,endY]);	
	}
	else if(relationLine.attrs.stroke == '#86f5e5'){
	relationLine.points([startX,startY,startX,startY-10,startX-5,startY-10,startX+5,startY-10,startX,startY-10,endX,endY+15,endX,endY+10,endX+5,endY,endX,endY+10,endX-5,endY,endX,endY+10,endX,endY])
	}
	break;	
	}
	 
};


//2개의 entity에 해당하는 범위를 구한 후, 중복되어 있는 선 제거
function deduplicationLine(firstEntity,secondEntity){
	console.log('deduplicationLine');
	compareX = firstEntity.x() - secondEntity.x();
	compareY = firstEntity.y() - secondEntity.y();
	
	var degree = getAngle(compareX,compareY);
	
	var startX, startY, endX, endY;   // 선에 관한 좌표 값을 담을 변수들
	
	var arr_first_range = new Array(); //firstEntity 범위 값에 관한 좌표를 담을 변수
	var arr_second_range = new Array();//SecondEntity 범위 값에 관한 좌표를 담을 변수
	var xy = new Array();//firstEntity와 SecondEntity의 좌표 정보를 담은 변수
	degree = degree-45;
	
	var firstEntityWidth = firstEntity.children[0].attrs.width;
	var firstEntityheight = firstEntity.children[0].attrs.height;
	var secondEntitywidth = secondEntity.children[0].attrs.width;
	var secondEntityheight = secondEntity.children[0].attrs.height;
	
	startX = firstEntity.x();
	startY = firstEntity.y();
	endX   = secondEntity.x();
	endY   = secondEntity.y();
	
	
	switch(Math.floor(degree/90)){
	case 0 : 	 // 45~134 도
		console.log('case0');
		startY+=(firstEntityheight/2);
		endX += (secondEntitywidth);
		endY += (secondEntityheight/2);
		
		//범위값을 정해준다.
		arr_first_range[0] = firstEntity.x();
		arr_first_range[1] = firstEntity.y();
		arr_first_range[2] = firstEntity.x();
		arr_first_range[3] = firstEntity.y()+firstEntityheight;
		
		arr_second_range[0] = secondEntity.x()+secondEntitywidth;
		arr_second_range[1] = secondEntity.y();
		arr_second_range[2] = secondEntity.x()+secondEntitywidth;
		arr_second_range[3] = secondEntity.y()+secondEntityheight;
		
		xy.push(startX);
		xy.push(startY);
		xy.push(endX);
		xy.push(endY);
	
		//중복된 선을 제거해주는 메서드
	 rePositioning(arr_first_range,arr_second_range,xy,secondEntity,0,false);
		
	
	
		
	break;
	case 1 :   // 135~224
		console.log('case1');
		startX += (firstEntityWidth/2);
		startY += (firstEntityheight);
		endX += (secondEntitywidth/2);
		
		//범위값을 정해준다.
		arr_first_range[0] = firstEntity.x();
		arr_first_range[1] = firstEntity.y()+firstEntityheight;
		arr_first_range[2] = firstEntity.x()+firstEntityWidth;
		arr_first_range[3] = firstEntity.y()+firstEntityheight;
		
		arr_second_range[0] = secondEntity.x();
		arr_second_range[1] = secondEntity.y();
		arr_second_range[2] = secondEntity.x()+secondEntitywidth;
		arr_second_range[3] = secondEntity.y();
		
		xy.push(startX);
		xy.push(startY);
		xy.push(endX);
		xy.push(endY);
		
	  rePositioning(arr_first_range,arr_second_range,xy,secondEntity,1,false);
		
		
	
		
	
	break;
	
	case 2 :   // 225~314
		console.log('case2');
		startX += (firstEntityWidth);
		startY += (firstEntityheight/2);
		endY   += (secondEntityheight/2);
		
		//범위값을 정해준다.
		arr_first_range[0] = firstEntity.x()+firstEntityWidth;
		arr_first_range[1] = firstEntity.y();
		arr_first_range[2] = firstEntity.x()+firstEntityWidth;
		arr_first_range[3] = firstEntity.y()+firstEntityheight;
		
		arr_second_range[0] = secondEntity.x();
		arr_second_range[1] = secondEntity.y();
		arr_second_range[2] = secondEntity.x();
		arr_second_range[3] = secondEntity.y()+secondEntityheight;
		
		xy.push(startX);
		xy.push(startY);
		xy.push(endX);
		xy.push(endY);
		
		rePositioning(arr_first_range,arr_second_range,xy,secondEntity,2,false);
		
	
		
	
	break;	
	
	default :  	// 315<X이거나 45>X
		console.log('default');
	startX += (firstEntityWidth/2); // 첫번 째 객체의 가운데 위에서 선이 출발 (Y값 변화 X)
	endX   += (secondEntitywidth/2); // 두번 째 객체의 가운데 아래에서 선이 종료
	endY   += secondEntityheight; 
	
	//범위값을 정해준다.
	arr_first_range[0] = firstEntity.x();
	arr_first_range[1] = firstEntity.y();
	arr_first_range[2] = firstEntity.x()+firstEntityWidth;
	arr_first_range[3] = firstEntity.y();
	
	arr_second_range[0] = secondEntity.x();
	arr_second_range[1] = secondEntity.y()+secondEntityheight;
	arr_second_range[2] = secondEntity.x()+secondEntitywidth;
	arr_second_range[3] = secondEntity.y()+secondEntityheight;
	
	xy.push(startX);
	xy.push(startY);
	xy.push(endX);
	xy.push(endY);
	
	rePositioning(arr_first_range,arr_second_range,xy,secondEntity,3,false);
	
	break;	
	}
	
}

//엔티티를 클릭했을 경우(mouseup) 엔티티와 관계된 관계선들을 보여주는 메서드
//보여주는 작업을 하기전에 entity들의 위치를 재조정 한다.
function entityMouseUp(first_Entity,flag){
	 var arr_line_To= relationLine_layer.find('.'+first_Entity.id());   //첫번째 객체가 시작점인 라인객체의 배열을 얻어옴
	 findEntityArr  = stage.find('.entity');
	 var second_Entity;
	 var arr_second_Entity = new Array();
	
	 //내가 클릭한 entity (first_Entity)가 관계선의 시작점일 경우에 그와 연관된 관계선의 위치 정리	
	 for(var i=0; i<arr_line_To.length; i++){
		var seconndEntityId = arr_line_To[i].attrs.lastPos //그 선 객체에서 pos에 숨어있는 2번쨰 객체의 참조값을 가져온다.
		second_Entity = findEntity(findEntityArr,seconndEntityId); // 선객체에 있는 참조값을 가지고 있는 entity를 찾는 메서드
		arr_second_Entity.push(second_Entity);
		
		//updLinePosition를 이용해서 entity에 위치에 맞게 라인들의 위치를 재조정한다.(단 선들이 겹쳐있음) -1)
		updLinePosition(first_Entity,second_Entity,arr_line_To[i]);
		arr_line_To[i].show();
		
	if(i == arr_line_To.length - 1 ){
		//마지막에 -1)에서 겹쳐져 있는 선들의 위치를 겹쳐져있지 않게 재조정 한다.
		deduplicationLine(first_Entity,second_Entity);  
	}	
	 }
	 
	
 	//내가 클릭한 entity (first_Entity)가 관계선의 도착점(From) 일 경우에 그와 연관된 관계선의 위치 정리
	 //관계선(line)에서 pos값에 클릭한 객체의 아이디가 있는 라인객체배열을 가져와야함
	 var arr_line_From = findLineRefPos(first_Entity.id());
	
	 for(var i=0; i<arr_line_From.length; i++){
		var seconndEntityId = arr_line_From[i].attrs.name//그 선 객체에서 name에 숨어있는객체 가져온다.
		seconndEntityId = parseInt(seconndEntityId); //문자열로 리턴되기때문에 정수로 변환한다.
		second_Entity = findEntity(findEntityArr, seconndEntityId);  // 선객체에 있는 참조값을 가지고 있는 entity를 찾는 메서드
		arr_second_Entity.push(second_Entity)
		
		//updLinePosition를 이용해서 entity에 위치에 맞게 라인들의 위치를 재조정한다.(단 선들이 겹쳐있음) -1)
		updLinePosition(second_Entity,first_Entity,arr_line_From[i]); //두번쨰로 가져온 객체가 시작점이므로 매개변수의 순서를 조심하자!
		arr_line_From[i].show();
		
		if(i == arr_line_From.length - 1 ){
			//마지막에 -1)에서 겹쳐져 있는 선들의 위치를 겹쳐져있지 않게 재조정 한다.
    		deduplicationLine(first_Entity,second_Entity);
    	}	
	 } 
	 
	 //객체가 이동하면 객체가 이동하기 전에 있던 선들도 재조정해줘야 하기 때문에 객체가 있었던 위치에 선들을 재조정해주는 메서드
	 for(var i = 0; i<arr_second_Entity.length; i++){
		 if(arr_second_Entity[i] != undefined && flag){
			 entityMouseUp(arr_second_Entity[i],false);
			 }
	 }
	
		relationLine_layer.draw();
	
}
var id=1230;

//선 연결의 종류를 확인한 뒤, 타입에 맞게 컬럼을 생성해주는 메서드
//type = true : identifying , false: non-identifying
function moveColumnIdentifying(type,line_id){
	console.log('line.id():'+line_id);
	var identifyType;
	if(type == true){
		identifyType = 'fk_group';
	}
	else{
		identifyType = 'attr_group';
	}
	
	var pk=firstEntity.findOne('.pk_group').children;
	var arr_identify = checkIdentify();
	var arr_total  = new Array();
	
//	pk.sort(function (a,b){ //차례대로 복사하기위해서 정렬
//		return a.attrs.id<b.attrs.id?-1 : a.attrs.id>b.attrs.id?1:0;   //현재 이 배열에는 내가 선택한 곳에 포함되는 객체들이 모두 들어있다.
//	});
	
	arr_identify.sort(function (a,b){
		return a.attrs.id<b.attrs.id?-1 : a.attrs.id>b.attrs.id?1:0;   //현재 이 배열에는 내가 선택한 곳에 포함되는 객체들이 모두 들어있다.
	});
	
	//원본 배열에 피해를 주지않기 위해서 임의 변수를 만들어서 옮긴다. (pk  / fk 순서도 보존해야 하기 때문에)
	for(var i= 0; i<pk.length; i++){
		arr_total.push(pk[i]);
	}
	
	arr_total.sort(function (a,b){ //차례대로 복사하기위해서 정렬
		return a.attrs.id<b.attrs.id?-1 : a.attrs.id>b.attrs.id?1:0;   //현재 이 배열에는 내가 선택한 곳에 포함되는 객체들이 모두 들어있다.
	});
	
	var arr_temp = new Array();
	
	for(var i= 0; i<arr_identify.length; i++){
		arr_temp.push(arr_identify[i]);
	}
	
	arr_temp.sort(function (a,b){ //차례대로 복사하기위해서 정렬
		return a.attrs.id<b.attrs.id?-1 : a.attrs.id>b.attrs.id?1:0;   //현재 이 배열에는 내가 선택한 곳에 포함되는 객체들이 모두 들어있다.
	});
	
	for(var i= 0; i<arr_temp.length; i++){
		arr_total.push(arr_temp[i]);
	}
	
	
	
	
	var secondEntityIdx = secondEntity.findOne('.'+identifyType).children.length; //second 객체에 이전에 만든 fk가 존재할 수도 있기 때문에
	
	for(var i =0; i<arr_total.length; i++){  //첫번째에 클릭한 pk의 길이만큼 반복
	//fk 추가
	fn_attributeAdd(identifyType,secondEntity); //fk 생성
	
	//위에서 추가한 fk
	var fk = secondEntity.findOne('.'+identifyType).children[secondEntityIdx]; //second 객체에 이전에 만든 fk가 존재할 수도 있기 때문에 위에서 추가한 fk의 index를 알기위해서
	secondEntityIdx++;
	
	//pk 값 fk로 복사
	copyColumnText(arr_total[i],fk,line_id,type);
	  entity_resize();
	}
	layer.draw();
	
}

//type: true = identifying   false = non-identifying
function copyColumnText(pk,fk,line_id,type){
	var columnText;
	console.log('line.id():'+line_id);
	for(var i = 1; i<8; i++ ){
		 columnText = pk.find('.attr_groups')[i].children[2].text();
		fk.find('.attr_groups')[i].children[2].text(columnText);
	}
	if(type){ //식별관계 일 때
		fk.id(get_numId()); // fk에도 id값을 부여해준다.
		fk.attrs.type = 'identify'
	}
	else{
		fk.attrs.type = 'non-identify'
	}

	
	fk.attrs.pkId = pk.attrs.id;
	if(pk.attrs.pkId != undefined){ //pkId가 존재할 때 => 즉 외래키 일 때
		fk.attrs.pkId = pk.attrs.pkId;
	}
	fk.attrs.lineId = line_id;
	console.log('fk.attrs.lineId '+  fk.attrs.lineId); //fk 일 경우 fk에  관계선의 id를 넣어준다.
}


//fk중에 identifying 속성이 있는 지 확인하는 메서드
function checkIdentify(){
	var arr = firstEntity.findOne('.fk_group').children;
	var arr_identify = new Array();
	for(var i=0; i<arr.length; i++){
		if(arr[i].attrs.type == 'identify'){
			arr_identify.push(arr[i]);
		}
	}
	return arr_identify;
}

function checkIdentify_1(tempEntity){
	var arr = tempEntity.findOne('.fk_group').children;
	var arr_identify = new Array();
	for(var i=0; i<arr.length; i++){
		if(arr[i].attrs.type == 'identify'){
			arr_identify.push(arr[i]);
		}
	}
	return arr_identify;
}


//추가 버튼을 눌렀을 때, 해당객체를 참조하는 자식 테이블에도 모두 추가하는 메서드 (재귀호출방식)
function cascadeAddFk(firstEntity,pkId,findEntityArr,pre_identifyingFlag,arr_addTableName){
	
	 //firstEntity = e.target.findAncestor('.entity');
     var arr_line_To= relationLine_layer.find('.'+firstEntity.id());
     
     //관계선이 존재할 경우에만 로직실행
     if(arr_line_To.length != 0){
      	 var fk;
      	 var flag;
         //배열에 id값을 추출 
         for(var i =0; i<arr_line_To.length; i++){
         	 var relationLineId = arr_line_To[i].attrs.id; //관계선 객체의 id
         			console.log('relationLineId'+ relationLineId);
         	 
         	var seconndEntityId = arr_line_To[i].attrs.lastPos //그 선 객체에서 pos에 숨어있는 2번쨰 객체의 참조값을 가져온다.
     		secondEntity = findEntity(findEntityArr,seconndEntityId); // 선객체에 있는 참조값을 가지고 있는 entity를 찾는 메서드
     		
     		if(arr_line_To[i].attrs.dash==undefined){ //식별관계(실선) 
     			if(!pre_identifyingFlag){ //이전엔티티가 비식별일 경우엔 속성이 추가되지 않는다.
     				continue;
     			}
     			fn_attributeAdd('fk_group',secondEntity);
     			fk = secondEntity.findOne('.fk_group').children[secondEntity.findOne('.fk_group').children.length-1]; //위에서 추가한 second속성을 가져옴
     			fk.id(get_numId()); // fk에도 id값을 부여해준다.
     			fk.attrs.type = 'identify';
     			flag = true;
     		}
     		else if(arr_line_To[i].attrs.dash.length>0){//비식별관계(점선)
     			if(!pre_identifyingFlag){ //이전엔티티가 비식별일 경우엔 속성이 추가되지 않는다
     				continue;
     			}
     			 fn_attributeAdd("attr_group",secondEntity);
     			 fk = secondEntity.findOne('.attr_group').children[secondEntity.findOne('.attr_group').children.length-1]; //위에서 추가한 second속성을 가져옴
     			 fk.attrs.type = 'non-identify';
     			flag = false;
     				 
     		}
     		
     			fk.attrs.lineId= relationLineId;
     			fk.attrs.pkId = pkId;
     			clickSecond(secondEntity); //second객체 클릭 효과
            	entity_resize();
            	arr_addTableName.push(secondEntity.children[5].attrs.text);
            	
            	firstEntity = secondEntity;
  			cascadeAddFk(firstEntity,pkId,findEntityArr,flag,arr_addTableName);  //재귀호출 
        		 }
     } 
   
     else return;
	
}


function cascadeDeletePk(entityId,arr_EntityAboutremoveCol,arr_removeTableName){
	 var arr_line_To= relationLine_layer.find('.'+firstEntity.id());

//	 var total_arr = arr_line_To.concat(arr_line_From);

	 
	 if(arr_line_To.length != 0){
        //배열에 id값을 추출 
        for(var i =arr_line_To.length-1; i>-1; i--){
        	 var relationLineId = arr_line_To[i].attrs.id; //관계선 객체의 id
        	 
        	 var seconndEntityId = arr_line_To[i].attrs.lastPos; //그 선 객체에서 pos에 숨어있는 2번쨰 객체의 참조값을 가져온다.
        	 secondEntity = findEntity(findEntityArr,seconndEntityId); // 선객체에 있는 참조값을 가지고 있는 entity를 찾는 메서드
        	 var delCnt = 0;

        	 var temp_tableName = "";
  			 for(var j=secondEntity.find('.attribute').length-1; j>-1; j--){
  				 if(secondEntity.find('.attribute')[j].attrs.pkId == entityId){
  					temp_tableName = secondEntity.children[5].attrs.text;
   					secondEntity.find('.attribute')[j].destroy();
   					
   					arr_EntityAboutremoveCol.push(secondEntity);  //삭제에 영향을 받은 entity를 알아야 하기 때문에 배열에 담는다.
   				 }
  			 }
  			 
  			arr_removeTableName.push(temp_tableName);
  			 
  	      	clickSecond(secondEntity); //second객체 클릭 효과
  	    	entity_resize();
  	    	firstEntity = secondEntity;
  			cascadeDeletePk(entityId,arr_EntityAboutremoveCol,arr_removeTableName);
       } 
        
	}
	 else return;
}

	//관계선을 참조하는 속성이 있는  지 판별해서 없을 시, 삭제시켜주는 메서드
function deleteRelationLine(arr_EntityAboutremoveCol){
	
		for(var i=arr_EntityAboutremoveCol.length-1; i>-1; i-- ){
			var arr_line_From = findLineRefPos(arr_EntityAboutremoveCol[i].id()); //삭제에 영향을 받은 entity의 from 배열을 찾음
				for(var j =arr_line_From.length-1; j>-1; j-- ){
						var relationId = arr_line_From[j].attrs.id;
						var delCnt = 0;						
						if(arr_EntityAboutremoveCol[i].find('.attribute').length == 0){ //속성이 존재하지 않을 경우에 무조건 관계를 삭제해야한다.
						}
						else{
						for(var k=arr_EntityAboutremoveCol[i].find('.attribute').length-1; k>-1; k--){  //속성의 개수만큼 for문을 돌면서 해당 라인을 참조하는 객체의 카운트를 구한다.
							if(arr_EntityAboutremoveCol[i].find('.attribute')[k].attrs.lineId==relationId){
								delCnt++;
								//break;
							}
						}
						}
						if(delCnt==0){ //해당 라인을 참조하는 객체가 존재하지 않으면 라인을 삭제한다.
							arr_line_From[j].destroy();
						}
					
				}
			
	}
	relationLine_layer.draw();
}

function firstEntityhighlight(tempEntity){
	//tempEntity
	var arr_tempEntity =  tempEntity.find('.pk_group')[0].children;
	var arr_tempPK = checkIdentify_1(tempEntity);
	
	
	 var total_arr = $.merge( $.merge([],arr_tempEntity), arr_tempPK);
	 //var total_arr = $.merge(arr_tempEntity, arr_tempPK);
	 
	 firstStrokeColor = total_arr[0].findOne('.attr_container').fill();
	for(var i =0; i<total_arr.length; i++){
		//console.log('for문 시작');
		var temp_attribute = total_arr[i]; 
		//console.log('temp_attribute'+ temp_attribute.attrs.id);
		highlighting(temp_attribute);
	}
	
//	temp_clickEntity.push(clickTarget(tempEntity));
	temp_clickEntity[0] = tempEntity;
}
function secondEntityhighlight(lineId,tempEntity){
	secondStrokeColor = tempEntity.find('.attribute')[0].findOne('.attr_container').fill();
	
for(var i=0; i<tempEntity.find('.attribute').length; i++){
	if(tempEntity.find('.attribute')[i].attrs.lineId == lineId){
		console.log('for문 시작');
		console.log('temp_attribute'+ tempEntity.find('.attribute')[i].attrs.id);
		highlighting(tempEntity.find('.attribute')[i]);
		}
	}		
temp_clickEntity[1] = tempEntity;
}


function highlighting(attribute){
 var total_attribute_length = attribute.children.length-1;
//attribute.zIndex(attribute.parent.children.length-1);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
attribute.parent.zIndex(total_attribute_length);      
  
attribute.findOne('.attr_container').fill('#ff0000');
      
      //선택속성 투명도
	attribute.findOne('.attr_container').opacity(0.6);
	attribute.findOne('.attr_background').opacity(0.6);

	
     //속성 버튼 설정
	attr_btn_remove = attribute.findOne('.attr_btn_remove');
    attr_btn_remove_t =attribute.findOne('.attr_btn_remove_t'); 
    attr_btn_remove.x(attribute.findOne('.attr_container').width()-BORDER_SIZE); //entity.findOne('.entity_container').width()-BORDER_SIZ 뭐가맞을까?
    attr_btn_remove_t.x(attr_btn_remove.x()+7);
	 
	 
     attribute.findOne('.attr_btn_group').visible(true);
    attribute.find('.attr_btn_group')[0].attrs.visible =false;
	//attr_btn_remove = attribute.findOne('.attr_btn_remove').visible(false);
    //attr_btn_remove_t =attribute.findOne('.attr_btn_remove_t').visible(false); 
}

function clickTarget(entity){

	
    //속성 버튼 초기화
	entity.find('.attr_btn_group').visible(false);
    //선택속성 투명도 초기화시키기
	entity.find('.attr_container').opacity(1);
	entity.find('.attr_background').opacity(1);
    

	
	
//	entity.findOne('.attr_container').opacity(1.0);
//	entity.findOne('.attr_background').opacity(1.0);	
//	attribute.findOne('.attr_container').fill('#ffffff');
//	 attribute.findOne('.attr_btn_group').visible(false); 
//       old_btn_entity_group.hide();
//       old_entity.draggable(false);
//       old_container.strokeWidth(0);
}