package kr.or.ddit.post.model;

public class BoardVo {
	private int boardNo;      //게시판번호
	private String boardNm;   //게시판이름
	
	public BoardVo(){
		
	}
	
	public BoardVo(int boardNo, String boardNm){
		super();
		this.boardNo = boardNo;
		this.boardNm = boardNm;
	}
	
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public String getBoardNm() {
		return boardNm;
	}
	public void setBoardNm(String boardNm) {
		this.boardNm = boardNm;
	}

	@Override
	public String toString() {
		return "BoardVo [boardNo=" + boardNo + ", boardNm=" + boardNm + "]";
	}

	
}
