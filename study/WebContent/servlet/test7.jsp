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

<form action="" method="post">

단 : <input type="text" name="dan"/>
<input type="submit" value="결과"/><br/>


</form>

<table>
<c:if test="${!empty param.dan}">
	${param.dan } 단 <br/>
	
	<c:forEach var="i" begin="1" end="9" step="1">
	<tr>
		<td>${param.dan } * ${i } = ${param.dan*i }</td>
	</tr> 
	
	</c:forEach>

</c:if>
</table>

<br/><br/>



</body>
</html>