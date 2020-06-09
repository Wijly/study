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

수1 : <input type="text" name="su1"/><br/>
수2 : <input type="text" name="su2"/><br/>
<input type="submit" value="결과"/><br/><br/>

</form>

<c:if test="${!empty param.su1 && !empty param.su2 }">
	<!--  set = 변수를 하나 초기화 하는 것 -->
	<c:set var="result" value="1"/>
	<c:forEach var="i" begin="1" end="${param.su2 }" step="1">
		<c:set var="result" value="${result * param.su1 }"/>	
		${param.su1 }^${i } = ${result }<br/>
	</c:forEach>
</c:if>


<c:if test="${!empty param.su1 && !empty param.su2 }">

<c:choose>
	<c:when test="${param.su1%3==0 && param.su1%4==0 }">
		${param.su1 }은 3과 4의 배수<br/>
	</c:when>
	
	<c:when test="${param.su1%4==0 }">
		${param.su1 }은 4의 배수<br/>
	</c:when>
	
	<c:when test="${param.su1%3==0 }">
		${param.su1 }은 3의 배수<br/>
	</c:when>
	
	<c:otherwise>
		${param.su1 }은 3과 4의 배수가 아니다<br/>
	</c:otherwise>
	

</c:choose>



</c:if>

</body>
</html>