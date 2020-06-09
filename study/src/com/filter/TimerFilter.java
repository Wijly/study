package com.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

// 필터 : 웹 어플리케이션에서 사용하는 서블릿이나 jsp에 도착하기 전에
// request의 내용을 조작한 후 서블릿이나 JSP에게 전송하는 기능

// 주로 보안을 위해 사용 로그파일 작성, 인코딩 작업

public class TimerFilter implements Filter{
	
	private FilterConfig config;
	
	@Override
	public void destroy() {
	}
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		long before = System.currentTimeMillis();
		
		chain.doFilter(request, response);
		
		long after = System.currentTimeMillis();
		
		String uri;
		
		if(request instanceof HttpServletRequest) {

			HttpServletRequest req = (HttpServletRequest)request;
			
			uri = req.getRequestURI();
			
			// 로그 만드는 방법
			config.getServletContext().log(uri + ":"+ (after-before) + "ms");
			
		}
	}
	
	@Override
	public void init(FilterConfig config) throws ServletException {
		
		this.config = config;
		
	}

	
	
}
