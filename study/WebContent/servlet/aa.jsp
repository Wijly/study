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

<table border="1" cellpadding="0" cellspacing="0" width="200">
	<tr>
		<td width="100">이름 </td>
		<td width="100">나이 </td>
	</tr>
	
	<c:forEach var="dto" items="${lists }">
	
	<tr>
		<td width="100">${dto.name } </td>
		<td width="100">${dto.age } </td>
	</tr>
	</c:forEach>
</table>

</body>
</html>