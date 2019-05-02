package kr.or.ddit.post.service;

import java.util.List;

import kr.or.ddit.post.model.BoardVo;

public interface IBoardService {
	
	List<BoardVo> getAllBoard();
	
	BoardVo getSelectBoard(String boardNo);
	
}
