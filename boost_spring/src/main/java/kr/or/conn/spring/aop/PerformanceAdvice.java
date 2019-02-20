package kr.or.conn.spring.aop;

import org.aspectj.lang.ProceedingJoinPoint;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class PerformanceAdvice {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public Object trace(ProceedingJoinPoint joinPoint) throws Throwable{
		StringBuffer strBuffer = new StringBuffer();
		String signature = joinPoint.getSignature().toShortString();
		strBuffer.append("\n=====================================================================\n");
		strBuffer.append("[ start Method : "+ signature+ "]\n");
		strBuffer.append("=====================================================================\n\t");
		logger.info("{}",strBuffer.toString());
		
		long start = System.currentTimeMillis();
		
		try {
			Object result = joinPoint.proceed();
			return result;
		}finally {
			long finish = System.currentTimeMillis();
//			System.out.println("======================================= " + signature + " End (" + (finish - start) + " ms)");
		strBuffer.setLength(0);
		strBuffer.append("\n=====================================================================\n");
		strBuffer.append("[ end Method : "+ " End (" + (finish - start) + " ms)"+ "]\n");
		strBuffer.append("=====================================================================\n\t");
		logger.info("{}",strBuffer.toString());
		
		}
		
	}
}
