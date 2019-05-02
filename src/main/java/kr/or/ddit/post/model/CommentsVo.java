package kr.or.ddit.post.model;

import java.text.SimpleDateFormat;
import java.util.Date;

public class CommentsVo {
	private int cmtNo;     		//댓글번호
	private Date cmtRegDt; 		//댓글 작성 날짜
	private String cmtContent;  //내용
	private String cmtDelFlag;	//댓글삭제구분(T/F)
	private int postNo;			//게시글번호
	private String memId;		//댓글작성자아이디
	private int cnt;			//댓글좋아요 건수
	private String flag;        //댓글좋아요 순위에 사용
	
	public CommentsVo(){
		
	}
	
	public CommentsVo(int postNo, int cmtNo, String cmtContent) {
		super();
		this.postNo = postNo;
		this.cmtNo = cmtNo;
		this.cmtContent = cmtContent;
	}
	
	public int getCmtNo() {
		return cmtNo;
	}
	
	public void setCmtNo(int cmtNo) {
		this.cmtNo = cmtNo;
	}

	// yyyy-MM-dd 포맷팅
	public String getCmtRegDt_fmt() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.format(cmtRegDt);
	}

	public void setCmtRegDt(Date cmtRegDt) {
		this.cmtRegDt = cmtRegDt;
	}
		
	public String getCmtContent() {
		return cmtContent;
	}
	
	public void setCmtContent(String cmtContent) {
		this.cmtContent = cmtContent;
	}
	
	public String getCmtDelFlag() {
		return cmtDelFlag;
	}
	
	public void setCmtDelFlag(String cmtDelFlag) {
		this.cmtDelFlag = cmtDelFlag;
	}
	
	public int getPostNo() {
		return postNo;
	}
	
	public void setPostNo(int postNo) {
		this.postNo = postNo;
	}
	
	public String getMemId() {
		return memId;
	}
	
	public void setMemId(String memId) {
		this.memId = memId;
	}
	
	public int getCnt() {
		return cnt;
	}
	
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	
	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}
	
	@Override
	public String toString() {
		return "CommentsVo [cmtNo=" + cmtNo + ", cmtRegDt=" + cmtRegDt + ", cmtContent=" + cmtContent + ", cmtDelFlag="
				+ cmtDelFlag + ", postNo=" + postNo + ", memId=" + memId + ", cnt=" + cnt + ", flag=" + flag + "]";
	}

	
}
