<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="com.board.BoardDTO"%>
<%@page import="com.board.BoardDAO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	// 바꿀 게시글의 번호 받아오기
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	// 디비 연결해서 값 가져오기
	Connection conn = DBConn.getConnection();
	BoardDAO dao = new BoardDAO(conn);
	
	BoardDTO dto = dao.getReadData(num);
	
	
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
		
	DBConn.close();
	
	if(dto==null){
		response.sendRedirect("list.jsp"+param);
	}
	
	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판</title>

<link rel = "stylesheet" href="<%=cp %>/board/css/style.css">
<link rel = "stylesheet" href="<%=cp %>/board/css/created.css">

<script type="text/javascript" src="<%=cp %>/board/js/util.js"></script>
<script type="text/javascript">
	function sendIt() {
		
		f = document.myForm;
		str = f.subject.value;
		str = str.trim();
		
		if(!str){ // 글 제목 검사
			alert("\n제목을 입력하세요.");
			f.subject.foucs();
			return;
		}
		f.subject.value = str; 
		
		if(f.email.value){ // 이메일 검사
			if(!isValidEmail(f.email.value)){
				alert("\n이메일을 입력하세요");
				f.email.focus();
				return;
			}
		}
		
		str = f.content.value;
		str = str.trim();
		
		if(!str){ // 글 내용 검사
			alert("\n내용을 입력하세요.");
			f.content.foucs();
			return;
		}
		f.content.value = str; 
		
		str = f.pwd.value;
		str = str.trim();

		if(!str){ // 패스워드 검사
			alert("\n비밀번호를 입력하세요.");
			f.pwd.foucs();
			return;
		}
		f.pwd.value = str;
		
		if(str != <%=dto.getPwd()%> ){
			alert("\n비밀번호가 틀렸습니다.");
			f.pwd.focus();
			return;
		}
		f.pwd.value = str; 
		
		f.action = "<%=cp %>/board/update_ok.jsp";
		f.submit();
	}
</script>
</head>
<body>
<div id = "bbs">
	<div id = "bbs_title">
		게 시 판 (JSP)
	</div>
	
	<form name = "myForm" method="post">
		<div id = "bbsCreated">
			<div class= "bbsCreated_bottomLine">
				<div>
					<dl>
						<dt>제&nbsp;&nbsp;&nbsp;&nbsp;목</dt>
						<dd><input type = "text" name = "subject" size = "68" maxlength="100" class="boxTF" value="<%=dto.getSubject()%>"></dd>
					</dl>
				</div>
			</div>
			
			<div class= "bbsCreated_bottomLine">
				<div>
					<dl>
						<dt>작성자</dt>
						<dd><input type = "text" name = "name" size = "35" maxlength="20" class="boxTF" value="<%=dto.getName()%>" ></dd>
					</dl>
				</div>
			</div>
			
			<div class= "bbsCreated_bottomLine">
				<div>
					<dl>
						<dt>E-Mail</dt>
						<dd>
						<!--  삼항연산자. email이 null값이면 빈칸, 값이 있으면 email -->
						<input type = "text" name = "email" size = "35" maxlength="50" class="boxTF" value="<%=dto.getEmail()==null?"":dto.getEmail() %>">
						</dd>
					</dl>
				</div>
			</div>
			
			<div id= "bbsCreated_content">
				<div>
					<dl>
						<dt>내&nbsp;&nbsp;&nbsp;&nbsp;용</dt>
						<dd><textarea rows="12" cols="63" name="content" class="boxTA"><%=dto.getContent() %></textarea></dd>
					</dl>
				</div>
			</div>
			
			<div class= "bbsCreated_noLine">
				<div>
					<dl>
						<dt>패스워드</dt>
						<dd><input type = "password" name = "pwd" size = "35" maxlength="7" class="boxTF">&nbsp;(게시물 수정 및 삭제시 필요)</dd>
					</dl>
				</div>
			</div>
			
			<div id = "bbsCreated_footer">
			
				<input type="hidden" name="num" value="<%=dto.getNum() %>"/>
				<input type="hidden" name="pageNum" value="<%=pageNum %>"/>
				<input type="hidden" name="searchKey" value="<%=searchKey %>"/>
				<input type="hidden" name="searchValue" value="<%=searchValue %>"/>
				
				<input type ="button" value = " 수정하기 " class="btn2" onclick="sendIt();"/>
				<input type ="button" value = " 수정취소 " class="btn2" onclick="javascript:location.href = '<%=cp %>/board/list.jsp?pageNum=<%=pageNum%><%=param%>';"/>
			</div>
		</div>
	</form>
</div>
</body>
</html>