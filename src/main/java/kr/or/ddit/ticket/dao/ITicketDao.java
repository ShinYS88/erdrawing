package kr.or.ddit.ticket.dao;

import java.util.List;
import java.util.Map;

import kr.or.ddit.ticket.model.TicketBuyHistVo;
import kr.or.ddit.ticket.model.TicketRefHistVo;
import kr.or.ddit.ticket.model.TicketVo;
import kr.or.ddit.util.model.PageVo;

public interface ITicketDao {
	/**
	 * Method : getAllTicketList
	 * 작성자 : PC02
	 * 변경이력 :
	 * @return
	 * Method 설명 : 티켓 전체 조회
	 */
	List<TicketVo> getAllTicketList();
	
	
	/**
	 * Method : selectTicket
	 * 작성자 : PC02
	 * 변경이력 :
	 * @param ticketNo
	 * @return
	 * Method 설명 : 특정 티켓 정보 조회
	 */
	TicketVo selectTicket(String ticketNo);
	
	/**
	 * Method : insertTicket
	 * 작성자 : PC02
	 * 변경이력 :
	 * @param ticketVo
	 * @return
	 * Method 설명 :티켓 추가 
	 */
	int insertTicket(TicketVo ticketVo);
	
	/**
	 * Method : updateTicket
	 * 작성자 : PC02
	 * 변경이력 :
	 * @param ticketNo
	 * @return
	 * Method 설명 :티켓정보 수정
	 */
	int updateTicket(TicketVo ticketVo);
	
	/**
	 * Method : deleteTicket
	 * 작성자 : PC02
	 * 변경이력 :
	 * @param ticketNo
	 * @return
	 * Method 설명 : 티켓 삭제 
	 */
	int deleteTicket(String ticketNo);
	
	/**
	 * Method : selectTicketHist
	 * 작성자 : PC02
	 * 변경이력 :
	 * @param ticketNo
	 * @return
	 * Method 설명 : 티켓 
	 */
	List<TicketBuyHistVo> selectTicketHist(Map<String, Object> ticketMap);
	
	/**
	 * Method : selectTicketMonthList
	 * 작성자 : PC02
	 * 변경이력 :
	 * @param yyyy
	 * @return
	 * Method 설명 : 티켓별 매달 매출
	 */
	List<TicketBuyHistVo> selectTicketMonthList(Map<String, Object> ticketMap);

	
	/**
	 * Method : selectTicketYearList
	 * 작성자 : PC02
	 * 변경이력 :
	 * @param ticketNo
	 * @return
	 * Method 설명 :오늘을 기준으로 일년전 티켓매출내역 가져옴
	 */
	List<TicketBuyHistVo> selectTicketYearList(String ticketNo);
	
	/**
	 * Method : insertticketBuyHist
	 * 작성자 : PC02
	 * 변경이력 :
	 * @param ticketBuyHistVo
	 * @return
	 * Method 설명 :티켓구매
	 */
	int insertticketBuyHist(TicketBuyHistVo ticketBuyHistVo);
	
	/**
	 * Method : selectTicketYearPieList
	 * 작성자 : PC02
	 * 변경이력 :
	 * @param yyyy
	 * @return
	 * Method 설명 : 티켓별 매달 매출
	 */
	List<TicketBuyHistVo> selectTicketYearPieList(Map<String, Object> ticketMap);
	
	
	/**
	 * Method : getAllTicketRefList
	 * 작성자 : PC02
	 * 변경이력 :
	 * @return
	 * Method 설명 :전체 환불내역 가져오기
	 */
	
	List<Map<String, Object>> getAllTicketRefList(Map<String, Object> map);
	
	/**
	 * Method : getAllTicketRefListCnt
	 * 작성자 : PC02
	 * 변경이력 :
	 * @return
	 * Method 설명 : 티켓환불내역 갯수 가져오기
	 */
	int getAllTicketRefListCnt();
	
	/**
	 * Method : selectTicketBuyHist
	 * 작성자 : PC02
	 * 변경이력 :
	 * @param map
	 * @return
	 * Method 설명 : 티켓구매 정보+티켓 환불신청정보  가져오기
	 */
	List<Map<String, Object>> selectTicketBuyHist(String ticketBuyNo);
	
	/**
	 * Method : updateTicketRefDt
	 * 작성자 : PC02
	 * 변경이력 :
	 * @param ticketbutNo
	 * @return 
	 * Method 설 명 :환불 되면 환불된 날짜 업데이트
	 */
	int updateTicketRefDt(String ticketbutNo);
	
	List<Map<String, Object>> selectMyTicketDt(String memId);
	
	String selectEndDt(String addDt); 
	
	List<TicketVo> selectRefOkList(String memId);
	
	int insertTicketRef(TicketRefHistVo ticketRefHistVo);

	List<Map<String, Object>> selectTicketBuyList(String ticketBuyNo);
	
	// 사용중인 티켓 갯수
	int getUsingTicketCnt(String memId);
}
