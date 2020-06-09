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
<title>Insert title here</title>
</head>
<body>

<form action="" method="post">

수 1 : <input type="text" name="su1"/><br/>
수 2 : <input type="text" name="su2"/><br/>
<input type="submit" value="결과"/><br/>

</form>

<br/>
<br/>

su1 : <%=request.getParameter("su1") %><br/>
su2 : <%=request.getParameter("su2") %><br/>



<%
	int sum = 0;
	if(request.getParameter("su1") != null & request.getParameter("su2") !=null){
		sum = Integer.parseInt(request.getParameter("su1")) + Integer.parseInt(request.getParameter("su2"));
	}
%>

합 : <%=sum %><br/>

<br/><br/>

합 : ${param.su1 + param.su2 }<br/>
${param.su1 }은(는) ${param.su1%2==0?"짝수":"홀수" }<br/>




</body>
</html>