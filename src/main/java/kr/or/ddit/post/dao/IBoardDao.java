package kr.or.ddit.post.dao;

import java.util.List;

import kr.or.ddit.post.model.BoardVo;

public interface IBoardDao {
	
	List<BoardVo> getAllBoard();

	BoardVo getSelectBoard(String boardNo);
	
}
