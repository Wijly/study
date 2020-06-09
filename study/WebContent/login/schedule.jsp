<%@ page contentType="text/html; charset=UTF-8" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");

	String sid = session.getId();
	int sTime = session.getMaxInactiveInterval();


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<center>
<h4>일정관리 화면</h4>
세션 아이디 : <%=sid %><br/>
세션 유지시간 : <%=sTime %><br/>
</center>
</body>	
</html>