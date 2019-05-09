package kr.or.ddit.ticket.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.or.ddit.ticket.dao.ITicketDao;
import kr.or.ddit.ticket.model.TicketBuyHistVo;
import kr.or.ddit.ticket.model.TicketRefHistVo;
import kr.or.ddit.ticket.model.TicketVo;
import kr.or.ddit.util.model.PageVo;

@Service("ticketService")
public class TicketServiceImpl implements ITicketService{

	private Logger logger = LoggerFactory.getLogger(TicketServiceImpl.class);
	
	@Resource(name="ticketDao")
	private ITicketDao ticketDao;
	
	@Override
	public List<TicketVo> getAllTicketList() {
		return ticketDao.getAllTicketList();
	}

	@Override
	public TicketVo selectTicket(String ticketNo) {
		return ticketDao.selectTicket(ticketNo);
	}

	@Override
	public int insertTicket(TicketVo ticketVo) {
		return ticketDao.insertTicket(ticketVo);
	}

	@Override
	public int updateTicket(TicketVo ticketVo) {
		return ticketDao.updateTicket(ticketVo);
	}

	@Override
	public int deleteTicket(String ticketNo) {
		return ticketDao.deleteTicket(ticketNo);
	}

	@Override
	public List<TicketBuyHistVo> selectTicketHist(Map<String, Object> ticketMap) {
		return ticketDao.selectTicketHist(ticketMap);
	}

	@Override
	public List<TicketBuyHistVo> selectTicketMonthList(Map<String, Object> ticketMap) {
		return ticketDao.selectTicketMonthList(ticketMap);
	}

	@Override
	public List<TicketBuyHistVo> selectTicketYearList(String ticketNo) {
		return ticketDao.selectTicketYearList(ticketNo);
	}

	@Override
	public int insertticketBuyHist(TicketBuyHistVo ticketBuyHistVo) {
		return ticketDao.insertticketBuyHist(ticketBuyHistVo);
	}

	@Override
	public List<TicketBuyHistVo> selectTicketYearPieList(Map<String, Object> ticketMap) {
		return ticketDao.selectTicketYearPieList(ticketMap);
	}

	@Override
	public List<Map<String, Object>> getAllTicketRefList(Map<String, Object> ticketMap) {
	

		return ticketDao.getAllTicketRefList(ticketMap);	
		}

	@Override
	public List<Map<String, Object>> selectTicketBuyHist(String ticketBuyNo) {
		return ticketDao.selectTicketBuyHist(ticketBuyNo);	
	}

	@Override
	public int updateTicketRefDt(String ticketbutNo) {
		return ticketDao.updateTicketRefDt(ticketbutNo);	
	}

	@Override
	public List<Map<String, Object>> selectMyTicketDt(String memId) {
		return ticketDao.selectMyTicketDt(memId);	
	}

	@Override
	public String selectEndDt(String addDt) {
		return ticketDao.selectEndDt(addDt);	
	}

	@Override
	public List<TicketVo> selectRefOkList(String memId) {
		return ticketDao.selectRefOkList(memId);
	}

	@Override
	public int insertTicketRef(TicketRefHistVo ticketRefHistVo) {
		return ticketDao.insertTicketRef(ticketRefHistVo);
	}

	@Override
	public List<Map<String, Object>> selectTicketBuyList(String ticketBuyNo) {
		return ticketDao.selectTicketBuyList(ticketBuyNo);
	}

	@Override
	public int getUsingTicketCnt(String memId) {
		return ticketDao.getUsingTicketCnt(memId);
	}
}
