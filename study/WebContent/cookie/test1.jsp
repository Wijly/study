<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");
	//주소를 찾기 위한것
	String cp = request.getContextPath();
	
	
	// 사용자 변수명, 사용자명
	Cookie c1 = new Cookie("name","dasuel");
	Cookie c2 = new Cookie("age","22");
	// 한글은 인코딩 디코딩 해줘야 한다
	Cookie c3 = new Cookie("addr",URLEncoder.encode("서울","UTF-8"));
	
	//클라이언트한테 보냄
	response.addCookie(c1);
	response.addCookie(c2);
	response.addCookie(c3);
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<a href="test2.jsp">쿠키</a>

</body>
</html>