<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

	function flocation_opener(){
		window.opener.location.href="lotte_member.jsp";
		window.close();
	}
</script>


</head>
<body>

<h3>Lotte Famaily 로그인</h3>
<br/><br/>
회원 ID  : <input type="text"><br/>
비밀번호 : <input type="password"><br/>
<br/><br/>
<input type="button" value="로그인">
<br/><br/>

<a href="javascript:flocation_opener()">회원가입</a>

<a href="javascript:window.close();">닫기</a>

</body>
</html>