package kr.or.ddit.websocket.util;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import kr.or.ddit.member.model.MemberVo;

public class ErdHandler extends TextWebSocketHandler{
	private Logger logger = LoggerFactory.getLogger(ErdHandler.class);
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	//private Map<String, WebSocketSession> userSessions = new HashMap<>();
	
	//클라이언트와 연결 이후에 실행되는 메서드
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception{
		sessionList.add(session);
		logger.info("{} 연결됨", session.getId());
		String senderId = getId(session);
		
		
		//userSessions.put(senderId, session);
		
//		for(WebSocketSession sess : sessionList){
//			sess.sendMessage(new TextMessage(senderId+"님이 접속하셨습니다."));
//		}
			
			
	}
	
	//클라이언트가 서버로 메시지를 전송했을 때 실행되는 메서드
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception{
		logger.info("{}로 부터 {} 받음",session.getId(), message.getPayload());
		
		String senderId = getId(session);
		
//		for(WebSocketSession sess : sessionList){
//			sess.sendMessage(new TextMessage(senderId + " : " + message.getPayload()));
//		}
		
		//protocol : cmd, ERD수정자, ERD번호	(ex: erd,user1,123)
		String msg = message.getPayload();
		if(null != msg){
			String[] strs = msg.split("★");
			if(strs != null && strs.length == 2){
				String cmd = strs[0];
				String content = strs[1];
				String sendSId = session.getId();
				if(cmd.indexOf("domain") > -1){
					for(WebSocketSession sess : sessionList){
						String receSId = sess.getId();
						
						if(session.getUri().equals(sess.getUri())){
						
						//TextMessage tmpMsg = new TextMessage("{\"cmd\":\""+cmd+"\", \"editor\":\""+senderId+"\", \"content\":\""+content+"\"}");
						TextMessage tmpMsg = new TextMessage(cmd+"★"+senderId+"★"+content+"★"+sendSId+"★"+receSId);
						
						sess.sendMessage(tmpMsg);
						}
					}
				}else if(cmd.equals("erd")){
					for(WebSocketSession sess : sessionList){
						TextMessage tmpMsg = new TextMessage(senderId + "님이 ");
						sess.sendMessage(tmpMsg);
					}
				}else if(cmd.equals("chat")){
					for(WebSocketSession sess : sessionList){
						String receSId = sess.getId();
						if(session.getUri().equals(sess.getUri())){
							TextMessage tmpMsg = new TextMessage(cmd + "★" + senderId + "★" + content + "★" + sendSId + "★" + receSId);
							sess.sendMessage(tmpMsg);
						}
					}
				}

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
			//return session.getId();
			return "Guest"+session.getId();
		else
			return loginUser.getMemId();
		
	}
	
	
}
