package kr.or.ddit.erd.model;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class ErdVo {
	private int erdNo;			//erd번호
	private String erdTitle;	//erd제목
	private String erdScope;	//erd범위 (public, private, team)
	private int erdReadCnt;		//조회수
	private Date erdCDt; 		//erd Create 날짜 
	private Date erdUDt; 		// erd Update 날짜
	private String erdColor;	//배경색
	private String memId;		//회원아이디(팀 erd인 경우 null이 들어감)
	private int teamNo;			//팀 번호 ( 팀 erd가 아닌 경우, null값이 들어감)
	private String erdImg;
	private String orderKind;	// 정렬종류
	private int likeCnt; 		// 좋아요 수
	
	public ErdVo() {
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

	public String getErdScope() {
		return erdScope;
	}

	public void setErdScope(String erdScope) {
		this.erdScope = erdScope;
	}

	public int getErdReadCnt() {
		return erdReadCnt;
	}

	public void setErdReadCnt(int erdReadCnt) {
		this.erdReadCnt = erdReadCnt;
	}

	//@DateTimeFormat(pattern="MM-dd-yyyy")
	public Date getErdCDt() {
		return erdCDt;
	}

	public void setErdCDt(Date erdCDt) {
		this.erdCDt = erdCDt;
	}

	public Date getErdUDt() {
		return erdUDt;
	}

	public void setErdUDt(Date erdUDt) {
		this.erdUDt = erdUDt;
	}

	public String getErdColor() {
		return erdColor;
	}

	public void setErdColor(String erdColor) {
		this.erdColor = erdColor;
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}

	public int getTeamNo() {
		return teamNo;
	}

	public void setTeamNo(int teamNo) {
		this.teamNo = teamNo;
	}
	
	public String getErdImg() {
		return erdImg;
	}

	public void setErdImg(String erdImg) {
		this.erdImg = erdImg;
	}
	
	

	public String getOrderKind() {
		return orderKind;
	}

	public void setOrderKind(String orderKind) {
		this.orderKind = orderKind;
	}

	public int getLikeCnt() {
		return likeCnt;
	}

	public void setLikeCnt(int likeCnt) {
		this.likeCnt = likeCnt;
	}

	@Override
	public String toString() {
		return "ErdVo [erdNo=" + erdNo + ", erdTitle=" + erdTitle + ", erdScope=" + erdScope + ", erdReadCnt="
				+ erdReadCnt + ", erdCDt=" + erdCDt + ", erdUDt=" + erdUDt + ", erdColor=" + erdColor + ", memId="
				+ memId + ", teamNo=" + teamNo + ", erdImg=" + erdImg + ", orderKind=" + orderKind + ", likeCnt="
				+ likeCnt + "]";
	}

}
