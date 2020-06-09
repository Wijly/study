<%@ page contentType="text/html; charset=UTF-8" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");
	
	// 세션에있는 유저 아이디를 받음, (String) 으로 다운캐스팅
	String userId = (String)session.getAttribute("userId");
	
	//시간 변경 위해. 초단위
	session.setMaxInactiveInterval(5);
	

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	
	// 버튼사용을 위한 스크립트
	function sendIt(){
		
		var f = document.myForm;
		
		if(!f.userId.value){
			alert("아이디 입력");
			f.userId.focus();
			return;
		}
		if(!f.userPwd.value){
			alert("패스워드 입력");
			f.userPwd.focus();
			return;
		}
		
		f.submit();
	}
	


</script>


</head>
<body style="font-size: 10pt">
<table border="1" width="600" align="center" style="font:10">
	<tr height="20">
		<td colspan="2" align="right">
		|게시판|
		<% if(userId==null){ 
		// 로그인 아이디가 없으면 일정관리 비활성화
		%>
				일정관리
		 
		<%}else{%>
		<a href="schedule.jsp">일정관리</a>
		<%} %>
		</td>
	</tr>
	
	<tr height="400">
		<td width="100" valign="top">
		<%if(userId==null){ %>
		<form action="login_ok.jsp" method="post" name="myForm">
			아이디 : <input type="text" name="userId" size="10"/><br/>
			패스워드 : <input type="password" name="userPwd" size="10"/><br/>
			<input type="button" value="로그인" onclick="sendIt();"/>		
		</form>
		<%}else{ %>
			<font color="aqua"><b><%=userId %></b></font>님 환영합니다<br/>
			<a href="logout.jsp">로그아웃</a><br/>
		<%} %>
		</td>
		<td valign="middle" align="center">
		<%if(userId==null) {%>
		<b>로그인하면 새로운 세상이 보입니다</b>
		<%}else{ %>
		
		여기에 캘린더 바디부분
		
		<%} %>
		</td>
	</tr>
</table>


</body>
</html>