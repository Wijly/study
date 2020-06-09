<%@page import="java.net.URLDecoder"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");

	String eng= request.getParameter("eng");
	String han = request.getParameter("kor");
	
	//encode되어 받은 kor을 다시 decode
	String kor = URLDecoder.decode(han, "UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

포워딩된 데이터<br/>
eng = <%=eng %><br/>
kor = <%=kor %><br/>


</body>
</html>