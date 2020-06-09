<%@ page contentType="text/html; charset=UTF-8" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
	function sendIt(){
		
		var f = document.myForm;
		
		if(!f.dan.value){
			alert("단을 입력하세요.");
			f.dan.focus();
			return;			
		}
		//action을 지우고 
		f.action="gugudan_ok.jsp"
		f.submit();
	}
</script>


</head>
<body>

<form method="post" name="myForm">

단 : <input type="text" name="dan"/><br/>

<input type="button" value="결과" onclick="sendIt();"/> <br/>


</form>

</body>
</html>