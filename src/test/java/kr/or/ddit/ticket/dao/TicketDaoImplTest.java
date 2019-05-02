package kr.or.ddit.ticket.dao;

import static org.junit.Assert.*;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.map.HashedMap;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.test.logicTestConfig;
import kr.or.ddit.ticket.model.TicketBuyHistVo;
import kr.or.ddit.ticket.model.TicketRefHistVo;
import kr.or.ddit.ticket.model.TicketVo;
import kr.or.ddit.util.encrypt.kisa.sha256.KISA_SHA256;
import kr.or.ddit.util.model.PageVo;

public class TicketDaoImplTest extends logicTestConfig{
	private Logger logger = LoggerFactory.getLogger(TicketDaoImplTest.class);
	
	@Resource(name="ticketDao")
	private ITicketDao ticketDao;

	@Test
	public void testTicketHistList() {
		Map<String,Object> map = new HashedMap();
		map.put("startDt", "20181101");
		map.put("endDt", "20200101");
		map.put("ticketNo", "2");
		List<TicketBuyHistVo> list = ticketDao.selectTicketHist(map);
		for(TicketBuyHistVo vo: list )
		assertTrue(list.size()>20);
	}

	@Test
	public void testTicketMonthList() {
		Map<String,Object> map = new HashMap<>();
		map.put("yyyy", "2018");
		map.put("ticketNo", 2);
		List<TicketBuyHistVo> list = (List<TicketBuyHistVo>) ticketDao.selectTicketMonthList(map);
		logger.debug("====ser{}",list);
		
		assertTrue(list.size()>0);
	}
	
	@Test
	public void testSelectTicketYearList() {
		List<TicketBuyHistVo> list =  ticketDao.selectTicketYearList("2");
		
		logger.debug("====ser{}",list);
		
		assertTrue(list.size()>0);
		assertTrue(list.size()==12);
	}
	
	@Test
	public void testSelectTicketRefList() {
		
		Map<String, Object> map = new HashMap<>();
		PageVo vo = new PageVo();
		
		logger.debug("====sersssasdasd{}",vo.getPageNo());
		map.put("pageNo", 1);
		map.put("pageSize", 10);
		List<Map<String, Object>> list =  ticketDao.getAllTicketRefList(map);
		logger.debug("====serssssssssssssds{}",vo.getPageNo());
		logger.debug("====ser122 : {}",map.get("pageNo"));
		
		int cnts = Integer.valueOf((String) list.get(0).get("CNT"));
		logger.debug(list.toString());
		
		vo.setPageNo((int) map.get("pageNo"));
		vo.setPageNo((int) map.get("pageSize"));
		vo.setTotalCount(cnts);
		logger.debug("====ser1{}",list.get(0));
		logger.debug("====ser2{}",vo.getPageNo()-1);
		logger.debug("====ser2{}",vo.getPageSize());
		logger.debug("====ser4{}",vo.getPrevPageNo());
		logger.debug("====ser5{}",vo.getEndPageNo());
		
		
		 
		logger.debug("====ser3{}",cnts);
		
		assertTrue(list.size()>0);
	}
	
	
	

}
