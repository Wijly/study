<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
	
	// 회원가입 버튼을 누르면 실행되는 함수
	function sendIt(){
		
		var f = document.myForm;
		
		// 아이디를 입력하지 않았을 때
		if(!f.userID.value){
			alert("아이디 입력");
			// 아이디에 포커스를 가져감
			f.userID.focus();
			return;
		}
		//비밀번호를 입력하지않았을 때
		if(!f.userPwd.value){
			alert("비밀번호 입력");
			// 비밀번호에 포커스를 가져감
			f.userID.focus();
			return;
		}
		
		// 비밀번호 값이 없을 때
		if(!f.tel1.value){
			alert("전화번호 선택");
			f.tel1.focus();
			return;
		}
		alert("회원가입 성공");
		f.action="test1_ok.jsp"
		f.submit();
	}
	
	// 0~9까지의 숫자
	function onlyNum(){
		if(event.keyCode<48 || event.keyCode>57){
			event.returnValue=false;
		}	
	}
	
	// 한글값
	function hangul(){
		if(event.keyCode<12592 || event.keyCode>12687){
			event.returnValue=false;
		}	
	}
	
	


</script>

</head>
<body>
<!--  사용자 정의 -->
<form name ="myForm" method="post">
<!--  스크립트를 사용하려면 이름을 지정해야한다 -->
아이디 : <input type="text" name="userID"/><br/>
패스워드 : <input type="password" name="userPwd"/> <br/>

<!--  한글만 입력가능하도록 onkeypress 한글 설정 -->
이름 : <input type="text" name="username" onkeypress="hangul();"/>

성별 : <input type="radio" name="gender" checked="checked" value="M"/>남자 
<input type="radio" name="gender" checked="checked" value="F"/>여자<br/>
전화 : 
<select name="tel1">
	<option value="">선택</option>
	<!-- 처음보여주는것이 010으로 보여주기 -->
	<option value="010" selected="selected">010</option>
	<option value="011">011</option>
	<option value="012">012</option>
	<option value="013">013</option>
</select>

<!-- 번호만입력(onkeypress)이 가능하도록 함수설정  -->
<input type="text" size="4" name="tel2" onkeypress="onlyNum();"/>
-
<input type="text" size="4" name="test3" onkeypress="onlyNum();"/><br/>

동의합니까? <input type="checkbox" name="chk" value="y"/><br/>
메모 : <br/>
<textarea rows="5" cols="20" name="memo"></textarea><br/><br/>

<!-- 회원가입 버튼을 클릭(onclick)했을때 함수 호출 -->
<input type="button" value="회원가입" onclick="sendIt();"/>

<input type="reset" value="다시입력" onclick="document.myForm.userID.focus();"/>
<input type="button" value="취소"/>

</form>

</body>
</html>