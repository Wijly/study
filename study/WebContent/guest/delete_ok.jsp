<%@page import="javafx.scene.control.Alert"%>
<%@page import="com.guest.GuestDAO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");
	//주소를 찾기 위한것
	String cp = request.getContextPath();
	
	int num = Integer.parseInt(request.getParameter("deleteNum"));
	
	Connection conn = DBConn.getConnection();
	GuestDAO dao = new GuestDAO(conn);
	int result = dao.deleteData(num);
	
	DBConn.close();
	
	response.sendRedirect("guest.jsp");
%>
