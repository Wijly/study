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
<title>Insert title here</title>
</head>
<body style="font-size: 10pt">
<br/><br/>

<table width="400" align="center" cellpadding="0" cellspacing="0" border="1" bordercolor="cyan">
	<tr>
		<td align="right" colspan="4">
			<input type="button" value=" 글쓰기 "onclick="javascript:location.href='<%=cp%>/file/write.do';"/>
		</td>
	</tr>
	<tr>
		<td align="center" width="50">번호</td>
		<td align="center" width="150">제목</td>
		<td align="center" width="250">파일명</td>
		<td align="center" width="50">삭제</td>
	</tr>
<c:forEach var="dto" items="${lists }">
	<tr>
		<td align="center" width="50">${dto.num }</td>
		<td align="center" width="150">${dto.subject }</td>
		<!-- 
		<td align="center" width="250"><a href="${downloadPath }?num=${dto.num }">${dto.originalFileName }</a></td>
		 -->
		 <!--  이미지 -->
		 <td align="center" width="250"><a href="${imagePath }/${dto.saveFileName}"><img src="${imagePath }/${dto.saveFileName}"	width="180" height="180"/></a></td>
		<td align="center" width="50"><a href="${deletePath }?num=${dto.num }">삭제</a></td>
	</tr>

</c:forEach>
</table>
<table align="center">
<tr>
	<td>${pageIndexList }</td>
</tr>
</table>
</body>
</html>