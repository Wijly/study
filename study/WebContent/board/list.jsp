<%@page import="com.util.DBCPConn"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="com.util.MyUtil"%>
<%@page import="com.board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.board.BoardDAO"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.util.DBConn"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");
	//주소를 찾기 위한것
	String cp = request.getContextPath();

	// 디비 연결 후 dao에 연결
//	Connection conn = DBConn.getConnection();
	Connection conn = DBCPConn.getConnection();
	BoardDAO dao = new BoardDAO(conn);
	// 페이징을 위한 객체 생성
	MyUtil myUtil = new MyUtil();

	// 페이징
	// 넘어온 페이지 번호 (myUtil, article)
	String pageNum = request.getParameter("pageNum");
	
	// 첫 시작시 현재 페이지
	int currentPage = 1;
	
	//넘어온 현재 페이지가 존재할 경우 현재페이지에 값 넣기
	if(pageNum!=null){
		currentPage= Integer.parseInt(pageNum);
	}else{
		pageNum = "1";
	}
	
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
	
	//전체 데이터 구하기	(34개)
	int dataCount = dao.getDataCount(searchKey, searchValue);
	
	// 한 페이지에 표시할 데이터 개수, 3개씩 보여줌 myUtil에도 설정되어있음
	int numPerPage = 3;
	
	// 전체 페이지의 개수(34개,3개) = 12페이지
	int totalPage = myUtil.getPageCount(numPerPage, dataCount);
	
	// 데이터를 삭제해서 페이지가 줄어들었을 때 처리.
	if(currentPage > totalPage ) {
		currentPage = totalPage;
	}
	
	// 가져올 데이터의 시작과 끝
	int start = (currentPage-1)*numPerPage+1;
	int end = currentPage*numPerPage;
	
	List<BoardDTO> lists = dao.getLists(start,end,searchKey,searchValue);
	
	// 검색했을 경우 검색한 리스트를 다시 불러오도록 함
	// 포워드 방식은 무조건 한글이 깨짐 받을때 decoding하므로 여기서 encoding 해줌
	String param = "";
	if(!searchValue.equals("")){
		param = "?searchKey="+ searchKey;
		param+= "&searchValue="+URLEncoder.encode(searchValue,"UTF-8");
	}
	// 검색하지 않았을 때는 다시 null로 적용	
	
	// 페이징 처리
	String listUrl = "list.jsp" + param;
	String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
	
	// 글 내용 보기 주소정리
	String articleUrl = cp + "/board/article.jsp";
	
	// 검색하지 않았을 때
	if(param.equals("")){
		articleUrl += "?pageNum="+currentPage;	
	}else{	// 검색 했을 때
		articleUrl += param + "&pageNum="+currentPage;
	}
	
		
	// select 문은 redirect하지않음
//	DBConn.close();
	DBCPConn.close();
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게 시 판</title>

<link rel = "stylesheet" href="<%=cp %>/board/css/style.css">
<link rel = "stylesheet" href="<%=cp %>/board/css/list.css">

<script type="text/javascript">

	// 검색으 사용하기 위한 스크립트
	function sendIt(){
		
		var f = document.searchForm;
		
		f.action = "<%=cp%>/board.do?method=list";
		f.submit();
	}

</script>

</head>
<body>

<div id="bbsList">
	<div id="bbsList_title">
	
	<a href="<%=cp%>/board/list.jsp" >게시판</a>

	</div>
	<div id="bbsList_header">
		<div id="leftHeader">
			<form action="" method="post" name="searchForm">
				<select name="searchKey" class="selectField">
					<option value="subject">제목</option>
					<option value="name">이름</option>
					<option value="content">내용</option>
				</select>
				<input type="text" name="searchValue" class="textField"/>
				<input type="button" value=" 검 색 " class="btn2" onclick="sendIt()"/>
			</form>	
		</div>
		<div id="rightHeader">
			<input type="button" value=" 글올리기 " class="btn2" onclick="javascript:location.href='<%=cp%>/board.do?method=write';"/>
		</div>
	</div>
	<div id="bbsList_list">
		<div id="title">
			<dl>
				<dt class="num">번호</dt>
				<dt class="subject">제목</dt>
				<dt class="name">작성자</dt>
				<dt class="created">작성일</dt>
				<dt class="hitCount">조회수</dt>
			</dl>
		</div>
		<!--  페이지 글 list -->
		<div id="lists">
		<%
		// lists개수만큼 반복
		for(BoardDTO dto : lists) { 
		%>
			<dl>
				<dd class="num"><%=dto.getNum() %></dd>
				<dd class="subject">
					<!--  num과 pageNum 값을 article.jsp로 보낼 수 있음-->
					<a href="<%=articleUrl %>&num=<%=dto.getNum()%>"><%=dto.getSubject() %></a>
					
				</dd>
				<dd class="name"><%=dto.getName() %></dd>
				<dd class="created"><%=dto.getCreated() %></dd>
				<dd class="hitCount"><%=dto.getHitCount() %></dd>
			</dl>
		<%
		} 
		%>
		</div>
		<!--  페이징, 페이지 갯수 -->
		<div id="footer">
			<%=pageIndexList %>
		
		</div>
	</div>
</div>

</body>
</html>