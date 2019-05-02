package kr.or.ddit.util.interceptor;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.message.model.MessageVo;
import kr.or.ddit.message.service.IMessageService;

public class LoginInterceptor extends HandlerInterceptorAdapter{
	
	@Resource(name="messageService")
	private IMessageService messageService;
	private Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);
	
	/**
	 * Method : preHandle
	 * 작성자 : PC02
	 * 변경이력 :
	 * @param request
	 * @param response
	 * @param handler
	 * @return
	 * @throws Exception
	 * Method 설명 : controller method 실행전
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)throws Exception {
		
		HttpSession session = request.getSession();
		// login처리를 담당하는 사용자 정보를 담고 있는 객체를 가져옴
		Object obj = session.getAttribute("SESSION_MEMBERVO");
		
		/*if ( obj == null ){
			// 로그인이 안되어 있는 상태임으로 로그인 폼으로 다시 돌려보냄(redirect)
			response.sendRedirect("/login");
			return false; // 더이상 컨트롤러 요청으로 가지 않도록 false로 반환함
		}*/
		
		if(obj!=null){
			// 메시지 리스트 
			MemberVo memberVo = (MemberVo) obj;
			logger.debug("===memId : {} ", memberVo.getMemId());
			List<MessageVo> msgList = messageService.getAllMsg(memberVo.getMemId());
			session.setAttribute("MSGLIST", msgList);
			
			int msgCnt = messageService.getMsgCnt(memberVo.getMemId());
			session.setAttribute("MSGCNT", msgCnt);
			
			// preHandle의 return은 컨트롤러 요청 uri로 가도 되냐 안되냐를 허가하는 의미임
			// 따라서 true로하면 컨트롤러 uri로 가게 됨.
		}
		
		
		return true;
		
		
	}

	

}
