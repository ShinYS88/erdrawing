package kr.or.ddit.erdhistory.model;
	
public class FkConstrHistVo {
	private int constrNo;			//제약조건내역번호
	private String fkRelationType;  //제약조건종류(1:1, 1:N)
	private int referPkConstrNo; 	//참조 PK제약조건번호
}
