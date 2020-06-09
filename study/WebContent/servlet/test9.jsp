<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");
	//주소를 찾기 위한것
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>


<c:set var="url" value="test7.jsp"/>
<c:import url="${url }" var="gugudan">
	<c:param name="dan" value="7"/>	

</c:import>
<c:out value="${gugudan }" escapeXml="false"/>


<c:set var="url" value="https://www.daum.net"/>
<c:import url="${url }" var="daum"/>
<c:out value="${daum }" escapeXml="false"/>

</body>
</html>