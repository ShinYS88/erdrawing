package kr.or.ddit.message.service;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.or.ddit.message.model.MessageVo;
import kr.or.ddit.test.logicTestConfig;
import kr.or.ddit.util.model.PageVo;

public class MessageServiceImplTest extends logicTestConfig{
	private Logger logger = LoggerFactory.getLogger(MessageServiceImplTest.class);
	
	@Resource(name="messageService")
	private IMessageService messageService;

	/**
	* Method : testGetAllMsg
	* 작성자 : PC08
	* 변경이력 :
	* Method 설명 : 멤버 별 메시지 조회
	*/
	@Test
	public void testGetAllMsg() {
		/***Given***/
		String memId = "user2";
		/***When***/
		List<MessageVo> allMsg = messageService.getAllMsg(memId);

		/***Then***/
		assertNotNull(allMsg);
		logger.debug("===allMsg : {}", allMsg);
	}
	
	/**
	* Method : testInsertMsg
	* 작성자 : PC08
	* 변경이력 :
	* Method 설명 : 알림 전송 테스트
	*/
	@Test
	public void testInsertMsg(){
		/***Given***/
		Map<String, Object> memberMap = new HashMap<String, Object>();
		List<MessageVo> memList = new ArrayList<MessageVo>();
		
		String senderId = "user2";
		String content = senderId + "님이 ~팀에 초대하였습니다.";
		
		MessageVo vo = new MessageVo();
		vo.setSenderId(senderId);
		vo.setReceiverId("user3");
		vo.setMsgContent(content);

		MessageVo vo1 = new MessageVo();
		vo1.setSenderId(senderId);
		vo1.setReceiverId("user3");
		vo1.setMsgContent(content);
		
		MessageVo vo2 = new MessageVo();
		vo2.setSenderId(senderId);
		vo2.setReceiverId("user3");
		vo2.setMsgContent(content);
		
		memList.add(vo);
		memList.add(vo1);
		memList.add(vo2);
		
		memberMap.put("memList", memList);
		
		/***When***/
		int insertMsg = messageService.insertMsg(memberMap);

		/***Then***/
		assertNotNull(insertMsg);
		logger.debug("===memList : {}", memList);
		logger.debug("===insertMsg : {}", insertMsg);

	}
	
	/**
	* Method : testDelMsg
	* 작성자 : PC08
	* 변경이력 :
	* Method 설명 : 알림 삭제 테스트 
	*/
	@Test
	public void testDelMsg(){
		/***Given***/
		int msgNo = 1015;
		/***When***/
		int delMsg = messageService.delMsg(msgNo);
		/***Then***/
		assertEquals(1, delMsg);
	}
	
	/**
	* Method : testMsgPagingList
	* 작성자 : PC08
	* 변경이력 :
	* Method 설명 : 알림 페이징 리스트 테스트
	*/
	@Test
	public void testMsgPagingList(){
		/***Given***/
		String memId = "user3";
		PageVo vo = new PageVo();
		vo.setReceiverId("user3");
		
		/***When***/
		List<MessageVo> msgPagingList = messageService.msgPagingList(vo, memId);
		
		/***Then***/
		assertEquals(5, msgPagingList.size());
		logger.debug("===msgPagingList : {}", msgPagingList);
	}
	

}
