<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");
	//주소를 찾기 위한것
	String cp = request.getContextPath();
	
	Cookie c = new Cookie("productName2",URLEncoder.encode("세탁기","UTF-8"));
	
	c.setMaxAge(30);
	
	response.addCookie(c);
	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

마동석 주먹으로 돌아가는 세탁기<br/>
<img alt="세탁기" src="./img/세탁기.jpg"/><br/>
<a href="shop.jsp">돌아가기</a>

</body>
</html>