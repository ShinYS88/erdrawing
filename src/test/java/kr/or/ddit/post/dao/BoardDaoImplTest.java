package kr.or.ddit.post.dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;

import kr.or.ddit.post.dao.IBoardDao;
import kr.or.ddit.post.model.BoardVo;
import kr.or.ddit.test.logicTestConfig;

public class BoardDaoImplTest extends logicTestConfig{
	@Resource(name = "boardDao")
	private IBoardDao boardDao;
	// 게시판 전체 리스트
	@Test
	public void testGetAllBoard() {
		List<BoardVo> boardList = boardDao.getAllBoard();
		for (BoardVo boardVo : boardList) {

		assertNotNull(boardDao.getAllBoard());
		assertEquals(3, boardList.size());
		}
	}
	
	// 특정 게시판
	@Test
	public void testGetSelectBoard() {
		String boardNo = "1";

		BoardVo boardVo = boardDao.getSelectBoard(boardNo);

		assertEquals("공지사항", boardVo.getBoardNm());
	}

}
