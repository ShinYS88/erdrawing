/**
 *  쿼리추출 관련
 */

//쿼리추출 1번 - 스테이지에 접근
 	function exportQeury(){
 		var query = "";
 		for(var i = 0; i<stage.children[0].children.length; i++ ){
 			if(stage.children[0].children[i].find('.attribute').length==0){ //속성이 없는 테이블은 만들지 않는다. 
 				continue;
 			}
 			query	+= createTable(stage.children[0].children[i])+'\n';
 			query	+= createComments(stage.children[0].children[i])+'\n';
 		}		
 		return query;
 	}
 	
//2번 -테이블에 접근
 	function createTable(table){
 		var tableName = table.children[5].attrs.text;
 		var query = 'CREATE TABLE "' + tableName + '" ( \n'; 
 		query+= createColumns(table);
 		query+=');\n'
 			
 		return query;
 	}
 	
 //3번 -각각의 컬럼에 접근	
 	function createColumns(table){
 		var columns = table.find('.attribute');
 		var query = "";
 			for(var i =0; i<columns.length; i++){
 				if(i==columns.length-1){
 		 			query = query+createColum(columns[i])+'\n'; //마지막은 ,가 붙지 않는다.
 		 			break; //마지막이기 때문에 break로 붙어도 된다. 
 		 		}	
 				query = query+createColum(columns[i])+',\n';
 			}
 	
 			return query;
 	}
 //4번 한 컬럼에 각각 하나씩 접근		
 	function createColum(columns){
 		var space = '   ';
 		var column = columns.find('.attr_groups');
 		
 		var key = column[2].children[2].attrs.text;
 		var domain  = column[4].children[2].attrs.text;
 			if(domain == ''){
 				 domain = 'VARCHAR(255)'; //''일 때 varchar2로 먹임
 				}
 			
 		var nullable = column[5].children[2].attrs.text;
 		var defaultValue = column[6].children[2].attrs.text;
 		if(defaultValue != ''){
 			defaultValue = space+'DEFAULT  ' + defaultValue;
 		}

 		return '"'+key+'"'+space+domain + defaultValue +space+nullable;  
 	}
 	
//2번 중간 - 커멘트를 만들어주는 메서드 	
  function createComments(table){
	  var tableName = table.children[5].attrs.text;
		var columns = table.find('.attribute');
		
		var query = "";
			for(var i =0; i<columns.length; i++){
			var column = columns[i].find('.attr_groups');
				
	 		var comment = column[7].children[2].attrs.text;
	 		//
	 		if(comment != ''){
	 			var key = column[2].children[2].attrs.text;
	 			query += 'COMMENT ON COLUMN "'+tableName+'"."'+key+'" IS '+"'"+comment+"'; \n";
	 			}
			}
	
			return query;
		
  }
 	
 
 	
 	//1번 - add_pk부분
 	function add_pk(){
 		
 		var query = "";
 		for(var i = 0; i<stage.children[0].children.length; i++ ){
 			var pk = stage.children[0].children[i].findOne('.pk_group').children; //해당 테이블에 pk속성배열
 			
 			pk.sort(function (a,b){ //합치기전에 pk끼리 정렬
 				return a.attrs.id<b.attrs.id?-1 : a.attrs.id>b.attrs.id?1:0;   //현재 이 배열에는 내가 선택한 곳에 포함되는 객체들이 모두 들어있다.
 			});
 			
 			var pk_fk = checkIdentify_1(stage.children[0].children[i]); 		  //해당 테이블에 fk면서 pk인 속성배열(identifying인 fk)
 			
 			pk_fk.sort(function (a,b){ //합치기전에 ㄹk끼리 정렬
 				return a.attrs.id<b.attrs.id?-1 : a.attrs.id>b.attrs.id?1:0;   //현재 이 배열에는 내가 선택한 곳에 포함되는 객체들이 모두 들어있다.
 			});
 			
 			
 			var total_pk =$.merge( $.merge([],pk), pk_fk); //각자 정렬된 애들로 합치기
 			
 			if(total_pk.length==0){ //속성이 없는 테이블은 만들지 않는다. 
 				continue;
 			}
 			query	+= createPk(stage.children[0].children[i],total_pk)+'\n';
 		}
 		
 		return query; 		
 	}
 	
 	//2번 pk 쿼리 생성
 	function createPk(table,total_pk){
 		var tableName = table.children[5].attrs.text;
 		var query = 'ALTER TABLE "' + tableName +'" ADD CONSTRAINT ' + '"PK_'+tableName+'" PRIMARY KEY( \n';  
 			for(var i=0; i<total_pk.length; i++){
 				
 				if(i == total_pk.length-1){
 					query += '"'+total_pk[i].find('.attr_groups')[2].children[2].attrs.text+'" \n);\n'; //마지막은 쉼표 생략;
 					break;
 				}
 				query += '"'+total_pk[i].find('.attr_groups')[2].children[2].attrs.text+'", \n';
 			}
 		return query;
 	}
 	
 	
 	//1번 - identifying realation인 fk를 추가하는 쿼리생성
 	function add_fk(){
 		arr_Indetifying = selectIdentifyingRelationLine(); //식별관계인 관계선만 찾음
 		
 		var EntityArr  = stage.find('.entity'); //entity 객체가 들어있는 배열
 		var query = '';
 		for(var i = 0; i<arr_Indetifying.length; i++){
 			
 		superEntity = findEntity(EntityArr,arr_Indetifying[i].attrs.name);
 		subEntity = findEntity(EntityArr,arr_Indetifying[i].attrs.lastPos);
 		
 			query += createFk(superEntity,subEntity);
 		
 		
 		}
 		
 		return query;
 		
 	}
	//1번의 서브   식별관계인 괸계선만 찾음
 	function selectIdentifyingRelationLine(){
 		var arr_Indetifying  = new Array();
 		for(var i =0 ; i<relationLine_layer.children.length; i++){
 			if(relationLine_layer.children[i].attrs.dash==undefined){
 				arr_Indetifying.push(relationLine_layer.children[i]);
 			}
 		}
 		return arr_Indetifying;
 	}
 	
 	//2번- 매개변수로 넘어온 애들에 관한 외래키 제약조건 생성
 	function createFk(superEntity,subEntity){
 		
 		var pk_tableName = superEntity.children[5].attrs.text;
 		var fk_tableName = subEntity.children[5].attrs.text;
 		var query ='';
 		var fk =subEntity.find('.fk_group');
 		
 		for(var i = 0; i<fk[0].children.length; i++){
 			pk_id = fk[0].children[i].attrs.pkId;
 			
 			var pk_Attr= selectPkId(superEntity,pk_id);
 			 
 			 if(pk_Attr  != null){ //참조하는 값이 있을때만 실행한다.
 				 query += createFkQuery(pk_tableName,fk_tableName,pk_Attr,fk[0].children[i]) +'\n';
 			 }
 			
 			//query += createFkQuery(pk_tableName,fk_tableName,pk_Attr,fk[0].children[i]) +'\n';
 			 
 			
 		}
 		return query;
 	}

 	
 	//2번 -중간  해당 fk가 참조하는 pk의 속성을 리턴한다.
 	function selectPkId(superEntity,pk_id){
 		var pk =superEntity.find('.pk_group');
 		var fk = superEntity.find('.fk_group');
 		
 		for(var i = 0; i<pk[0].children.length; i++){
 			if(pk[0].children[i].attrs.id == pk_id){
 				return pk[0].children[i];
 			}
 		}
 		for(var i = 0; i<fk[0].children.length; i++){
 			if(fk[0].children[i].attrs.pkId == pk_id){
 				return fk[0].children[i];
 			}
 		}
 		
 	}
 	
 	
 	
 	//3번 -fk 생성
 	function createFkQuery(pk_tableName,fk_tableName,pk,fk){
 	
 		var query='';
 		var pk_key=pk.children[4].children[2].attrs.text;
 		var fk_key=fk.children[4].children[2].attrs.text;
 		query = 'ALTER TABLE "'+fk_tableName+'" ADD CONSTRAINT "FK_'+pk_tableName+'_TO_'+fk_tableName+'" FOREIGN KEY ( \n "'+fk_key+'" \n ) \n REFERENCES "'+pk_tableName+'" (\n "'+pk_key+'" \n);\n';
 		return query; 
 	}
 	
 
 	
 	
 	//1번 - non-identifying realation인 fk를 추가하는 쿼리생성
 	function add_non(){
 		arr_non_Indetifying = selectNonIdentifyingRelationLine(); //식별관계인 관계선만 찾음
 		
 		var EntityArr  = stage.find('.entity'); //entity 객체가 들어있는 배열
 		var query = '';
 		for(var i = 0; i<arr_non_Indetifying.length; i++){
 			
 		superEntity = findEntity(EntityArr,arr_non_Indetifying[i].attrs.name);
 		subEntity = findEntity(EntityArr,arr_non_Indetifying[i].attrs.lastPos);
 		
 			query += createAttr(superEntity,subEntity);
 		
 		
 		}
 		
 		return query;
 		
 	}
	//1번의 서브   비식별관계인 괸계선만 찾음
 	function selectNonIdentifyingRelationLine(){
 		var arr_NonIndetifying  = new Array();
 		for(var i =0 ; i<relationLine_layer.children.length; i++){
 			if(relationLine_layer.children[i].attrs.dash!=undefined){
 				arr_NonIndetifying.push(relationLine_layer.children[i]);
 			}
 		}
 		return arr_NonIndetifying;  
 	}
 	
 	//2번 attribute에 대한 컬럼 찾기
function createAttr(superEntity,subEntity){
 		
 		var pk_tableName = superEntity.children[5].attrs.text;
 		var fk_tableName = subEntity.children[5].attrs.text;
 		var query ='';
 		var fk =subEntity.find('.attr_group');
 		
 		for(var i = 0; i<fk[0].children.length; i++){
 			pk_id = fk[0].children[i].attrs.pkId;
 			
 			 var pk_Attr= selectPkId(superEntity,pk_id);
 			 
 			 
 			 if(pk_Attr  != null){ //참조하는 값이 있을때만 실행한다.
 				 query += createFkQuery(pk_tableName,fk_tableName,pk_Attr,fk[0].children[i]) +'\n';
 			 }
 			 
 			//query += createFkQuery(pk_tableName,fk_tableName,pk_Attr,fk[0].children[i]) +'\n';
 			
 		}
 		return query;
 	}

function add_drop(){
	var query = "";
		for(var i = 0; i<stage.children[0].children.length; i++ ){
			if(stage.children[0].children[i].find('.attribute').length==0){ //속성이 없는 테이블은 만들지 않는다. 
				continue;
			}
			query	+= drop_Table(stage.children[0].children[i])+'\n';
		}
			
		return query;
}
function drop_Table(table){
	var tableName = table.children[5].attrs.text;
		var query = 'DROP TABLE IF EXISTS "' + tableName + '"; \n'; 
		return query;
	
} 	

 	