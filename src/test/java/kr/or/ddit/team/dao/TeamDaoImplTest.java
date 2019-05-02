package kr.or.ddit.team.dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotEquals;
import static org.junit.Assert.assertNotNull;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.or.ddit.erd.model.ErdVo;
import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.team.model.TagHistVo;
import kr.or.ddit.team.model.TagVo;
import kr.or.ddit.team.model.TeamListVo;
import kr.or.ddit.team.model.TeamVo;
import kr.or.ddit.test.logicTestConfig;

public class TeamDaoImplTest extends logicTestConfig{
	private Logger logger = LoggerFactory.getLogger(TeamDaoImplTest.class);
	
	@Resource(name="teamDao")
	private ITeamDao teamDao;

	/**
	* Method : testGetTeamAllList
	* 작성자 : kjy
	* 변경이력 :
	* Method 설명 : 회원의 팀 리스트 가져오기
	*/
	@Test
	public void testGetTeamAllList() {
		/***Given***/
		
		/***When***/
		List<TeamListVo> teamAllList = teamDao.getTeamAllList("user3");

		/***Then***/
		assertNotNull(teamAllList);
		logger.debug("====teamAllList : {}", teamAllList);
		
	}
	
	/**
	* Method : testGetTeamInfo
	* 작성자 : kjy
	* 변경이력 :
	* Method 설명 : 팀 정보 가져오기
	*/
	@Test
	public void testGetTeamInfo() {
		/***Given***/
		
		/***When***/
		TeamVo teamVo = teamDao.getTeamInfo(1);

		/***Then***/
		assertNotNull(teamVo);
		logger.debug("====teamVo : {}", teamVo);
		
	}
	
	/**
	* Method : testInsertTag
	* 작성자 : kjy
	* 변경이력 :
	* Method 설명 : 태그 insert 중복 됐을 때
	*/
	@Test
	public void testInsertTagDuple() {
		/***Given***/
		TagVo tagVo = new TagVo();
		tagVo.setTagContent("1");
		tagVo.setTagMaker("user3");
		/***When***/
		int insertTag = teamDao.insertTag(tagVo);

		/***Then***/
		assertNotEquals(1, insertTag);
		
	}
	
	/**
	* Method : testInsertTagNew
	* 작성자 : kjy
	* 변경이력 :
	* Method 설명 : 태그 insert 중복 없을 때
	*/
	@Test
	public void testInsertTagNew() {
		/***Given***/
		TagVo tagVo = new TagVo();
		tagVo.setTagContent("4");
		tagVo.setTagMaker("user3");
		/***When***/
		int insertTag = teamDao.insertTag(tagVo);

		/***Then***/
		assertEquals(1, insertTag);
		
	}
	
	/**
	* Method : testInsertTagHist
	* 작성자 : kjy
	* 변경이력 :
	* Method 설명 : 태그, erd 맵핑 테스트
	*/
	@Test
	public void testInsertTagHist(){
		/***Given***/
		TagHistVo tagHistVo = new TagHistVo();
		tagHistVo.setErdNo(1035);
		tagHistVo.setTagNo(1);
		/***When***/
		int cnt = teamDao.insertTagHist(tagHistVo);

		/***Then***/
		assertEquals(1, cnt);

		
	}
	
	@Test
	public void testGetTagNo(){
		/***Given***/
		String content = "1";
		/***When***/
		int tagNo = teamDao.getTagNo(content);

		/***Then***/
		assertEquals(1, tagNo);

	}
	
	@Test
	public void testGetErdTag(){
		/***Given***/
		int erdNo = 1035;
		/***When***/
		List<TagVo> erdTag = teamDao.getErdTag(erdNo);

		/***Then***/
		assertNotNull(erdTag);
	}
	
	/**
	* Method : testInsertTeam
	* 작성자 : PC08
	* 변경이력 :
	* Method 설명 : 팀 생성 테스트
	*/
	@Test
	public void testInsertTeam(){
		/***Given***/
		TeamVo teamVo = new TeamVo();
		teamVo.setMakerId("user3");
		teamVo.setTeamNm("테스트코드");
		teamVo.setTeamNo(9);
		
		/***When***/
		int insertTeam = teamDao.insertTeam(teamVo);

		/***Then***/
		assertNotNull(insertTeam);
		logger.debug("teamVo.getTeamNo : {}", teamVo.getTeamNo());

	}
	
	/**
	* Method : testGetTeamErdList
	* 작성자 : PC08
	* 변경이력 :
	* Method 설명 : teamErd 가져오기
	*/
	@Test
	public void testGetTeamErdList(){
		/***Given***/
		int teamNo = 2;
		/***When***/
		List<ErdVo> teamErdList = teamDao.getTeamErdList(teamNo);
		/***Then***/
		assertNotNull(teamErdList);
		logger.debug("===teamErdList : {}", teamErdList);
	}
	
	/**
	* Method : testInsertTeamMember
	* 작성자 : kjy
	* 변경이력 :
	* Method 설명 : 팀 멤버 추가 테스트
	*/
	@Test
	public void testInsertTeamMember(){
		/***Given***/
		TeamListVo teamListVo = new TeamListVo();
		teamListVo.setMemId("user2");
		teamListVo.setTeamNo(1008);
		/***When***/
		int insertTeamMember = teamDao.insertTeamMember(teamListVo);

		/***Then***/
		assertNotNull(insertTeamMember);

	}
	/**
	* Method : testInsertTeamMember
	* 작성자 : kjy
	* 변경이력 :
	* Method 설명 : 팀 멤버 추가 테스트 생성자
	*/
	@Test
	public void testInsertTeamMemberCreator(){
		/***Given***/
		TeamListVo teamListVo = new TeamListVo();
		teamListVo.setMemId("user3");
		teamListVo.setTeamNo(1009);
		teamListVo.setTeamAgreeFlag("y");
		teamListVo.setTeamAuth("creator");
		/***When***/
		int insertTeamMember = teamDao.insertTeamMember(teamListVo);

		/***Then***/
		assertNotNull(insertTeamMember);

	}
	
	/**
	* Method : testGetTeamAllListTeamNo
	* 작성자 : kjy
	* 변경이력 :
	* Method 설명 : 팀리스트 가져오기(팀 번호)
	*/
	@Test
	public void testGetTeamAllListTeamNo(){
		/***Given***/
		int teamNo = 1010;
		/***When***/
		List<TeamListVo> teamAllListTeamNo = teamDao.getTeamAllListTeamNo(teamNo);

		/***Then***/
		assertNotNull(teamAllListTeamNo);
		logger.debug("===teamAllListTeamNo:{}", teamAllListTeamNo);

	}
	
	/**
	* Method : testGetTeamMember
	* 작성자 : kjy
	* 변경이력 :
	* Method 설명 : 팀 멤버 가져오기
	*/
	@Test
	public void testGetTeamMember(){
		/***Given***/
		int teamNo = 1010;
		/***When***/
		List<MemberVo> teamMember = teamDao.getTeamMember(teamNo);
		/***Then***/
		assertNotNull(teamMember);
		logger.debug("===teamMember : {}", teamMember);

	}
	
	/**
	* Method : testAuthUpdate
	* 작성자 : PC08
	* 변경이력 :
	* Method 설명 : 멤버 권한 수정 테스트
	*/
	@Test
	public void testAuthUpdate(){
		/***Given***/
		TeamListVo vo = new TeamListVo();
		/***When***/
		vo.setMemId("user2");
		vo.setTeamNo(1010);
		vo.setTeamAuth("user");
		
		int authUpdate = teamDao.authUpdate(vo);
		/***Then***/
		assertNotNull(authUpdate);
	}
	
	/**
	* Method : testDelMember
	* 작성자 : PC08
	* 변경이력 :
	* Method 설명 : 팀 멤버 삭제
	*/
	@Test
	public void testDelMember(){
		/***Given***/
		TeamListVo vo = new TeamListVo();
		vo.setMemId("user2");
		vo.setTeamNo(1010);
		/***When***/
		int delMember = teamDao.delMember(vo);
		/***Then***/
		assertNotNull(delMember);

	}
	
	@Test
	public void testUpdateAgreeFlag(){
		/***Given***/
		TeamListVo vo = new TeamListVo();
		vo.setMemId("user2");
		vo.setTeamNo(1027);
		vo.setTeamAgreeFlag("n");
		/***When***/
		int updateAgreeFlag = teamDao.updateAgreeFlag(vo);
		/***Then***/
		assertNotNull(updateAgreeFlag);
	}
	
	@Test
	public void testTeamMofify(){
		/***Given***/
		TeamVo teamVo = new TeamVo();
		teamVo.setTeamIntro("팀 수정 테스트");
		teamVo.setTeamNo(1010);
		teamVo.setTeamNm("바꿨지");
		/***When***/
		int teamModify = teamDao.teamModify(teamVo);
		/***Then***/
		assertNotNull(teamModify);

	}
	
}
