package kr.or.ddit.util.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class ProfileInterceptor extends HandlerInterceptorAdapter{
	private Logger logger = LoggerFactory.getLogger(ProfileInterceptor.class);
	
//	데이터가 외곡될 수 있음
//	private long startTime;
//	private long endTime;
	
	/**
	 * Method : preHandle
	 * 작성자 : shinys
	 * 변경이력 :
	 * @param request
	 * @param response
	 * @param handler
	 * @return
	 * @throws Exception
	 * Method 설명 : Controller method 실행 전 
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		logger.debug("ProfileInterceptor preHandle");
		// 다른 인터셉터 혹은 controller로 요청을 계속 위임 처리
		
		request.setAttribute("startTime", System.currentTimeMillis());
//		startTime = System.currentTimeMillis();
		
		return true;
		
	}
	
	
	/**
	 * Method : postHandle
	 * 작성자 : shinys
	 * 변경이력 :
	 * @param request
	 * @param response
	 * @param handler
	 * @param modelAndView
	 * @throws Exception
	 * Method 설명 : Controller method 실행 후
	 */
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		logger.debug("profileInterceptor postHandle");
	
		long startTime = (long) request.getAttribute("startTime");
		long endTime = System.currentTimeMillis();
		long profilingTime = endTime-startTime;
		
		
		
		logger.debug("( {} - profilingTime : {} )", request.getRequestURI(), profilingTime);
		
		//preHandel에서 구현 startTime 값을 가져와야...?
	}

	
	
	
}
