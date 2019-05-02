package kr.or.ddit.message.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.message.model.MessageVo;
import kr.or.ddit.team.model.TeamListVo;
import kr.or.ddit.util.model.PageVo;

public interface IMessageService {
	
	/**
	* Method : getAllMsg
	* 작성자 : PC08
	* 변경이력 :
	* @param memId
	* @return
	* Method 설명 : 멤버별 메시지 조회
	*/
	List<MessageVo> getAllMsg(String memId);
	
	/**
	* Method : insertMsg
	* 작성자 : PC08
	* 변경이력 :
	* @param memberMap
	* @return
	* Method 설명 : 알림 전송
	*/
	int insertMsg(Map<String, Object> memberMap);
	
	/**
	* Method : insertAplyMsg
	* 작성자 : PC08
	* 변경이력 :
	* @param messageVo
	* @return
	* Method 설명 : 회신 알림 전송
	*/
	int insertAplyMsg(MessageVo messageVo, TeamListVo teamListVo);
	
	/**
	* Method : delMsg
	* 작성자 : PC08
	* 변경이력 :
	* @param msgNo
	* @return
	* Method 설명 : 알림 삭제
	*/
	int delMsg(int msgNo);
	
	/**
	* Method : delMsgAll
	* 작성자 : PC08
	* 변경이력 :
	* @param memId
	* @return
	* Method 설명 : 메시지 전체 삭제
	*/
	int delMsgAll(String memId);
	
	/**
	* Method : msgPagingList
	* 작성자 : PC08
	* 변경이력 :
	* @param pageVo
	* @return
	* Method 설명 : 알림 페이징 리스트
	*/
	List<MessageVo> msgPagingList(PageVo pageVo, String memId);
	
	/**
	* Method : getMsgCnt
	* 작성자 : PC08
	* 변경이력 :
	* @param receiverId
	* @return
	* Method 설명 : 알림 갯수
	*/
	int getMsgCnt(String receiverId);
	
	/**
	* Method : insertMsgOne
	* 작성자 : PC08
	* 변경이력 :
	* @param messageVo
	* @return
	* Method 설명 : 한명에게 알림 전송
	*/
	int insertMsgOne(MessageVo messageVo);
}
