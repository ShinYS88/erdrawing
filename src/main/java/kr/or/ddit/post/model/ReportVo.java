package kr.or.ddit.post.model;

import java.util.Date;

public class ReportVo {
	private String fromMemId; 		 //신고한 회원아이디
	private String toMemId;  		 //신고당한 회원아이디
	private String reportReason; 	 //신고사유
	private Date reportDt;			 //신고날짜
	private String cnt;			 	 //신고총갯수
	
	public ReportVo() {
	
	}
	
	public String getCnt() {
		return cnt;
	}

	public void setCnt(String cnt) {
		this.cnt = cnt;
	}

	public String getFromMemId() {
		return fromMemId;
	}

	public void setFromMemId(String fromMemId) {
		this.fromMemId = fromMemId;
	}

	public String getToMemId() {
		return toMemId;
	}

	public void setToMemId(String toMemId) {
		this.toMemId = toMemId;
	}

	public String getReportReason() {
		return reportReason;
	}

	public void setReportReason(String reportReason) {
		this.reportReason = reportReason;
	}

	public Date getReportDt() {
		return reportDt;
	}

	public void setReportDt(Date reportDt) {
		this.reportDt = reportDt;
	}

	@Override
	public String toString() {
		return "ReportVo [fromMemId=" + fromMemId + ", toMemId=" + toMemId + ", reportReason=" + reportReason
				+ ", reportDt=" + reportDt + "]";
	}

}
