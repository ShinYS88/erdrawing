package kr.or.ddit.ticket.service;

import static org.junit.Assert.*;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.test.logicTestConfig;
import kr.or.ddit.ticket.dao.ITicketDao;

public class TicketServiceImplTest extends logicTestConfig{
	
	private Logger logger = LoggerFactory.getLogger(TicketServiceImplTest.class);
	
	@Resource(name="ticketService")
	private ITicketService ticketService;
	
	@Test
	public void testMyticketList() {
		List<Map<String, Object>> myTicketList = ticketService.selectMyTicketDt("user3");
	
		logger.debug("===={}",myTicketList);
		logger.debug("==size=={}",myTicketList.size());
		int totalPeriod=0;

		if(myTicketList.size()>0){
			for(int i = 0; i<myTicketList.size(); i++){
				 int PeriodUse = Integer.valueOf((String) myTicketList.get(i).get("PeriodUse"));
				 totalPeriod+=PeriodUse;
				 logger.debug("===totalPeriod={}",totalPeriod);
				logger.debug("===PeriodUse={}",PeriodUse);
			}
			
			String endDt = ticketService.selectEndDt(totalPeriod+"");
			logger.debug("====endDt{}==",endDt);
			
		}
		
		assertTrue(myTicketList.get(0).size()>0);
	
		}
	}
