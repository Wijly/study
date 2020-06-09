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
<body style="font-size: 10px;">

<form action="<%=cp %>/file/write_ok.do" method="post" enctype="multipart/form-data">

제목 : <input type="text" name="subject"/><br/>
파일 : <input type="file" name="upload"/><br/>
<input type="submit" value=" 전송 "/>
<input type="button" value=" 리스트 " onclick="javascript:location.href='<%=cp %>/image/list.do';"/>

</form>

</body>
</html>