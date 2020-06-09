<%@page import="com.score.ScoreDTO"%>
<%@page import="com.score.ScoreDAO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");
	//주소를 찾기 위한것
	String cp = request.getContextPath();
	
	// 전달받고 전달해줄 hak
	String hak = request.getParameter("hak");
	
	// 디비 연결
	Connection conn = DBConn.getConnection();
	
	// dao문의 delete문을 실행
	ScoreDAO dao = new ScoreDAO(conn);
	
	// dao문 실행해서 result 값 받음
	int result = dao.deleteData(hak);
	
	DBConn.close();
	
	if(result !=0){
		response.sendRedirect("list.jsp");
	}
	
%>

삭제오류