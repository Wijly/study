<%@page import="com.naver.NaverDAO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");
	//주소를 찾기 위한것
	String cp = request.getContextPath();
	
	String id = request.getParameter("id");
	
	Connection conn = DBConn.getConnection();
	
	NaverDAO dao = new NaverDAO(conn);
	
	int result = dao.deleteData(id);
	
	DBConn.close();
	
	response.sendRedirect("naver_list.jsp");
	
	
%>
