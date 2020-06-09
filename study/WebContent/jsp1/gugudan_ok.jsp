<%@ page contentType="text/html; charset=UTF-8" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");

	int dan = Integer.parseInt(request.getParameter("dan"));
	

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	for(int i=1; i<=9; i++){
//		out.print(dan + " * "+ i + " = " + (dan*i)+"<br/>");
		
		String str = String.format("%d * %d = %d<br/>",dan,i,dan*i);
		out.print(str);
	}
%>

</body>
</html>