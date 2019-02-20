package kr.or.conn.spring.aop;


import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Aspect
public class LoggingAspect {
   
    private static final Logger logger = LoggerFactory.getLogger(LoggingAspect.class);
    static String name = "";
    static String type = "";
     
    @Around("execution(* co.kr.ucs.spring.controller.*Controller.*(..)) or execution(* co.kr.ucs.spring.service.*Service.*(..)) or execution(* co.kr.ucs.spring.dao.*Dao.*(..))")
    public Object logPrint(ProceedingJoinPoint joinPoint) throws Throwable {
        type = joinPoint.getSignature().getDeclaringTypeName();
         
        if (type.indexOf("Controller") > -1) {
            name = "Controller  \t:::::::::::::  ";
        }
        else if (type.indexOf("Service") > -1) {
            name = "Service  \t::::::::::::  ";
        }
        else if (type.indexOf("DAO") > -1) {
            name = "DAO  \t\t:::::::::::";
        }
        //logger.debug(name + type + "." + joinPoint.getSignature().getName() + "()");
        return joinPoint.proceed();
    }

}
