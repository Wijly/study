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
<body style="font-size: 9pt;">

<form action="sendMail_ok.jsp" method="post">
<table border="1" align="center" style="font-size: 9pt;" cellpadding="0" cellspacing="0" bordercolor="cyan">

<tr>
	<td> 보내는 사람 이름 </td>
	<td>
		<input type="text" name="senderName" size="50"/>
	</td>
</tr>
<tr>
	<td> 보내는 사람 E-Mail</td>
	<td>
		<input type="text" name="senderEmail" size="50"/>
	</td>
</tr>
<tr>
	<td> 받는 사람 E-Mail</td>
	<td>
		<input type="text" name="receiverEmail" size="50"/>
	</td>
</tr>

<tr>
	<td> 제목 </td>
	<td>
		<input type="text" name="subject" size="50"/>
	</td>
</tr>
<tr>
	<td> 내용 </td>
	<td>
		<input type="text" name="content" size="50"/>
	</td>
</tr>
<tr>
	<td colspan="2" align="center">
		<input type="submit" value=" 메일보내기 "/>
	</td>
</tr>
</table>
</form>

</body>
</html>