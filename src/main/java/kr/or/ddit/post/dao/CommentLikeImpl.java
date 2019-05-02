package kr.or.ddit.post.dao;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.or.ddit.post.model.CommentLikeVo;

@Repository("commentLikeDao")
public class CommentLikeImpl implements ICommentLikeDao{
	
	@Resource(name = "sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List<CommentLikeVo> getSelectCmtLike(CommentLikeVo commentLikeVo) {
		List<CommentLikeVo> cmtLikeList = sqlSessionTemplate.selectList("post.getSelectCmtLike", commentLikeVo);

		return cmtLikeList;
	}

	@Override
	public int insertCmtLike(CommentLikeVo commentLikeVo) {
		int insertCnt = sqlSessionTemplate.insert("post.insertCmtLike", commentLikeVo);
		
		return insertCnt;
	}

	@Override
	public int deleteCmtLike(CommentLikeVo commentLikeVo) {
		int deleteCnt = sqlSessionTemplate.delete("post.deleteCmtLike", commentLikeVo);
		
		return deleteCnt;
	}

}
