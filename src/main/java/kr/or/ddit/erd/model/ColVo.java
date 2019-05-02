package kr.or.ddit.erd.model;

//Column을 담는 Vo
public class ColVo {
	
	private int colNo; 				//속성(컬럼)번호
	private String attrNm; 			//속성명
	private String colNm;  			//컬럼명
	private String colDataType; 	//데이터타입
	private String colDefaultValue; //기본값
	private String colIsnull;  		//널 허용여부  T/F
	private String colComment;		//주석(코멘트)
	private int colOrder;			//속성순번
	private int tbNo;				//엔터티번호(FK)
}
