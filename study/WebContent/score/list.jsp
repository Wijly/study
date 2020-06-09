<%@page import="com.score.ScoreDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.score.ScoreDAO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");

	//주소를 찾기 위한것
	String cp=request.getContextPath();

	Connection conn = DBConn.getConnection();
	
	ScoreDAO dao = new ScoreDAO(conn);
	
	// 리스트를 불러오고
	List<ScoreDTO> lists = dao.getList();
	
	// 연결을 끊음
	DBConn.close();
	
	
	// 2. ServletContect 인터페이스
	ServletContext context = getServletContext();
	String gender = context.getInitParameter("gender");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>성적 처리</title>

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

<table width="700" cellpadding="0" cellspacing="3" align="center" bgcolor="#e4e4e4">
<tr height="50">
	<td bgcolor="#ffffff" style="padding-left: 10px;">
	<b>성적처리 리스트</b>
	</td>
</tr>
</table>

<br/>

<table width="650" cellpadding="0" cellspacing="3" align="center">
<tr height="35">
	<td align="right">
		<input type="button" class="btn" value="글작성" onclick="javascript:location.href='<%=cp%>/score/write.jsp'"/>
	</td>												
</tr>
</table>

<table width="650" cellpadding="0" cellspacing="1" align="center" bgcolor="#cccccc">
<tr height="30">
	<td align="center" bgcolor="#e6e6e6" width="80"><b>학번</b></td>
	<td align="center" bgcolor="#e6e6e6" width="80"><b>이름</b></td>
	<td align="center" bgcolor="#e6e6e6" width="60">국어</td>
	<td align="center" bgcolor="#e6e6e6" width="60">영어</td>
	<td align="center" bgcolor="#e6e6e6" width="60">수학</td>
	<td align="center" bgcolor="#e6e6e6" width="60">총점</td>
	<td align="center" bgcolor="#e6e6e6" width="60">평균</td>
	<td align="center" bgcolor="#e6e6e6" width="60">랭킹</td>
	<td align="center" bgcolor="#e6e6e6" width="130">수정</td>
</tr>

<%
	// 리스트를 넣는 반복문
	for(ScoreDTO dto : lists){ %>
	<tr height="30">
		<td align="center" bgcolor="#ffffff"><%=dto.getHak() %></td>
		<td align="center" bgcolor="#ffffff"><%=dto.getName() %></td>
		<td align="center" bgcolor="#ffffff"><%=dto.getKor() %></td>
		<td align="center" bgcolor="#ffffff"><%=dto.getEng() %></td>
		<td align="center" bgcolor="#ffffff"><%=dto.getMat() %></td>
		<td align="center" bgcolor="#ffffff"><%=dto.getTot() %></td>
		<td align="center" bgcolor="#ffffff"><%=dto.getAvg() %></td>
		<td align="center" bgcolor="#ffffff"><%=dto.getRank() %></td>
		<td align="center" bgcolor="#ffffff">
			<a href="update.jsp?hak=<%=dto.getHak()%>">수정</a>
			<a href="delete.jsp?hak=<%=dto.getHak()%>">삭제</a>
		</td>
	</tr>
<%
	}
%>
</table>

<%=gender %>

</body>
</html>