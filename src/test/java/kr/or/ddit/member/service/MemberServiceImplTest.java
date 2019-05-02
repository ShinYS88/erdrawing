package kr.or.ddit.member.service;

import static org.junit.Assert.*;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.test.logicTestConfig;

public class MemberServiceImplTest extends logicTestConfig{
	
	private Logger logger = LoggerFactory.getLogger(MemberServiceImplTest.class);
	
	@Resource(name="memberService")
	private IMemberService memberService;
	
	@Test
	public void test() {
	//	assertNotNull(memberService.selectMember("user212"));
		assertNull(memberService.selectMember("user212"));
		assertEquals("윤한수",memberService.selectMember("user1").getMemNm());
		assertEquals(null,memberService.selectMember("user1333"));
	}
	
	/**
	* Method : testGetAutoFindMem
	* 작성자 : PC08
	* 변경이력 :
	* Method 설명 : 멤버 자동완성 검색
	*/
	@Test
	public void testGetAutoFindMem(){
		/***Given***/
		String memId = "u";
		/***When***/
		List<MemberVo> autoFindMem = memberService.getAutoFindMem(memId);
		/***Then***/
		assertNotNull(autoFindMem);
		logger.debug("===autoFindMem : {}", autoFindMem);
		
	}

}
