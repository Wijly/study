<%@ page contentType="text/html; charset=UTF-8" %>

<%
	//form 메소드:포스트에서 입력된 한글을 받아낼 때 깨지지않게 처리
	request.setCharacterEncoding("UTF-8");


	// hap의 name의 모든값이 request에 담겨서 넘어온다
	// 넘어오는 request의 값은 모두 String
	// 다시 hap으로 넘어갈때는 response에 담겨서 넘어간다
	String s1 = request.getParameter("su1");	// 변수 su1의 값을 받음
	String s2 = request.getParameter("su2");
	
	// 넘어온 su의 값은 String으로 받으므로 int로 변환
	int su1= Integer.parseInt(s1);
	int su2= Integer.parseInt(s2);
	
/*	
	= 줄여서 
	int su1 = Integer.parseInt(request.getParameter("su1"));
	int su2 = Integer.parseInt(request.getParameter("su2"));
*/
	

	// 이름 받기
	String name= request.getParameter("username");

	int sum;
	sum = su1 + su2;
	
	

%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
이름 : <%=name %><br/>
결과  : <%=su1 %> + <%=su2 %> = <%=sum %> <br/>

</body>
</html>