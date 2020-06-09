<%@ page contentType="text/html; charset=UTF-8" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");

	String userId = request.getParameter("userId");
	String userPwd = request.getParameter("userPwd");
	
	// 아이디가 다스리 이고 비밀번호가 123이면
	if(userId.equals("다스리") && userPwd.equals("123")){
		
		// 아이디와 비밀번호가 일치하면
		// 세션에 아이디와 비밀번호를 올림
		// 1번째 userId= 이름, 2번째 userId = 다스리
		session.setAttribute("userId", userId);
		
		// 세션에 올린 후 로그인 창 다시 실행, 세션이 있으면 화면이 바뀜
		response.sendRedirect("login.jsp");
	}

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
아이디 또는 패스워드 오류<br/>
<a href="login.jsp">돌아가기</a>


</body>
</html>