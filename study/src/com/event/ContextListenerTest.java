package com.event;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class ContextListenerTest implements ServletContextListener{

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		System.out.println("¼­¹öÁÖ±Ý");
	}

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		System.out.println("¼­¹ö »Ï·Î·Õ");
		
		ServletContext sc = sce.getServletContext();
		
		sc.setAttribute("name", "²à¸ð´×");
	}
}
