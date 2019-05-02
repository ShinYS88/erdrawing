package kr.or.ddit.erd.model;

import java.util.Date;

public class ErdLikeVo {
	//지연이 누나 파트  
	
	private int erdNo;				//erd좋아요
	private String memId;			//회원아이디
	private Date erdLikeDt;			//erd좋아요를 누른 날짜
	
	
	public int getErdNo() {
		return erdNo;
	}
	public void setErdNo(int erdNo) {
		this.erdNo = erdNo;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public Date getErdLikeDt() {
		return erdLikeDt;
	}
	public void setErdLikeDt(Date erdLikeDt) {
		this.erdLikeDt = erdLikeDt;
	}
	
	@Override
	public String toString() {
		return "ErdLikeVo [erdNo=" + erdNo + ", memId=" + memId + ", erdLikeDt=" + erdLikeDt + "]";
	}
	
	
	
}
