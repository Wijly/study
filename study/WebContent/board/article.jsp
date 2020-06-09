<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="com.board.BoardDTO"%>
<%@page import="com.board.BoardDAO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");
	//주소를 찾기 위한것
	String cp = request.getContextPath();
	
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	// 검색해서 들어왔을 경우 searchKey,Value값을 전달받음
	// 검색 관련 ------------------------------------------------------------
	String searchKey = request.getParameter("searchKey");
	String searchValue = request.getParameter("searchValue");
	
	// 검색을 했을 때
	if(searchValue != null){
		
		// 한글을 넘길때 encoding 작업을 해줘야 함. get방식일 때 압축된 한글을 디코딩 방식을해서 한글을 다시 보여줌 
		if(request.getMethod().equalsIgnoreCase("GET")){
			searchValue = URLDecoder.decode(searchValue, "UTF-8");
		}
	}
	else{ // 검색을 하지 않았을 때
		searchKey = "subject";
		searchValue = "";	
	}
	//-------------------------------------------------------------------------
	
	
	Connection conn = DBConn.getConnection();
	BoardDAO dao = new BoardDAO(conn);
	
	// 조회수 증가
	dao.updateHitcount(num);
	
	// 글 가져오기
	BoardDTO dto = dao.getReadData(num);
	
	if( dto==null )
		response.sendRedirect("list.jsp");
	
	// 글 line 수, enter 다위로 글을 나눠서 line의 수를 센다
	int lineSu = dto.getContent().split("\n").length;
	
	// 글 내용의 엔터를 <br>로 변경
	dto.setContent(dto.getContent().replaceAll("\n", "<br/>"));
	
	// 주소 정리
	String param="";
	// 인코딩
	if(!searchValue.equals("")){
		param = "&searchKey="+ searchKey;
		param+= "&searchValue="+URLEncoder.encode(searchValue,"UTF-8");
	}
	
	
	DBConn.close();
	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="<%=cp %>/board/css/style.css"/>
<link rel="stylesheet" href="<%=cp %>/board/css/article.css"/>

</head>
<body>

<div id="bbs">
	<div id="bbs_title">
	게 시 판	
	</div>
	<div id="bbsArticle">
		<div id="bbsArticle_header">
			<%=dto.getSubject() %>
		</div>
		<div class="bbsArticle_bottomLine">
			<dl>
				<dt>작성자</dt>
				<dd><%=dto.getName() %></dd>
				<dt>줄  수</dt>
				<dd><%=lineSu %></dd>			
			</dl>
		</div>
			<div class="bbsArticle_bottomLine">
			<dl>
				<dt>등록일</dt>
				<dd><%=dto.getCreated() %></dd>
				<dt>조회수</dt>
				<dd><%=dto.getHitCount() %></dd>			
			</dl>
		</div>
		<div id="bbs_article_content">
			<table width="600" border="0" >
				<tr>
					<td style="padding-left: 20px 80px 20px 62px;"valign="top" height="200">
					<%=dto.getContent() %>
					</td>
				</tr>
			</table>
		</div>
	</div>
	
	<div class="bbsArticle_noLine" style="text-align: right;">
		From : <%=dto.getIpaddr() %>
	</div>
	
	<div id="bbsArticle_footer">
		<div id="leftFooter">
			<input type="button" value=" 수정 " class="btn2" onclick="javascript:location.href='<%=cp%>/board/update.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%><%=param%>';"/>
			<input type="button" value=" 삭제 " class="btn2" onclick="javascript:location.href='<%=cp%>/board/delete_ok.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%><%=param%>';"/>
		</div>
		<div id="rightFooter">
			<input type="button" value=" 리스트 " class="btn2" onclick="javascript:location.href='<%=cp%>/board/list.jsp?pageNum=<%=pageNum%><%=param%>';"/>
		</div>
	</div>
</div>


</body>
</html>