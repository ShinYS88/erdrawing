package kr.or.ddit.post.service;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;

import kr.or.ddit.post.model.BoardVo;
import kr.or.ddit.test.logicTestConfig;

public class BoardServiceImplTest extends logicTestConfig {
	
	@Resource(name="boardService")
	private IBoardService boardService;

	// 게시판 전체 리스트
	@Test
	public void testGetAllBoard() {
		List<BoardVo> boardList = boardService.getAllBoard();
		for (BoardVo boardVo : boardList) {

			assertNotNull(boardService.getAllBoard());
			assertEquals(3, boardList.size());
		}
	}
	
	// 특정 게시판
	@Test
	public void testGetSelectBoard() {
		String boardNo = "1";

		BoardVo boardVo = boardService.getSelectBoard(boardNo);

		assertEquals("공지사항", boardVo.getBoardNm());
	}

}
