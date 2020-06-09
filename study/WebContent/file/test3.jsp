<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");
	//주소를 찾기 위한것
	String cp = request.getContextPath();
	
	// 파일을 어디에 저장할지 지정
	String root = pageContext.getServletContext().getRealPath("/");
//	String root = request.getRealPath("/");		// 예전 방식

	String path = root + File.separator  + "pds" + File.separator + "saveData";

	File f = new File(path);
	// 파일이 없으면 파일을 만듬
	if(!f.exists()){
		f.mkdirs();
	}
	
	String encType = "UTF-8";
	int maxFileSize = 5 * 1024 * 1024;
	
	try{
		
		// 파일 업로드
		// 파일을 받아와서 주소에가져가고,파일크기, 파일타입을 확인하고 생성, 
		MultipartRequest mr = new MultipartRequest(request,path,maxFileSize,encType,new DefaultFileRenamePolicy());
		// 업로드된 파일 정보 추출
		out.print("제목 : "+ mr.getParameter("subject")+"<br/>");
		out.print("서버에 저장된 파일 이름 : "+ mr.getFilesystemName("upload")+"<br/>");
		out.print("업로드 된 파일 명 : "+mr.getOriginalFileName("upload")+"<br/>");
		out.print("파일 타입 : "+mr.getContentType("upload")+"<br/>");
		
		// 파일 사이즈
		File file = mr.getFile("upload");
		if(file!=null){
			out.print("파일 길이 : "+file.length()+"<br/>");
		}
		
		
	}catch(Exception e){
		
	}
	
	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%=root %>
<%=path %>

</body>
</html>