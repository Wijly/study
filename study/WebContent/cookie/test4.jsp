<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");
	//주소를 찾기 위한것
	String cp = request.getContextPath();
	
	// c4를 덮어씌우려고 함
	Cookie c4 = new Cookie("tel",null);
	response.addCookie(c4);
	
	Cookie[] ck = request.getCookies();
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
if(ck!=null){
	
	for(Cookie c : ck){
		
		out.print("cookie 이름 :");
		out.print(c.getName());
		out.print(", Cookie 값 : ");
		out.print(c.getValue()+"<br/>");
		

	}

}






%>



</body>
</html>