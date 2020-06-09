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

	// 버튼 =  스크립트를 사용하는 것
	// 스크립트를 만든건 버튼
	function sendIt(val){
		
	// form은 인덱스 번호로 처리됨 
//		var f = document.myForm;
		var f = document.forms[0];
		
		if(!f.name.value){
			alert("이름 입력");
			f.name.focus();
			return;
		}
		
		if(val=='r1')
			f.action = "result1.jsp";
		else if(val=='r2')
			f.action = "result2.jsp";
		
		f.submit();
	}
	
	function sendData(){
		var f = document.forms[0];
		
		if(!f.name.value){
			alert("이름 입력");
			f.name.focus();
			return;
		}
		
		f.submit();
	}


</script>


</head>
<body>

<form action="" method="post" name="myForm">

이름 : <input type="text" name="name"/><br/>

<input type="button" value="첫번째 전송" onclick="sendIt('r1');"/>
<input type="button" value="두번째 전송" onclick="sendIt('r2');"/>

</form>

<!-- submit으로 만들경우 조건 사용을 위해 onsubmit을 선언 -->
<form action="" method="post" name="myForm1" onsubmit="return sendData();">
이름 : <input type="text" name="name"/><br/>

<input type="submit" value="첫번째 전송" onclick="this.form.action='result1.jsp';"/>
<input type="submit" value="두번째 전송" onclick="this.form.action='result2.jsp';"/>

</form>



</body>
</html>