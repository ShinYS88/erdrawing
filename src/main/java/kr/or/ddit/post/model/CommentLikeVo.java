package kr.or.ddit.post.model;

import java.util.Date;

public class CommentLikeVo {
	private int cmtNo;		// 댓글번호
	private String memId;	// 회원아이디
	private Date cmtLikeDt; // 댓글 좋아요를 누른 날짜 
	
	public CommentLikeVo(){
		
	}
	
	public CommentLikeVo(int cmtNo, String memId){
		super();
		this.cmtNo = cmtNo;
		this.memId = memId;
	}
	
	public int getCmtNo() {
		return cmtNo;
	}
	public void setCmtNo(int cmtNo) {
		this.cmtNo = cmtNo;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public Date getCmtLikeDt() {
		return cmtLikeDt;
	}
	public void setCmtLikeDt(Date cmtLikeDt) {
		this.cmtLikeDt = cmtLikeDt;
	}


	/*public int getLikeCheck() {
		return likeCheck;
	}

	public void setLikeCheck(int likeCheck) {
		this.likeCheck = likeCheck;
	}*/

	@Override
	public String toString() {
		return "CommentLikeVo [cmtNo=" + cmtNo + ", memId=" + memId + ", cmtLikeDt=" + cmtLikeDt + "]";
	}
	
}
