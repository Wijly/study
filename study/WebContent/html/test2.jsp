<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>


<!-- text를 입력할 수 있는 칸 -->
<table>
<tr>
	<td><img src="./img/tit_h1_0201.gif"></td>
</tr>

<tr height="1">
	<td colspan="2" bgcolor="#dad6d7"></td>
</tr>
</table>
<table style="font-size:10pt; font-style: 돋움;" cellpadding="3">
<tr>
	<td><b>이름</b></td>
	<td><input type="text"></td>
</tr>
<tr>
	<td><b>주민번호</b></td>
	<td><input type="text" size="12">-<input type="text" size="12"></td>
</tr>
<tr height="1">
	<td colspan="2" bgcolor="#dad6d7"></td>
</tr>
<tr>
	<td align="center" colspan="2"><img src="./img/btn_ok01.gif"></td>
</tr>
</table>

<br/><br/><br/><br/>



<table style="font-size: 10pt; font-style: 돋움; "cellpadding="3">
<tr>
	<td><b>아이디</b></td>
	<td><input type="text" style="width: 100px; height:22px;"></td>
	<td></td>
</tr>
<tr>
	<td><b>비밀번호</b></td>
	<td><input type="password" style="width: 100px; height:22px;"></td>
	<td><img src="./img/btn_login.gif"></td>
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

<br/><br/><br/><br/>


<table background="./img/bg_575x84.gif" width="575" height="84">
<tr>
	<td align="center">
	
		<table style="font-size: 10pt; font-style: 돋움;" cellpadding="3">
		<tr>
			<td><input type="text" style="width: 300px; height: 22px;">
			<img src="./img/btn_search.gif" align="top">
			</td>
		</tr>
		<tr>
			<td align="center">
			<input type="radio" name="r1"><font color="#339900"><b>카페명</b></font>
			<input type="radio" name="r1"><font color="#339900"><b>게시물</b></font>
			<input type="radio" name="r1"><font color="#339900"><b>매니저/ID</b></font>
			
			<!--  
			<input type="radio" name="r2"><font color="#339900"><b>카페명</b></font>
			<input type="radio" name="r2"><font color="#339900"><b>게시물</b></font>
			<input type="radio" name="r2"><font color="#339900"><b>매니저/ID</b></font>
			-->
			</td>
		</tr>
		</table>
	</td>
</tr>	
</table>

<br/><br/><br/><br/>

<!--  파일 -->
파일선택 : <input type="file" style="border-style: solid; border-width: 1px; border-color: #aaaaaa; width: 400px; font-size: 10pt">


<br/><br/><br/><br/>

<!--  파란색은 value값, 검은색은 눈에 보이는 값 -->
휴대폰 : 
<select>
	<option>선택</option>
	<option value="010">010</option>
	<option value="011">011</option>
	<option value="016">016</option>
	<option value="070">070</option>
</select>
-
<input type="text" size="4"/>
-
<input type="text" size="4"/>


<br/><br/><br/><br/>


<textarea style="border-style: solid; border-width: 1px; border-color: #aaaaaa; width: 400px; height: 200px"> 게시글 작성</textarea>

</body>
</html>