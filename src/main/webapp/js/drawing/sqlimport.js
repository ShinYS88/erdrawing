6//ERD로 변환하기 전, sql이 create,alter.drop인지 판별하고 해당 메서드로 보내준다.



function drawERD(arr_query){
	for(var i = 0; i<arr_query.length-1; i++ ){ //마지막 방은 비어있으므로 -1로 빼준다.
		arr_query[i] = arr_query[i].trim();
		if(arr_query[i].toUpperCase().startsWith('CREATE')){
			console.log('create');
			drawCreateTable(arr_query[i]);
		}
		else if(arr_query[i].toUpperCase().startsWith('COMMENT')){
			console.log('comment');
			drawCreateComment(arr_query[i]);
		}
		else if(arr_query[i].toUpperCase().startsWith('ALTER')){
			console.log('alter');
			drawAlterTable(arr_query[i]);
		}
		else{
			console.log("****예외*****");
		}
	}
}

//생성 쿼리를 그려주는 메서드
function drawCreateTable(arr_query){
	
	 var pattern = /[^\w'"()\s,_]/g; //이상한 다른 특수문자가 있을 때,
		if(pattern.test(arr_query)){
			alert('잘못된 Query가 입력되었습니다.');
			return;
		}
	
	 pattern = /['|"]?[\w]*['|"]?(?=[\s]*\()/g; //테이블 네임을 찾는 정규식
	 regExec = pattern.exec(arr_query);
	 var tableName = regExec[0];
	 
	 
	 var quartationPattern = /['"]/g; //"'를 찾는 정규식
	 tableName = tableName.replace(quartationPattern,""); //'" 제거
	 
	 var plusX = 400;
	 var plusY = 200;
	 //위치조정
	 if(sqlimportX%(plusX*5) == 0 &&  sqlimportX != 0){ 
		 sqlimportX = -400;
		 sqlimportY += plusY;
	 }
	 sqlimportX += plusX;
	 
	
	 
	 var circlePos = new Object();
	 circlePos.x = sqlimportX;
	 
	
	 circlePos.y =sqlimportY;
	 
	 entityAdd(circlePos); //테이블 생성
	 
	 textNode = entity.findOne('.entity_phisical_txt');
	 
	 enterK2(tableName);
   
	 
	 //속성을 단위에 맞게 분리해주는 정규표현식 ( 한 줄 한줄로 나눠준다.)
	 pattern = /([\w\d"']*)[\s]*((?:varchar2|varchar|number|date|int)[\(\d\)]*)(?:\s*DEFAULT([\s]*[\w\d']*)?)?[\s]*(NULL|NOT NULL)/gi;
	 
	 
	 //위에서 나눠진 속성을 컬럼에 맞게 나눠주는 정규표현식
	 var pattern_capture = /([\w\d"']*)[\s]*((?:varchar2|varchar|number|date|int)[\(\d\)]*)(?:\s*DEFAULT([\s]*[\w\d']*)?)?[\s]*(NULL|NOT NULL)/i;  

	 
	 var regColumnsQuery= arr_query.match(pattern);
	 var arr_attribute;
	 
	 for(var i=0; i<regColumnsQuery.length; i++){
		 regColumnsQuery[i] = regColumnsQuery[i].replace(quartationPattern,""); //'" 제거
		  arr_attribute  = regColumnsQuery[i].match(pattern_capture);
		 console.log('entity' +  entity );
		 arr_attribute[0] ='Field';
		 
		 fn_attributeAddforDrawing("attr_group",entity,arr_attribute,null);
		 console.log('arr_attribute' +  arr_attribute);
	 }
	 
	 clickSecond(entity); //second객체 클릭 효과
 	 entity_resize();
     mini_layer.draw(); 
     layer.draw();
	 
	 //각각의 index를 다시 패턴에 적용
	 //columnsQuery = columnsQuery.split(',');
	 
	 

		 
		 
	// pattern = /(NOT\sNULL|DEFAULT\s[\w]+|([\w]+\([1-9]+\))|[a-zA-Z0-9'"]+)/gi; //NOT NULL 이거나 DEFAULT 이거나 문자로 시작하는 문자열을 찾는 정규식
	// 속성 추출
	
}

//수정 쿼리를 그려주는 메서드
function drawAlterTable(arr_query){
	var pk_pattern = /\s+"(\w*)"\s+ADD\sCONSTRAINT\s+"\w*"\s+PRIMARY\s+KEY/i;
	var fk_pattern = /\s+"(\w*)"\s+ADD\sCONSTRAINT\s+"\w*"\s+FOREIGN\s+KEY/i; 
	
	if(pk_pattern.test(arr_query)){ //PK일 때
		drawAlterTablePk(arr_query,pk_pattern);
	}
	
	else if(fk_pattern.test(arr_query)){ //FK 일 때
		drawAlterTableFk(arr_query,fk_pattern);
	}
	
}

function drawAlterTablePk(arr_query,pk_pattern){ //pk로 alter해주는 메서드 
	var tableName = arr_query.match(pk_pattern);

	 var table = searchTable(tableName[1]); //테이블을 찾음
	 
	
	 //key값만 추출
	 var exceptDDL = arr_query.split('(');
	 
	 var quartationPattern = /['"\s)]/g; //"'를 찾는 정규식
	 exceptDDL[1] = exceptDDL[1].replace(quartationPattern,""); //'" 제거
	 
	 var arr_keys = exceptDDL[1].split(',');
	 
	 var arr_attrs =table.find('.attribute');
	 for(var i = 0; i<arr_keys.length; i++){
		 changeAttrToPk(arr_attrs,arr_keys[i],table);
	 }
	 entity = table;
	 entity_resize();
}

function drawAlterTableFk(arr_query,fk_pattern){ //외래키 관계를 맺어주는 메서드
	var tableName = arr_query.match(fk_pattern);
	
	var sub_Entity = searchTable(tableName[1]); //테이블을 찾음 //참조를 받는 테이블
	 
	var pattern = /REFERENCES\s*"(\w*)"/i;
	  tableName = arr_query.match(pattern);
	 
	var super_Entity = searchTable(tableName[1]); //참조테이블
	
	pattern = /\(\s*"(\w+)"/gi;
	var arr_keys =arr_query.match(pattern);
	
	 var quartationPattern = /['"\s)(]/g; //"'를 찾는 정규식
	
	
	 for(var i =0; i<arr_keys.length; i++){
		 arr_keys[i] = arr_keys[i].replace(quartationPattern,""); //'" 제거
	 }
	 arr_keys[0]; //참조하는 어트리뷰트(sub)
	 arr_keys[1]; //참조되는 어트리뷰트(super)
	 
	 var pk_id;
	 var lineId;
	 //부모Entity의 참조할 키를 찾는다.
	 var arr_superEntityAttr =super_Entity.find('.attribute');
	 for(var i =arr_superEntityAttr.length-1; i>-1; i--){
		 if(arr_superEntityAttr[i].findOne('.attr_phisical_txt').attrs.text ==  arr_keys[1]){
			 console.log("속성찾음!");
			 firstEntity = super_Entity;
			 secondEntity = sub_Entity;
			 lineId = selectSameEntity(); //super_Enity sub_Entity를 참조하는 라인 아이디를 얻어온다.
			 cardinality='multi';
			 
			 if(arr_superEntityAttr[i].findOne('.attr_phisical_txt').parent.parent.attrs.type == undefined){ //PK일 때
			 pk_id = arr_superEntityAttr[i].findOne('.attr_phisical_txt').parent.parent.attrs.id
			 }
			 else if(arr_superEntityAttr[i].findOne('.attr_phisical_txt').parent.parent.attrs.type == 'identify'){ //FK일 떄
			 pk_id = arr_superEntityAttr[i].findOne('.attr_phisical_txt').parent.parent.attrs.pkId;
			 //relationType=true;
			 }
			 else if(arr_superEntityAttr[i].findOne('.attr_phisical_txt').parent.parent.attrs.type == 'non-identify'){
			 pk_id = arr_superEntityAttr[i].findOne('.attr_phisical_txt').parent.parent.attrs.pkId;	 
			 //relationType=false;
			 }
		 }
	 }
	 
	 var flag; //선을 생성해야 하는 지 존재하는 지 구분해주는 flag
	 if(lineId == null){ //기존의 연결되어있는 관계선이 없는 경우
		 flag = true; //선을 생성해야한다.
		 //compareEntityPosition(false); //관계선을 생성한다.
		 lineId = numId+2;  //numId => 관계선 아이디  관계선을 뒤에서 만들기 떄문에 여기서  +2을 해준다.
	 	}
	 	
	 //이쯤에서 라인을 나눈다. 
	 
	 
	 
	//자식Entity의 참조할 키를 찾는다.
	 var arr_subEntityAttr =sub_Entity.find('.attribute');
	 for(var i =arr_subEntityAttr.length-1; i>-1; i-- ){
			if(arr_subEntityAttr[i].findOne('.attr_phisical_txt').attrs.text == arr_keys[0]){
				console.log("속성찾음!");
				//arr_subEntityAttr[i].findOne('.attr_phisical_txt').parent.parent.attrs.type;
				var secondEntityIdx;
				var fk;
				var arr_attribute = new Array();
				arr_attribute.push(arr_subEntityAttr[i].findOne('.attr_phisical_txt').parent.parent.children[3].children[2].attrs.text); //논리키key
				arr_attribute.push(arr_subEntityAttr[i].findOne('.attr_phisical_txt').parent.parent.children[4].children[2].attrs.text); //물리키key
				arr_attribute.push(arr_subEntityAttr[i].findOne('.attr_phisical_txt').parent.parent.children[6].children[2].attrs.text); //Type
				arr_attribute.push(arr_subEntityAttr[i].findOne('.attr_phisical_txt').parent.parent.children[8].children[2].attrs.text); //Default
				arr_attribute.push(arr_subEntityAttr[i].findOne('.attr_phisical_txt').parent.parent.children[7].children[2].attrs.text); //Null
				arr_attribute.push(arr_subEntityAttr[i].findOne('.attr_phisical_txt').parent.parent.children[9].children[2].attrs.text); //Comment
				
				
				if(arr_subEntityAttr[i].findOne('.attr_phisical_txt').parent.parent.parent.hasName('pk_group')){ //식별관계일 때
					secondEntityIdx = secondEntity.findOne('.fk_group').children.length; //second 객체에 이전에 만든 fk가 존재할 수도 있기 때문에
					fn_attributeAddforDrawing('fk_group',sub_Entity,arr_attribute,pk_id);
					fk = secondEntity.findOne('.fk_group').children[secondEntityIdx];
					fk.id(get_numId()); // fk에도 id값을 부여해준다.
					fk.attrs.type = 'identify'
					relationType=true;
				}
				else{ // 비식별관계일 때
					secondEntityIdx = secondEntity.findOne('.attr_group').children.length; //second 객체에 이전에 만든 fk가 존재할 수도 있기 때문에
					fn_attributeAddforDrawing('attr_group',sub_Entity,arr_attribute,pk_id);
					fk = secondEntity.findOne('.attr_group').children[secondEntityIdx];
					fk.id(get_numId()); // fk에도 id값을 부여해준다.
					fk.attrs.type = 'non-identify'
					relationType=false;
				}
				
				fk.attrs.pkId = pk_id;
				fk.attrs.lineId = lineId;
				arr_subEntityAttr[i].findOne('.attr_phisical_txt').parent.parent.destroy();			
				
				entity = sub_Entity;
				entity_resize();
				 break;
//				firstEntity  = super_Entity;
//				secondEntity = sub_Entity;
			} 
	 }
	 if(flag){
		 console.log("관계선 생성 ==============");
		 compareEntityPosition(false); 
	 }
}

function drawCreateComment(arr_query){ //주석을 만들어주는 메서드 
	var pattern = /(?=\s)*"([\w]*)"."([\w]*)"\s+IS\s+'([\w]*)'/i;
	
	arr_commentInfo = arr_query.match(pattern);
	
	 var table = searchTable(arr_commentInfo[1]);
	 var arr_attrs =table.find('.attribute');
	 searchAttr(arr_attrs,arr_commentInfo);
}


function searchTable(tableName){
	var arr_entity=layer.children;
	for(var i = 0; i<arr_entity.length; i++){
		if(layer.children[i].children[5].attrs.text ==tableName){
			console.log('테이블발견');
			return layer.children[i];
			}
		}
	}

function changeAttrToPk(arr_attrs,key,table){
	for(var j =arr_attrs.length-1; j>-1; j--){
	
		if(arr_attrs[j].findOne('.attr_phisical_txt').text() === key){
			console.log("속성찾음!");
			arr_attrs[j].findOne('.attr_phisical_txt').parent.parent;
			var arr_attribute = new Array();
			arr_attribute.push('Key'+cntKey_param(table)); //논리키key
			arr_attribute.push(arr_attrs[j].findOne('.attr_phisical_txt').parent.parent.children[4].children[2].attrs.text); //key
			arr_attribute.push(arr_attrs[j].findOne('.attr_phisical_txt').parent.parent.children[6].children[2].attrs.text); //Type
			arr_attribute.push(arr_attrs[j].findOne('.attr_phisical_txt').parent.parent.children[8].children[2].attrs.text); //Default
			arr_attribute.push(arr_attrs[j].findOne('.attr_phisical_txt').parent.parent.children[7].children[2].attrs.text); //Null
			arr_attribute.push(arr_attrs[j].findOne('.attr_phisical_txt').parent.parent.children[9].children[2].attrs.text); //Comment
			
			fn_attributeAddforDrawing('pk_group',table,arr_attribute,null);
			arr_attrs[j].findOne('.attr_phisical_txt').parent.parent.destroy();			
			
			return;
			} 
	}
}
function searchAttr(arr_attrs,arr_commentInfo){
	for(var j =0; j<arr_attrs.length; j++){
		console.log('속성발견');
		if(arr_attrs[j].findOne('.attr_phisical_txt').attrs.text == arr_commentInfo[2]){
			console.log('comment변경')
			arr_attrs[j].findOne('.attr_comment_txt').parent.findOne('.placeHolder').attrs.visible = false; //placehoder 가리기
			arr_attrs[j].findOne('.attr_comment_txt').attrs.text = arr_commentInfo[3];
			return;
		} 
	}
}


function enterK2(tableName){
       //텍스트 입력 값 적용
        textNode.text(tableName);

        //텍스트 미입력시 최소값 설정
        if(textNode.width() < 40){
            textNode.textWidth = 30;
        }
        
        
        //플레이스홀더 설정
        if(textNode.findAncestor('.attr_groups') != null){
           if(textNode.text() === "" && textNode.findAncestor('.attr_groups').findOne('.placeHolder') != null ){
                textNode.findAncestor('.attr_groups').findOne('.placeHolder').visible(true);
            }else if(textNode.findAncestor('.attr_groups').findOne('.placeHolder') != null){
                textNode.findAncestor('.attr_groups').findOne('.placeHolder').visible(false);
            } 
        }
           
       //변수에 클릭 타겟 넣기
       //entity = allNode.findAncestor('.entity');

       entity_container = entity.findOne('.entity_container');
       entity_logical = entity.findOne('.entity_logical');
       entity_phisical = entity.findOne('.entity_phisical');
       entity_logical_txt = entity.findOne('.entity_logical_txt');
       entity_phisical_txt = entity.findOne('.entity_phisical_txt');
       
       btn_entity_group = entity.findOne('.btn_entity_group');
       
       btn_entity_delete = btn_entity_group.findOne('.btn_entity_delete');
       btn_entity_delete_txt = btn_entity_group.findOne('.btn_entity_delete_txt');
       
       btn_color = btn_entity_group.findOne('.btn_color');
       btn_color_txt = btn_entity_group.findOne('.btn_color_txt');
       
       btn_pk_add = btn_entity_group.findOne('.btn_pk_add');
       btn_pk_add_txt = btn_entity_group.findOne('.btn_pk_add_txt');
       
       btn_col_add = btn_entity_group.findOne('.btn_col_add');
       btn_col_add_txt = btn_entity_group.findOne('.btn_col_add_txt');
        
       //리사이징 시작
       entity_resize();
        
       //미니맵에 객체 갱신
        var mini_entity = mini_stage.find('#'+entity.id()+'');
        mini_entity.width(entity.children[0].width()*0.048);
        mini_entity.height(entity.children[0].height()*0.048);
        
        mini_layer.draw(); 
        layer.draw();
        
      // document.body.removeChild(inputss);
       //this.removeEventListener('keydown',arguments.callee);
       console.log("엔터입력 완료");
}

function selectSameEntity(){
		for(var i = 0 ; i<relationLine_layer.children.length; i++){
			if(relationLine_layer.children[i].attrs.name ==firstEntity.attrs.id && relationLine_layer.children[i].attrs.lastPos ==secondEntity.attrs.id){
				return relationLine_layer.children[i].attrs.id;
				break;
			}
		}
	
}



