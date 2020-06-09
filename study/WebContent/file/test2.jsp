<%@page import="java.io.DataInputStream"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.sun.jmx.snmp.Enumerated"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");
	//주소를 찾기 위한것
	String cp = request.getContextPath();
	
	//test1에서 name값을 받아옴
//	String subject = request.getParameter("subject");
	
	//파일은 getParameter로 받을 수 없으
//	String upload = request.getParameter("upload");
	
	// 파일 받기
	String contentType = request.getContentType();
	Enumeration e = request.getHeaderNames();
	
	out.print("전송받은 헤더 정보 ..<br/>");
	while(e.hasMoreElements()){
		
		String key = (String)e.nextElement();
		String value = request.getHeader(key);
		out.print(key + " : " + value + "<br/>");
		
	}
	
	out.print("<br/>전송받은 데이터 정보 <br/>");
	
	DataInputStream is = new DataInputStream(request.getInputStream());
	String str;
	
	while((str=is.readLine())!=null){
		
		// 한글처리
		out.print(new String(str.getBytes("ISO-8859-1"),"euc-kr")+"<br/>");
	}
	
%>
