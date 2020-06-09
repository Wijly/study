<%@page import="com.naver.NaverDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.naver.NaverDAO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");
	//주소를 찾기 위한것
	String cp = request.getContextPath();
	
	Connection conn = DBConn.getConnection();
	
	NaverDAO dao = new NaverDAO(conn);
	
	List<NaverDTO> lists = dao.getList();
	
	DBConn.close();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원 목록</title>

<style type="text/css">

*{
	padding: 0px;
	margin: 0px;	
}

body{
	font-size: 12pt;
}

td{
	font-size: 12pt;
}

.btn{
	 font-size: 10pt;
	 background: #e6e6e6;
}

</style>

</head>
<body>
<br/><br/>

<table width="780" cellpadding="0" cellspacing="3" align="center" bgcolor="#e4e4e4">
<tr height="50">
	<td bgcolor="#ffffff" style="padding-left: 10px;">
	<b>회원목록 리스트</b>
	</td>
</tr>
</table>
<br/>

<table width="780" cellpadding="0" cellspacing="3" align="center">
<tr height="35">
	<td align="right">
		<input type="button" class="btn" value="회원가입" onclick="javascript:location.href='<%=cp%>/naver/naver.jsp'"/>
	</td>												
</tr>
</table>

<table width="780" cellpadding="0" cellspacing="1" align="center" bgcolor="#cccccc">
<tr height="30">
	<td align="center" bgcolor="#e6e6e6" width="80"><b>아이디</b></td>
	<td align="center" bgcolor="#e6e6e6" width="80"><b>비밀번호</b></td>
	<td align="center" bgcolor="#e6e6e6" width="60">이름</td>
	<td align="center" bgcolor="#e6e6e6" width="60">년</td>
	<td align="center" bgcolor="#e6e6e6" width="60">월</td>
	<td align="center" bgcolor="#e6e6e6" width="60">일</td>
	<td align="center" bgcolor="#e6e6e6" width="60">성별</td>
	<td align="center" bgcolor="#e6e6e6" width="60">이메일</td>
	<td align="center" bgcolor="#e6e6e6" width="130">전화번호</td>
	<td align="center" bgcolor="#e6e6e6" width="130">수정</td>
</tr>

<%
	// 리스트를 넣는 반복문
	for(NaverDTO dto : lists){ %>
	<tr height="30">
		<td align="center" bgcolor="#ffffff"><%=dto.getId()%></td>
		<td align="center" bgcolor="#ffffff"><%=dto.getPwd() %></td>
		<td align="center" bgcolor="#ffffff"><%=dto.getName() %></td>
		<td align="center" bgcolor="#ffffff"><%=dto.getBirth1() %></td>
		<td align="center" bgcolor="#ffffff"><%=dto.getBirth2() %></td>
		<td align="center" bgcolor="#ffffff"><%=dto.getBirth3()%></td>
		<td align="center" bgcolor="#ffffff"><%=dto.getGender() %></td>
		<td align="center" bgcolor="#ffffff"><%=dto.getEmail() %></td>
		<td align="center" bgcolor="#ffffff"><%=dto.getTel1() %></td>
		<td align="center" bgcolor="#ffffff">
			<a href="update.jsp?id=<%=dto.getId()%>">수정</a>
			<a href="delete.jsp?id=<%=dto.getId()%>">삭제</a>
		</td>
	</tr>
<%
	}
%>


</table>

</body>
</html>