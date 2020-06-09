<%@page import="java.awt.List"%>
<%@page import="com.score.ScoreDAO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="dto" class="com.score.ScoreDTO" scope="page"/>
<jsp:setProperty property="*" name="dto"/>

<%
	// dto를 디비에 연결하는 작업
	Connection conn = DBConn.getConnection();

	// 생성자에 conn을 연결하여 의존성 주입으로 초기화
	ScoreDAO dao = new ScoreDAO(conn);
	
	int result = dao.updateData(dto);
	
	// 작업이 끝나면 종료해야 다음 실행이 가능
	DBConn.close();
	
	// 홈페이지는 정적이므로
	// 세션이 바뀌면 redirect, 다시한번 호출
	if(result != 0){
		response.sendRedirect("list.jsp");
	}
	
%>

입력 오류