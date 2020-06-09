<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");
	//주소를 찾기 위한것
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인</title>

<link rel="stylesheet" href="<%=cp %>/member/css/style.css" type="text/css"/>

<script type="text/javascript">
	function login(){
		
		var f = document.myForm;
		
		if(!f.userId.value){
			alert("아이디를 입력하세요.");
			f.userId.focus();
			return;
		}
		
		if(!f.userTel.value){
			alert("전화번호를 입력하세요.");
			f.userTel.focus();
			return;
		}
		
		f.action = "<%=cp%>/join/searchPw_ok.do";
		f.submit();
	
	}
</script>

</head>
<body>

<br/><br/>

<form action="" method="post" name="myForm">
<table align="center" cellpadding="0" cellspacing="0">
	<tr height="2"><td colspan="2" bgcolor="#cccccc"></td></tr>
	
	<tr height="30">
		<td colspan="2" align="center"><b>로그인</b></td>
	</tr>

	<tr height="2"><td colspan="2" bgcolor="#cccccc"></td></tr>
	
	<tr height="25">
		<td width="80" bgcolor="#e6e4e6" align="center">아이디</td>
		<td width="120" style="paddng-left: 5px;">
			<input type="text" name="userId" maxlength="10" size="15"/>
		</td>
	</tr>
	
	<tr height="2"><td colspan="2" bgcolor="#cccccc"></td></tr>
	
	<tr height="25">
		<td width="80" bgcolor="#e6e4e6" align="center">전화번호</td>
		<td width="120" style="paddng-left: 5px;">
			<input type="password" name="userTel" maxlength="10" size="15"/>
		</td>
	</tr>
	
	<tr height="2"><td colspan="2" bgcolor="#cccccc"></td></tr>
	
	<tr height="30">
		<td colspan="2" align="center">
			<input type="button" value=" 확인 " class="btn2" onclick="login();"/>
			<input type="button" value=" 취소 " class="btn2" onclick="javascript:location.href='<%=cp%>/join/login.do';"/>
		</td>
	</tr>
	
	<tr height="30">
		<td colspan="2" align="center">
		<font color="red"><b>${message}</b></font>
		</td>
	</tr>
</table>

</form>
</body>
</html>