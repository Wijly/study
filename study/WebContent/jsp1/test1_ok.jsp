<%@ page contentType="text/html; charset=UTF-8" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");
	
	String userID = request.getParameter("userID");
	String userPwd = request.getParameter("userPwd");
	String username = request.getParameter("username");
	String gender = request.getParameter("gender");
	/*
	int tel1 = Integer.parseInt(request.getParameter("tel1"));
	int tel2 = Integer.parseInt(request.getParameter("tel2"));
	int tel3 = Integer.parseInt(request.getParameter("tel3"));
	*/
	String tel1 = request.getParameter("tel1");
	String tel2 = request.getParameter("tel2");
	String tel3 = request.getParameter("tel3");
	String chk = request.getParameter("chk");
	String memo = request.getParameter("memo");
	
	memo = memo.replaceAll("\n", "<br/>");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
아이디 : <%=userID %> <br/>
비밀번호 : <%=userPwd %> <br/>
이름 : <%=username %> <br/>
성별 : <%=gender %> <br/>
전화번호 : <%=tel1 %> - <%=tel2 %> - <%=tel3 %> <br/> 
동의 : <%=chk %> <br/>
메모 : <%=memo %> <br/>
<br/>
</body>
</html>