package kr.or.ddit.team.model;

import java.util.Date;

public class TagHistVo {
	private int erdNo;				//erd번호
	private int tagNo;				//태그번호
	private Date tagDt; 			//태그내역  등록날짜
	public TagHistVo() {
		super();
	}
	public int getErdNo() {
		return erdNo;
	}
	public void setErdNo(int erdNo) {
		this.erdNo = erdNo;
	}
	public int getTagNo() {
		return tagNo;
	}
	public void setTagNo(int tagNo) {
		this.tagNo = tagNo;
	}
	public Date getTagDt() {
		return tagDt;
	}
	public void setTagDt(Date tagDt) {
		this.tagDt = tagDt;
	}
	@Override
	public String toString() {
		return "TagHistVo [erdNo=" + erdNo + ", tagNo=" + tagNo + ", tagDt=" + tagDt + "]";
	}
	
	
}
