package kr.or.ddit.post.model;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class PostVo {
	private int postNo;           //게시글번호
	private String postContent;   //게시글내용
	//@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date postRegDt;       //작성일시
	private int postGn;           //그룹번호
	private String postDelFlag;   //삭제여부
	private int boardNo;          //게시판번호
	private int parentPostNo;     //부모게시글번호
	private String writerId;      //작성자아이디
	private String postTitle;     //게시글제목
	private int viewCnt;		  //게시글 조회수
	private int level;            
	
	public PostVo(){
		
	}
	
	public PostVo(int postNo, String postContent, String postTitle) {
		super();
		this.postNo = postNo;
		this.postContent = postContent;
		this.postTitle = postTitle;
	}
	
	public int getPostNo() {
		return postNo;
	}

	public void setPostNo(int postNo) {
		this.postNo = postNo;
	}

	public String getPostContent() {
		return postContent;
	}

	public void setPostContent(String postContent) {
		this.postContent = postContent;
	}
	
	/*// yyyy-MM-dd 포맷팅
	public String getPostRegDt_fmt() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.format(postRegDt);
	}
	
	public Date getPostRegDt() {
		return postRegDt;
	}*/

	public Date getPostRegDt() {
		return postRegDt;
	}

	public void setPostRegDt(Date postRegDt) {
		this.postRegDt = postRegDt;
	}

	public int getPostGn() {
		return postGn;
	}

	public void setPostGn(int postGn) {
		this.postGn = postGn;
	}

	public String getPostDelFlag() {
		return postDelFlag;
	}

	public void setPostDelFlag(String postDelFlag) {
		this.postDelFlag = postDelFlag;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public int getParentPostNo() {
		return parentPostNo;
	}

	public void setParentPostNo(int parentPostNo) {
		this.parentPostNo = parentPostNo;
	}

	public String getWriterId() {
		return writerId;
	}

	public void setWriterId(String writerId) {
		this.writerId = writerId;
	}

	public String getPostTitle() {
		return postTitle;
	}

	public void setPostTitle(String postTitle) {
		this.postTitle = postTitle;
	}
	
	public int getViewCnt() {
		return viewCnt;
	}

	public void setViewCnt(int viewCnt) {
		this.viewCnt = viewCnt;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	@Override
	public String toString() {
		return "PostVo [postNo=" + postNo + ", postContent=" + postContent + ", postRegDt=" + postRegDt + ", postGn="
				+ postGn + ", postDelFlag=" + postDelFlag + ", boardNo=" + boardNo + ", parentPostNo=" + parentPostNo
				+ ", writerId=" + writerId + ", postTitle=" + postTitle + ", viewCnt=" + viewCnt + ", level=" + level
				+ "]";
	}

}

