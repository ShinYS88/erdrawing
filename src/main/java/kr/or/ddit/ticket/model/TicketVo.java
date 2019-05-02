package kr.or.ddit.ticket.model;

import java.util.Date;

public class TicketVo {
	private Integer ticketNo;			  //이용권번호
	private Integer ticketPrice;          //이용권금액
	private String ticketImg;         //이용권 이미지 경로
	private String ticketContent;     //이용권 내용
	private Date ticketInDt;          //이용권 등록일
	private String ticketPeriod;     //이용권 기한
	
	
	public TicketVo(){
		
	}
	
	

	public String getTicketPeriod() {
		return ticketPeriod;
	}



	public void setTicketPeriod(String ticketPeriod) {
		this.ticketPeriod = ticketPeriod;
	}



	public Integer getTicketNo() {
		return ticketNo;
	}

	public void setTicketNo(Integer ticketNo) {
		this.ticketNo = ticketNo;
	}

	public Integer getTicketPrice() {
		return ticketPrice;
	}

	public void setTicketPrice(Integer ticketPrice) {
		this.ticketPrice = ticketPrice;
	}

	public String getTicketImg() {
		return ticketImg;
	}

	public void setTicketImg(String ticketImg) {
		this.ticketImg = ticketImg;
	}

	public String getTicketContent() {
		return ticketContent;
	}

	public void setTicketContent(String ticketContent) {
		this.ticketContent = ticketContent;
	}

	public Date getTicketInDt() {
		return ticketInDt;
	}

	public void setTicketInDt(Date ticketInDt) {
		this.ticketInDt = ticketInDt;
	}



	@Override
	public String toString() {
		return "TicketVo [ticketNo=" + ticketNo + ", ticketPrice=" + ticketPrice + ", ticketImg=" + ticketImg
				+ ", ticketContent=" + ticketContent + ", ticketInDt=" + ticketInDt + ", ticketPeriod=" + ticketPeriod
				+ "]";
	}

	
	

}
