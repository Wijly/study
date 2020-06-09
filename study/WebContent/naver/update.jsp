<%@page import="com.naver.NaverDTO"%>
<%@page import="com.naver.NaverDAO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
	request.setCharacterEncoding("UTF-8");

	//주소를 찾기 위한것
	String cp = request.getContextPath();
	
	String id = request.getParameter("id");
	
	Connection conn = DBConn.getConnection();
	NaverDAO dao = new NaverDAO(conn);
	
	NaverDTO dto = dao.getReadData(id);
	
	DBConn.close();
	
	if(dto==null){
		response.sendRedirect("naver_list.jsp");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
	// 가입을 누르면 실행되는 함수
	function sendIt(){
		
		var f = document.myForm
		
		if(!f.pwd.value){
			alert("비밀번호 입력");
			f.userPwd.focus();
			return;
		}
		if(f.pwd.value != f.pwd2.value){
			alert("비밀번호 확인 오류");
			f.userPwd.focus();
			return;
		}
		if(!f.name.value){
			alert("이름 입력");
			f.username.focus();
			return;
		}

		if(!f.tel1.value){
			alert("번호입력");
			f.tel1.focus();
			return;
		}
		
		alert("회원정보 변경 성공");
		
		f.action="<%=cp%>/naver/update_ok.jsp";
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
	width: 200px;
	height: 40px;
}
.td{
	width: 200px;
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
	<td><%=dto.getId() %></td>
</tr>
<tr>
	<td>비밀번호</td>
</tr>
<tr>
	<td><input type="password" class="td" name="pwd" value="<%=dto.getPwd()%>"></td>
</tr>	
<tr>
	<td>비밀번호 확인</td>
</tr>
<tr>
	<td><input type="password" class="td" name="pwd2" ></td>
</tr>	
</table>
<br/>
<table>
<tr>
	<td>이름</td>
</tr>
<tr>
	<td><input type="text" class="td" name="name" value="<%=dto.getName()%>"></td>
</tr>
</table>
<table>
<tr>
	<td>생년월일</td>
</tr>
<tr>
	<td align="center"><%=dto.getBirth1() %>년</td>
	<td align="center">
	<%=dto.getBirth2() %>월</td>
	<td align="center"><%=dto.getBirth3() %>일</td>
</tr>
</table>
<table>
<tr>
	<td>성별</td>
</tr>
<tr>
	<td>
	<%=dto.getGender() %>
	</td>
</tr>
<tr>
	<td>본인 확인 이메일(선택)
</tr>
<tr>
	<td><input type="text" class="td" name="email" value="<%=dto.getEmail()%>"></td>
</tr>
</table>
<table>
<tr>
	<td>휴대전화</td>
</tr>
<tr>
	<td>
	<select style="width:160px; height:30px;">
		<option value="82">대한민국 +82</option>
		<option value="233">가나 +233</option>
		<option value="1">미국/캐나다 +1</option>
	</select>
	</td>
</tr>
<tr>
	<td><input type="text" style="width:160px; height:22px;" name="tel1" onkeypress="onlyNum();" value="<%=dto.getTel1()%>"></td>
	<td><input type="button" value="인증" style="width:40px; height:30px; color:rgb(0,199,83);" /></td>
</tr>
<tr>
	<td colspan="3"><input type="text" class="td" onkeypress="onlyNum();"/> </td>
</tr>
</table>
<table>
<tr>

	<td><input type="button" value="변경하기" class="btn" onclick="sendIt();"/>
		<input type="hidden" name="id" value="<%=dto.getId() %>"/>
		<input type="button" value="취소" class="btn" onclick="javascript:location.href='<%=cp%>/naver/naver_list.jsp'"/>
	</td>
</tr>
</table>
</center>
</form>
</body>
</html>