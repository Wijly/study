package com.event;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

// 서블릿 라이프 사이클
// HttpSessionListener : 세션이 생성, 종료될 때
// ServletContextListener : 서버가 시작, 중지될 때

public class CountManager implements HttpSessionListener{
	
	private static CountManager countManager;
	private static int count;
	
	// 생성자
	public CountManager() {
		countManager = this;	// 자기 자신
	}
	
	public static synchronized CountManager getInstance() throws Exception{
		if(countManager == null)
			countManager = new CountManager();	// null이면 객체 생성
		
		return countManager;
	}
	
	public static int getCount() {
		return count;
	}

	@Override
	public void sessionCreated(HttpSessionEvent evt) {
		
		// sid 키 값을 가져와서 할당을 해줌
		HttpSession session = evt.getSession();
		session.setMaxInactiveInterval(10*60); 		// 10분
		
		count++;
		
		System.out.println(session.getId() + "세션 생성,");
		System.out.println("접속자 수 : "+count);
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent evt) {
		
		HttpSession session = evt.getSession();
		
		count--;
		
		System.out.println(session.getId() + "세션 소멸,");
		System.out.println("접속자 수 : "+count);
		
	}
	

}
