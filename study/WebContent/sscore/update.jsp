<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.score.ScoreDTO"%>
<%@page import="com.score.ScoreDAO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8" %>
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
<title>성적 수정</title>

<script type="text/javascript">

	function sendIt(){
		
		var f = document.myForm;
		
		if(!f.kor.value){
			alert("국어점수를 입력하세요.");
			f.hak.focus();
			return;
		}
		else if(!f.eng.value){
			alert("영어점수를 입력하세요.");
			f.eng.focus();
			return
		}else if(!f.mat.value){
			alert("수학점수를 입력하세요.");
			f.a.focus();
			return
		}
		
		f.action ="<%=cp%>/jumsu/update_ok.do";
		f.submit();
	}

</script>
<style type="text/css">

*{
	padding: 0px;
	margin: 0px;	
}

body{
	font-size: 12pt;
}

td{
	font-size: 12pt;
}

.txtfield{
	font-size: 10pt;
	border: 1px solid;
}

.btn{
	 font-size: 10pt;
	 background: #e6e6e6;
}

</style>


</head>
<body>
<br/><br/>

<table width="500" cellpadding="0" cellspacing="3" align="center" bgcolor="#e4e4e4">
<tr height="50">
	<td bgcolor="#ffffff" style="padding-left: 10px">
	<b>성적처리 수정화면</b>
	</td>
</tr>
</table>
<br/>
<form action="" method="post" name="myForm">
<table width="500" cellpadding="0" cellspacing="0" align="center">
<!--  학번 -->
<tr height="2"><td colspan="2" bgcolor="#cccccc"></td></tr>
<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6e6">학번 </td>
	<td style="padding-left: 5px">
		${dto.hak}
	</td>
</tr>
<!--  이름 -->
<tr height="2"><td colspan="2" bgcolor="#cccccc"></td></tr>
<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6e6">이름 </td>
	<td style="padding-left: 5px">
		${dto.name}
	</td>
</tr>
<!-- 국 영 수  -->
<tr height="2"><td colspan="2" bgcolor="#cccccc"></td></tr>
<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6e6">국어 </td>
	<td style="padding-left: 5px">
		<input type="text" name="kor" value="${dto.kor }" size="20" maxlength="3" class="txtField"/>
	</td>
</tr>
<tr height="2"><td colspan="2" bgcolor="#cccccc"></td></tr>
<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6e6">영어 </td>
	<td style="padding-left: 5px">
		<input type="text" name="eng" value="${dto.eng }" size="20" maxlength="3" class="txtField"/>
	</td>
</tr>
<tr height="2"><td colspan="2" bgcolor="#cccccc"></td></tr>
<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6e6">수학 </td>
	<td style="padding-left: 5px">
		<input type="text" name="mat" value="${dto.mat }" size="20" maxlength="3" class="txtField"/>
	</td>
</tr>

<tr height="2"><td colspan="2" bgcolor="#cccccc"></td></tr>

<!--  버튼 -->
<tr height="35">
	<td align="center" colspan="2">		
		<input type="button" class="btn" value="수정완료" onclick="sendIt();"/>
		<input type="button" class="btn" value="수정취소" onclick="javascript:location.href='<%=cp%>/sscore/list.do?pageNum=${pageNum }';"/>
	</td>
</tr>
</table>

</form>

</body>
</html>