<%@page import="com.guest.GuestDAO"%>
<%@page import="com.util.DBConn"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");
	//주소를 찾기 위한것
	String cp = request.getContextPath();
%>

<jsp:useBean id="dto" class="com.guest.GuestDTO" scope="page"/>
<jsp:setProperty property="*" name="dto"/>

<%
	GuestDAO dao = new GuestDAO(DBConn.getConnection());
	
	int maxNum = dao.getMaxNum();
	
	// dto의 num을 자동으로 +1하며 생성
	dto.setNum(maxNum +1);
	// dto의 ip를 자동으로 할당
	dto.setIpAddr(request.getRemoteAddr());
	
	int result = dao.insertData(dto);
	
	DBConn.close();
	
	response.sendRedirect(cp + "/guest/guest.jsp");

%>