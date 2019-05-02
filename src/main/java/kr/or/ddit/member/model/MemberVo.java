package kr.or.ddit.member.model;

import java.util.Date;

public class MemberVo {
	private String memId;  			//회원아이디
	private String memEmail;			//이메일
	private String memPass;			//비밀번호
	private String memCancelFlag;	//탈퇴여부
	private String memImg;			//프로필이미지
	private String memAuth;			//관리자권한
	private String memNm;			//이름
	private String memIntro;		//자기소개
	private String memLang;			//사용언어
	private String memTel;			//핸드폰번호
	private Date memPeriod; 		//이용권 기한
	private Date memInDt;			//회원가입날짜
	private String memBlackFlag;	//블랙리스트여부
	private String memEmailDiv;		//이메일구분
	public MemberVo(){
		
	}
	
	public MemberVo(String memId, String memMail, String memPass, String memNm, String memLang,String memEmailDiv) {
		this.memId = memId;
		this.memEmail = memMail;
		this.memPass = memPass;
		this.memNm = memNm;
		this.memLang = memLang;
		this.memEmailDiv = memEmailDiv;
	}


	public String getMemEmailDiv() {
		return memEmailDiv;
	}

	public void setMemEmailDiv(String memEmailDiv) {
		this.memEmailDiv = memEmailDiv;
	}

	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getMemMail() {
		return memEmail;
	}
	public void setMemMail(String memMail) {
		this.memEmail = memMail;
	}
	public String getMemPass() {
		return memPass;
	}
	public void setMemPass(String memPass) {
		this.memPass = memPass;
	}
	public String getMemCancelFlag() {
		return memCancelFlag;
	}
	public void setMemCancelFlag(String memCancelFlag) {
		this.memCancelFlag = memCancelFlag;
	}
	public String getMemImg() {
		return memImg;
	}
	public void setMemImg(String memImg) {
		this.memImg = memImg;
	}
	public String getMemAuth() {
		return memAuth;
	}
	public void setMemAuth(String memAuth) {
		this.memAuth = memAuth;
	}
	public String getMemNm() {
		return memNm;
	}
	public void setMemNm(String memNm) {
		this.memNm = memNm;
	}
	public String getMemIntro() {
		return memIntro;
	}
	public void setMemIntro(String memIntro) {
		this.memIntro = memIntro;
	}
	public String getMemLang() {
		return memLang;
	}
	public void setMemLang(String memLang) {
		this.memLang = memLang;
	}
	public String getMemTel() {
		return memTel;
	}
	public void setMemTel(String memTel) {
		this.memTel = memTel;
	}
	public Date getMemPeriod() {
		return memPeriod;
	}
	public void setMemPeriod(Date memPeriod) {
		this.memPeriod = memPeriod;
	}
	public Date getMemInDt() {
		return memInDt;
	}
	public void setMemInDt(Date memInDt) {
		this.memInDt = memInDt;
	}
	public String getMemBlackFlag() {
		return memBlackFlag;
	}
	public void setMemBlackFlag(String memBlackFlag) {
		this.memBlackFlag = memBlackFlag;
	}
	
	
	@Override
	public String toString() {
		return "MemberVo [memId=" + memId + ", memMail=" + memEmail + ", memPass=" + memPass + ", memCancelFlag="
				+ memCancelFlag + ", memImg=" + memImg + ", memAuth=" + memAuth + ", memNm=" + memNm + ", memIntro="
				+ memIntro + ", memLang=" + memLang + ", memTel=" + memTel + ", memPeriod=" + memPeriod + ", memInDt="
				+ memInDt + ", memBlackFlag=" + memBlackFlag + "]";
	}
	
	
	
	
}
