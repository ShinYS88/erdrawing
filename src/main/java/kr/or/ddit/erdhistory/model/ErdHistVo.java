package kr.or.ddit.erdhistory.model;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

//erd 내역을 담는 Vo
//하나의 erd에 대해 여러개가 존재할 수 있다.
public class ErdHistVo {
	private int erdHistNo;			//erd내역번호
	private int erdNo;				//erd번호
	private String erdTitle;		//ERD제목
//	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date erdDt;				//생성날짜
	private String erdIsVisible;	//기본값 T   (스냅샷을 한 뒤에 F로 변경) => 수정 => 히스토리 : T, 스냅샷 : F
	private String snapImg;			//스냅샷이미지경로
	private Date snapCDt; 			//스냅샷 Create 생성날짜
	private String snapNm;			//스냅샷 명
	private String erdJson;			//erdJson저장
	
	
	public ErdHistVo() {
	}
	
	public int getErdHistNo() {
		return erdHistNo;
	}
	public void setErdHistNo(int erdHistNo) {
		this.erdHistNo = erdHistNo;
	}
	public int getErdNo() {
		return erdNo;
	}
	public void setErdNo(int erdNo) {
		this.erdNo = erdNo;
	}
	public String getErdTitle() {
		return erdTitle;
	}
	public void setErdTitle(String erdTitle) {
		this.erdTitle = erdTitle;
	}
	public Date getErdDt() {
		return erdDt;
	}
	public void setErdDt(Date erdDt) {
		this.erdDt = erdDt;
	}
	public String getErdIsVisible() {
		return erdIsVisible;
	}
	public void setErdIsVisible(String erdIsVisible) {
		this.erdIsVisible = erdIsVisible;
	}
	public String getSnapImg() {
		return snapImg;
	}
	public void setSnapImg(String snapImg) {
		this.snapImg = snapImg;
	}
	public Date getSnapCDt() {
		return snapCDt;
	}
	public void setSnapCDt(Date snapCDt) {
		this.snapCDt = snapCDt;
	}
	public String getSnapNm() {
		return snapNm;
	}
	public void setSnapNm(String snapNm) {
		this.snapNm = snapNm;
	}
	public String getErdJson() {
		return erdJson;
	}
	public void setErdJson(String erdJson) {
		this.erdJson = erdJson;
	}
	@Override
	public String toString() {
		return "ErdHistVo [erdHistNo=" + erdHistNo + ", erdNo=" + erdNo + ", erdTitle=" + erdTitle + ", erdDt=" + erdDt
				+ ", erdIsVisible=" + erdIsVisible + ", snapImg=" + snapImg + ", snapCDt=" + snapCDt + ", snapNm="
				+ snapNm + ", erdJson=" + erdJson + "]";
	}
	
	
}
