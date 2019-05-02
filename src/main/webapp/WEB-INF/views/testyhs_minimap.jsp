<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script src="https://unpkg.com/konva@3.2.0/konva.min.js"></script>

<style>
	/* <!-- 
http://localhost/testyhs
미니맵에 관한 test입니다. 
-미니맵으로 사용할 캔버스를 하나 더 만든다.
 -미니맵 안에 있는 메서드와 바깥쪽 메인 스테이지의 메서드 명이 똑같으므로 수정할 떄 조심해야함!
		-윤한수
  --> */
	#contents .container {
		position: relative;
	}

	#container_Shin {
		border: 2px solid #fff;
		margin-top: 50px;
		height: 600px;
		background: #666666;
	}

	#container_mini {
		display:none;
		position: absolute;
		top: 470px;
		left: 810px;
		border: 2px solid #000;
		width: 341px;
		/*#container_Shin.width()/3 */
		height: 178px;
		/*#container_Shin.height()/3 */
		background: #444;
	}

	#button1 {
		position: absolute;
		top: 55px;
		left: 25px;
		background: black;
		color: #fff;
		padding: 10px;
		cursor: pointer;
		z-index: 100;
	}

	#button2 {
		position: absolute;
		top: 55px;
		left: 200px;
		background: #333;
		color: #fff;
		padding: 10px;
		cursor: pointer;
		z-index: 100;
	}

	#button3 {
		position: absolute;
		top: 55px;
		left: 400px;
		background: #333;
		color: #fff;
		padding: 10px;
		cursor: pointer;
		z-index: 100;
	}

	#button4 {
		position: absolute;
		top: 55px;
		left: 650px;
		background: #333;
		color: #fff;
		padding: 10px;
		cursor: pointer;
		z-index: 100;
	}

	input {
		font-size: 16px;
	}

</style>

<body id="my_body">
	<div id="button1">테이블 이름 가져오기</div>
	<div id="button2">확대/축1소 초기화</div>
	<div id="container_Shin"></div>
	<div id="container_mini"></div>
	<div id="button3">미니맵 toggle</div>
	<div id="button4">테이블 생성 시 미니맵 그려지기</div>

	<script>

		$("#button1").on('click', function() {
			alert(textNode.text());
		});

		$("#button2").on('click', function() {
			stage.scale({
				x: 1,
				y: 1
			});
			stage.position({
				x: 0,
				y: 0
			});
			
			mini_rect.x(0),
			mini_rect.y(0),
			mini_rect.width(50),
			mini_rect.height(25)
			
			mini_layer.draw();
			stage.batchDraw();
		});

		var flag= true;
		$("#button3").on('click', function() {
			if(flag){
			$("#container_mini").css('display','block');
			}
			else if(!flag){
			$("#container_mini").css('display','none');
			}
			
			flag =!flag;
		});

		$("#button4").on('click', function() {
			alert('미니맵에 테이블 생성 클릭');
			var layer = new Konva.Layer();

			var mini_tb = new Konva.Rect({
				x: 3,
				y: 3,
				width: 6,
				height: 3,
				fill: 'black',
				/* opacity: 0.3 */
			});
			layer.add(mini_tb);
			mini_stage.add(layer);
		});


		
		var width2 = $('#container_Shin').width();
		var height2 = $('#container_Shin').height();

		console.log("height2 : " + height2);
		console.log("width2 : " + width2);
		//메인 스테이지 생성
		var stage = new Konva.Stage({
			container: 'container_Shin',
			x: 0,
			y: 0,
			width: width2,
			height: height2,
			draggable: true
		});

		var layer = new Konva.Layer();
		stage.add(layer);

		var blueGroup = new Konva.Group({
			x: 100,
			y: 100,
			//draggable: true,
			class: 'sys',
			name: 'sys'
		});

		var box = new Konva.Rect({
			x: 0,
			y: 0,
			width: 200,
			height: 200,
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
		blueGroup.add(box);
		blueGroup.add(simpleLabel);


		// 선 연결
		var arrow = new Konva.Arrow({
			points: [blueGroup.getX() + 80, blueGroup.getY() + 30, box2.getX() + 50, box2.getY() + 25],
			pointerLength: 10,
			pointerWidth: 10,
			fill: 'black',
			stroke: 'black',
			strokeWidth: 4
		});

		//미니스테이지 생성
		var mini_width = $('#container_mini').width();
		var mini_height = $('#container_mini').height();
		console.log('mini_width' + mini_width);
		console.log('mini_height' + mini_height);

		//작은 스테이지 생성(미니맵용)
		var mini_stage = new Konva.Stage({
			container: 'container_mini',
			width: mini_width,
			height: mini_height
		});

		
		var mini_layer = new Konva.Layer();

		var mini_rect = new Konva.Rect({
			x: 0,
			y: 0,
			width: 50,
			height: 25,
			stroke: 'red',
			strokeWidth: 4
			/* opacity: 0.3 */
		});
		mini_rect.draggable('true');
		mini_layer.add(mini_rect);

		mini_stage.add(mini_layer);

		mini_rect.on('dragmove', function() {
			console.log('move');
			//updateText();
			collision_check_mini();
			moveMiniStage();
		});

		function collision_check_mini() {
			//x좌표의 왼쪽쪽 끝
			if (mini_rect.x() <= 0) {
				mini_rect.x(0);
			}
			//y좌표의 왼쪽 끝
			if (mini_rect.y() <= 0) {
				mini_rect.y(0);
			}

			//x좌표의 오른쪽 끝
			if (mini_rect.x() >= (mini_stage.width() - mini_rect.width())) {
				mini_rect.x(mini_stage.width() - mini_rect.width());
			}
			//y좌표의 오른쪽 끝
			if (mini_rect.y() >= (mini_stage.height() - mini_rect.height())) {
				mini_rect.y(mini_stage.height() - mini_rect.height());
			}
		}

		function moveMiniStage() {
			stage.x(-mini_rect.x() * 20);
			stage.y(-mini_rect.y() * 12);
			console.log('스테이지 이동');
			layer.draw();
		}
		
		
		
		
		
		function adjustPoint(e) {
			var p = [blueGroup.getX() + 80, blueGroup.getY() + 30, box2.getX() + 50, box2.getY() + 25];
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
		updateText();

		//스테이지를 이동할 때
		stage.on('dragmove', function() {
			console.log('Main Stamove');
			updateText();
			collision_check();
			moveStage();
		});

		function updateText() {
			var lines = [
				'x: ' + stage.x(),
				'y: ' + stage.y(),
				'rotation: ' + stage.rotation(),
				'width: ' + stage.width(),
				'height: ' + stage.height(),
				'scaleX: ' + stage.scaleX(),
				'scaleY: ' + stage.scaleY(),
			];

			console.log(lines);
			layer.batchDraw();
		};

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
			if (stage.x() < -5690) {
				stage.x(-5690);
			}
			//y좌표의 오른쪽 끝
			if (stage.y() < -1765) {
				stage.y(-1765);
			}
		};


		function moveStage() {
			//var shape_Rect = mini_stage.find('Rect')[0];
			//var layer_mini = mini_stage.find('Layer')[0];
			//console.log('shape_Rect' + shape_Rect);
			//console.log('shape_Rect.x()' + shape_Rect.x());

			mini_rect.x(-stage.x() / 20);
			mini_rect.y(-stage.y() / 12);
			mini_layer.draw();
			console.log('스테이지 이동');

		};
		stage.on('click', function(e) {
			console.log("=========================");
			console.log(e.target);
			console.log(simpleLabel);
			console.log("=========================");


			if (e.target.parent == null) {
				simpleLabel.find('#myRect')[0].setAttrs({
					stroke: 'black',
					strokeWidth: 2,
				})

				//                      .find('#myRect')[0].strokeWidth(0);


				box.stroke('black');
				box.strokeWidth(2);
				layer.draw();
				console.log("없음");
				blueGroup.draggable(false);

				if (document.body.getElementsByTagName('input').length) {
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
			inputss.style.width = textNode.width() * stage.scale().x;
			inputss.style.height = textNode.height() * stage.scale().y;

			inputss.focus();

			inputss.addEventListener('keydown', enterK);


		});




		function enterK(e) {
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

			console.log('mini_rect.width()'+mini_rect.width());
			//확대할 경우에...
			if (e.evt.deltaY > 0) {
				if(mini_rect.width()<20){  //작은 돋보기 크기가 너무 작아지는 것을 막아줌
					console.log('return');
					return;
				}
				mini_rect.width(mini_rect.width() - 10);
				mini_rect.height(mini_rect.height() - 5);

			}
			//축소할 경우에...
			else if (e.evt.deltaY < 0) {
				if(mini_rect.width()>320){ //작은 돋보기 크기가 너무 커지는 것을 막아줌
					console.log('return');
					return;
				}
				mini_rect.width(mini_rect.width() + 10);
				mini_rect.height(mini_rect.height() + 5);
			}
			
			
			
			var mousePointTo = {
				x: stage.getPointerPosition().x / oldScale - stage.x() / oldScale,
				y: stage.getPointerPosition().y / oldScale - stage.y() / oldScale
			};

			var newScale =
				e.evt.deltaY > 0 ? oldScale * scaleBy : oldScale / scaleBy;
			stage.scale({
				x: newScale,
				y: newScale
			});


			var newPos = {
				x:
					-(mousePointTo.x - stage.getPointerPosition().x / newScale) *
					newScale,
				y:
					-(mousePointTo.y - stage.getPointerPosition().y / newScale) *
					newScale
			};

			mini_layer.draw();
			stage.position(newPos);
			stage.batchDraw();
			console.log(stage.scale().x);
		});







		// 크기조정

		stage.on('click tap', function(e) {
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

</body>
