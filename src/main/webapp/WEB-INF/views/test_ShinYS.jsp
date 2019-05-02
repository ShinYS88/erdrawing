<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="https://unpkg.com/konva@3.2.0/konva.min.js"></script>


<style>

    #contents .container{
    position:relative;
  
    }
    
    #container_Shin{
      	border:2px solid #fff;
 		margin-top:50px;
		height:600px;
		background:#666666;
    }
    
    #button1{position:absolute; top:55px; left:25px; background:black; color:#fff; padding:10px; cursor: pointer; z-index: 100;}
    
    #button2{position:absolute; top:55px; left:200px; background:#333; color:#fff; padding:10px; cursor: pointer; z-index: 100;}
    
    input{font-size: 16px;}
    
    
</style>
    

    <div id="button1">테이블 이름 가져오기</div>
    <div id="button2">확대/축소 초기화</div>
    <div id="container_Shin"></div>
 
      
    <script>
        

        $("#button1").on('click', function(){
           alert(textNode.text());
        });
        
        
        $("#button2").on('click', function(){
           stage.scale({ x: 1, y: 1 });
            stage.position({x:0, y:0});
            stage.batchDraw();
        });
        
       
        
        
//      변수 초기화
      var width = window.innerWidth;
      var height = window.innerHeight;

      var width2 = $('#container_Shin').width();
      var height2 = $('#container_Shin').height();
      
      console.log("width : "+width);
      console.log("width2 : "+width2);
        
        
      var target, activeWedge, stage, layer, wheel, pointer, box;
      var entity;
        
      function init_ERD(){
          
          stage = new Konva.Stage({
            container: 'container_Shin',
            width: width2,
            height: height2,
              draggable: true
          });
          
          layer = new Konva.Layer();
          
          stage.add(layer);
          
          layer.draw();
          
          
          
          stage.on("click", function(){
                // what is transform of parent element?
                var transform = layer.getAbsoluteTransform().copy();

                // to detect relative position we need to invert transform
                transform.invert();

              var pos = stage.getPointerPosition();
              var circlePos = transform.point(pos);
              entityAdd(circlePos);
              
          })
          
      }  
        
    
      init_ERD();
      console.log(stage);
        
        
        
//        초기화 종료
        
        
        function entityAdd(circlePos){
            entity = new Konva.Group({
                x: circlePos.x,
                y: circlePos.y
            });
            
            
            box = new Konva.Rect({
                x: 0,
                y: 0,
                width: 150,
                height: 50,
                fill: 'yellow',
                stroke: 'black'

            });
            
            
            entity.add(box);
            layer.add(entity);
            
            layer.draw();
        }
      

      
      

     
        
      
        
      
        
//========================================================================
   /*     
        
        var blueGroup = new Konva.Group({
         x: 300,
         y: 300,
//            draggable: true,
            class: 'sys',
            name: 'sys'
        });
        
        var box = new Konva.Rect({
        x: 10,
        y: 10,
        width: 150,
        height: 50,
        fill: 'red',
        stroke: 'black'
        
        });
        
        var box2 = new Konva.Rect({
        x: 400,
        y: 100,
        width: 100,
        height: 50,
        fill: 'orange',
        stroke: 'black',
        draggable: true,
        name: 'boxsize'
        });
        
        
        
        // simple label
        var simpleLabel = new Konva.Label({
            x: 10,
            y: -16,
            opacity: 0.75
        });

        simpleLabel.add(new Konva.Tag({
            fill: 'yellow',
            stroke: 'black',
            strokeWidth: 2,
            id: 'myRect',
            name: 'test'
        }));
        
        
         var textNode = new Konva.Text({
            text: '테이블명 더블클릭 수정',
    //        x: 50,
    //        y: 50,
              padding: 5,
              fontSize: 16,
              name: 'test'
          });
        
        
        
         var textNode2 = new Konva.Text({
        text: '클릭 후 이동됨',
            x: 16,
            y: 42,
            fontSize: 20,
             fill: 'yellow'
          });
        
        


        simpleLabel.add(textNode);
        
//        box2.add(textNode2);

    
        
      blueGroup.add(box);
      blueGroup.add(simpleLabel);
        
  
      layer.add(box2).add(blueGroup).add(textNode2);
      layer.draw();*/
        
    </script>
    
    