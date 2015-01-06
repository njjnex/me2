package by.my.aspect;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

@Component
@Aspect
public class LoggingAspect {
	LoggingAspect(){
		System.out.println("start aspect");
	}
	Logger logger = LogManager.getLogger(LoggingAspect.class);
		
	@After("execution(* by.my..*.*(..))")
	public void logDebug(JoinPoint joinPoint){
		logger.debug("calling " + joinPoint.getSignature().getName());
		logger.debug(joinPoint);
	}
	@After("execution(* by.my.dao.EventDao.search(..)) && args (searchEventName)")
	public void logUserSearch(JoinPoint joinPoint, String searchEventName){
		logger.info("Searching event:" + searchEventName);
	}
	
}
