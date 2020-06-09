<%@page import="com.board.BoardDAO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");
	//주소를 찾기 위한것
	String cp = request.getContextPath();
%>
<jsp:useBean id="dto" class="com.board.BoardDTO" scope="page"/>
<jsp:setProperty property="*" name="dto"/>

<%
	// 자동으로 들어가는 num과 ip
	Connection conn = DBConn.getConnection();
	BoardDAO dao = new BoardDAO(conn);
	
	// dao에서 num의 최댓값을 가져옴
	int maxNum = dao.getMaxNum();
	
	// dto의 num에 +1을 해서 넣음,
	dto.setNum(maxNum + 1);
	// 아이피를 가져와서 dto.ip에 넣음
	dto.setIpaddr(request.getRemoteAddr());

	//dto 넣은 값을 insert 시킴 -> redirect 필요
	dao.insertData(dto);
	
	// redirect
	response.sendRedirect("list.jsp");

%>

