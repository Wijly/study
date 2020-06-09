package com.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class CharsetEncodingFilter implements Filter{
	
	
	// web.xml에서 param으로인해
	// 변수 charset에 utf-8이 넘어옴
	private String charset;

	@Override
	public void destroy() {
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		String uri;
		
		if(request instanceof HttpServletRequest){
			
			HttpServletRequest req = (HttpServletRequest)request;
			
			uri = req.getRequestURI();
			
			if(uri.indexOf("abc.do")!=-1) {
				
				req.setCharacterEncoding("euc-kr");

			}else {
				req.setCharacterEncoding(charset);
			}
		}
		
		// 두번째 필터로 넘겨줌
		chain.doFilter(request, response);
		
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		
		charset = filterConfig.getInitParameter("charset");
		
		if(charset == null) {
			charset = "utf-8";
		}
	}
}
