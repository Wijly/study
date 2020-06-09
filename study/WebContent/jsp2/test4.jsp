<%@ page contentType="text/html; charset=UTF-8" %>
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

<form action="" method="post">

이름 : <input type="text" name="name"/><br/>
<input type="submit" value="redirect" onclick="this.form.action='test4_ok.jsp'"/>
<input type="submit" value="foward" onclick="this.form.action='test4_for.jsp'"/>


</form>


</body>
</html>