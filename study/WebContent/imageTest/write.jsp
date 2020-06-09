<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");
	//주소를 찾기 위한것
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Image board</title>

<link rel="stylesheet" href="<%=cp%>/imageTest/data/style.css" type="text/css" />
<script type="text/javascript" src="<%=cp%>/imageTest/data/image.js">

</script>

</head>
<body>

<table width="560" border="2" cellpadding="0" cellspacing="0" bordercolor="#d6d4a6" align="center">
	<tr height="40">
		<td style="padding-left: 20px;"><b>이미지 게시판</b></td>
	</tr>
</table>

<form action="<%=cp %>/image/write_ok.do" method="post" name="myForm" enctype="multipart/form-data">
<table width="560" border="0" cellpadding="3" cellspacing="0" align="center">
	<tr><td colspan="2" height="3" bgcolor="#dbdbdb" align="center"></td></tr>
	<tr>
		<td width="120px" height="30" bgcolor="#eeeeee" style="padding-left:20px;">제목 </td>
		<td style="padding-left:10px;"><input type="text" name="subject" class="boxTF"/></td>
	</tr>
	<tr><td colspan="2" height="3" bgcolor="#dbdbdb" align="center"></td></tr>
	
	<tr>
		<td width="20%" height="30" bgcolor="#eeeeee" style="padding-left:20px;">파일 </td>
		<td style="padding-left:10px;"><input type="file" name="upload" class="boxTF"/><br/></td>
	</tr>
	<tr><td colspan="2" height="3" bgcolor="#dbdbdb" align="center"></td></tr>
</table>
<table align="center">
	<tr>
	<td align="center">
		<input type="button" value=" 등록하기 " onclick="sendIt();"/>
		<input type="button" value=" 다시입력 " onclick="document.myForm.subject.focus();"/>
		<input type="button" value=" 리스트 " onclick="javascript:location.href='<%=cp %>/image/list.do';"/>
	</td>
	</tr>
</table>
</form>

</body>
</html>