<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");

	Calendar now = Calendar.getInstance();
	
	// 년월일
	int nowYear = now.get(Calendar.YEAR);
	int nowMonth = now.get(Calendar.MONTH);
	int nowDay = now.get(Calendar.DAY_OF_MONTH);

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
	
	function sendIt(){
		
		var f = document.myForm;
		
		f.action= "guest_ok.jsp";
		f.submit();
		
	}
</script>


</head>
<body>

<form action="" method="post" name="myForm">

이름 : <input type="text" name="userName"/><br/>
제목 : <input type="text" name="subject"/><br/>
내용 : <textarea rows="5" cols="30" name="content"></textarea><br/>

<!-- 보이지 않는 created 이름으로 날짜를 저장 -->
<input type="hidden" name="created" value="<%=nowYear %>년 <%=nowMonth %>월 <%=nowDay %>일"/>

<input type="button" value="글올리기" onclick="sendIt()"/>


</form>

</body>
</html>