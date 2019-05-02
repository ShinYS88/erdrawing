package kr.or.ddit.erdhistory.model;

//Column의 내역을 담는 Vo
public class ColHistVo {
	private int colNo;				//속성내역번호
	private String attrNm;			//속성명
	private String colNm;			//컬럼명
	private String colDataType;		//데이터타입
	private String colDefaultValue;	//기본값
	private String colIsnull;		//널 허용 여부 (T/F)
	private String colComment;		//주석
	private int colOrder;			//속성순번
	private int tbNo;				//테이블(엔티티)내역 번호
		
}
