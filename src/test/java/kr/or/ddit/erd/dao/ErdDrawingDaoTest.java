package kr.or.ddit.erd.dao;

import static org.junit.Assert.*;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.or.ddit.erd.model.DomainVo;
import kr.or.ddit.test.logicTestConfig;

public class ErdDrawingDaoTest extends logicTestConfig{
	private Logger logger = LoggerFactory.getLogger(ErdDrawingDaoTest.class);

	@Resource(name="erdDrawingDao")
	private IErdDrawingDao erdDrawingDao;
	
	
	@Test
	public void domainListTest() {

		/***Given***/

		/***When***/
		List<DomainVo> list = erdDrawingDao.domainList(1098);
		for(DomainVo vo : list){
			logger.debug("도메인 이름 : {}", vo.getDomainNm());
		}
		
		/***Then***/
		assertNotNull(list);

	}
	
	@Test
	public void domainInsertTest(){
		/***Given***/
		DomainVo domainVo = new DomainVo();
		
		domainVo.setDomainNm("테스트 이름2");
		domainVo.setDomainDataType("VARCHAR2");
		domainVo.setDomainDefaultValue("기본 값2");
		domainVo.setErdNo(1098);

		/***When***/
		int cnt = erdDrawingDao.domainInsert(domainVo);

		/***Then***/
		assertTrue(cnt>0);
	}
	
	@Test
	public void domainModifyTest(){
		/***Given***/
		DomainVo domainVo = new DomainVo();
		
		domainVo.setDomainNo(1000);
		domainVo.setDomainNm("테스트 이름6");
		domainVo.setDomainDataType("VARCHAR2");
		domainVo.setDomainDefaultValue("기본 값6");

		/***When***/
		int cnt = erdDrawingDao.domainModify(domainVo);

		/***Then***/
		assertTrue(cnt>0);
	}
	
	@Test
	public void domainDeleteTest(){
		/***Given***/
		

		/***When***/
		int cnt = erdDrawingDao.domainDelete(1001);
		
		/***Then***/
		assertTrue(cnt > 0);
		

	}
	
	@Test
	public void domainSearchTest(){
		/***Given***/
		DomainVo domainVo = new DomainVo();
		domainVo.setErdNo(1244);
		domainVo.setDomainNm("테스트 이름");

		/***When***/
		List<DomainVo> list = erdDrawingDao.domainSearch(domainVo);
		for(DomainVo vo : list){
			logger.debug("출력 : {}", vo.toString());
		}
		
		/***Then***/
		assertNotNull(list);
	}
	

}
