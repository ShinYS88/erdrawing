package kr.or.ddit.post.dao;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.or.ddit.post.model.CommentsVo;
import kr.or.ddit.util.model.PageVo;

@Repository("commentsDao")
public class CommentsDaoImpl implements ICommentsDao {
	
	@Resource(name = "sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List<CommentsVo> getAllComments(String postNo) {
		List<CommentsVo> CommentsList = sqlSessionTemplate.selectList("post.getAllComments", postNo);

		return CommentsList;
	}
	
	@Override
	public List<CommentsVo> getPagingAllComments(PageVo pageVo) {
		List<CommentsVo> cmtPagingList = sqlSessionTemplate.selectList("post.getPagingAllComments", pageVo);
	
		return cmtPagingList;
	}
	
	@Override
	public int getCmtCnt(int postNo) {
		int cmtCnt = sqlSessionTemplate.selectOne("post.getCmtCnt", postNo);
		
		return cmtCnt;
	}

	@Override
	public CommentsVo getSelectComments(String cmtNo) {
		CommentsVo commentsVo = sqlSessionTemplate.selectOne("post.getSelectComments", cmtNo);
		
		return commentsVo;
	}

	@Override
	public int insertComments(CommentsVo commentsVo) {
		int insertCnt = sqlSessionTemplate.insert("post.insertComments", commentsVo);
		
		return insertCnt;
	}

	@Override
	public int deleteComments(String cmtNo) {
		int deleteCnt = sqlSessionTemplate.delete("post.deleteComments", cmtNo);
		
		return deleteCnt;
	}

}
