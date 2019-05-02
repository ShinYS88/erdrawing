package kr.or.ddit.erd.model;

import java.util.Date;

public class ChatVo {

	private int chatNo; 		//채팅번호
	private int erdNo;			//erd번호
	private String memId;		//회원번호
	private String chatContent; //채팅내용
	private Date chatInDt; 		//채팅 작성 날짜
	
	public int getChatNo() {
		return chatNo;
	}
	public void setChatNo(int chatNo) {
		this.chatNo = chatNo;
	}
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
	public String getChatContent() {
		return chatContent;
	}
	public void setChatContent(String chatContent) {
		this.chatContent = chatContent;
	}
	public Date getChatInDt() {
		return chatInDt;
	}
	public void setChatInDt(Date chatInDt) {
		this.chatInDt = chatInDt;
	}
	@Override
	public String toString() {
		return "ChatVo [chatNo=" + chatNo + ", erdNo=" + erdNo + ", memId=" + memId + ", chatContent=" + chatContent
				+ ", chatInDt=" + chatInDt + "]";
	}

	
}
