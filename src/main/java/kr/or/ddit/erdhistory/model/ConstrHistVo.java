package kr.or.ddit.erdhistory.model;
//제약조건내역을 담는 Vo
public class ConstrHistVo {
	private int constrNo ;		//제약조건내역번호
	private String constrNm ;	//제약조건내역명
	private String constrType;	//제약조건구분 (PK/FK)
	private int tbNo;			//엔티티(테이블)내역번호
}
