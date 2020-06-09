<%@ page contentType="text/html; charset=UTF-8" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");
	
	String userId = request.getParameter("userId");
	String userPwd = request.getParameter("userPwd");
	
	// 세션에 있는 것을 가지고 옴
	String userName = request.getParameter("userName");
	String userBirth = request.getParameter("userBirth");

	// 세션에 올렸던 것을 가져오는 것이므로 다운캐스팅
//	String userName = (String)session.getAttribute("userName");
//	String userBirth = (String)session.getAttribute("userBirth");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

아이디 : <%=userId %> 	<br/>
패스워드 : <%=userPwd %><br/>
이름 : <%=userName %>	<br/>
생일 : <%=userBirth %>	<br/>

</body>
</html>