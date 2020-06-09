<%@page import="java.net.URLDecoder"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");
	//주소를 찾기 위한것
	String cp = request.getContextPath();
	
	Cookie[] ck = request.getCookies();
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<table border="1" width="400" cellpadding="0" cellspacing="0">
	<tr>
		<th>상 품 명</th>
		<th>가    격</th>
	</tr>
	
	<tr>
		<td><a href="p1.jsp">냉장고</a></td>
		<td>10000</td>
	</tr>
	
	<tr>
		<td><a href="p2.jsp">세탁기</a></td>
		<td>20000</td>
	</tr>
	
	<tr>
		<td><a href="p3.jsp">컴퓨터</a></td>
		<td>5000</td>
	</tr>

</table>
<br/>

<hr align="left" width="400" color="blue">
오늘 본 상품 목록 <br/>

<%
	if(ck!=null){
		
		for(int i=ck.length-1;i>=0;i--){
			
			if(ck[i].getName().indexOf("productName")!=-1){
%>
				<!--  한글 디코더하여 쿠키의 value값을 가져옴 -->
				<%=URLDecoder.decode(ck[i].getValue(),"UTF-8") %><br/>
				<img src="./img/<%=URLDecoder.decode(ck[i].getValue(),"utf-8")%>.jpg" width="100" height="100"/>
<%
				
			}
		}
		
	}




%>

</body>
</html>