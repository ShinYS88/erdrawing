package kr.or.ddit.post.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.or.ddit.post.dao.IBoardDao;
import kr.or.ddit.post.model.BoardVo;

@Service("boardService")
public class BoardServiceImpl implements IBoardService {
	
	@Resource(name="boardDao")
	private IBoardDao boardDao;
	
	public BoardServiceImpl(){
	}

	@Override
	public List<BoardVo> getAllBoard() {
		List<BoardVo> boardList = boardDao.getAllBoard();

		return boardList;
	}

	@Override
	public BoardVo getSelectBoard(String boardNo) {
		BoardVo boardVo = boardDao.getSelectBoard(boardNo);
		
		return boardVo;
	}

}
