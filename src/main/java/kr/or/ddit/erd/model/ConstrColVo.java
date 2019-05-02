package kr.or.ddit.erd.model;

//제약조건속성(컬럼)에 관한 Vo
public class ConstrColVo {
	private int constrNo; 		//제약조건번호
	private int colNo;			//속성번호
	private int constrColOrder; //제약조건속성순번(순서);(같은 제약조건을 참조하는 속성들끼리의 순번)
}
