package kr.or.ddit.team.service;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotEquals;
import static org.junit.Assert.assertNotNull;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.or.ddit.erd.model.ErdVo;
import kr.or.ddit.team.model.TagHistVo;
import kr.or.ddit.team.model.TagVo;
import kr.or.ddit.team.model.TeamListVo;
import kr.or.ddit.team.model.TeamVo;
import kr.or.ddit.test.logicTestConfig;

public class TeamServiceImplTest extends logicTestConfig{
	private Logger logger = LoggerFactory.getLogger(TeamServiceImplTest.class);
	
	@Resource(name="teamService")
	private ITeamService teamService;

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
		List<TeamListVo> teamAllList = teamService.getTeamAllList("user3");

		/***Then***/
		assertNotNull(teamAllList);
		logger.debug("====teamAllList : {}", teamAllList);
		

	}
	
	/**
	* Method : testGetMemberTeamInfoList
	* 작성자 : kjy
	* 변경이력 :
	* Method 설명 : 회원의 팀 정보 가져오기
	*/
	@Test
	public void testGetMemberTeamInfoList(){
		/***Given***/
		/***When***/
		List<TeamVo> memberTeamInfoList = teamService.getMemberTeamInfoList("user3");

		/***Then***/
		assertNotNull(memberTeamInfoList);
		
		logger.debug("====memberTeamInfoList : {}", memberTeamInfoList);
		

	}
	
	/**
	* Method : testGetMemberAgreTeamInfoList
	* 작성자 : kjy
	* 변경이력 :
	* Method 설명 : 회원이 수락한 팀 정보 가져오기
	*/
	@Test
	public void testGetMemberAgreTeamInfoList(){
		/***Given***/
		/***When***/
		List<TeamVo> memberTeamInfoList = teamService.getMemberAgreTeamInfoList("user3");

		/***Then***/
		assertNotNull(memberTeamInfoList);
		
		logger.debug("====memberTeamInfoList : {}", memberTeamInfoList);
		

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
		int insertTag = teamService.insertTag(tagVo);

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
		tagVo.setTagContent("5");
		tagVo.setTagMaker("user3");
		/***When***/
		int insertTag = teamService.insertTag(tagVo);

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
		tagHistVo.setTagNo(2);
		/***When***/
		int cnt = teamService.insertTagHist(tagHistVo);

		/***Then***/
		assertEquals(1, cnt);

		
	}
	
	/**
	* Method : testGetErdTagMap
	* 작성자 : PC08
	* 변경이력 :
	* Method 설명 : erd에 해당하는 태그 리스트 가져오기
	*/
/*	@Test
	public void testGetErdTagMap(){
		*//***Given***//*
		int erdNo = 1035;
		*//***When***//*
		Map<Integer, List<TagVo>> erdTagMap = teamService.getErdTagMap(erdNo);
		List<TagVo> list = erdTagMap.get(erdNo);

		*//***Then***//*
		assertEquals(2, list.size());

	}*/
	
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
		teamVo.setTeamNm("팀멤버생성테스트코드");
		teamVo.setTeamNo(11);
		
		List<String> member = new ArrayList<String>();
		member.add("user2");
		member.add("user1");
		member.add("user3");
		
		/***When***/
		int insertTeam = teamService.insertTeam(teamVo, member);

		/***Then***/
		assertNotNull(insertTeam);
		logger.debug("teamVo.getTeamNo : {}", teamVo.getTeamNo());

	}
	@Test
	public void testSplit(){
		String realFileName = "9.jpg";
		String[] split = realFileName.split("\\.");
		
		int length = split.length;
		
		String fileName = split[0];
		String ext = split[1];
		
		logger.debug("===fileName : {}", fileName);
		logger.debug("ext : {} ", ext);
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
		List<ErdVo> teamErdList = teamService.getTeamErdList(teamNo);
		/***Then***/
		assertNotNull(teamErdList);
		logger.debug("===teamErdList : {}", teamErdList);
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
		List<TeamListVo> teamAllListTeamNo = teamService.getTeamAllListTeamNo(teamNo);

		/***Then***/
		assertNotNull(teamAllListTeamNo);
		logger.debug("===teamAllListTeamNo", teamAllListTeamNo);

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
		vo.setTeamAuth("admin");
		
		int authUpdate = teamService.authUpdate(vo);
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
		int delMember = teamService.delMember(vo);
		/***Then***/
		assertNotNull(delMember);

	}
}
