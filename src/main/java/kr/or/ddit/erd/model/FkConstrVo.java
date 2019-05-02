package kr.or.ddit.erd.model;

public class FkConstrVo {
	private int constrNo;			// 제약조건번호
	private String fkRelationType;  // 관계종류(1:1, 1:N)
	private int referPkConstrNo;    // 참조 PK제약조건
}
