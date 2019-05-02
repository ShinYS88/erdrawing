package kr.or.ddit.ticket.model;

import java.util.Date;

public class TicketBuyHistVo {
	private int ticketBuyNo; // 이용권구매번호
	private int ticketNo; // 이용권번호
	private String memId; // 회원아이디
	private Date ticketBuyDt; // 이용권구매일
	private int ticketFee; // 결제금액
	private String ticketMonDt; // 달

	public TicketBuyHistVo() {

	}

	public String getTicketMonDt() {
		return ticketMonDt;
	}

	public void setTicketMonDt(String ticketMonDt) {
		this.ticketMonDt = ticketMonDt;
	}

	@Override
	public String toString() {
		return "TicketBuyHistVo [ticketBuyNo=" + ticketBuyNo + ", ticketNo=" + ticketNo + ", memId=" + memId
				+ ", ticketBuyDt=" + ticketBuyDt + ", ticketFee=" + ticketFee + ", ticketMonDt=" + ticketMonDt + "]";
	}

	public int getTicketBuyNo() {
		return ticketBuyNo;
	}

	public void setTicketBuyNo(int ticketBuyNo) {
		this.ticketBuyNo = ticketBuyNo;
	}

	public int getTicketNo() {
		return ticketNo;
	}

	public void setTicketNo(int ticketNo) {
		this.ticketNo = ticketNo;
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}

	public Date getTicketBuyDt() {
		return ticketBuyDt;
	}

	public void setTicketBuyDt(Date ticketBuyDt) {
		this.ticketBuyDt = ticketBuyDt;
	}

	public int getTicketFee() {
		return ticketFee;
	}

	public void setTicketFee(int ticketFee) {
		this.ticketFee = ticketFee;
	}

}
