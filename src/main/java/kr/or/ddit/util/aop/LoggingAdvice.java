package kr.or.ddit.util.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LoggingAdvice {
	private Logger logger = LoggerFactory.getLogger(LoggingAdvice.class);
	
	public void beforeMethod(JoinPoint joinPoint){
	
		logger.debug("loggingAdvice Before");
	
	}
	
	public void afterMethod(JoinPoint joinPoint){
		String className = joinPoint.getTarget().getClass().getName();
		String methodName = joinPoint.getSignature().getName();
		
		
		logger.debug("loggingAdvice After");
		logger.debug("className : {}",className);
		logger.debug("methodName : {}",methodName);
		
	}
	
	
	public Object aroundMethod(ProceedingJoinPoint joinPoint) throws Throwable{
		
		//해싱 로직 호출 전
		long startTime = System.currentTimeMillis();
		
		//해싱 로직 호출	//getArgs를 호출하면 메서드를 사용할 수 있다
		Object[] args = joinPoint.getArgs();	//메서드 배열에 담기
		Object returnObj = joinPoint.proceed(args);
		
		//해싱 로직 호출 후
		long endTime = System.currentTimeMillis();
		logger.debug("profilingTime : {}", endTime - startTime);
		
		return returnObj;
	}
	

}
