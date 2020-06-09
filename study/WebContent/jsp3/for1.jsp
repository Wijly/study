<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
	String eng = "TEST";
	String kor = "테스트";
	
	// forward방식에서 한글을 넘길때는 encode해서 넘기고 decode로 받아야 함
	String han = URLEncoder.encode(kor, "UTF-8");
	
%>
<jsp:forward page="for2.jsp">
	<jsp:param value="<%=eng %>" name="eng"/>
	<jsp:param value="<%=han %>" name="kor"/>
</jsp:forward>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>