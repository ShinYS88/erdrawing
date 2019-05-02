package kr.or.ddit.post.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.or.ddit.post.dao.ICommentLikeDao;
import kr.or.ddit.post.model.CommentLikeVo;

@Service("commentLikeService")
public class CommentLikeServiceImpl implements ICommentLikeService {
	
	@Resource(name="commentLikeDao")
	private ICommentLikeDao commentLikeDao;
	
	public CommentLikeServiceImpl(){
	}

	@Override
	public List<CommentLikeVo> getSelectCmtLike(CommentLikeVo commentLikeVo) {
		List<CommentLikeVo> cmtLikeList = commentLikeDao.getSelectCmtLike(commentLikeVo);
		
		return cmtLikeList;
	}

	@Override
	public int insertCmtLike(CommentLikeVo commentLikeVo) {
		int insertCnt = commentLikeDao.insertCmtLike(commentLikeVo);
		
		return insertCnt;
	}

	@Override
	public int deleteCmtLike(CommentLikeVo commentLikeVo) {
		int deleteCnt = commentLikeDao.deleteCmtLike(commentLikeVo);
		
		return deleteCnt;
	}


}
