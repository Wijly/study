<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type = "text/javascript">
	var str;
	
	str="변수 선언 후 값 대입";
	document.write(str+" : " +  typeof(str) + "<br/>");		// String
	
	str = 123;
	document.write(str+" : " +  typeof(str) + "<br/>");		// number
	
	str = true;
	document.write(str+" : " +  typeof(str) + "<br/>");		// boolean

	document.write("-------------------------------------------<br/>");
	
	var hello = "함수 밖 전역변수(hello) ";
	
	function thisFuction(){
		
		// var를 붙이면 지역변수가 됨
		var hello = " 함수 안 지역 변수(hello)";
		var local = "함수 안 지역 변수 (local)";
		// 붙이지 않으면 전역변수가 됨
		global = " 함수 안 전역 변수 (global)";
		
		document.write(hello + "<br/>");
		document.write(local + "<br/>");
		document.write(global + "<br/>");
		document.write("=================================<br/>");
		
	}
	
	thisFuction();
	
	document.write(hello + "<br/>");
//	document.write(local + "<br/>");
	document.write(global + "<br/>");
	
	var num1=20, num2=5;
	document.write("num1 + num2 = "+ (num1+num2) + "<br/>");
	document.write("num1 - num2 = "+ (num1-num2) + "<br/>");
	document.write("num1 * num2 = "+ (num1*num2) + "<br/>");
	document.write("num1 / num2 = "+ (num1/num2) + "<br/>");
	
	document.write("num1 > num2 : "+ (num1>num2) + "<br/>");
	document.write("num1 < num2 : "+ (num1<num2) + "<br/>");
	
	var ans = 10;
	if(ans>0){
		document.write(ans + "는 양수<br/>");
	}
	else if(ans<0){
		document.write(ans + "는 음수<br/>");
	}
	else{
		document.write(ans + "는 0<br/>");
	}
	document.write("<br/><br/>");
	
	
	for(var i =0; i<10;i++){
		document.write(i+"<br/>");		
	}
	
	document.write("<br/><br/>");
	
	var a=1;
	while(a<=10){
		document.write(a+ "\t");
		a++;
	}
	
	// 자바 스크립트 호출 <body onload="test1();">
	function test1(){
		alert("javascript 함수");
	}
	function test2(color){
		document.bgColor = color;
	}
	
	// 폼을 사용하기 위한 함수
	function idpwCheck(){
		
		var f= document.myForm;
		
		if(!f.id.value){
			alert("아이디를 입력하세요.");
			f.id.focus();
			return;
		}
		if(!f.pwd.value){
			alert("패스워드를 입력하세요.");
			f.pwd.focus();
			return;
		}
		alert("로그인 성공");
	}
	
	function fdelete(num){
		
		var returnValue;
		// 윈도우(객체)
		returnValue = window.confirm("삭제 하시겠습니까?\n delete custom where num= "+ num);
		if(returnValue == true){
			alert("delete custom where num= "+num+"실행 됨");
		}
		
	}
	
	
</script>

</head>
<!-- 시작하면 test1으로 alert 호출 -->
<body onload="test1();">

배경색 선택하기<br/>
<!--  기본값이 흰색인 radio 타입 생성 -->
<input type="radio" name="r1" onclick="test2('white')" checked="checked"/> while<br/>
<input type="radio" name="r1" onclick="test2('red')"/> red<br/>
<input type="radio" name="r1" onclick="test2('blue')"/> blue<br/>
<input type="radio" name="r1" onclick="test2('yellow')"/> yellow<br/>
<input type="radio" name="r1" onclick="test2('aqua')"/> aqua<br/>

<br/><br/><br/><br/>


<!-- id,pwd를 쓰기위한 form을 주기 -->
<form action="" name="myForm">

<table style="font-size: 10pt; font-style: 돋움; "cellpadding="3">
<tr>
	<td><b>아이디</b></td>
	<td><input type="text" style="width: 100px; height:22px;" name="id"></td>
	<td></td>
</tr>
<tr>
	<td><b>비밀번호</b></td>
	<td><input type="password" style="width: 100px; height:22px;"name="pwd"></td>
	<!--  로그인을 클릭했을 때 실행되는 idpwcheck -->
	<td><a href="javascript:idpwCheck();"><img src="./img/btn_login.gif"></a></td>
</tr>
<tr>
	<td colspan="3" align="center">
	<input type="checkbox">아이디 저장
	<input type="checkbox" checked="checked"> 보안 접속
	</td>
</tr>

<tr height="1">
	<td colspan="3" bgcolor="#dad6d7"></td>
</tr>
</table>
</form>

<br/><br/><br/>

<table border="0" cellpadding="5">
<tr bgcolor="#ccccff">
	<td>1</td><td>다스리</td><td>22</td><td>서울</td><td><a href="javascript:fdelete(1);">삭제</a></td>
</tr>
<tr bgcolor="#ccccff">
	<td>2</td><td>준형</td><td>25</td><td>경기도</td><td><a href="javascript:fdelete(1);">삭제</a></td>
</tr>


</table>

</body>
</html>