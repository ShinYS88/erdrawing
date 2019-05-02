package kr.or.ddit.post.service;

import java.util.List;

import kr.or.ddit.post.model.CommentLikeVo;

public interface ICommentLikeService {
	
	// 댓글 좋아요 특정 조회
	List<CommentLikeVo> getSelectCmtLike(CommentLikeVo commentLikeVo);

	// 댓글 좋아요 선택(생성)
	int insertCmtLike(CommentLikeVo commentLikeVo);
	
	// 댓글 좋아요 취소(삭제)
	int deleteCmtLike(CommentLikeVo commentLikeVo);

}
