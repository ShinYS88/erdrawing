package kr.or.ddit.erd.dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.slf4j.LoggerFactory;

import ch.qos.logback.classic.Logger;
import kr.or.ddit.erd.model.ErdVo;
import kr.or.ddit.test.logicTestConfig;

public class ErdDaoImplTest extends logicTestConfig{
	private Logger logger = (Logger) LoggerFactory.getLogger(ErdDaoImplTest.class);
	
	@Resource(name="erdDao")
	private IErdDao erdDao;

	/**
	* Method : testAddErd
	* 작성자 : PC08
	* 변경이력 :
	* Method 설명 : erd 생성 테스트
	*/
	@Test
	public void testAddErd() {
		/***Given***/
		ErdVo erdVo = new ErdVo();
		
		erdVo.setErdTitle("테스트코드타이틀");
		erdVo.setErdScope("public");
		erdVo.setMemId("user3");
		erdVo.setTeamNo(0);
		/***When***/
		int addCnt = erdDao.addErd(erdVo);

		/***Then***/
		assertEquals(addCnt, 1);

	}
	
	/**
	* Method : testGetMyErdList
	* 작성자 : PC08
	* 변경이력 :
	* Method 설명 : 나의 erd 리스트 가져오기 테스트
	*/
	@Test
	public void testGetMyErdList(){
		/***Given***/
		String memId = "user3";
		/***When***/
		List<ErdVo> myErdList = erdDao.getMyErdList(memId);

		/***Then***/
		assertNotNull(myErdList);

	}
	
	/**
	* Method : testDelErd
	* 작성자 : PC08
	* 변경이력 :
	* Method 설명 : erd 삭제
	*/
	@Test
	public void testDelErd(){
		/***Given***/
		int erdNo = 1194;
		/***When***/
		int delErd = erdDao.delErd(erdNo);
		/***Then***/
		assertNotNull(delErd);
	}
	
	/**
	* Method : testSearchList
	* 작성자 : PC08
	* 변경이력 :
	* Method 설명 : 검색된 public 리스트
	*/
	@Test
	public void testSearchList(){
		/***Given***/
		String search = "1";
		/***When***/
		List<ErdVo> searchList = erdDao.searchList(search);
		/***Then***/
		assertNotNull(searchList);
		logger.debug("***serachList : {}", searchList);

	}
	
	@Test
	public void testGetAllErdListOrder(){
		/***Given***/
		ErdVo erdVo = new ErdVo();
		erdVo.setOrderKind("");
		/***When***/
		List<ErdVo> allErdListOrder = erdDao.getAllErdListOrder(erdVo);
		/***Then***/
		assertNotNull(allErdListOrder);
		
		logger.debug("***orderKing : {}", allErdListOrder);

	}
	
	@Test
	public void testErdUdt(){
		/***Given***/
		ErdVo erdVo = new ErdVo();
		erdVo.setErdNo(1244);
		erdVo.setErdTitle("g");
		erdVo.setErdScope("private");
		erdVo.setMemId("user3");
		/***When***/
		int erdUdt = erdDao.erdUdt(erdVo);
		/***Then***/
		assertNotNull(erdUdt);
		logger.debug("***erdUdt : {}", erdUdt);

	}
	

}
