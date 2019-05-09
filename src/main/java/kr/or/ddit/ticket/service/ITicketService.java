package kr.or.ddit.ticket.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.ticket.model.TicketBuyHistVo;
import kr.or.ddit.ticket.model.TicketRefHistVo;
import kr.or.ddit.ticket.model.TicketVo;
import kr.or.ddit.util.model.PageVo;

public interface ITicketService {

	List<TicketVo> getAllTicketList();
	
	TicketVo selectTicket(String ticketNo);
	
	int insertTicket(TicketVo ticketVo);

	int updateTicket(TicketVo ticketVo);

	
	int deleteTicket(String ticketNo);
	
	List<TicketBuyHistVo> selectTicketHist(Map<String, Object> ticketMap);
	
	List<TicketBuyHistVo> selectTicketMonthList(Map<String, Object> ticketMap);
	
	List<TicketBuyHistVo> selectTicketYearList(String ticketNo);
	
	int insertticketBuyHist(TicketBuyHistVo ticketBuyHistVo);
	
	List<TicketBuyHistVo> selectTicketYearPieList(Map<String, Object> ticketMap);

	List<Map<String, Object>> getAllTicketRefList(Map<String, Object> ticketMap);
	
	List<Map<String, Object>> selectTicketBuyHist(String ticketBuyNo);
	
	int updateTicketRefDt(String ticketbutNo);
	
	List<Map<String, Object>> selectMyTicketDt(String memId);
	
	String selectEndDt(String addDt);
	
	List<TicketVo> selectRefOkList(String memId);
	
	int insertTicketRef(TicketRefHistVo ticketRefHistVo);
	
	List<Map<String, Object>> selectTicketBuyList(String ticketBuyNo);
	
	// 사용중인 티켓 갯수
	int getUsingTicketCnt(String memId);
	}
