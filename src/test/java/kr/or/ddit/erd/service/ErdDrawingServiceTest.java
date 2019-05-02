package kr.or.ddit.erd.service;

import static org.junit.Assert.*;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.or.ddit.erd.model.DomainVo;
import kr.or.ddit.test.logicTestConfig;


public class ErdDrawingServiceTest extends logicTestConfig{
	private Logger logger = LoggerFactory.getLogger(ErdDrawingServiceTest.class);
	
	@Resource(name="erdDrawingService")
	private IErdDrawingService erdDrawingService;
	
	@Test
	public void domainListTest() {
		
		/***Given***/
		List<DomainVo> list = erdDrawingService.domainList(1098);
		

		/***When***/
		for(DomainVo vo : list){
			logger.debug("도메인 이름 : {}",vo.getDomainNm());
		}

		/***Then***/
		assertNotNull(list);
	}
	
	@Test
	public void domainUpdateTest(){
		/***Given***/
		DomainVo domainVo = new DomainVo();
		
		domainVo.setDomainDataType("타입");
		domainVo.setDomainDefaultValue("기본값");
		domainVo.setDomainNm("도메인이름");
		domainVo.setDomainNo(0);		// 0 : 추가 , else : 수정
		domainVo.setErdNo(1098);

		/***When***/
		erdDrawingService.domainUpdate(domainVo);
		/***Then***/

	}
	
	@Test
	public void domainDeleteTest(){
		/***Given***/
		int domainNo = 1016;

		/***When***/
		erdDrawingService.domainDelete(domainNo);
		/***Then***/
		
		assertTrue(domainNo > 0);

	}
	
	@Test
	public void domainSearchTest(){
		/***Given***/
		DomainVo domainVo = new DomainVo();
		domainVo.setErdNo(1244);
		domainVo.setDomainNm("테스트 이름");

		/***When***/
		List<DomainVo> list = erdDrawingService.domainSearch(domainVo);
		for(DomainVo vo : list){
			logger.debug("출력 : {}", vo.toString());
		}
		
		/***Then***/
		assertNotNull(list);
	}

}
