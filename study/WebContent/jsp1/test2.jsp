<%@ page contentType="text/html; charset=UTF-8" %>

<%
	int a=15, b=7, c;
	c = a+b;




%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

합 : <%=a%>+<%=b%>=<%=c%><br/>

<%
// jsp 영역에서 출력, 소스보기에서 jsp의 영역은 출력되지 않는다
// 내장객체 (servlet)
out.print("합(2) : " + a + " + " + b + " = " + c + "<br/>");

String str = String.format("합(3) : %d + %d = %d<br/>",a,b,c);
out.print(str);

%>

</body>
</html>