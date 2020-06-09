<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
	// 가입을 누르면 실행되는 함수
	function sendIt(){
		
		var f = document.myForm
		
		if(!f.userId.value){
			alert("아이디 입력");
			f.userId.focus();
			return;
		}
		if(!f.userPwd.value){
			alert("비밀번호 입력");
			f.userPwd.focus();
			return;
		}
		if(f.userPwd.value != f.userPwd2.value){
			alert("비밀번호 확인 오류");
			f.userPwd.focus();
			return;
		}
		if(!f.username.value){
			alert("이름 입력");
			f.username.focus();
			return;
		}
		if(!f.birth1.value){
			alert("년도 입력");
			f.birth1.focus();
			return;
		}
		if(!f.birth3.value){
			alert("생년 일 입력");
			f.birth3.focus();
			return;
		}
		if(!f.gender.value){
			alert("성별 선택");
			f.gender.focus();
			return;
		}
		if(!f.tel2.value){
			alert("번호입력");
			f.tel2.focus();
			return;
		}
		
		alert("회원가입 성공");
		f.action="naver_ok.jsp";
		f.submit();
	}
	
	// 번호만 입력
	function onlyNum(){
		if(event.keyCode<48 || envet.keyCode>57){
			event.returnValue=false;
		}
	}


</script>

<!-- css -->
<style type="text/css">
body {
	border: 1;
	background-color: rgb(245,246,248)
}
.btn{
	font-size: 12pt;
	color: rgb(0,0,0);
	background-color: rgb(0,199,83);
	width: 250px;
	height: 40px;
}
.textsize{
	width: 250px;
	height:30px;
}
</style>

</head>
<body>
<form name="myForm" method="post">
<center>
<img src="./img/naver.JPG" ><br/>
<table>
<tr>
	<td>아이디</td>
</tr>
<tr>
	<td><input type="text" name="userId" class="textsize"></td>
</tr>
<tr>
	<td>비밀번호</td>
</tr>
<tr>
	<td><input type="password" class="textsize" name="userPwd"></td>
</tr>	
<tr>
	<td>비밀번호 확인</td>
</tr>
<tr>
	<td><input type="password" class="textsize" name="userPwd2"></td>
</tr>	
<tr>
	<td>이름</td>
</tr>
<tr>
	<td><input type="text" class="textsize" name="username"></td>
</tr>
<tr>
	<td>생년월일</td>
</tr>
<tr>
	<td><input type="text" style="width: 85px;height: 30px;" maxlength="4" name="birth1" onkeypress="onlyNum();">
	<select style="width: 70px; height:30px;" name="birth2" >
		<option value="">월</option>
		<option value="1">1월</option>
		<option value="2">2월</option>
		<option value="3">3월</option>
		<option value="4">4월</option>
		<option value="5">5월</option>
		<option value="6">6월</option>
		<option value="7">7월</option>
		<option value="8">8월</option>
		<option value="9">9월</option>
		<option value="10">10월</option>
		<option value="11">11월</option>
		<option value="12">12월</option>
	</select>
	<input type="text" style="width: 80px; height:30px;" maxlength="2" name="birth3" onkeypress="onlyNum();">
	</td>
</tr>
<tr>
	<td>성별</td>
</tr>
<tr>
	<td>
	<select style="width: 250px; height:30px;" name="gender">
		<option value="" selected>성별</option>
			<option value="남자">남자</option>
			<option value="여자">여자</option>
	</select>
	</td>
</tr>
<tr>
	<td>본인 확인 이메일(선택)
</tr>
<tr>
	<td><input type="text" style="width: 250px; height:30px;" name="email"></td>
</tr>
<tr>
	<td>휴대전화</td>
</tr>
<tr>
	<td>
	<select name="tel1">
		<option value="82">대한민국 +82</option>
		<option value="233">가나 +233</option>
		<option value="1">미국/캐나다 +1</option>
	</select>
	</td>
</tr>
<tr>
	<td><input type="text" style="width:210px; height:30px;" name="tel2" onkeypress="onlyNum();">
	<input type="button" value="인증" style="width:40px; height:35px; color:rgb(0,199,83);" /></td>
</tr>
<tr>
	<td colspan="3"><input type="text" style="width:250px; height:30px;" name="tel3" onkeypress="onlyNum();"/> </td>
</tr>
<tr>
	<td><input type="button" value="가입하기" class="btn" onclick="sendIt();"></td>
</tr>
</table>
</center>
</form>
</body>
</html>