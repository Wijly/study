<%@ page contentType="text/html; charset=UTF-8" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");

	// 세션에있는 userId를 지움, 
	session.removeAttribute("userId");	// 다스리 삭제
	session.invalidate();				// userId 변수 삭제
	
	// 세션을 지웠으므로 redirect 시켜서 재확인시켜야한다
	response.sendRedirect("login.jsp");
	
	// html은 필요없으므로 삭제해도 됌
%>
