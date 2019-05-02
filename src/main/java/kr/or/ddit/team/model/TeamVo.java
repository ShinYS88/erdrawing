package kr.or.ddit.team.model;

public class TeamVo {
	private int teamNo;		        //팀 번호
	private String teamNm;          //팀 명
	private String teamIntro;       //팀 소개
	private String teamImg;         //썸네일이미지
	private String makerId;         //생성자
	public TeamVo() {
		super();
	}
	public int getTeamNo() {
		return teamNo;
	}
	public void setTeamNo(int teamNo) {
		this.teamNo = teamNo;
	}
	public String getTeamNm() {
		return teamNm;
	}
	public void setTeamNm(String teamNm) {
		this.teamNm = teamNm;
	}
	public String getTeamIntro() {
		return teamIntro;
	}
	public void setTeamIntro(String teamIntro) {
		this.teamIntro = teamIntro;
	}
	public String getTeamImg() {
		return teamImg;
	}
	public void setTeamImg(String teamImg) {
		this.teamImg = teamImg;
	}
	public String getMakerId() {
		return makerId;
	}
	public void setMakerId(String makerId) {
		this.makerId = makerId;
	}
	@Override
	public String toString() {
		return "TeamVo [teamNo=" + teamNo + ", teamNm=" + teamNm + ", teamIntro=" + teamIntro + ", teamImg=" + teamImg
				+ ", makerId=" + makerId + "]";
	}

	
}
