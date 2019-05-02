<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script>
	var erdNo = ${erdNo};
</script>


<div id="tmp_canvas" style="display: none;"></div>
<div id="tmp_canvas2" style="display: none;"></div>

<div id="drawing_container">
	<div class="drawing_top">
		<div class="top_left">
			<a id="botton0" class="buttons" href="/">홈</a>
			<div class="buttons_top" id="goLib" title="라이브러리">
				<a href="/library">
					<i class="fas fa-book" style="font-size: 18px; line-height: 18px;"></i>
				</a>
			</div>

			<input id="erdName" type="text" value="${erdVo.erdTitle }">
			<div class="buttons_top" id="erdTitleEditBtn" title="ERD이름 변경">
				<i class="fas fa-pencil-alt"
					style="font-size: 18px; line-height: 18px;"></i>
			</div>

			<!--   <div id="button1" class="buttons" style="display: none">테이블 이름 가져오기</div>
                <div id="button5" class="buttons">1대1 연결</div>
                <div id="button6" class="buttons">1대 다 연결</div>
                <div id="button20" class="buttons">데이터 저장</div> -->
			<div id="button21" class="buttons">데이터 불러오기</div>
		</div>

		<div class="top_right">
			<div class="buttons_top" title="ERD 복사" id="erdCopyBtn">
				<i class="fas fa-copy"></i>
			</div>
			<div class="buttons_top" title="ERD 설정" id="erdModify" data-erdno="${erdNo }">
				<i class="fas fa-cog"></i>
			</div>
			<div class="buttons_top" id="message" title="알람">
				<i class="fas fa-bell"></i>
			</div>
			<div class="buttons_top" title="로그아웃">
				<i class="fas fa-sign-out-alt"></i>
			</div>
			<div class="buttons_top" id="searchModal" title="검색 창 열기">
				<i class="fas fa-search"></i>
			</div>
		</div>





	</div>
	<div id="container_mini"></div>

	<div class="drawing_box">

		<session class="drawing_left drawing_pannel"> <!-- entity 추가-->
		<div id="button3" class="buttons_right" title="entity 추가">
			<img src="/image/drawing/entity.png">
		</div>

		<div class="buttons_right" title="없거나 한개 또는 여러개">
			<img src="/image/drawing/NoOneOrMore.png">
		</div>
		<div class="buttons_right" title="없거나 여러개">
			<img src="/image/drawing/NoOrMore.png">
		</div>
		<div class="buttons_right" title="없거나 한개">
			<img src="/image/drawing/NoOrOne.png">
		</div>

		<div class="buttons_right" title="오직 한개만">
			<img src="/image/drawing/onlyone.png">
		</div>
		<div class="buttons_right" title="한개 또는 여러개">
			<img src="/image/drawing/OneOrMore.png">
		</div>
		<div class="buttons_right" title="여러개" id='one2many'>
			<img src="/image/drawing/more.png">
		</div>
		<div class="buttons_right" title="한개" id='one2one'>
			<img src="/image/drawing/one.png">
		</div>


		<label><input type="radio" name="chk_lp" value="lp" checked>
		<div class="buttons_right" title="논리/물리">
				<img src="/image/drawing/LP.png">
			</div></label> <label><input type="radio" name="chk_lp" value="logical">
		<div class="buttons_right" title="논리">
				<img src="/image/drawing/L.png">
			</div></label> <label><input type="radio" name="chk_lp" value="physical">
		<div class="buttons_right" title="물리">
				<img src="/image/drawing/P.png">
			</div></label> </session>

		<session class="drawing_right drawing_pannel">

		<div class="right_top">
<!-- 			<div class="buttons_right" title="엔티티 목록"> -->
<!-- 				<i class="fas fa-list-alt"></i> -->
<!-- 			</div> -->
			<div id="button42" class="buttons_right" title="채팅">
				<i class="far fa-comment"></i>
			</div>
			<div id="button41" class="buttons_right" title="스냅샷">
				<i class="fas fa-film"></i>
			</div>
			<div id="button40" class="buttons_right" title="히스토리">
				<i class="fas fa-history"></i>
			</div>



		</div>
		<div class="right_bottom">
			<div id="erdLikeBtn" class="buttons_right like" title="좋아요">
				<i class="fas fa-thumbs-up"></i>
			</div>
			<!-- 미니맵 Toggle -->
			<div id="button4" class="buttons_right" title="미니맵 Toggle">
				<i class="material-icons">picture_in_picture_alt</i>
			</div>
			<!-- 확대/축소 초기화 -->
			<div id="button2" class="buttons_right" title="확대 초기화">
				<i class="material-icons">visibility</i>
			</div>
		</div>
		</session>

		<session class="drawing_bottom drawing_pannel">

		<div class="bottom_left">
			<div id="button30" class="buttons">
				<i class="fas fa-paste" style="margin-right: 5px;"></i>도메인
			</div>
			<div id="button31" class="buttons">
				<i class="fas fa-download" style="margin-right: 5px;"></i>가져오기
			</div>
			<div id="button32" class="buttons">
				<i class="fas fa-upload" style="margin-right: 5px;"></i>내보내기
			</div>
		</div>


		<div class="bottom_right">
			<!--
                     <label><input type="checkbox" value="attr_logical" class="test_check" checked> 논리 켜기/끄기</label>
                     <label><input type="checkbox" value="attr_phisical" class="test_check" checked> 물리 켜기/끄기</label>
-->

			<label><input type="checkbox" value="attr_domain"
				class="test_check" checked> <span class="check_txt">DOMAIN</span></label>
			<label><input type="checkbox" value="attr_type"
				class="test_check" checked> TYPE</label> <label><input
				type="checkbox" value="attr_null" class="test_check" checked>
				NULL</label> <label><input type="checkbox" value="attr_default"
				class="test_check" checked> DEFAULT</label> <label><input
				type="checkbox" value="attr_comment" class="test_check" checked>
				COMMENT</label>

		</div>

		</session>


		<!-- 식별, 비식별 모달 -->
		<div id="line_background" class="identify_hs">
			<div id="lineInformation">
				<div id="identifying">identifying RelationShip</div>
				<div id="nonidentifying">Non - identifying RelationShip</div>
			</div>
		</div>
		
		


		<!-- 도메인 컨테이너 -->
		<div id="container_domain" class="ani_sys">
			<div class="under_top">
				<div class="under_top_left">
					<span class="title_name">DOMAIN</span> <span class="btn_domain"><i
						class="fas fa-plus-square"></i></span>
				</div>
				<div class="under_top_right">
					<span class="btn_search"><i class="fas fa-search"></i></span> <input
						class="box_search" type="text" placeholder="Search domain" /> <span
						class="btn_close_under"><i class="fas fa-times"></i></span>

				</div>
			</div>


			<div class="container_inner">
				<div class="under_list_box">

					<table>
						<thead>
							<tr>
								<th style="width: 30%">DOMAIN NAME</th>
								<th style="width: 30%">TYPE</th>
								<th style="width: 30%">DEFAULT VALUE</th>
								<th style="padding: 0 5px;">update</th>
								<th style="padding: 0 5px;">delete</th>
							</tr>
						</thead>
						<tbody>
							<!--                                     <tr> -->
							<!--                                         <td><input class="input_box" type="text"/></td> -->
							<!--                                         <td><input class="input_box" type="text"/></td> -->
							<!--                                         <td><input class="input_box" type="text"/></td> -->
							<!--                                         <td class="btn_d_update"><i class="fas fa-sync-alt"></i></td> -->
							<!--                                         <td class="btn_d_delete"><i class="fas fa-trash"></i></td> -->
							<!--                                     </tr> -->


						</tbody>
					</table>
				</div>
			</div>
		</div>


		<!-- 가져오기 컨테이너 -->
		<div id="container_import" class="ani_sys">
			<div class="under_top">
				<div class="under_top_left">
					<span class="title_name">가져오기</span>
				</div>
				<div class="under_top_right">
					<span class="btn_close_under"><i class="fas fa-times"></i></span>
				</div>
			</div>
			<div class="container_inner">
                        <textarea id="input_query">                        
CREATE TABLE "TableName3" ( 
"Key1"   VARCHAR(255)   NOT NULL,
"Key2"   VARCHAR(255)   NOT NULL,
"Key3"   VARCHAR(255)   NOT NULL,
"Field1"   VARCHAR(255)   NULL,
"Field2"   VARCHAR(255)   NULL,
"Field3"   VARCHAR(255)   NOT NULL
);



ALTER TABLE "TableName3" ADD CONSTRAINT "PK_TableName3" PRIMARY KEY( 
"Key1", 
"Key2", 
"Key3" 
);
                        </textarea>
                    </div>
			<div class="under-bottom" id="importQuery">
                        <span>Import</span>
                    </div>
		</div>


		<!-- 내보내기 컨테이너 -->
		<div id="container_export" class="ani_sys">
			<div class="under_top">
				<div class="under_top_left">
					<span class="title_name">내보내기</span>
				</div>
				<div class="under_top_right">
					<span class="btn_close_under"><i class="fas fa-times"></i></span>
				</div>
			</div>

			<div class="under_top2">
				<label> <input type="checkbox" value="add_pk" id='add_pk'
					checked> ADD PK CONSTRAINT
				</label> <label> <input type="checkbox" value="add_fk" id='add_fk'>
					ADD FK CONSTRAINT
				</label> <label> <input type="checkbox" value="add_non" id='add_non'>
					ADD NON IDENTIFYING RELATIONSHIP CONSTRAINT
				</label> <label> <input type="checkbox" value="add_drop"
					id='add_drop'> ADD DROP
				</label>

			</div>


			<div class="container_inner">
				<textarea id="queryText">
    					</textarea>
			</div>

			<div class="under-bottom">
				<span id='preview'>SQL Oracle Preview</span> <span>Download
					PNG</span>
			</div>
		</div>
		

		<!-- 히스토리 컨테이너 -->
		<div id="history_container" class="ani_sys">

			<div class="flexVertical">
				
				<div class="right_top">
					<div class="right_top_left">
						<span class="title_name">히스토리</span>
					</div>
					<div class="right_top_right">
						<span class="btn_close_under"><i class="fas fa-times"></i></span>
					</div>
				</div>
	
				<div class="container_inner">
					<div class="con_inner">
						
						<table>
							<thead>
								<tr>
									<th width="200px;"></th>
									<th width="100px;"></th>
									<th></th>
								</tr>
							</thead>
							<tbody>
								
							</tbody>
						</table>
							
					</div>
				</div>
	
			</div>
		
		</div>
		
		
		
		<!-- 스냅샷 컨테이너 -->
		<div id="snapshot_container" class="ani_sys">
		
			<div class="flexVertical">
				
				<div class="right_top">
					<div class="right_top_left">
						<span class="title_name">스냅샷</span>
					</div>
					<div class="right_top_right">
						<span class="btn_snapshot_add"><i class="fas fa-camera"></i></span>
						<span class="btn_close_under"><i class="fas fa-times"></i></span>
					</div>
				</div>
	
				<div class="container_inner">
					<div class="con_inner">
						<table>
							<thead>
								<tr>
									<th width="200px;"></th>
									<th width="100px;"></th>
									<th></th>
								</tr>
							</thead>
							<tbody>
								
							</tbody>
						</table>
					</div>
				</div>
	
			</div>
		
		</div>
		
		
		<!-- 채팅 컨테이너 -->
		<div id="chat_container" class="ani_sys">

			<div class="flexVertical">
				
				<div class="right_top">
					<div class="right_top_left">
						<span class="title_name">채팅</span>
					</div>
					<div class="right_top_right">
						<span class="btn_close_under"><i class="fas fa-times"></i></span>
					</div>
				</div>
	
				<div class="container_inner">
					<div class="con_inner">
							
					</div>
				</div>
	
	
				<div class="right-bottom">
					<div class="con_inner">
						채팅입력부
					</div>
				</div>
			</div>
		</div>


		<session class="drawing_content drawing_pannel">
		<div id="container_Shin"></div>
		<div id="loading">
			<div class="loading_inner">
				<div class="lodding_content">
					로딩중
				</div>
			</div>
		</div>
		</session>

	</div>
</div>

<form action="${cp }/erd/erdCopy" method="get" id="erdCopyFrm">
	<input type="hidden" name="erdNo" value="${erdNo }">
	<input type="hidden" name="erdTitle" value="${erdVo.erdTitle }">
	<input type="hidden" name="erdImg" value="${erdVo.erdImg }">
</form>




<script>

    
    //논리,물리 버튼 active
    $('input[name=chk_lp]:checked').closest('label').find('.buttons_right').addClass('active');
    
    $('input[name=chk_lp]').on('change',function(){
        $('input[name=chk_lp]').each(function(){
            $(this).closest('label').find('.buttons_right').removeClass('active');
        });
        $(this).closest('label').find('.buttons_right').addClass('active');
        
        var tmp_check = $('input[name=chk_lp]:checked').val();
        var tmp_name1 = 'attr_logical';
        var tmp_name2 = 'attr_phisical';
        
        
        
        if(tmp_check === 'logical'){

            stage.find("."+tmp_name1).each(function(get){
                get.parent.attrs.visible = true;
            });
            visible_save[tmp_name1] = true;
            
            stage.find("."+tmp_name2).each(function(get){
                get.parent.attrs.visible = false;
            });
            visible_save[tmp_name2] = false;

            
        }else if(tmp_check === 'physical'){
            
            stage.find("."+tmp_name1).each(function(get){
                get.parent.attrs.visible = false;
            });
            visible_save[tmp_name1] = false;
            
            stage.find("."+tmp_name2).each(function(get){
                get.parent.attrs.visible = true;
            });
            visible_save[tmp_name2] = true;
            
        }else{
            
             stage.find("."+tmp_name1).each(function(get){
                get.parent.attrs.visible = true;
            });
            visible_save[tmp_name1] = true;
            
            stage.find("."+tmp_name2).each(function(get){
                get.parent.attrs.visible = true;
            });
            visible_save[tmp_name2] = true;
            
        }
        
        
        if(layer.find('.entity').length === 0){
           return;
        }
        
        
        layer.find('.entity').each(function(z){
            entity = z;
            stageClick();
        });
        
        stageClick(0);
        
        
    });


    
    //속성 visible 기본값 설정
    var visible_save = {"attr_logical":true,
                        "attr_phisical":true,
                        "attr_domain":true,
                        "attr_type":true,
                        "attr_null":false,
                        "attr_default":false,
                        "attr_comment":false};
    
    
    //체크박스 초기화
    $(".test_check").each(function(s){
        var setInit_Value = visible_save[$(this).val()];
       $(this).prop("checked",setInit_Value);
    });
    
    //체크박스 선택 이벤트
    $(".test_check").on("change",function(changes){
        
        check_name = $(this).val();
        if($(this).prop("checked")){
            
            stage.find("."+check_name).each(function(get){
                get.parent.attrs.visible = true;

            });
            visible_save[check_name] = true;
            
        }else{
        
            stage.find("."+check_name).each(function(get){
                get.parent.attrs.visible = false;
                
            });
            visible_save[check_name] = false;
        }


        
        if(layer.find('.entity').length === 0){
           return;
        }
        
        
        layer.find('.entity').each(function(z){
            entity = z;
            stageClick();
        });
        
        //엔티티 모양이 바뀌었을 경우  관계선의 위치도 재조정
        findEntityArr  = stage.find('.entity');
       for(var i =0; i<findEntityArr.length; i++ ){
       	 entityMouseUp(findEntityArr[i],true); 
       }
        stageClick(0);
        
    });
 
   
    

        //버튼 이벤트
        $("#button1").on('click', function(){
           alert(textNode.text());
        });
        $("#button2").on('click', function(){
            
        	//미니맵 빨간 사각형 초기화
        	
            mini_rect.x(0),
  			mini_rect.y(0),
  			mini_rect.width(screenWidth*0.048),
  			mini_rect.height(screenHeight*0.048)
  			
  			mini_layer.draw();
             
           stage.scale({ x: 1, y: 1 });
            stage.position({x:0, y:0});
            stage.batchDraw();
        });
        
        $("#button3").on('click', function(){
            
        
           $('html').css({'cursor':'url(/image/erase.cur), auto'});
           
            
            stage.on("click", function(){
                // what is transform of parent element?
                var transform = layer.getAbsoluteTransform().copy();

                // to detect relative position we need to invert transform
                transform.invert();

              var pos = stage.getPointerPosition();
              var circlePos = transform.point(pos);
              entityAdd(circlePos);
                
                
                $('html').css({'cursor':'default'});
                
                 //stage.off('click');

           });
        });
        
        //관계 연결선 1대 1
        $("#one2one").on('click', function(){
      	  $('html').css({'cursor':'url(/image/erase.cur), auto'});
      	  cardinality = 'single';
      	  isRRelationClick = true;
      });
      
      //관계 연결선 1대 다
        $("#one2many").on('click', function(){
      	  $('html').css({'cursor':'url(/image/erase.cur), auto'});
      	  cardinality = 'multi';
      	  isRRelationClick = true;
      });
    
    
    
      //도메인 닫기 버튼
      $('#container_domain .btn_close_under').on('click', function(){
          
          $('#container_domain').removeClass('active');
      });
    
      //가져오기 닫기 버튼
      $('#container_import .btn_close_under').on('click', function(){
          
          $('#container_import').removeClass('active');
      });
    
      //내보내기 닫기 버튼
      $('#container_export .btn_close_under').on('click', function(){
          
          $('#container_export').removeClass('active');
      });
    
    
      //도메인 활성화 버튼
      $('#button30').on('click', function(){

          $('#container_import').removeClass('active');
          $('#container_export').removeClass('active');
          $('#container_domain').addClass('active');
        
      });
      
      //가져오기 활성화 버튼
      $('#button31').on('click', function(){

          $('#container_domain').removeClass('active');
          $('#container_export').removeClass('active');
          $('#container_import').addClass('active');
        
      });
    
      //내보내기 활성화 버튼
      $('#button32').on('click', function(){

          $('#container_domain').removeClass('active');
          $('#container_import').removeClass('active');
          $('#container_export').addClass('active');
        
      });
      
      
      //히스토리 닫기 버튼
      $('#history_container .btn_close_under').on('click', function(){
          $('#history_container').removeClass('active');
      });
      
      //스냅샷 닫기 버튼
      $('#snapshot_container .btn_close_under').on('click', function(){
          $('#snapshot_container').removeClass('active');
      });
    
      //채팅 닫기 버튼
      $('#chat_container .btn_close_under').on('click', function(){
          $('#chat_container').removeClass('active');
      });
      
      
      //히스토리 활성화 버튼
      $('#button40').on('click',function(){
    	  	$('#snapshot_container').removeClass('active');
    	  	$('#chat_container').removeClass('active');
    	  	$('#history_container').addClass('active');
      });

      //스냅샷 활성화 버튼
      $('#button41').on('click',function(){
    	  	$('#history_container').removeClass('active');
    	  	$('#chat_container').removeClass('active');
    	  	$('#snapshot_container').addClass('active');
      });

      //채팅 활성화 버튼
      $('#button42').on('click',function(){
    	  	$('#history_container').removeClass('active');
    	  	$('#snapshot_container').removeClass('active');
    	  	$('#chat_container').addClass('active');
      });


       //identifying을 클릭했을 때
       $("#identifying").on('click', function(){
     	  console.log('identifyingclick')
     	  
     $('.identify_hs').css('display','none');
     	   	var arr_identify = checkIdentify();
     if(firstEntity.findOne('.pk_group').children.length<1 && arr_identify.length<1 ){
   	 return;
     }
   
     relationType = true;
     compareEntityPosition(true); 
     });
     
     //nonidentifying을 클릭했을 때
       $("#nonidentifying").on('click', function(){
     	  console.log('nonidentifyingclick')
     	  
     $('.identify_hs').css('display','none');
     	var arr_identify = checkIdentify();
     if(firstEntity.findOne('.pk_group').children.length<1 && arr_identify.length<1 ){
   	  return;
     }
    
   	  relationType = false;
     compareEntityPosition(true);
     	  
     });
        
        
        
//    1. 변수 선언 및 초기화
      var width = window.innerWidth;
      var height = window.innerHeight;

      var width2 = $('#container_Shin').width();
      var height2 = $('#container_Shin').height();
      
      console.log("width2 : "+width2);
      console.log("height2 : "+height2);
        
      var BORDER_SIZE = 3;

      var color1_num, target, activeWedge, stage, layer, wheel, pointer, box, textNode, allNode;
      
      // entity
      var entity, entity_container, entity_logical, entity_phisical, entity_logical_txt, entity_phisical_txt;
        
      // entity버튼
      var btn_entity_group, btn_entity_delete, btn_color, btn_pk_add, btn_col_add, btn_entity_delete_txt, btn_color_txt, btn_pk_add_txt, btn_col_add_txt;
        
      // attribute group.
      var pk_group, fk_group, attr_group;
    
      //미니맵 관련 전연변수 선언
      var mini_width, mini_height, screenWidth, screenHeight;;
      var mini_stage, mini_layer, mini_rect;

      //temp변수
      var json, json2;   
      var stage2, mini_stage2;
    
      var tmp_PosY = 0;
    
      //yhs
       var isRRelationClick = false;  
      var temp_arrow_layer;
      var temp_arrow;  
      var relationLine; //실제 관계를 연결해주는 선
      var relationLine_layer; 
      var relationType;  //identifying or non-identifying        
      var cardinality //차수 1대1인지 1대 다 인지?
      var firstEntity //첫번째로 클릭한 엔티티
      var secondEntity  //두번째로 클릭한 엔티티
      var relationSwitchFlag;
      var numId = 0;  
      var findEntityArr;
      var pre_identifyingFlag;
      var temp_stroke;
      var temp_relationLine;
      var temp_clickEntity = new Array(2);
      var firstStrokeColor;
      var secondStrokeColor;
      

      //쿼리로 ERD를 그릴 때, 테이블들의 위치정보를 담아놓을 변수
      var sqlimportX =0;
      var sqlimportY =50;
      
    
//    2. ERD화면 초기화
      function init_ERD(){
          
         //기본 레이어 생성
          stage = new Konva.Stage({
            container: 'container_Shin',
            width: width2,
            height: height2,
            draggable: true
          });
          
          layer = new Konva.Layer();
          layer2 = new Konva.Layer();
          
          
          
        // 미니맵용 스테이지 생성
        mini_width = $('#container_mini').width();
		mini_height = $('#container_mini').height();
    
        screenWidth = $('#container_Shin').width();
        screenHeight = $('#container_Shin').height();
    
    
		mini_stage = new Konva.Stage({
			container: 'container_mini',
			width: mini_width,
			height: mini_height
		});
		
		mini_layer = new Konva.Layer();
	
		//미니맵에 보이는 사각형 생성(빨간네모)
		mini_rect = new Konva.Rect({
			x: 0,
			y: 0,
			id: 'mini_red',
			width: screenWidth*0.048,
			height: screenHeight*0.048,
			stroke: 'red',
			strokeWidth: 2
			/* opacity: 0.3 */
		});
		mini_rect.draggable('true');
		mini_layer.add(mini_rect);
          
          
		  mini_stage.add(mini_layer);
          stage.add(layer).add(layer2);
        stage.add(temp_arrow_layer);
        stage.add(relationLine_layer);
          
        relationLine_layer.draw();
          mini_layer.draw();
          layer.draw();
          
          
      }  
        
    
       temp_arrow_layer = new Konva.Layer();
       relationLine_layer = new Konva.Layer();
       var relationSwitchFlag = true;
    
      init_ERD();
 

        
//        테이블 생성
        function entityAdd(circlePos){

            color1_num = Math.floor(Math.random() * 6);
            //color1_num = 3;
            
            entity = new Konva.Group({
                x: circlePos.x,
                y: circlePos.y,
                opacity: 0.9,
                name: 'entity',
                id: get_numId()
            });
            
            var giveColor = new Konva.Text({
                text: color1_num+'',
                name: 'giveColor',
                visible:false
            });
            
          
            
//            테이블 전체 박스
            entity_container = new Konva.Rect({
                x: 0,
                y: 0,
                width: 200,
                height: 26,
                fill: colorPick[color1_num].entityBg,
                stroke: 'white',
                strokeWidth: 0,
                name: 'entity_container'
            });
            
            //미니맵에 표시할 테이블 생성
            var mini_tb = new Konva.Rect({
				x: circlePos.x*0.048,
				y: circlePos.y*0.048,
				fill: 'black',
				name :entity.id()+''
				/* opacity: 0.3 */
			});
//            console.log('mini_tb 아이디 :'+mini_tb.id());
//            console.log('entity_container.width:'+entity_container.width());
//            console.log('entity_container.height:'+entity_container.height());
			
            
            entity_logical = new Konva.Rect({
                x: BORDER_SIZE,
                y: BORDER_SIZE,
                width: 98,
                height: 20,
                //fill: '#000000',
                //stroke: 'red',
                name: 'entity_logical'
            });
            
            
            
            entity_phisical = new Konva.Rect({
                x: entity_logical.x() + entity_logical.width(),
                y: BORDER_SIZE,
                width: 98,
                height: 20,
                //fill: '#000000',
                //stroke: 'red',
                name: 'entity_phisical'
            });
            
            entity_logical_txt = new Konva.Text({
                text: '테이블명',
                x: entity_logical.x(),
                y: entity_logical.y(),
                padding: 5,
                fill: colorPick[color1_num].entityColor,
                fontSize: 11,
                name: 'entity_logical_txt'
            });

            entity_phisical_txt = new Konva.Text({
                text: 'TableName' + cntEntity(),
                x: entity_phisical.x(),
                y: entity_phisical.y(),
                padding: 5,
                fill: colorPick[color1_num].entityColor,
                fontSize: 11,
                name: 'entity_phisical_txt'
            });
            
            entity.add(entity_container).add(giveColor);
            entity.add(entity_logical).add(entity_phisical);
            entity.add(entity_logical_txt).add(entity_phisical_txt);
            
//            버튼 생성
            btn_entity_group = new Konva.Group({
                x: 0,
                y: 0,
                visible:false,
                name: 'btn_entity_group'
            });

            //entity 삭제 버튼
            btn_entity_delete = new Konva.Rect({
                x: entity_container.width() -(20-(BORDER_SIZE-1)),
                y: -(20+(BORDER_SIZE-1)),
                width: 20,
                height: 20,
                fill: '#262629',
                //stroke: 'red',
                cornerRadius: 5,
                name: 'btn_entity_delete'
                
            });
            
            btn_entity_delete_txt = new Konva.Text({
                text: 'x',
                x: btn_entity_delete.x()+4,
                y: btn_entity_delete.y()+3.5,
                fill: '#ffffff',
                fontSize: 12,
                name: 'btn_entity_delete_txt'
            });

            
            //색상 변경 버튼
            btn_color = new Konva.Rect({
                x: btn_entity_delete.x() - 21,
                y: btn_entity_delete.y(),
                width: 20,
                height: 20,
                fill: '#262629',
                //stroke: 'red',
                cornerRadius: 5,
                name: 'btn_color'
            });
            
            btn_color_txt = new Konva.Text({
                text: 'o',
                x: btn_color.x()+4,
                y: btn_color.y()+3.5,
                fill: '#ffffff',
                fontSize: 12,
                name: 'btn_color_txt'
            });

            btn_entity_group.add(btn_entity_delete).add(btn_color);
            btn_entity_group.add(btn_entity_delete_txt).add(btn_color_txt);
            
            
            //pk추가 버튼
            btn_pk_add = new Konva.Rect({
                x: -1,
                y: btn_entity_delete.y(),
                width: 20,
                height: 20,
                fill: '#FFD403',
                //stroke: 'red',
                cornerRadius: 5,
                name: 'btn_pk_add'
            });
            
            btn_pk_add_txt = new Konva.Text({
                text: '+',
                x: btn_pk_add.x()+4,
                y: btn_pk_add.y()+1.5,
                fill: '#000000',
                fontSize: 20,
                name: 'btn_pk_add_txt'
            });
            
            
            
            //일반 컬럼 추가 버튼
            btn_col_add = new Konva.Rect({
                x: btn_pk_add.x()+21,
                y: btn_entity_delete.y(),
                width: 20,
                height: 20,
                fill: '#0EB6FF',
                //stroke: 'red',
                cornerRadius: 5,
                name: 'btn_col_add'
            });
            
            btn_col_add_txt = new Konva.Text({
                text: '+',
                x: btn_col_add.x()+4,
                y: btn_col_add.y()+1.5,
                fill: '#000000',
                fontSize: 20,
                name: 'btn_col_add_txt'
            });
            
            
            btn_entity_group.add(btn_pk_add).add(btn_col_add);
            btn_entity_group.add(btn_pk_add_txt).add(btn_col_add_txt);
            
            
           
            
            pk_group = new Konva.Group({
                x: 0,
                y: 26,
                name: 'key_group pk_group'
            });
            
            fk_group = new Konva.Group({
                x: 0,
                y: 0,
                name: 'key_group fk_group'
            });
            
            attr_group = new Konva.Group({
                x: 0,
                y: 0,
                name: 'key_group attr_group'
            });
            
            
            
            layer.add(entity);
            entity.add(btn_entity_group);
            entity.add(pk_group);
			entity.add(fk_group);
            entity.add(attr_group);
            
            entity_resize();
             
            
            
            //리사이즈 된 크기에 맞춰서 미니맵테이블의 크기 설정
            mini_tb.width(entity_container.width()*0.048);
            mini_tb.height(entity_container.height()*0.048);
            
            mini_layer.add(mini_tb);
            mini_rect.zIndex(mini_layer.children.length-1);
            
            
            layer.draw();
            mini_layer.draw();
            
            
             entity.off('dblclick');
             //entity.on('dblclick', textClick);
            
             entity.off('mouseup');
             entity.off('mousedown');
            
             stage.off('click');
             stage.on('click', stageClick);

            //yhs================================
             // 엔티티를 클릭했을 경우(mouseup) 엔티티와 관계된 관계선들을 보여준다. 
             
           
              
            
            
            //yhs===========================================
            
            
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
        }
        //entity 생성 종료
       
        
        
    
        //전역변수로 빼기
        var old_entity;
        var zNode;
        
        //스테이지 클릭
        function stageClick(e){
        		
            console.log('스테이지 클릭');
            
            if(temp_relationLine != null){
            	temp_relationLine.attrs.stroke = temp_stroke;
            	temp_relationLine  = null;
            	
            	
            	temp_clickEntity[0].find('.attr_container').fill(firstStrokeColor);
            	temp_clickEntity[1].find('.attr_container').fill(secondStrokeColor);
            	clickTarget(temp_clickEntity[0]);
            	clickTarget(temp_clickEntity[1]);
            	relationLine_layer.draw();
            }
            
            if(stage.find('.entity').length===0){
            		return;
            }
            
            
            if(e === undefined){
                allNode = entity.findOne('.entity_logical_txt');
            }else{
            	
            	 	var keycheck = Object.keys(e);
                 console.log("이벤트 키 : ", keycheck[0]);
               
                 if(keycheck[0] === '_id'){
     	    			allNode = e;
     	    		}else if(e === 0){
                     allNode = stage;
                 }else if(e != null){

     	            	if(e.target.findAncestor('.btn_entity_group') === undefined && e.target.findAncestor('.attr_btn_group') === undefined){
     	            		
     	            		zNode = e;
     	        			console.log("zNode저장");
     	            	}else{
     	            		zNode = e.target.findAncestor('.entity');
     	            		  
     	            		console.log("zNode - entity저장");
     	            	}
     	            	
     	 
                     		allNode = e.target;

                 }
            	
            }
            
           
//             else{
//                 allNode = entity.findOne('.entity_logical_txt');
//             }
         	
         	
         	
         	
         	
         	
            
            
            //이동버튼 클릭시
                if(allNode.name().indexOf('attr_btn_move') > -1){
                    return;
                    
                    //return;
                }
            
            

            var old_container = entity_container;
            old_entity = entity;
            var old_btn_pk_add = btn_pk_add;
            var old_btn_col_add = btn_col_add;
            var old_btn_entity_delete = btn_entity_delete;
            var old_btn_color = btn_color;
            var old_btn_entity_group = btn_entity_group;
            
            //입력창 삭제
           if(document.body.getElementsByClassName('attrInput').length > 0){
               document.body.removeChild(inputss);
           }
            
            /////yhs
           if(allNode.parent === null || temp_arrow != null){  // 좀 더 생각해보자 temp_arrow != null말고 e.를 활용해서 
               console.log('temp_arrow'+ temp_arrow);
               console.log('allNode'+ allNode);
       
               
               try {
            	      old_btn_entity_group.hide();
            	      old_entity.draggable(false);
                  old_container.strokeWidth(0);
				} catch (e) {
				}
               
               
               
               if(temp_arrow != null ){ //빈스테이지를 찍어 temp_arrow를 제거해주는 것.
               	
               	//객체 클릭 했을 때
                   if(allNode.findAncestor('.entity')){
                  	console.log('객체 선택');
                  	
                  	$('html').css({'cursor':'default'});
                  	
                  	//identifying을 물어보는 창 생성
                  	$('.identify_hs').css('display','table');
                  	
                  	//새로운 화살표 생성 단  relationType가 true/false인지 확인해야람 identifying인지 non-identify인지
                  
                  	secondEntity = allNode.findAncestor('.entity');
                  	
                  }
               	
               	//빈 스테이지 클릭했을 때.
               	stage.off('mousemove');
               	temp_arrow.remove();
               	temp_arrow_layer.draw();
               	isRRelationClick=false;
               	temp_arrow=null;
               }
           }
            
         
            
            
            
            
            ///yhs
           if(allNode.parent === null || temp_arrow != null ){  // 좀 더 생각해보자 temp_arrow != null말고 e.를 활용해서 
               console.log('temp_arrow'+ temp_arrow);
               console.log('allNode'+ allNode);
               
               try {
               old_btn_entity_group.hide();
               old_entity.draggable(false);
               old_container.strokeWidth(0);
				
			} catch (e) {
				// TODO: handle exception
			}
               
               if(temp_arrow != null ){ //빈스테이지를 찍어 temp_arrow를 제거해주는 것.
               	
               	//객체 클릭 했을 때
                   if(allNode.findAncestor('.entity')){
                  	console.log('객체 선택');
                  	
                  	//identifying을 물어보는 창 생성
                  	$('.identify_hs').css('display','block');
                  	
                  	//새로운 화살표 생성 단  relationType가 true/false인지 확인해야람 identifying인지 non-identify인지
                  
                  	secondEntity = allNode.findAncestor('.entity');
                  	
                  }
               	
               	//빈 스테이지 클릭했을 때.
               	stage.off('mousemove');
               	temp_arrow.remove();
               	temp_arrow_layer.draw();
               	isRRelationClick=false;
               	temp_arrow=null;
               }
           }
            
           else if(allNode.className =='Line'){
             	console.log('관계선클릭');
             	
           	var lindId = allNode.attrs.id;
            	var first_entity  = stage.find('#'+allNode.attrs.name);
            	var second_entity = stage.find('#'+allNode.attrs.lastPos);
            	
            	firstEntityhighlight(first_entity[0]);
            	secondEntityhighlight(lindId,second_entity[0]);
            	
            	temp_stroke = allNode.attrs.stroke;
               temp_relationLine = allNode;
            	
            	
            	allNode.attrs.stroke = '#ff0000';
            	relationLine_layer.draw();
             }  
            
            
            
        /*     //스테이지 클릭시
            if(allNode.parent === null){
                console.log("스테이지 선택");
                
                old_btn_entity_group.hide();
                
                old_entity.draggable(false);
                old_container.strokeWidth(0);
                
            } */
            
            
            
            //객체 선택시
            else {
                
                //변수에 클릭 타겟 넣기
	            
                if(e === undefined){
                		entity = allNode.findAncestor('.entity')
                }else if(keycheck[0] === '_id'){
		        		entity = e;
                }else{
		        		entity = allNode.findAncestor('.entity');
                }

                
                
                
 
                //entity 삭제버튼 이벤트 
                if(allNode.name().indexOf('btn_entity_delete') > -1){
                	
               	 	 findEntityArr  = stage.find('.entity');
               	  var removeTableNo=allNode.findAncestor('.entity').id();
              	  var length = allNode.findAncestor('.entity').find('.attribute').length;
             	  var tempEntity = allNode.findAncestor('.entity');
           		  var arr_EntityAboutremoveCol = new Array();
           		  
           		  //삭제 클릭 시, 내가 클릭한 entity의 속성을 모두 제거
                for(var i=length-1; i>-1; i--){
                	 if(allNode.findAncestor('.entity').find('.attribute')[i].attrs.pkId == undefined){  //마스터테이블 일 때,  즉 외래키가 이닐 때
                         entityId = allNode.findAncestor('.entity').find('.attribute')[i].attrs.id;
                        }
                        
                        else{
                       	 entityId = allNode.findAncestor('.entity').find('.attribute')[i].attrs.pkId    //삭제를 선택한 녀석이 외래키 일 때
                        	arr_EntityAboutremoveCol.push(tempEntity);
                        }
                        	firstEntity = tempEntity;
                           	cascadeDeletePk(entityId,arr_EntityAboutremoveCol);
                            //allNode.findAncestor('.attribute').destroy();
                            allNode.findAncestor('.entity').find('.attribute')[i].destroy();
                }
 				          	deleteRelationLine(arr_EntityAboutremoveCol);
                    
                    mini_stage.find('.'+removeTableNo).remove(); //미니맵 테이블 삭제
                    
                    entity = tempEntity;
                    entityMouseUp(entity,true); //관계선의 위치 재조정
                    for(var i =0; i<arr_EntityAboutremoveCol.length;i++){
                    	entityMouseUp(arr_EntityAboutremoveCol[i],true); //다른 객체의 관계선 위치 재조정
                    }
                    
                    allNode.findAncestor('.entity').remove(); //클릭한 entity 삭제
                    mini_layer.draw();
                    layer.draw();
                    return;
                }
                
                
                //pk버튼 이벤트
                if(allNode.name().indexOf('btn_pk_add') > -1){
                	 fn_attributeAdd('pk_group',entity); //pk 추가
                     
                     firstEntity = e.target.findAncestor('.entity');
                     
                       findEntityArr  = stage.find('.entity');
                      
                      var pkId = entity.findOne('.pk_group').children[entity.findOne('.pk_group').children.length-1].id();
                      pre_identifyingFlag = true;
                      cascadeAddFk(firstEntity,pkId,findEntityArr,pre_identifyingFlag); //매개변수 : pkId
                      
                      entity = firstEntity;
                      
                      entityMouseUp(firstEntity,true);  //관계선의 위치 재조정
                }
                
                //attr버튼 이벤트
                if(allNode.name().indexOf('btn_col_add') > -1){
                    fn_attributeAdd("attr_group",entity);
                    //return;
                }
                
                //fk 테스트
                if(allNode.name().indexOf('btn_color') > -1){
                    fn_attributeAdd("fk_group",entity);
                    
                    //return;
                }
                
                
                
                
     
                
                //속성 삭제 버튼 테스트
                if(allNode.name().indexOf('attr_btn_remove') > -1){
         
                    findEntityArr  = stage.find('.entity');
                    firstEntity = e.target.findAncestor('.entity');
                   var temp_firstEntity = firstEntity; // 최초에 클릭했던 객체를 담아논다.
                   var entityId;
                   var arr_EntityAboutremoveCol = new Array();
                   
                   if(allNode.findAncestor('.attribute').attrs.pkId == undefined){  //마스터테이블 일 때,  즉 외래키가 이닐 때
                    entityId = allNode.findAncestor('.attribute').attrs.id;
                   }
                   
                   else{
                  	 entityId = allNode.findAncestor('.attribute').attrs.pkId    //삭제를 선택한 녀석이 외래키 일 때
                   	arr_EntityAboutremoveCol.push(firstEntity);
                   }
                   	
                       cascadeDeletePk(entityId,arr_EntityAboutremoveCol);
                       allNode.findAncestor('.attribute').destroy();
                       
                    //관계선의 위치를 재조정 해주는 메서드
   				/*내가 지운 녀석들과 관계가 있는 객체 라인들을 확인해야한다.*/  
   				deleteRelationLine(arr_EntityAboutremoveCol);
                       
                       entityMouseUp(temp_firstEntity,true);  //관계선의 위치 재조정
                       entity = temp_firstEntity;
     
                }
                
                
                
                else if(allNode.findAncestor('.entity')){
                	
                	entity.on('dblclick', textClick);
                	
            	  entity.on('dragend',function(e){
                  	 console.log('드래그엔드');
                  	 var first_Entity = e.target; // 첫번째 객체를 얻어옴 (내가 클릭한 객체)
                  	 
                  	entityMouseUp(first_Entity,true); 
                  	relationLine_layer.draw();
                  }); 
                  
               
                  // 엔티티를 클릭했을 경우(mousedown) 엔티티와 관계된 관계선들을 숨겨준다.
                  
                  entity.on('dragstart',function(e){
                 	 console.log('드래그스타트');
                 	
                 	 // e.target.findAncestor('.entity');
                 	 var arr_line_To= relationLine_layer.find('.'+e.target.id());
     				 
                 	 var arr_line_From = findLineRefPos(e.target.id());
                 	 for(var i=0; i<arr_line_To.length; i++){
                 		 arr_line_To[i].hide();
                 	 }
                 	 
                 	 for(var i = 0; i<arr_line_From.length; i++){
                 		 arr_line_From[i].hide();
                 	 }
                 		relationLine_layer.draw();
                 });
            	
            }
                
                
                
                
                
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

                
                
                //로직 시작
                entity.moveTo(layer2);
       
                old_btn_entity_group.hide();
                
                old_entity.draggable(false);
                old_container.strokeWidth(0);
 
                btn_entity_group.show();
                
                entity.draggable(true);
                
                entity_container.strokeWidth(BORDER_SIZE);
                
                entity.moveTo(layer);
                
                
                console.log('makeArrow');
                makeArrow(e);
            }
           //리사이징 시작
           if(allNode.className !='Line'){
           entity_resize();
           
           //미니맵에 객체 갱신
            var mini_entity = mini_stage.find('.'+entity.id());
            mini_entity.width(entity.children[0].width()*0.048);
            mini_entity.height(entity.children[0].height()*0.048);
            mini_layer.draw();
           
           }
           
           layer.draw();
       }
       
        
    
    
    
    
//        텍스트 값 입력 메소드
        var inputss = document.createElement('input');
        
        function textClick(e){
            
            console.log("double click!!!");
            
            textNode = e.target;
            
            if(textNode.className != "Text" || textNode.name().indexOf('btn') > -1){
                return;
            }
            
            
            console.log(textNode.text());
            var textPosition = textNode.getAbsolutePosition();


            var stageBox = stage.container().getBoundingClientRect();


            var areaPosition = {
              x: stageBox.left + textPosition.x,
              y: stageBox.top + textPosition.y
            };


			console.log((textNode.width()*stage.scale().x)+3);
            document.body.appendChild(inputss);
            $(inputss).addClass('attrInput');
            inputss.value = textNode.text();
            inputss.style.position = 'absolute';
            inputss.style.top = (areaPosition.y) + 'px';	/* (areaPosition.y-(stage.scale().x+1)) + 'px'; */
            inputss.style.left = (areaPosition.x) + 'px';
            inputss.style.width = (textNode.width()-6)*stage.scale().x + 'px';
            inputss.style.height = (textNode.height()-3)*stage.scale().y + 'px';
            inputss.style.fontSize = textNode.fontSize()*stage.scale().x + 'px';
            inputss.style.paddingLeft = (5*stage.scale().x)+'px';
            
            inputss.style.background = textNode.findAncestor('.entity').findOne('.entity_container').attrs.fill;
            inputss.style.color = textNode.findAncestor('.entity').findOne('.entity_container').attrs.stroke;
            inputss.style.border = '0px';
            inputss.style.fontFamily = textNode.fontFamily();
           
//             inputss.style.border = (2*stage.scale().x)+'px solid #000';

            inputss.focus();

            inputss.addEventListener('keydown', enterK);
    
        }
       
        
        
        
        
        
        
        
        //엔터입력
        function enterK(e){
             if (e.keyCode === 13) {
                //텍스트 입력 값 적용
                 textNode.text(inputss.value);
                 
  
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
                entity = allNode.findAncestor('.entity');

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
                 
                document.body.removeChild(inputss);
                //this.removeEventListener('keydown',arguments.callee);
                console.log("엔터입력 완료");
              }
        }
        
        
      
        
        var reszie_entity_container;
        
        //리사이징
        
        function entity_resize(){
            
//           1. entity(테이블 리사이징)
             entity_logical.width(entity_logical_txt.width());
             
             entity_phisical.x(entity_logical.width()+BORDER_SIZE);
             entity_phisical_txt.x(entity_phisical.x());
             entity_phisical.width(entity_phisical_txt.width()); 
             
           
           reszie_entity_container = entity_logical_txt.width()+entity_phisical_txt.width()+(BORDER_SIZE*2);
            
               
               
//               entity_container.width(entity_logical_txt.width()+entity_phisical_txt.width()+(BORDER_SIZE*2));
  
            
//          2. attribute(속성 리사이징)
            resize2(entity);
            
            
            
            
//          3. entity(테이블 논리, 물리 위치)
            entity_phisical.x(entity_container.width()-entity_phisical.width()-BORDER_SIZE);
            entity_phisical_txt.x(entity_phisical.x());
            
//          4. entity 기능 버튼 위치(pk,attr, 색상변경, 삭제 버튼 등등...)
            btn_entity_delete.x(entity_container.width() -(20-(BORDER_SIZE-1)));
            btn_color.x(btn_entity_delete.x() - 21);
            btn_entity_delete_txt.x(btn_entity_delete.x()+7);
            btn_color_txt.x(btn_color.x()+7);
            
            
 
        }
  
        $('#preview').on('click',function(){
        	var query = '';
        	
        	if(stage.children[0].children.length == 0){ //스테이지에 테이블이 없으면 리턴 
     			return;
     		}
        	
			if($('#add_drop').prop("checked")){
				console.log('add_drop=== 체크박스 선택');
				query+=add_drop();
			}
        	
         	 query += exportQeury();
         	 
			
			if($('#add_pk').prop("checked")){
				console.log('pk체크박스 선택');
				query+=add_pk();
			}
			
			if($('#add_fk').prop("checked")){
				console.log('fk체크박스 선택');
				query += add_fk();
			}
			
			if($('#add_non').prop("checked")){
				console.log('non체크박스 선택');
				query += add_non();
			}
			
			
			
         	$('#queryText').val(query);
        });
        
        $('#importQuery').on('click',function(){
        	var totalQuery= $('#input_query').val();
        	var arr_query =  totalQuery.split(';');     // ; 를 기준으로 쿼리를 나눈다. 마지막방은 빈 값이 들어간다.
        	console.log(arr_query);
        	if(arr_query.length<1){
        		return;
        	}
        	drawERD(arr_query);
        	
        });
        
        
        
        
        
        
        
        //스크롤 확대 축소
        var SCALE_MIN = 0.45;
        var SCALE_MAX = 1.8;
        var scaleBy = 1.05;
        stage.on('wheel', function(e) {
                
                e.evt.preventDefault();
                var oldScale = stage.scaleX();
				console.log('stage.scaleX()'+ stage.scaleX());
				
			
            
            
            
                //미니맵 관련
                var screenWidth = $('#container_Shin').width();
                var screenHeight = $('#container_Shin').height();
            
                var plusWidth = ((screenWidth)*0.048)/(stage.scale().x);
                var plusHeight = ((screenHeight)*0.048)/(stage.scale().y);
            
                mini_rect.width(plusWidth);
                mini_rect.height(plusHeight);
            
                mini_rect.x((-stage.x() * 0.048)/stage.scaleX());
		        mini_rect.y((-stage.y() * 0.048)/stage.scaleY());
             
                collision_check_mini();
            
                mini_layer.draw();//돋보기창
                //미니맵 관련 종료
            
				
                var mousePointTo = {
                  x: stage.getPointerPosition().x / oldScale - stage.x() / oldScale,
                  y: stage.getPointerPosition().y / oldScale - stage.y() / oldScale
                };
                
            
                //최소, 최대 스케일 추가
                var newScale
                if(stage.scaleX() <= SCALE_MIN){
                    
                    newScale = e.evt.deltaY > 0 ? oldScale * scaleBy : oldScale;
                    
                }else if(stage.scaleX() >= SCALE_MAX){
                    
                    newScale = e.evt.deltaY > 0 ? oldScale : oldScale / scaleBy;
                    
                }else{    
                    
                    newScale = e.evt.deltaY > 0 ? oldScale * scaleBy : oldScale / scaleBy;
                    
                }
    
                    
                stage.scale({ x: newScale, y: newScale });

                var newPos = {
                  x:
                    -(mousePointTo.x - stage.getPointerPosition().x / newScale) *
                    newScale,
                  y:
                    -(mousePointTo.y - stage.getPointerPosition().y / newScale) *
                    newScale
                };
            
  

                stage.position(newPos);
                stage.batchDraw();
                console.log(stage.scale().x);
            
        
      });
    
	// erd 설정 버튼 클릭시       
   $("#erdModify").on("click", function(){
   	var erdNo = $("#erdModify").attr("data-erdno");	
   	erdModifyModal(erdNo);
   });
   // 수정할 erd 정보 가져오기 ajax
   function erdModifyModal(erdNo) {
   	$.ajax({
   		url : "${cp}/erd/erdModify",
   		type : "get",
   		data : {
   			erdNo : erdNo
   		},
   		success : function(data) {
   			console.log(data);
   			insertInfoToModal(data);
   		}
   	});
   }

   // 모달창에 정보 넣기
   function insertInfoToModal(data){
   	var erdVo = data.erdVo;
   	var tagList = data.tagList;
   	
   	var tag = "";
   	for(var i in tagList){
   		tag += tagList[i].tagContent + ",";
   	}
   	tag = tag.substr(0, tag.length-1);	// 마지막 쉼표 지우기
   	$("#title").val(erdVo.erdTitle);
   	$("#tag").val(tag);
   	$("#erdImg").attr("src","${cp }/erd/erdImg?erdNo=${erdNo}");
   	$("#erdNo").val(erdVo.erdNo);
   	$('input:radio[name="erdScope"][value="' + erdVo.erdScope + '"]').attr( "checked" , "checked");
   	
   	// 스냅샷 찍기
   	$("#snapshotBtn").on("click", function(){
   	var dataURL = stage.toDataURL({ pixelRatio: 3 });
   		$("#erdImg").attr('src', dataURL);
   		$("#snapshot").val(dataURL);
   		$("#profileImg").val(""); 
   	});
   	
   }

   // erd 제목 수정 ajax
   $("#erdTitleEditBtn").on("click", function(){
   	var erdTitle = $("#erdName").val();
   	var erdNo = ${erdVo.erdNo};
   	$.ajax({
   		url : "${cp}/erd/erdTitleEdit",
   		type : "get",
   		data : {
   			erdNo : erdNo,
   			erdTitle : erdTitle
   		},
   		success : function(data) {
   			$("#erdName").val(data.erdTitle);
   		}
   	});
   })

   var likeFlag = ${likeCnt};
   if(likeFlag == 1){
   	$(".like").css("color", "red");
   }else{
   	$(".like").css("color", "white");
   }

   // erd 좋아요 클릭 / 취소
   $("#erdLikeBtn").on("click", function(){
   	var erdNo = ${erdVo.erdNo};
   	$.ajax({
   		url : "${cp}/erd/erdLikeClick",
   		type : "get",
   		data : {
   			erdNo : erdNo
   		},
   		success : function(data) {
   			if(likeFlag == 1){
   				$(".like").css("color", "white");
   				likeFlag = 0;
   			}else{
   				$(".like").css("color", "red");
   				likeFlag = 1;
   			}
   		}
   	});
   });

   $("#erdCopyBtn").on("click", function(){
   	$("#erdCopyFrm").submit();
   });

   
   
   

        
</script>










