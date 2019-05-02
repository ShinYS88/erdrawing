package kr.or.ddit.websocket.util;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.stereotype.Repository;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.message.service.IMessageService;

@Repository
public class ChatHandler extends TextWebSocketHandler{
	private Logger logger = LoggerFactory.getLogger(ChatHandler.class);
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	
	//클라이언트와 연결 이후에 실행되는 메서드
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception{
		sessionList.add(session);
		logger.info("{} 연결됨", session.getId());
		//String senderId = getId(session);
		
	}
	
	//클라이언트가 서버로 메시지를 전송했을 때 실행되는 메서드
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception{
		logger.info("{}로 부터 {} 받음",session.getId(), message.getPayload());
		
		String senderId = getId(session);
		
		//protocol : cmd, ERD수정자, ERD번호	(ex: msg,user1,123)
		String msg = message.getPayload();
		
		String[] strs = msg.split("★");
		String content = strs[0];
		int erdNo = Integer.parseInt(strs[1]);
		
		for(WebSocketSession sess : sessionList){
			if(session.getUri().equals(sess.getUri())){
				TextMessage tmpMsg = new TextMessage(senderId + "★" + content);
				sess.sendMessage(tmpMsg);
			}
		}
		
	}
	
	//클라이언트와 연결을 끊었을 때 실행되는 메서드
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception{
		sessionList.remove(session);
		logger.info("{} 연결 끊김", session.getId());
	}
	
	
	private String getId(WebSocketSession session){
		Map<String, Object> httpSession = session.getAttributes();
		MemberVo loginUser = (MemberVo) httpSession.get("SESSION_MEMBERVO");
		
		if(null == loginUser)
			return "Guest"+session.getId();
		else
			return loginUser.getMemId();
	}

}
