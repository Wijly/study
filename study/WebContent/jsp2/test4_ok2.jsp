<%@ page contentType="text/html; charset=UTF-8" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");

	String name = request.getParameter("name");
	
	// setAttribute는 getAttribute로 받음
	String msg = (String)request.getAttribute("msg");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

redirect 또는 forward한 페이지 <br/>
<h3>test4_ok2.jsp 와씀다</h3>

이름 : <%=name %>	<%=msg %>

</body>
</html>