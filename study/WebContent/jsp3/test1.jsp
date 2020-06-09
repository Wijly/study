<%@ page contentType="text/html; charset=UTF-8" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");

	// 영역 ( Scope )
	// page, request, session, application
	
	int n = 0;
	String count = (String)application.getAttribute("count");
	
	if(count!=null){
		n=Integer.parseInt(count);
	}
	n++;
	application.setAttribute("count", Integer.toString(n));
	
	// 실제 저복자의 주소
	String realPath = application.getRealPath("/");
	// request.getReomoteAddr() = 사용자의 ip
	application.log("접속자 : "+request.getRemoteAddr());

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

총 접속자 : <%=n %> <br/>
웹서버의 실제 경로 : <%=realPath %><br/>


</body>
</html>