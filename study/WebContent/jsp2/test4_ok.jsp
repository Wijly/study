<%@ page contentType="text/html; charset=UTF-8" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");
	
	String name= request.getParameter("name");
	
	// ok2로 넘어갈 때 msg 라는 변수에 "하이룽"을 담아감
	request.setAttribute("msg", "하이룽");
	
	response.sendRedirect("test4_ok2.jsp");


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

이름 = <%=name %>

</body>
</html>