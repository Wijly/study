<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="com.board.BoardDAO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");
	//주소를 찾기 위한것
	String cp = request.getContextPath();
%>
<jsp:useBean id="dto" class="com.board.BoardDTO" scope="page"/>
<jsp:setProperty property="*" name="dto"/>
<%
	String pageNum = request.getParameter("pageNum");

	//검색해서 들어왔을 경우 searchKey,Value값을 전달받음
	// 검색 관련 ------------------------------------------------------------
	String searchKey = request.getParameter("searchKey");
	String searchValue = request.getParameter("searchValue");
	
	// 검색을 했을 때
	if(searchValue != null){
		
		// 한글을 넘길때 encoding 작업을 해줘야 함. get방식일 때 압축된 한글을디코딩 방식을해서 한글을 다시 보여줌 
		if(request.getMethod().equalsIgnoreCase("GET")){
			searchValue = URLDecoder.decode(searchValue, "UTF-8");
		}
	}
	else{ // 검색을 하지 않았을 때
		searchKey = "subject";
		searchValue = "";	
	}
	//-------------------------------------------------------------------------
	
	String param ="";
	if(!searchValue.equalsIgnoreCase("")){
		param = "&searchKey="+ searchKey;
		param+= "&searchValue="+URLEncoder.encode(searchValue,"UTF-8");
	}

	Connection conn = DBConn.getConnection();
	BoardDAO dao = new BoardDAO(conn);
	
	dao.updateData(dto);
	
	DBConn.close();
	
	response.sendRedirect("list.jsp?pageNum="+pageNum+param);
	
%>