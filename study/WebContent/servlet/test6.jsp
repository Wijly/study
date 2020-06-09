<%@page import="java.util.List"%>
<%@page import="com.svt.MyDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");
	//주소를 찾기 위한것
	String cp = request.getContextPath();
	
	List<MyDTO> lists = new ArrayList<MyDTO>();
	
	MyDTO dto;
	
	dto = new MyDTO("다수리",22);
	lists.add(dto);
	
	dto = new MyDTO("즐리",25);
	lists.add(dto);
	
	dto = new MyDTO("미스터차",45);
	lists.add(dto);
	
	dto = new MyDTO("루루",99);
	lists.add(dto);
	
	request.setAttribute("lists", lists);
	
%>
<jsp:forward page="aa.jsp"/>