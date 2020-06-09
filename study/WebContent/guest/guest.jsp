<%@page import="com.util.MyUtil"%>
<%@page import="com.guest.GuestDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.util.DBConn"%>
<%@page import="com.guest.GuestDAO"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");
	//주소를 찾기 위한것
	String cp = request.getContextPath();
	
	MyUtil myutil = new MyUtil();
	
	// dao 메소드 실행위한 선언
	GuestDAO dao = new GuestDAO(DBConn.getConnection());
	
	String pageNum = request.getParameter("pageNum");

	// 전체 데이터 개수
	int dataCount = dao.getDataCount();
	
	// 한 페이지에 표시할 데이터 개수
	int numPage = 5;
	
	// 첫 시작시 페이지
	int currentPage = 1;
	
	// 넘어온 현재 페이지가 존재할 경우 현재 페이지에 값 넣기
	if(pageNum!=null){
		currentPage = Integer.parseInt(pageNum);
	}else{
		pageNum = "1";
	}

	// 전체 페이지의 개수 ( 전체데이터 / 표시할 데이터)
	int totalPage = myutil.getPageCount(numPage, dataCount);
	
	// 데이터 삭제시 페이지가 줄어들었을 때 처리
	if(currentPage > totalPage){
		currentPage = totalPage;
	}
	
	// 가져올 데이터의 첫번째와 마지막
	int start = (currentPage-1)*numPage+1;
	int end = currentPage*numPage;
	
	// 객체를 불러오기위한 list
	List<GuestDTO> lists = dao.getLists(start,end);
	
	String param = "";
		
	String listUrl = "guest.jsp"+param;
	String pageIndexList = myutil.pageIndexList(currentPage, totalPage, listUrl);

	
	DBConn.close();
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>방 명 록</title>

<link rel="stylesheet" href="<%=cp%>/guest/data/style.css" type="text/css" />
<script type="text/javascript" src="<%=cp %>/guest/data/guest.js">



</script>


</head>
<body>
<br/><br/>

<table width="560" border="2" cellpadding="0" cellspacing="0" bordercolor="#d6d4a6" align="center">
	<tr height="40">
		<td style="padding-left: 20px;"><b>방 명 록</b></td>
	</tr>
</table>
<br/>
<!--  액션이 sendIt에 적혀있으므로 빈칸 -->
<form action="" name="myForm" method="post">
<table width="560" border="0" cellpadding="3" cellspacing="0" align="center">
	<!-- 선하나 긋기 -->
	<tr><td colspan="2" height="3" bgcolor="#dbdbdb" align="center"></td></tr>
	<tr>
		<td width="20%" height="30" bgcolor="#eeeeee" style="padding-left:20px;">
		작성자
		</td>
		<td width="80%" style="padding-left: 10px;">
		<input type="text" name="name" size="35" maxlength="20" class="boxTF"/>
		</td>
	</tr>
	
	<tr><td colspan="2" height="3" bgcolor="#dbdbdb" align="center"></td></tr>
	
	<tr>
		<td width="20%" height="30" bgcolor="#eeeeee" style="padding-left:20px;">
		이메일
		</td>
		<td width="80%" style="padding-left: 10px;">
		<input type="text" name="email" size="35" maxlength="50" class="boxTF"/>
		</td>
	</tr>
	
	<tr><td colspan="2" height="3" bgcolor="#dbdbdb" align="center"></td></tr>
	
	<tr>
		<td width="20%" height="30" bgcolor="#eeeeee" style="padding-left:20px;">
			홈페이지
		</td>
		<td width="80%" style="padding-left: 10px;">
		<input type="text" name="homepage" size="35" maxlength="50" class="boxTF" value="http://"/>
		</td>
	</tr>
	
	<tr><td colspan="2" height="3" bgcolor="#dbdbdb" align="center"></td></tr>
	
	<tr>
		<td width="20%" height="30" bgcolor="#eeeeee" style="padding-left:20px;">
			내&nbsp;&nbsp;&nbsp;&nbsp;용
		</td>
		<td width="80%"  valign="top" style="padding-left: 10px;">
			<textarea rows="7" cols="60" name="content" class="boxTA"></textarea>
		</td>
	</tr>
	
	<tr><td colspan="2" height="3" bgcolor="#dbdbdb" align="center"></td></tr>

</table>

<table width="560" border="0" cellpadding="3" cellspacing="0" align="center">
	<tr align="center">
		<td height="40">
			<input type="button" value=" 등록하기 "  class="btn1" onclick="sendIt();"/>
			<input type="reset" value=" 다시입력 " class="btn1" onclick="document.myForm.name.focus();"/>
		</td>
	</tr>
</table>

<%
	if(lists==null){
%>
	<!--  없을경우 자료가  -->
	<table width="560" border="0" cellpadding="3" cellspacing="0" align="center">
	<tr><td colspan="2" height="3" bgcolor="#dbdbdb" align="center"></td></tr>
	<tr align="center"><td height="60" bgcolor="#eeeeee" align="center" ><b> 등록된 자료가 없습니다. </b></td></tr>
	<tr><td colspan="2" height="3" bgcolor="#dbdbdb" align="center"></td></tr>
	</table>
<%
	}
%>


<%
	if(lists!=null){
%>
<!--  lists 개수만큼 반복 -->
	<table width="560" border="0" cellpadding="3" cellspacing="0" align="center">
	<%
		for(GuestDTO dto : lists){
	%>

		<tr><td colspan="2" height="3" bgcolor="#dbdbdb" align="center"></td></tr>
		<tr height="30" bgcolor="#eeeeee">
			<td width="50%" align="left"><b>No <%=dto.getNum() %>. <%=dto.getName()%>(<%=dto.getEmail() %>)</b></td>
			<td width="50%" align="right">홈페이지 : <%=dto.getHomepage() %></td>
		</tr>
		<tr height="30" bgcolor="#eeeeee">
			<td width="50%" align="left">작성일 : <%=dto.getCreated() %> (<%=dto.getIpAddr() %>)</td>
			<td width="50%" align="right">
			<input type="hidden" name="deleteNum" value="<%=dto.getNum()%>"/>
			<a href="javascript:deleteIt()" >삭제</a></td>

		</tr>
		<tr><td colspan="2" height="3" bgcolor="#dbdbdb" align="center"></td></tr>
		<tr>
			<td><%=dto.getContent() %><br/></td>
		</tr>
<%
		}
%>
	<tr><td colspan="2" height="3" bgcolor="#dbdbdb" align="center"></td></tr>
	
<%
	}
%>
</table>
<table align="center">
<tr>
	<td> <%=pageIndexList %></td>
</tr>
</table>

</form>

</body>
</html>