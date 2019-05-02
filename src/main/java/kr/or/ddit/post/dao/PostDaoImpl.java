package kr.or.ddit.post.dao;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.or.ddit.post.model.PostVo;
import kr.or.ddit.post.model.UploadFileVo;
import kr.or.ddit.util.model.PageVo;

@Repository("postDao")
public class PostDaoImpl implements IPostDao {
	
	@Resource(name = "sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List<PostVo> getAllPost(String boardNo) {
		List<PostVo> postList = sqlSessionTemplate.selectList("post.getAllPost",boardNo);
		
		return postList;
	}

	@Override
	public PostVo getSelectPost(String postNo) {
		PostVo postVO = sqlSessionTemplate.selectOne("post.getSelectPost", postNo);
		
		return postVO;
	}

	@Override
	public List<PostVo> selectPostPagingList(PageVo pageVo) {
		int boardNo = pageVo.getBoardNo();
		List<PostVo> postList;
		if(boardNo == 1){
			 postList = sqlSessionTemplate.selectList("post.selectNoticePagingList", pageVo);
		}
		else{
			 postList = sqlSessionTemplate.selectList("post.selectPostPagingList", pageVo);
		}
		return postList;
	}

	@Override
	public int getPostCnt(int boardNo) {
		int postCnt = sqlSessionTemplate.selectOne("post.getPostCnt", boardNo);
		
		return postCnt;
	}
	
	@Override
	public int getViewCnt(String postNo) {
		int postViewCnt = sqlSessionTemplate.update("post.getViewCnt", postNo);
		
		return postViewCnt;
	}

	@Override
	public int insertPost(PostVo postVo) {
		int insertCnt = sqlSessionTemplate.insert("post.insertPost", postVo);
		
		return insertCnt;
	}

	@Override
	public int updatePost(PostVo postVo) {
		int updateCnt = sqlSessionTemplate.update("post.updatePost", postVo);
		
		return updateCnt;
	}

	@Override
	public int deletePost(String PostNo) {
		int deleteCnt = sqlSessionTemplate.delete("post.deletePost", PostNo);
		
		return deleteCnt;
	}
	
	@Override
	public int insertReply(PostVo postVo) {
		int insertCnt = sqlSessionTemplate.insert("post.insertReply", postVo);
		
		return insertCnt;
	}

	@Override
	public String getSelectBoardNm(String boardNo) {
		String boardNm = sqlSessionTemplate.selectOne("post.getSelectBoardNm", boardNo);
		return boardNm;
	}

	
}
