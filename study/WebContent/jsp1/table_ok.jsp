<%@ page contentType="text/html; charset=UTF-8" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");

	int su1 = Integer.parseInt(request.getParameter("su1"));
	int su2= Integer.parseInt(request.getParameter("su2"));
	
	int cnt=0;
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<table border="1" cellpadding="0" cellspacing="0" width="600">
<%
	// 가로 x 세로 만큼 칸을 만들어야하므로 jsp
	// 가로의 갯수만큼 tr을 만듬
	for(int i=1; i<=su1; i++){
		out.print("<tr>");	// 가로 입력갯수만큼 tr을 엶
		
		for(int j=1; j<=su2;j++){
			// 세로 입력개수만큼 td를 만들고 그안에 cnt값을 넣음
			cnt++;		// 1칸 안에 들어갈 값 ++
%>
			<td width="50" align="center"><%=cnt %></td>
<%		
		// 2중 포문 닫기
		}
%>
	<!--  tr(가로) 한번 생성끝 -->
	</tr>
<%
	// tr 생성 포문 닫기
	}
%>


</table>
 
</body>
</html>