<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<body>
	<table width="560" border="2" cellpadding="0" cellspacing="0"
		bordercolor="#d6d4a6" align="center">
		<tr height="40">
			<td style="padding-left: 20px;"><b>이미지 게시판</b></td>
		</tr>
	</table>

	<table width="600" align="center" cellspacing="2" cellpadding="1">
		<tr>
			<td align="left" colspan="2" width="400">Total ${dataCount }
				articles, ${totalPage } pages / Now page is ${pageNum }</td>
			<td align="right" colspan="1" width="200"><input type="button"
				value="게시물등록"
				onclick="javascript:location='<%=cp%>/image/write.do';" /></td>
		</tr>
		<tr>
			<td colspan="2" height="3" bgcolor="#dbdbdb" align="center"></td>
		</tr>
		<%
			int cnt = 0;
		%>
		<c:forEach var="dto" items="${lists}">
			<%
				if (cnt == 0) {
						out.print("<tr>");
					}
					cnt++;
			%>
			<td align="center" width="190"><input type="hidden" value=${dto.num } name="num" />
			<a href="${imagePath}">
			 	<img src="${imagePath}/${dto.saveFileName}" width="190" height="190" /> <br />
					${dto.subject}
			</a>
			<a href="<%=cp %>/image/delete.do?num=${dto.num}&pageNum=${pageNum}"> ${dto.num }삭제 </a>
			</td>
			<%
				if (cnt == 3) {
					out.print("</tr>");
					cnt = 0;
				}
			%>
		</c:forEach>
		<%
			while (cnt > 0 && cnt < 3) {
				out.print("<td width='180'></td>");
				cnt++;
			}
			out.print("</tr>");
		%>
	</table>
	<table align="center">
		<tr>
			<td align="center">${pageIndexList }</td>
		</tr>
	</table>

</body>
</html>