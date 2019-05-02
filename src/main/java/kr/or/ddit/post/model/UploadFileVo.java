package kr.or.ddit.post.model;

public class UploadFileVo {
	private int uploadFileNo;			  //첨부파일번호
	private int postNo;                   //게시글번호
	private String uploadFileNm;          //업로드파일명
	private String uploadRealFilePath;    //저장경로
	
	public int getUploadFileNo() {
		return uploadFileNo;
	}
	
	public void setUploadFileNo(int uploadFileNo) {
		this.uploadFileNo = uploadFileNo;
	}
	
	public int getPostNo() {
		return postNo;
	}
	
	public void setPostNo(int postNo) {
		this.postNo = postNo;
	}
	
	public String getUploadFileNm() {
		return uploadFileNm;
	}
	
	public void setUploadFileNm(String uploadFileNm) {
		this.uploadFileNm = uploadFileNm;
	}
	
	public String getUploadRealFilePath() {
		return uploadRealFilePath;
	}
	
	public void setUploadRealFilePath(String uploadRealFilePath) {
		this.uploadRealFilePath = uploadRealFilePath;
	}
	
	@Override
	public String toString() {
		return "UploadFileVo [uploadFileNo=" + uploadFileNo + ", postNo=" + postNo + ", uploadFileNm=" + uploadFileNm
				+ ", uploadRealFilePath=" + uploadRealFilePath + "]";
	}
	
}
