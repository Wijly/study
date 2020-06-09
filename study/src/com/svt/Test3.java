package com.svt;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Test3 extends HttpServlet{

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
	
		// name과 age = 모델
		String name = req.getParameter("name");
		String age = req.getParameter("age");
		
		String str = name + "의 나이는 "+age+"살 입니다.";
		
		// 클래스에서 jsp파일로 넘어감
		// 포워딩할 데이터를 넘김
		req.setAttribute("str", str);
		
		// 포워딩, result.jsp까지 연결
		RequestDispatcher rd = req.getRequestDispatcher("/servlet/result.jsp");
		
		// req와 resp 데이터를 가지고 result.jsp로 가져간다
		rd.forward(req, resp);
		
		
		
	}
	

}
