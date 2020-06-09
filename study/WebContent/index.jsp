<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.member.CustomImfo"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
	//post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");
	//주소를 찾기 위한것
	String cp = request.getContextPath();
	
	//세션에서 데이터 갖고옴
//	CustomImfo info = (CustomInfo)session.getAttribute("customInfo");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<h3> JSP</h3>
	<!--  세션의 customInfo에 userId값이 없으면(empty) -->
<c:choose>
	<c:when test="${empty sessionScope.customInfo.userId}">
		<b> 로그인 하시면 보입니다 </b>
	</c:when>
	<c:otherwise>
		<font color="cyan"><b>${sessionScope.customInfo.userName }</b></font>님 하이룽<br/>
	</c:otherwise>
</c:choose>

<!--  세션의 customInfo에 userId값이 없으면(empty) -->
<c:choose>
	<c:when test="${empty sessionScope.customInfo.userId}">
		1. 성적처리(jsp)<br/>
		2. 네이버(jsp)<br/>
		3. 게시판(jsp)<br/>
		4. 방명록(jsp)<br/>
		5. 게시판(servlet)<br/>
		7. 파일 게시판(Servlet)<br/>
	</c:when>
	<c:otherwise>
		1. <a href="<%=cp%>/score/list.jsp">성적처리(jsp)</a><br/>
		2. <a href="<%=cp %>/naver/naver_list.jsp">네이버(jsp)</a><br/>
		3. <a href="<%=cp %>/board/list.jsp">게시판(jsp)</a><br/>
		4. <a href="<%=cp %>/guest/guest.jsp">방명록(jsp)</a><br/>
		5. <a href="<%=cp %>/sboard/list.do">게시판(servlet)</a><br/>
		6. <a href="<%=cp %>/jumsu/list.do">성적처리(servlet)</a><br/>
		7. <a href="<%=cp %>/file/list.do"> 파일 게시판(Servlet)</a><br/>
		8. <a href="<%=cp %>/image/list.do">이미지 게시판(Servlet)</a><br/>
	</c:otherwise>
</c:choose>

<br/><br/>


<!--  세션의 customInfo에 userId값이 없으면(empty) -->
<c:choose>
	<c:when test="${empty sessionScope.customInfo.userId}">
		
		<a href="<%=cp %>/join/created.do">회원가입</a>
		<a href="<%=cp %>/join/login.do">로그인</a><br/>
		
	</c:when>
	<c:otherwise>
		<a href="<%=cp %>/join/updated.do">회원정보수정</a>
		<a href="<%=cp %>/join/logout.do">로그아웃</a><br/>
	</c:otherwise>
</c:choose>
</body>
</html>