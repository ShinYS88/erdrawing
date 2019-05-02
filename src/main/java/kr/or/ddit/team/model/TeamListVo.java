package kr.or.ddit.team.model;

public class TeamListVo {
	private String memId;			//회원아이디
	private int teamNo;				//팀 번호
	private String teamAuth; 		//사용자가 그 팀에서 어떤 권한(직책)을 가지는 지? ex)creator, admin, user
	private String teamAgreeFlag;	//초대 수락유무
	
	public TeamListVo() {
		super();
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}

	public int getTeamNo() {
		return teamNo;
	}

	public void setTeamNo(int teamNo) {
		this.teamNo = teamNo;
	}

	public String getTeamAuth() {
		return teamAuth;
	}

	public void setTeamAuth(String teamAuth) {
		this.teamAuth = teamAuth;
	}

	public String getTeamAgreeFlag() {
		return teamAgreeFlag;
	}

	public void setTeamAgreeFlag(String teamAgreeFlag) {
		this.teamAgreeFlag = teamAgreeFlag;
	}

	@Override
	public String toString() {
		return "TeamListVo [memId=" + memId + ", teamNo=" + teamNo + ", teamAuth=" + teamAuth + ", teamAgreeFlag="
				+ teamAgreeFlag + "]";
	}
	
	

}
