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
</head>
<body>

<form action="test3_ok.jsp" method="post">

이름 : <input type="text" name="name"/><br/>
메모 : <textarea rows="5" cols="30" name="memo"></textarea><br/>
이상형 : <br/>
<input type="checkbox" name="wanabe" value="다수리">다수리<br/>
<input type="checkbox" name="wanabe" value="청순">청순<br/>
<input type="checkbox" name="wanabe" value="앞머리">앞머리<br/>
<input type="checkbox" name="wanabe" value="긴머리">긴머리<br/>
<input type="checkbox" name="wanabe" value="단발">단발<br/>
<input type="checkbox" name="wanabe" value="귀여움">귀여움<br/>
<input type="checkbox" name="wanabe" value="마름">마름<br/>
<input type="checkbox" name="wanabe" value="재력">재력<br/>
<input type="checkbox" name="wanabe" value="큰키">큰키<br/>
<input type="checkbox" name="wanabe" value="작은키">작은키<br/>
<br/>
전공 : 
<select name="major">
	<option value="국어">국어</option>
	<option value="수학">수학</option>
	<option value="영어">영어</option>
	<option value="서비스업">서비스업</option>
</select>
<br/>
취미 : 
<select name="hobby" size="4" multiple="multiple">
	<option value="게임">게임</option>
	<option value="운동">운동</option>
	<option value="영화">영화</option>
	<option value="음악">음악</option>
	<option value="공부">공부</option>
</select>
<br/>

<input type="submit" value="전송">

</form>

</body>
</html>