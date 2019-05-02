package kr.or.ddit.post.service;

import static org.junit.Assert.assertEquals;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;

import kr.or.ddit.post.model.PostVo;
import kr.or.ddit.test.logicTestConfig;
import kr.or.ddit.util.model.PageVo;

public class PostServicemplTest extends logicTestConfig {
	
	@Resource(name = "postService")
	private IPostService postService;
	
	// 게시글 전체 리스트
	@Test
	public void testGetAllPost() {
		List<PostVo> postList = postService.getAllPost("1");

		assertEquals(5, postList.size());
	}
	
	// 특정 게시글 검색
	@Test
	public void testGetSelectPost() {
		String postNo = "1046";
		
		PostVo postVo = postService.getSelectPost(postNo);

		assertEquals("공지사항TEST", postVo.getPostTitle());
	}
	
	// 게시글 페이징 전체 리스트
	//List<PostVo> selectPostPagingList(PageVo pageVo);
	/*@Test
	public void testselectUserPagingList() {
		PageVo pageVo = new PageVO(1, 10, "12");
		Map<String, Object> map = board_dService.selectBoardPagingList(pageVO, "12");

		List<BoardDetailVO> postList = (List<BoardDetailVO>) map.get("boardList");
		int boardCnt = (int) map.get("boardCnt");

		assertNotNull(postList);
		assertEquals(10, postList.size());
	}*/
	
	// 게시글 생성
	@Test
	public void testInsertPost() {
		PostVo postVo = new PostVo();
		postVo.setBoardNo(1);
		postVo.setPostTitle("insertTest");
		postVo.setPostContent("insertTest");
		postVo.setWriterId("e");
		
		int insertCnt = postService.insertPost(postVo);

		assertEquals(1, insertCnt);
	}
	
	// 게시글 수정
	@Test
	public void testUpdatePost() {
		PostVo postVo = new PostVo();
		postVo.setPostNo(1067);
		postVo.setPostTitle("updateTest");
		postVo.setPostContent("updateTest");

		int updateCnt = postService.updatePost(postVo);

		assertEquals(1, updateCnt);
	}
	
	// 게시글 삭제
	@Test
	public void testDeletePost(){
		PostVo postVo = new PostVo();
		postVo.setPostNo(1067);
		postVo.setPostDelFlag("F");
		
		int deleteCnt = postService.deletePost("1067");
		
		assertEquals(1, deleteCnt);	
	}
	
	// 답글 생성
	@Test
	public void testInsertReply() {
		PostVo postVo = new PostVo();
		postVo.setBoardNo(3);
		postVo.setPostTitle("insertReplyTest");
		postVo.setPostContent("insertReplyTest");
		postVo.setPostGn(1065);
		postVo.setParentPostNo(1065);
		postVo.setWriterId("e");

		int insertReplyCnt = postService.insertReply(postVo);

		assertEquals(1, insertReplyCnt);
	}

	// 게시판 이름 검색
	@Test
	public void testGetSelectBoardNm() {
		assertEquals("공지사항", postService.getSelectBoardNm("1"));
	}
	
}
