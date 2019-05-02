package kr.or.ddit.post.dao;

import static org.junit.Assert.assertEquals;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;

import kr.or.ddit.post.model.CommentsVo;
import kr.or.ddit.post.model.PostVo;
import kr.or.ddit.test.logicTestConfig;

public class CommentsDaoImplTest extends logicTestConfig {
	
	@Resource(name = "commentsDao")
	private ICommentsDao commentsDao;

	// 댓글 전체 리스트
	@Test
	public void testGetAllComments() {
		List<CommentsVo> cmtList = commentsDao.getAllComments("1020");

		assertEquals(1, cmtList.size());
	}
	
	// 특정 댓글 검색
	@Test
	public void testSelectComments() {
		String postNo = "1020";

		CommentsVo cmtVo = commentsDao.getSelectComments("1102");

		assertEquals("7", cmtVo.getCmtContent());
	}
	
	// 댓글 생성
	@Test
	public void testInsertComments() {
		CommentsVo cmtVo = new CommentsVo();
		cmtVo.setCmtContent("cmtTest");
		cmtVo.setMemId("e");
		cmtVo.setPostNo(1020);
	
		int insertCmtCnt = commentsDao.insertComments(cmtVo);

		assertEquals(1, insertCmtCnt);
	}
	
	// 댓글 삭제
	@Test
	public void testDeleteComments() {
		String cmtNo = "1120";

		int delectCmtCnt = commentsDao.deleteComments(cmtNo);

		assertEquals(1, delectCmtCnt);
	}
	
}
