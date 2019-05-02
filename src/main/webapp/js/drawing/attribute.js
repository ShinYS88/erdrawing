
//    1. 변수 선언 및 초기화
    var attributeGroup, attribute, attr_container;
    var attr_btn_group, attr_btn_remove, attr_btn_remove_t, attr_btn_move, attr_btn_move_t;


    var widthTotal;
    var attrKey, key_name;

    var containerColor, backgroundColor, fontColor, placeHolderColor;


    // ===================================================================
    // attribute(row)추가 function - ShinYS
    // select_group : pk_group . fk_group . attr_group
    // entity : entity node
    // circlePos : 사용 보류
    function fn_attributeAdd(select_group, entity, circlePos){
        
        //컨트롤 할 그룹 설정
        attributeGroup = entity.findOne("."+select_group);
        
        //entity 색상코드 가져오기
        //var color1_num = entity.attrs.class;
        var color1_num = entity.findOne('.giveColor').text();

        //속성 자손 개수 찾기
        var attrLength = attributeGroup.children.length;
        
        //속성 위치값 구하기
        var attrPosition = 23*attrLength;
        

        switch(select_group){
            case "pk_group":
                attrKey = "PrimaryKey";
                nullDefault = "NOT NULL";
                key_name = "Key" + cntKey();
                containerColor = colorPick[color1_num].groupColor;
                backgroundColor = colorPick[color1_num].pkBg;
                fontColor = colorPick[color1_num].pkColor;
                placeHolderColor = colorPick[color1_num].pkPlaceHolder
                break;
                
            case "fk_group":
                attrKey = "ForeignKey";
                nullDefault = "NOT NULL";
                key_name = "FKname";
                containerColor = colorPick[color1_num].groupColor;
                backgroundColor = colorPick[color1_num].fkBg;
                fontColor = colorPick[color1_num].fkColor;
                placeHolderColor = colorPick[color1_num].fkPlaceHolder
                break;
                
            case "attr_group":
                attrKey = "Attribute";
                nullDefault = "NULL";
                key_name = "Field" + cntField();
                containerColor = colorPick[color1_num].groupColor;
                backgroundColor = colorPick[color1_num].atBg;
                fontColor = colorPick[color1_num].atColor;
                placeHolderColor = colorPick[color1_num].atPlaceHolder
                break;
                
        }
        
        //속성 row
        attribute = new Konva.Group({
            x: BORDER_SIZE,
            y: attrPosition,
            name: 'attribute'
        });
        
        if(select_group =='pk_group'){
        	attribute.id(get_numId()); 
        }
        


//      속성 전체 박스
        attr_container = new Konva.Rect({
            x: 0,
            y: 0,
            width: 508,
            height: 26,
            fill: containerColor,
            name: 'attr_container'
        });

      

        //속성 종류 설정
        // key . 논리 . 물리 . 도메인 . 타입
        
        attr_groups = new Konva.Group({
            x: BORDER_SIZE,
            y: BORDER_SIZE,
            name: 'attr_groups'
        });
        
        
        //key
        attr_key = new Konva.Rect({
            x: 0,
            y: 0,
            width: 98,
            height: 20,
            fill: backgroundColor,
            //stroke: 'red',
            name: 'attr_background attr_key'
        });
        
        attr_key_txt = new Konva.Text({
            text: attrKey,
            x: attr_key.x(),
            y: attr_key.y(),
            padding: 5,
            fill: fontColor,
            fontSize: 11,
            name: 'setAttrsText attr_key_txt'
        });
        

        
        
        
        //      객체 등록
        attributeGroup.add(attribute);
        attribute.add(attr_container);
        attribute.add(attr_groups);
        
        attr_groups.add(attr_key).add(attr_key_txt);
        
        
        
        
        //============= 그룹추가 ===============
        
        attr_btn_group = new Konva.Group({
            name: 'attr_btn_group',
            y:BORDER_SIZE,
            visible:false
//            ,
//            draggable: true,
//            dragBoundFunc: function(pos) {
//              return {
//                x: this.absolutePosition().x,
//                y: pos.y
//              };
//            }
        });
        
        attr_btn_move = new Konva.Rect({
            name: 'attr_btn_move',
            x:-20-BORDER_SIZE,
            width: 20,
            height: 20,
            cornerRadius: 5,
            strokeWidth: 1,
            stroke: '#ffffff',
            fill: '#0EB6FF'
        });
        
        attr_btn_move_t = new Konva.Text({
            name: 'attr_btn_move_t',
            x: attr_btn_move.x()+2.1,
            y: attr_btn_move.y()+2.3,
            fill: '#ffffff',
            fontSize: 18,
            text: '▦'
        });
        
        attr_btn_remove = new Konva.Rect({
            name: 'attr_btn_remove',
            x:30,
            width: 20,
            height: 20,
            cornerRadius: 5,
            strokeWidth: 1,
            stroke: '#ffffff',
            fill: '#4335af'
        });
        
        attr_btn_remove_t = new Konva.Text({
            name: 'attr_btn_remove_t',
            x: attr_btn_remove.x()+7,
            y: attr_btn_remove.y()+3.5,
            fill: '#ffffff',
            fontSize: 12,
            text: 'x'
        });
        
        attr_btn_group.add(attr_btn_move).add(attr_btn_move_t);
        attr_btn_group.add(attr_btn_remove).add(attr_btn_remove_t);
        attribute.add(attr_btn_group);
        
        
        
        
        
        
        
        //Key_논리
        var attr_logical = fn_setAttr(attr_groups, "attr_logical", key_name, "key_논리");
        
        //Key_물리
        var attr_phisical = fn_setAttr(attr_logical, "attr_phisical", key_name, "key_물리");
        
        //Domain
        var attr_domain = fn_setAttr(attr_phisical, "attr_domain", "", "Domain");
        
        //Type
        var attr_type = fn_setAttr(attr_domain, "attr_type", "", "Type");
        
        //NOT NULL (select box)
        var attr_null = fn_setAttr(attr_type, "attr_null", nullDefault, "none");
        
        //Default value
        var attr_default = fn_setAttr(attr_null, "attr_default", "", "Default value");
        
        //Comment
        var attr_comment = fn_setAttr(attr_default, "attr_comment", "", "Comment");
        
        
        
        
        
        
        
        
        
        //===================================================================
        //리사이징
        
        //entity_resize();
        

    }
    //entity 생성 종료

    //쿼리입력 시, ERD를 그릴 때, 쿼리에서 추출한 속성을 가지고, 컬럼을 만들 때 (생성자) //YHS
function fn_attributeAddforDrawing(select_group,entity,arr_attribute,pk_id){
		console.log(arr_attribute);
		var logic_key = arr_attribute[0];
		var key = arr_attribute[1];
		var dataType = arr_attribute[2];
		var defaultValue = arr_attribute[3];
		console.log("defaultValue"+ defaultValue);
		var nullable = arr_attribute[4];
		console.log("nullable"+ nullable);
		comment="";
		if(arr_attribute[5]!=null){
		 comment = arr_attribute[5];
		}
        //컨트롤 할 그룹 설정
        attributeGroup = entity.findOne("."+select_group);
        
        //entity 색상코드 가져오기
        //var color1_num = entity.attrs.class;
        var color1_num = entity.findOne('.giveColor').text();

        //속성 자손 개수 찾기
        var attrLength = attributeGroup.children.length;
        
        //속성 위치값 구하기
        var attrPosition = 23*attrLength;
        
        switch(select_group){
        case "pk_group":
            attrKey = "PrimaryKey";
            nullDefault = "NOT NULL";
            key_name = "Key" + cntKey();
            containerColor = colorPick[color1_num].groupColor;
            backgroundColor = colorPick[color1_num].pkBg;
            fontColor = colorPick[color1_num].pkColor;
            placeHolderColor = colorPick[color1_num].pkPlaceHolder
            break;
            
        case "fk_group":
            attrKey = "ForeignKey";
            nullDefault = "NOT NULL";
            key_name = "FKname";
            containerColor = colorPick[color1_num].groupColor;
            backgroundColor = colorPick[color1_num].fkBg;
            fontColor = colorPick[color1_num].fkColor;
            placeHolderColor = colorPick[color1_num].fkPlaceHolder
            break;
            
        case "attr_group":
            attrKey = "Attribute";
            nullDefault = "NULL";
            key_name = "Field" + cntField();
            containerColor = colorPick[color1_num].groupColor;
            backgroundColor = colorPick[color1_num].atBg;
            fontColor = colorPick[color1_num].atColor;
            placeHolderColor = colorPick[color1_num].atPlaceHolder
            break;
            
    }
        
        //속성 row
        attribute = new Konva.Group({
            x: BORDER_SIZE,
            y: attrPosition,
            name: 'attribute'
        });
        
        if(select_group =='pk_group'){
        	attribute.id(get_numId()); 
        }
        //추가함
        else if(pk_id != null){
        	attribute.attrs.pkId = pk_id;
        }


//      속성 전체 박스
        attr_container = new Konva.Rect({
            x: 0,
            y: 0,
            width: 508,
            height: 26,
            fill: containerColor,
            name: 'attr_container'
        });

      

        //속성 종류 설정
        // key . 논리 . 물리 . 도메인 . 타입
        
        attr_groups = new Konva.Group({
            x: BORDER_SIZE,
            y: BORDER_SIZE,
            name: 'attr_groups'
        });
        
        
        //key
        attr_key = new Konva.Rect({
            x: 0,
            y: 0,
            width: 98,
            height: 20,
            fill: backgroundColor,
            //stroke: 'red',
            name: 'attr_background attr_key'
        });
        
        attr_key_txt = new Konva.Text({
            text: attrKey,
            x: attr_key.x(),
            y: attr_key.y(),
            padding: 5,
            fill: fontColor,
            fontSize: 11,
            name: 'setAttrsText attr_key_txt'
        });
        

        
        
        
        //      객체 등록
        attributeGroup.add(attribute);
        attribute.add(attr_container);
        attribute.add(attr_groups);
        
        attr_groups.add(attr_key).add(attr_key_txt);
        
        
        
        
        //============= 그룹추가 ===============
        
        attr_btn_group = new Konva.Group({
            name: 'attr_btn_group',
            y:BORDER_SIZE,
            visible:false
//            ,
//            draggable: true,
//            dragBoundFunc: function(pos) {
//              return {
//                x: this.absolutePosition().x,
//                y: pos.y
//              };
//            }
        });
        
        attr_btn_move = new Konva.Rect({
            name: 'attr_btn_move',
            x:-20-BORDER_SIZE,
            width: 20,
            height: 20,
            cornerRadius: 5,
            strokeWidth: 1,
            stroke: '#ffffff',
            fill: '#0EB6FF'
        });
        
        attr_btn_move_t = new Konva.Text({
            name: 'attr_btn_move_t',
            x: attr_btn_move.x()+2.1,
            y: attr_btn_move.y()+2.3,
            fill: '#ffffff',
            fontSize: 18,
            text: '▦'
        });
        
        attr_btn_remove = new Konva.Rect({
            name: 'attr_btn_remove',
            x:30,
            width: 20,
            height: 20,
            cornerRadius: 5,
            strokeWidth: 1,
            stroke: '#ffffff',
            fill: '#4335af'
        });
        
        attr_btn_remove_t = new Konva.Text({
            name: 'attr_btn_remove_t',
            x: attr_btn_remove.x()+7,
            y: attr_btn_remove.y()+3.5,
            fill: '#ffffff',
            fontSize: 12,
            text: 'x'
        });
        
        attr_btn_group.add(attr_btn_move).add(attr_btn_move_t);
        attr_btn_group.add(attr_btn_remove).add(attr_btn_remove_t);
        attribute.add(attr_btn_group);
        
        
        
        
        
        
        
        //Key_논리
        var attr_logical = fn_setAttr(attr_groups, "attr_logical", logic_key, "key_논리");
        
        //Key_물리
        var attr_phisical = fn_setAttr(attr_logical, "attr_phisical", key, "key_물리");
        
        //Domain
        var attr_domain = fn_setAttr(attr_phisical, "attr_domain", "", "Domain");
        
        //Type
        var attr_type = fn_setAttr(attr_domain, "attr_type", dataType, "Type");
        
        //NOT NULL (select box)
        var attr_null = fn_setAttr(attr_type, "attr_null", nullable, "none");
        
        //Default value
        var attr_default = fn_setAttr(attr_null, "attr_default", defaultValue, "Default value");
        
        //Comment
        var attr_comment = fn_setAttr(attr_default, "attr_comment", comment, "Comment");
        
        
        
        
        
        
        
        
        
        //===================================================================
        //리사이징
        
        //entity_resize();
        

    }
    //entity 생성 종료


//=================================================================
//    속성 추가 function - ShinYS
//    baseName : 베이스 속성
//    attrName : 속성 이름
//    defaultVal : 기본값
//    placeHolder : 안내문구
//    return : this.setAttrs


    function fn_setAttr(baseName, attrName, defaultVal, placeHolder){

        var setAttr_groups = new Konva.Group({
            x: BORDER_SIZE+baseName.x() + baseName.findOne('Rect').width(),
            y: BORDER_SIZE,
            visible: visible_save[attrName],
            name: 'attr_groups'
        });
        
        var setAttrs = new Konva.Rect({
            x: 0,
            y: 0,
            width: 98,
            height: 20,
            fill: backgroundColor,
            name: 'attr_background '+attrName
        });

        var setAttrs_txt = new Konva.Text({
            text: defaultVal,
            x: setAttrs.x(),
            y: setAttrs.y(),
            padding: 5,
            fill: fontColor,
            fontSize: 11,
            name: 'setAttrsText '+ attrName + '_txt'
        });
        
        var setAttrs_placeHolder = new Konva.Text({
            text:placeHolder,
            fill:placeHolderColor,
            padding: 5,
            fontSize: 11,
            visible:false,
            name:'placeHolder'
        });

        
        
        setAttr_groups.add(setAttrs).add(setAttrs_placeHolder).add(setAttrs_txt);
        attribute.add(setAttr_groups);
        
        if(setAttrs_txt.text() === ""){
            setAttrs_placeHolder.visible(true);
        }
        
        
        
//        attributeGroup.add(attribute);
        return setAttr_groups;

    }


//=================================================================
//  리사이징 시작

    //전역변수로 빼기
    var tmp_groupColor;

    //리사이징2 - 처음만들어놓은 entityResize 함수와 연동되어 사용되어짐.
    function resize2(entity){
        
   
        //속성이 없다면?
        if(entity.findOne('.attribute') == null){
            
            //엔티티 컨테이너 넓이 변경
            entity.findOne('.entity_container').width(reszie_entity_container);
            entity.findOne('.entity_container').height(4+29);
            
            //선택된 컨테이너 초기화 시키기.
            if(old_entity != null ){
                if(old_entity.find('.attribute') != null){
                   var old_color = old_entity.findOne('.giveColor').text();
                    old_entity.find('.attr_container').fill(colorPick[old_color].groupColor);
                }
            };

            return;
        };
 
        
        
        var arr_attr = [0,0,0,0,0,0,0,0];
        var attr_GP1 = entity.find('.attribute');
        var attr_GP2 = new Array(); // 2차 배열 자식
        var attr_GP3 = new Array(); // 2차 배열 부모
 
        
        attr_GP1.each(function(GP1){
            var attr_GP_tmp = GP1.find('.attr_groups');
            attr_GP2 = new Array();
            
            attr_GP_tmp.each(function(e, j){
                if(e.visible() != false){
                    attr_GP2.push(e);
                }
            });
            
            attr_GP3.push(attr_GP2);

        });
        
        
        //row 돌리기 1
        attr_GP3.forEach(function(GP1){
           
         //  var attr_GP2 = GP1.find('.attr_groups');
     
            
            //속성 돌리기
            GP1.forEach(function(e,j){
                
                //1. 속성 크기 설정
//                e.findOne('Rect').width(e.findOne('Text').width());

                var tmp_attr_text = e.findOne('.setAttrsText').text();
                
                //Text값 초기화
                e.findOne('.setAttrsText').textWidth = 0;
                e.findOne('.setAttrsText').text("a");
                e.findOne('.setAttrsText').text(tmp_attr_text);
                
                //2. max값 구하기
                if(arr_attr[j] < e.findOne('.setAttrsText').width()){
                    
                    //placeHolder를 갖고있는 열이라면?
                    if(e.findOne('.placeHolder') != null){
                        
                        //플레이스 홀더보다 입력 값이 크다면?
                         if(e.findOne('.setAttrsText').width() > e.findOne('.placeHolder').width()){
                            arr_attr[j] = e.findOne('.setAttrsText').width(); 
                        }else{
                            arr_attr[j] = e.findOne('.placeHolder').width(); 
                        }
                        
                    }else{
                        arr_attr[j] = e.findOne('.setAttrsText').width(); 
                    }
                }
                
            });
    
        });

        
        

        
        //row 돌리기2 - 최대값 적용
        attr_GP3.forEach(function(GP1){
            
            var beforeWidth = BORDER_SIZE;
            widthTotal = 0;
            //var attr_GP2 = GP1.find('.attr_groups');
            
            //속성 돌리기
            GP1.forEach(function(e,j){

                //1. 속성 크기 설정
                 e.findOne('Rect').width(arr_attr[j]);
                 e.findOne('.setAttrsText').textWidth = e.findOne('Rect').width()-10;
                
            
                //2. 위치 설정 
                if(j > 0){

                    beforeWidth = beforeWidth + GP1[j-1].findOne('Rect').width() + BORDER_SIZE;
                    
                    //속성, 위치값
                    e.x(beforeWidth);
                }

                
                //3. 전체 크기
                widthTotal += e.findOne('Rect').width() + BORDER_SIZE;
                //console.log(e.find('Rect').attrs.width);
            });
 
        });
        
 

        //속성 토탈 넓이 값
        widthTotal = widthTotal + BORDER_SIZE;
                                          
                                          
        //** 속성 크기보다 엔티티 명칭이 더 커지면
        if(reszie_entity_container > widthTotal+(BORDER_SIZE*2)){
            
            //마지막 속성 name값 가져오기
            var lastAttributes = entity.findOne('.attribute').find(".attr_groups");
            var lastAttribute = "attr_comment";
            var check_Idx = 1;
            
            
            //lastAttribute = lastAttribute[lastAttribute.length-1].findOne('Rect').name();
            //lastAttribute 변경 => visble false 제외시키기
            for(var i = 0; i < lastAttributes.length; i++){
              
                lastAttribute = lastAttributes[lastAttributes.length-check_Idx];
     
                if(lastAttribute.visible() != false){
                    lastAttribute = lastAttribute.findOne('Rect').name().split(' ')[1];
                    break;
                }
                check_Idx++;
                
            };
            
            
            console.log(lastAttribute);
            var commentWidth = entity.findOne('.'+lastAttribute).width();
            var plusWidth = reszie_entity_container - widthTotal - (BORDER_SIZE*2);
            var resizeCommentWidth = commentWidth + plusWidth;
            
            
            //마지막 속성 크기와 Text크기 셋팅
            entity.find('.'+lastAttribute).each(function(gb){
                gb.width(resizeCommentWidth);
                gb.parent.findOne('.setAttrsText').textWidth = resizeCommentWidth-10;
            });            
        }
        //if end
        
        
        //엔티티 컨테이너 넓이 값
        widthTotal2 = widthTotal + (BORDER_SIZE*2);
        
        //속성 전체 넓이 보다 entity 넓이값이 더 크면?
        if(reszie_entity_container > widthTotal2){
           
            //넓이값 변경
            widthTotal2 = reszie_entity_container;
            widthTotal = widthTotal2 - (BORDER_SIZE*2);
            
            
            //속성 컨테이너 넓이 변경
            entity.find('.attr_container').each(function(e){
                e.width(widthTotal);
            });


            //엔티티 컨테이너 넓이 변경
            entity.findOne('.entity_container').width(widthTotal2);


            
            
        }else{
            
  
            //속성 컨테이너 넓이 변경
            entity.find('.attr_container').each(function(e){
                e.width(widthTotal);
            });


            //엔티티 컨테이너 넓이 변경
            entity.findOne('.entity_container').width(widthTotal2);


           
        }
        
        
        
        
        
        
        //================================================
        // attribute 선택 이벤트
        try {
        	var new_color;
        	var old_color = old_entity.findOne('.giveColor').text();
        	//엔티티 객체 선택시
        	if(allNode.findAncestor('.entity') != null){
        		
        		//컬러셋 초기화 
        		new_color = entity.findOne('.giveColor').text();
        		
        		if(old_entity.id() != allNode.findAncestor('.entity').id()){
        			
        			tmp_groupColor = colorPick[old_color].groupColor;
        			
        		}else{
        			//전역변수로 뺌
        			tmp_groupColor = colorPick[new_color].groupColor;
        		}
        		
        	}else{
        		tmp_groupColor = colorPick[old_color].groupColor;
        	}
        	
        	
        	//속성 배경 초기화
        	old_entity.find('.attr_container').fill(tmp_groupColor);
        	
        	//속성 버튼 초기화
        	old_entity.find('.attr_btn_group').visible(false);
        	
        	
        	//선택속성 투명도 초기화시키기
        	old_entity.find('.attr_container').opacity(1);
        	old_entity.find('.attr_background').opacity(1);
			
		} catch (e) {
			// TODO: handle exception
		}
        
    
        
		try {
			  //속성 선택시
	        if(allNode.findAncestor('.attribute') != null){
	           
	   
	           var total_attribute_length = allNode.findAncestor('.attribute').parent.children.length-1;
	         
	           allNode.findAncestor('.attribute').zIndex(total_attribute_length);
	           allNode.findAncestor('.attribute').parent.zIndex(entity.children.length-1);
	            
	           //console.log(allNode.findAncestor('.attribute').zIndex()); 
	           allNode.findAncestor('.attribute').find('.attr_container').fill(colorPick[new_color].groupColorActive);
	            
	            
	            //선택속성 투명도
	           allNode.findAncestor('.attribute').findOne('.attr_container').opacity(0.8);
	           allNode.findAncestor('.attribute').find('.attr_background').opacity(0.7);
	            
	           //속성 버튼 설정
	           attr_btn_remove = allNode.findAncestor('.attribute').findOne('.attr_btn_remove');
	           attr_btn_remove_t = allNode.findAncestor('.attribute').findOne('.attr_btn_remove_t');
	           attr_btn_remove.x(entity.findOne('.entity_container').width()-BORDER_SIZE);
	           attr_btn_remove_t.x(attr_btn_remove.x()+7);
	           
	           
	           allNode.findAncestor('.attribute').findOne('.attr_btn_group').visible(true);
	           //////// allNode.findAncestor('.attribute').remove();
	            
	            
	  
	            
	        }
		} catch (e) {
			// TODO: handle exception
		}
      
        
        
        
        
        
        
        
        //==========############# 마지막 #############==========
        // attr그룹 위치 크기 조절

        //node설정
        pk_group = entity.findOne('.pk_group');
        fk_group = entity.findOne('.fk_group');
        attr_group = entity.findOne('.attr_group');
            
        
        //속성 row y축 변경
        
        
        //change();

        arr_pk_group = pk_group.find('.attribute');
        arr_fk_group = fk_group.find('.attribute');
        arr_attr_group = attr_group.find('.attribute');
        
 /*       if(arr_pk_group.length > 2){
            console.log('오름차순');
            arr_pk_group.sort(function(a, b) { // 오름차순
                return a.id() - b.id();
                // 13, 21, 25, 44
            });
        }
       
        
*/
        
        pk_group.find('.attribute').forEach(function(item,i){
            item.y(23*i);
        });
        fk_group.find('.attribute').forEach(function(item,i){
            item.y(23*i);
        });
        attr_group.find('.attribute').forEach(function(item,i){
            item.y(23*i);
        });

        
        pkLength = pk_group.children.length;
        fkLength = fk_group.children.length;
        atLength = attr_group.children.length;
        
        //속성 위치값 구하기
        pkPosition = 23*pkLength;
        fkPosition = 23*fkLength;
        atPosition = 23*atLength;

        //fk, attr 그룹 y축 변경
        fk_group.y(26+pkPosition);
        attr_group.y(26+pkPosition+fkPosition);
        
        

        //엔티티 컨테이너 높이 변경
        entity.findOne('.entity_container').height(4+29+(pkPosition+fkPosition+atPosition));
        
        
        layer.draw();
        
        
    }

    var arr_pk_group, arr_fk_group, arr_attr_group;
//    var temp;
//    var temp1;
    function change(){
//        temp = pk_group.find('.attribute')[0];
//        pk_group.find('.attribute')[0] = pk_group.find('.attribute')[1];
//        pk_group.find('.attribute')[1] = temp;
        //temp1 = 999 ;
//        arr_pk_group[0]._id = 999;
//        arr_pk_group[1]._id = 888;
        //layer.draw();
    }
    
    
    
    function clickSecond(secondEntity){ // pk 추가 할시 자동으로 fk에도 추가되는 기능을 할 때, second 객체에 resize이 안되는 문제를 해결하기 위해, 잠시 second 객체를 클릭하는 효과를 주는 메서드
    		entity = secondEntity;
    		console.log('second_resize');
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
    	
    }

