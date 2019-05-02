// Name Count함수

    function cntEntity(){
        
        return layer.find('.entity_logical_txt').length + 1;
        
    }

    function cntKey(){
        return entity.findOne('.pk_group').find('.attr_phisical').length + 1;
    }
    
    function cntKey_param(table){
        return (table.findOne('.pk_group').find('.attr_phisical').length) + 1;
    }

    function cntField(){
        return entity.findOne('.attr_group').find('.attr_phisical').length + 1;
    }

    //entity생성 ID생성 함수
    function newEntity_id(){
        var arr_Entity_num = layer.find('.entity');
        var new_num = 0;
        
        if(arr_Entity_num.length > 0){
           arr_Entity_num.each(function(item){
               new_num = new_num < item.id() ? item.id() : new_num;
           });
        }

        return new_num+1;
        
    }


    function get_numId(){
    	return ++numId;
    } 

    
 /*  function getMaxNumId(){
    	var arr_Entity = layer.find('.entity');
    	var arr_Relation = relationLine_layer.find('Line');
    	var arr_miniEntity = mini_layer.find('Rect');
    	
    	var arr= stage.find('.pk_group');
    	var arr1 = new Array();
    		for(var i = 0; i<arr.length; i++){
    			for(var j=0; j<arr[i].children.length; j++){
    			arr1.push(arr[i].children[j]);
    			}
    	}
    	var arr_total = arr_Entity.concat(arr_Relation).concat(arr_miniEntity).concat(arr1);
    	arr_total.attrs.id()
    }
*/

/**
 * erdDrawing.jsp minimap 기능에 관련된 스크립트 입니다.
 */

//미니맵 사각형의 충돌 체크
	function collision_check_mini() {
//		console.log((mini_stage.width() - mini_rect.width()));
//		console.log((mini_stage.height() - mini_rect.height()));
        
        
		//x좌표의 왼쪽쪽 끝
		if (mini_rect.x() < 0) {
			mini_rect.x(0);
            stage.x(0);
            
		}
		//y좌표의 왼쪽 끝
		if (mini_rect.y() < 0) {
			mini_rect.y(0);
            stage.y(0);
		}

		//x좌표의 오른쪽 끝
		if (mini_rect.x() > (mini_stage.width() - mini_rect.width())) { //160
			mini_rect.x(mini_stage.width() - mini_rect.width());
            stage.x((-mini_rect.x()/0.048)*stage.scaleX()+0.1);
		}
		//y좌표의 오른쪽 끝
		if (mini_rect.y() > (mini_stage.height() - mini_rect.height())) { //90
			mini_rect.y(mini_stage.height() - mini_rect.height());
            stage.y((-mini_rect.y()/0.048)*stage.scaleY()+0.1);
		}
	}


//미니맵 켜기/끄기
$(document).ready(function() {
	var flag = true;
    
    
	$("#button4").on('click', function() {
		if (flag) {
			$("#container_mini").css('display', 'block');
		} else if (!flag) {
			$("#container_mini").css('display', 'none');
		}
		flag = !flag;
	});
    
    
	mini_rect.on('dragmove', function() {
		//console.log('move');
		collision_check_mini();
		moveMiniStage();
	});

	

	//미니맵에 사각형을 움직였을 때. 메인 스테이지의 위치를 바꿔주는 메서드
	function moveMiniStage() {
		console.log('스테이지 이동')
		stage.x((mini_rect.x() / -0.048)*stage.scaleX());
		stage.y((mini_rect.y() / -0.048)*stage.scaleY());
		layer.draw();
		relationLine_layer.draw();
		
	}

	//메인 스테이지를 드래그로  이동할 때
	stage.on('dragmove', function() {
		//collision_check();
        //collision_check_mini();
        moveStage();

	});

    
    

	//메인스테이지의  충돌체크
	function collision_check() {
		//x좌표의 왼쪽쪽 끝
		if (stage.x() > 0) {
			stage.x(0);
		}
		//y좌표의 왼쪽 끝
		if (stage.y() > 0) {
			stage.y(0);
		}

		//x좌표의 오른쪽 끝
		if (stage.x() < -3680) {
			stage.x(-3680);
		}
		//y좌표의 오른쪽 끝
		if (stage.y() < -1714) {
			stage.y(-1714);
		}
	}

	//메인 스테이지가 움직 일 때, 미니맵 스테이지를 움직이게 하는 메서드
	function moveStage() {
        
        
        mini_rect.x((-stage.x() * 0.048)/stage.scaleX());
		mini_rect.y((-stage.y() * 0.048)/stage.scaleY());
        
        collision_check_mini();
     
        
		mini_layer.draw();
	}
    
    
    function test111(){
        
        alert('asad');
    }

});