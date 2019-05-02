package kr.or.ddit.erd.model;

public class DomainVo {
	private int domainNo;				//도메인번호
	private String domainNm;			//도메인이름
	private String domainDataType;		//데이터타입
	private String domainDefaultValue;	//기본값
	private int erdNo;					//erd번호
	
	
	
	public DomainVo() {
	}
	
	public int getDomainNo() {
		return domainNo;
	}
	public void setDomainNo(int domainNo) {
		this.domainNo = domainNo;
	}
	public String getDomainNm() {
		return domainNm;
	}
	public void setDomainNm(String domainNm) {
		this.domainNm = domainNm;
	}
	public String getDomainDataType() {
		return domainDataType;
	}
	public void setDomainDataType(String domainDataType) {
		this.domainDataType = domainDataType;
	}
	public String getDomainDefaultValue() {
		return domainDefaultValue;
	}
	public void setDomainDefaultValue(String domainDefaultValue) {
		this.domainDefaultValue = domainDefaultValue;
	}
	public int getErdNo() {
		return erdNo;
	}
	public void setErdNo(int erdNo) {
		this.erdNo = erdNo;
	}
	
	@Override
	public String toString() {
		return "DomainVo [domainNo=" + domainNo + ", domainNm=" + domainNm + ", domainDataType=" + domainDataType
				+ ", domainDefaultValue=" + domainDefaultValue + ", erdNo=" + erdNo + "]";
	}
	
	
}


