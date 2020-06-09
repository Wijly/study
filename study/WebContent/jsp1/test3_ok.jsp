<%@ page contentType="text/html; charset=UTF-8" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");

	String name = request.getParameter("name");
	String memo = request.getParameter("memo");
	
	// 여러개를 받을 수 있으므로 배열로
	String[] type = request.getParameterValues("wanabe");
	
	// 전공
	String major = request.getParameter("major");
	
	// 취미= multiple이므로 배열로 받음
	String[] hobby = request.getParameterValues("hobby");
	
	// enter를 인식하지 못하므로 공백을 br로 바꿈
	memo = memo.replaceAll("\n", "<br/>");
	
	// 체크박스를 받아오기 위해서 for문 실행
	String str= "";
	// null 이 아닐 경우에 실행해서 str에 집어넣음
	if(type!=null){
		for(String temp: type)
			str += temp + " ";
	}
	
	// 취미가 여러개일 수 있으므로 null이 아닌경우 모두 출력
	String str1="";
	if(hobby!=null){
		for(String temp: hobby)
			str1 += temp + " ";
	}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

이름 : <%=name %><br/>
메모 : <%=memo %><br/>
이상형 : <%=str %><br/>
전공 : <%=major %><br/>
취미 : <%=str1 %><br/>




</body>
</html>