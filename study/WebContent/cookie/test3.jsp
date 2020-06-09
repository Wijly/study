<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");
	//주소를 찾기 위한것
	String cp = request.getContextPath();
	
	Cookie c1 = new Cookie("name","dasuel");
	Cookie c2 = new Cookie("age","22");
	Cookie c3 = new Cookie("addr","seoul");
	Cookie c4 = new Cookie("tel","010-4607-0124");
	
	c1.setMaxAge(0);	// 바로 삭제
	c2.setMaxAge(-1);	// 끝까지 남음
	c3.setMaxAge(10); 	// 20초 후 삭제
	
	response.addCookie(c1);
	response.addCookie(c2);
	response.addCookie(c3);
	response.addCookie(c4);
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<a href="test4.jsp">쿠키먹자</a>

</body>
</html>