package kr.or.ddit.post.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.post.model.PostVo;
import kr.or.ddit.post.model.UploadFileVo;
import kr.or.ddit.util.model.PageVo;

public interface IPostService {
	
	List<PostVo> getAllPost(String boardNo);
	
	PostVo getSelectPost(String postNo);
	
	//Map<String, Object> selectPostPagingList(PageVo pageVo, String boardNo);
	
	List<PostVo> selectPostPagingList(PageVo pageVo);
	
	int getViewCnt(String postNo); //게시글 조회수
	
	int insertPost(PostVo postVo); //게시글 등록

	int updatePost(PostVo postVo);
	
	int deletePost(String PostNo);
	
	int insertReply(PostVo postVo); //답글 등록
	
	String getSelectBoardNm(String boardNo);
	
}
