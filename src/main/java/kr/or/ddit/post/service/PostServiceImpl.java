package kr.or.ddit.post.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.or.ddit.post.dao.IPostDao;
import kr.or.ddit.post.model.PostVo;
import kr.or.ddit.post.model.UploadFileVo;
import kr.or.ddit.util.model.PageVo;

@Service("postService")
public class PostServiceImpl implements IPostService {
	
	@Resource(name="postDao")
	private IPostDao postDao;
	
	public PostServiceImpl(){
		
	}
	
	@Override
	public List<PostVo> getAllPost(String boardNo) {
		List<PostVo> postList = postDao.getAllPost(boardNo);
	    
	    return postList;
	}

	@Override
	public PostVo getSelectPost(String postNo) {
		PostVo postVo = postDao.getSelectPost(postNo);
		
		return postVo;
	}

	/*@Override
	public Map<String, Object> selectPostPagingList(PageVo pageVo, String boardNo) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("postList", postDao.selectPostPagingList(pageVo));
		resultMap.put("postCnt", postDao.getPostCnt(boardNo));

		return resultMap;
	}*/
	
	@Override
	public List<PostVo> selectPostPagingList(PageVo pageVo) {
		int totalCount = postDao.getPostCnt(pageVo.getBoardNo());
		pageVo.setTotalCount(totalCount);
		
		List<PostVo> postList = new ArrayList<>();
		postList = postDao.selectPostPagingList(pageVo);

		return postList;
	}
	
	@Override
	public int getViewCnt(String postNo) {
		int postViewCnt = postDao.getViewCnt(postNo);
		
		return postViewCnt;
	}

	@Override
	public int insertPost(PostVo postVo) {
		int insertCnt = postDao.insertPost(postVo);
		 
		return insertCnt;
	}

	@Override
	public int updatePost(PostVo postVo) {
		int updateCnt = postDao.updatePost(postVo);
		
		return updateCnt;
	}

	@Override
	public int deletePost(String PostNo) {
		int deleteCnt = postDao.deletePost(PostNo);
		
		return deleteCnt;
	}
	
	@Override
	public int insertReply(PostVo postVo) {
		int insertCnt = postDao.insertReply(postVo);
		 
		return insertCnt;
	}	

	@Override
	public String getSelectBoardNm(String boardNo) {
		String boardNm = postDao.getSelectBoardNm(boardNo);
		
		return boardNm;
	}

	
}
