package kr.or.ddit.ticket.model;

import java.util.Date;

public class TicketRefHistVo {
	private int ticketBuyNo;			 //이용권구매번호
	private Date refundReqDt;            //환불신청날짜
	private String account;              //계좌번호
	private String bankNm;               //은행명
	private String accountHolder;        //예금주명
	private Date refund_Respdt;			 //환불날짜
	
	public TicketRefHistVo(){
		
	}
	
	public int getTicketBuyNo() {
		return ticketBuyNo;
	}
	public void setTicketBuyNo(int ticketBuyNo) {
		this.ticketBuyNo = ticketBuyNo;
	}
	public Date getRefundReqDt() {
		return refundReqDt;
	}
	public void setRefundReqDt(Date refundReqDt) {
		this.refundReqDt = refundReqDt;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getBankNm() {
		return bankNm;
	}
	public void setBankNm(String bankNm) {
		this.bankNm = bankNm;
	}
	public String getAccountHolder() {
		return accountHolder;
	}
	public void setAccountHolder(String accountHolder) {
		this.accountHolder = accountHolder;
	}
	public Date getRefund_Respdt() {
		return refund_Respdt;
	}
	public void setRefund_Respdt(Date refund_Respdt) {
		this.refund_Respdt = refund_Respdt;
	}
	@Override
	public String toString() {
		return "TicketRefHistVo [ticketBuyNo=" + ticketBuyNo + ", refundReqDt=" + refundReqDt + ", account=" + account
				+ ", bankNm=" + bankNm + ", accountHolder=" + accountHolder + ", refund_Respdt=" + refund_Respdt + "]";
	}

	

}


