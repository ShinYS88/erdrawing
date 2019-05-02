package kr.or.ddit.team.model;

import java.util.Date;

public class TagVo {
	private int tagNo;			     //태그번호
	private String tagContent;       //태그내용
	private Date tagInDt;            //태그등록일시
	private String tagMaker;         //태그작성자
	public TagVo() {
		super();
	}
	public int getTagNo() {
		return tagNo;
	}
	public void setTagNo(int tagNo) {
		this.tagNo = tagNo;
	}
	public String getTagContent() {
		return tagContent;
	}
	public void setTagContent(String tagContent) {
		this.tagContent = tagContent;
	}
	public Date getTagInDt() {
		return tagInDt;
	}
	public void setTagInDt(Date tagInDt) {
		this.tagInDt = tagInDt;
	}
	public String getTagMaker() {
		return tagMaker;
	}
	public void setTagMaker(String tagMaker) {
		this.tagMaker = tagMaker;
	}
	@Override
	public String toString() {
		return "TagVo [tagNo=" + tagNo + ", tagContent=" + tagContent + ", tagInDt=" + tagInDt + ", tagMaker="
				+ tagMaker + "]";
	}
	
	
}
