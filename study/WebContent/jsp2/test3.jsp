<%@ page contentType="text/html; charset=UTF-8" %>
<!--  한번 내보낸 메모리를 초기화 autoFlasu = true, false면 초기화시키지않아서 출력되지않는다 -->
<%@ page buffer='1kb' autoFlush="false"%>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<% for(int i=1;i<=1000;i++){ %>
123
<%}%>	
	
	
%>


</body>
</html>