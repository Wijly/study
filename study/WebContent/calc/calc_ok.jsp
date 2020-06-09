<%@page import="com.calc.Calc"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");

// 클래스를 사용하면 자동으로 넘어가므로 필요없음
/*
	int su1 = Integer.parseInt(request.getParameter("su1"));
	int su2 = Integer.parseInt(request.getParameter("su2"));
	String oper = request.getParameter("oper");
*/

/*
	// 클래스를 사용하는 기본 방법 
	Calc ob = new Calc();
	
	ob.setSu1(su1);
	ob.setSu2(su2);
	ob.setOper(oper);
	
	String str = ob.result();
*/
%>
<!-- 클래스 사용 -->	
<jsp:useBean id="ob" class="com.calc.Calc" scope="page"/>
<!--  property =  메소드 , su1 set메소드 찾아감 -->
<jsp:setProperty property="*" name="ob" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%=ob.result() %>

</body>
</html>