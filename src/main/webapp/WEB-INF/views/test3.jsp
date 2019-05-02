<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
        
       
        
        
        
      var width = window.innerWidth;
      var height = window.innerHeight;

      var width2 = $('#container_Shin').width();
      var height2 = $('#container_Shin').height();
      
      console.log("width : "+width);
      console.log("width2 : "+width2);
      var stage = new Konva.Stage({
        container: 'container_Shin',
        width: width2,
        height: height2,
          draggable: true
      });

      var layer = new Konva.Layer();
      stage.add(layer);

     
        
      
        
      
        

        
        
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
            fontSize: 20
          });
        
        


        simpleLabel.add(textNode).add(textNode2);

//        simpleLabel.add(new Konva.Text({
//            text: 'Simple label',
//            fontFamily: 'Calibri',
//            fontSize: 18,
//            padding: 5,
//            fill: 'black'
//        }));
        
        
//        blueGroup.add(textNode);
//        blueGroup.add(box);
//        blueGroup.add(textNode);
    
        
      blueGroup.add(box);
    blueGroup.add(simpleLabel);
        
        
        
        
        
      // 선 연결
        
    var arrow = new Konva.Arrow({
      points: [blueGroup.getX()+80, blueGroup.getY()+30, box2.getX()+50, box2.getY()+25],
      pointerLength: 10,
      pointerWidth: 10,
      fill: 'black',
      stroke: 'black',
      strokeWidth: 4
    });

    function adjustPoint(e){
      var p=[blueGroup.getX()+80, blueGroup.getY()+30, box2.getX()+50, box2.getY()+25];
      arrow.setPoints(p);
      layer.draw();
    }

    blueGroup.on('dragmove', adjustPoint);

    box2.on('dragmove', adjustPoint);
        
        
        
        
        
      
      layer.add(box2).add(arrow).add(blueGroup);
      layer.draw();

        
        
      console.log(layer);
        
        
      blueGroup.on('click', () => {
          //alert(simpleLabel.children.hasName('test')[0].attrs.width);
          simpleLabel.find('#myRect')[0].stroke('blue');
          simpleLabel.find('#myRect')[0].strokeWidth(4);
          box.stroke('blue');
          box.strokeWidth(4);
          blueGroup.draggable(true);
          layer.draw();
      });
        
        
      stage.on('click', function(e){
          console.log("=========================");
          console.log(e.target);
          console.log(simpleLabel);
           console.log("=========================");
          
//          try{
//               if(e.target.hasName('sys') || e.target.parent.parent.hasName('sys')){
//                     simpleLabel.find('#myRect')[0].stroke('blue');
//                      simpleLabel.find('#myRect')[0].strokeWidth(2);
//                      layer.draw();
//                 }else{
//
//                     simpleLabel.find('#myRect')[0].strokeWidth(0);
//                     box.stroke('black');
//                     layer.draw();
//                     console.log("없음");
//                     document.body.removeChild(textarea);
//                 }
//          }catch(e){
          
          
          if(e.target.parent == null){
                  simpleLabel.find('#myRect')[0].setAttrs({
                      stroke: 'black',
            strokeWidth: 2,})
            
//                      .find('#myRect')[0].strokeWidth(0);
              
                
                  box.stroke('black');
                    box.strokeWidth(2);
                         layer.draw();
                         console.log("없음");
                         blueGroup.draggable(false);

                  if(document.body.getElementsByTagName('input').length){
                     document.body.removeChild(inputss);
//                      inputss.removeEventListener('keydown', arguments.callee);

                 }
             
             }
             
              
              
//          }
         
      });
        
        var inputss = document.createElement('input');
      textNode.on('dblclick', () => {
          
        console.log(textNode.text());

          
        var textPosition = textNode.getAbsolutePosition();


        var stageBox = stage.container().getBoundingClientRect();


        var areaPosition = {
          x: stageBox.left + textPosition.x,
          y: stageBox.top + textPosition.y
        };


          
        document.body.appendChild(inputss);

        inputss.value = textNode.text();
        inputss.style.position = 'absolute';
        inputss.style.top = areaPosition.y + 'px';
        inputss.style.left = areaPosition.x + 'px';
        inputss.style.width = textNode.width()*stage.scale().x;
        inputss.style.height = textNode.height()*stage.scale().y;

        inputss.focus();

        inputss.addEventListener('keydown', enterK);
          
          
      });
        
        
        
        
        function enterK(e){
             if (e.keyCode === 13) {
                textNode.text(inputss.value);
                layer.draw();
                document.body.removeChild(inputss);
                //this.removeEventListener('keydown',arguments.callee);
              }
        }
        
        
        
        
        //스크롤 확대 축소
        
        var scaleBy = 1.05;
      stage.on('wheel', e => {
        e.evt.preventDefault();
        var oldScale = stage.scaleX();

        var mousePointTo = {
          x: stage.getPointerPosition().x / oldScale - stage.x() / oldScale,
          y: stage.getPointerPosition().y / oldScale - stage.y() / oldScale
        };

        var newScale =
          e.evt.deltaY > 0 ? oldScale * scaleBy : oldScale / scaleBy;
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
        
        
        
        
     
        
        
        // 크기조정
        
        stage.on('click tap', function (e) {
      // if click on empty area - remove all transformers
      if (e.target === stage) {
        stage.find('Transformer').destroy();
        layer.draw();
        return;
      }
      // do nothing if clicked NOT on our rectangles
      if (!e.target.hasName('boxsize')) {
        return;
      }
      // remove old transformers
      // TODO: we can skip it if current rect is already selected
      stage.find('Transformer').destroy();

      // create new transformer
      var tr = new Konva.Transformer();
      layer.add(tr);
      tr.attachTo(e.target);
      layer.draw();
    })
        
        
        
    </script>
    
    