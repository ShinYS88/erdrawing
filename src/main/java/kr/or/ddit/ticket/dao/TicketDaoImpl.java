package kr.or.ddit.ticket.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.or.ddit.ticket.model.TicketBuyHistVo;
import kr.or.ddit.ticket.model.TicketRefHistVo;
import kr.or.ddit.ticket.model.TicketVo;
import kr.or.ddit.util.model.PageVo;

@Repository("ticketDao")
public class TicketDaoImpl implements ITicketDao{

	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<TicketVo> getAllTicketList() {
		return sqlSession.selectList("ticket.getAllTicketList");
	}

	@Override
	public TicketVo selectTicket(String ticketNo) {
		return sqlSession.selectOne("ticket.selectTicket",ticketNo);
	}

	@Override
	public int insertTicket(TicketVo ticketVo) {
		return sqlSession.insert("ticket.insertTicket",ticketVo);
	}

	@Override
	public int updateTicket(TicketVo ticketVo) {
		return sqlSession.update("ticket.updateTicket",ticketVo);
	}

	@Override
	public int deleteTicket(String ticketNo) {
		return sqlSession.delete("ticket.deleteTicket",ticketNo);
	}

	@Override
	public List<TicketBuyHistVo> selectTicketHist(Map<String, Object> ticketMap) {
		return sqlSession.selectList("ticket.selectTicketHist",ticketMap);
	}

	@Override
	public List<TicketBuyHistVo> selectTicketMonthList(Map<String, Object> ticketMap) {
		return sqlSession.selectList("ticket.selectTicketMonthList",ticketMap);
	}

	@Override
	public List<TicketBuyHistVo> selectTicketYearList(String ticketNo) {
		return sqlSession.selectList("ticket.selectTicketYearList",ticketNo);
	}

	@Override
	public int insertticketBuyHist(TicketBuyHistVo ticketBuyHistVo) {
		return sqlSession.insert("ticket.insertticketBuyHist",ticketBuyHistVo);
	}

	@Override
	public List<TicketBuyHistVo> selectTicketYearPieList(Map<String, Object> ticketMap) {
		return sqlSession.selectList("ticket.selectTicketYearPieList",ticketMap);
	}

	@Override
	public List<Map<String, Object>> getAllTicketRefList(Map<String, Object> map) {
		return  sqlSession.selectList("ticket.getAllTicketRefList",map);
		
	}

	@Override
	public int getAllTicketRefListCnt() {
		return  sqlSession.selectOne("ticket.getAllTicketRefListCnt");
	}

	@Override
	public List<Map<String, Object>> selectTicketBuyHist(String ticketBuyNo) {
		return sqlSession.selectList("ticket.selectTicketBuyHist",ticketBuyNo);
	}

	@Override
	public int updateTicketRefDt(String ticketbutNo) {
		return sqlSession.update("ticket.updateTicketRefDt",ticketbutNo);
	}

	@Override
	public List<Map<String, Object>> selectMyTicketDt(String memId) {
		return sqlSession.selectList("ticket.selectMyTicketDt",memId);
	}

	@Override
	public String selectEndDt(String addDt) {
		return sqlSession.selectOne("ticket.selectEndDt",addDt);
	}

	@Override
	public List<TicketVo> selectRefOkList(String memId) {
		return sqlSession.selectList("ticket.selectRefOkList",memId);
	}

	@Override
	public int insertTicketRef(TicketRefHistVo ticketRefHistVo) {
		return sqlSession.insert("ticket.insertTicketRef",ticketRefHistVo);
	}

	@Override
	public List<Map<String, Object>> selectTicketBuyList(String ticketBuyNo) {
		return sqlSession.selectList("ticket.selectTicketBuyList",ticketBuyNo);
	}

	@Override
	public int getUsingTicketCnt(String memId) {
		return sqlSession.selectOne("ticket.getUsingTicketCnt", memId);
	}
	
	

}
