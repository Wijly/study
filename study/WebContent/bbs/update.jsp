<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판</title>

<link rel = "stylesheet" href="<%=cp %>/bbs/css/style.css">
<link rel = "stylesheet" href="<%=cp %>/bbs/css/created.css">

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
		
		str = f.name.value;
		str = str.trim();
		if(!str){ // 이름 검사
			alert("\n이름을 입력하세요.");
			f.name.foucs();
			return;
		}
		if(!isValidKorean(str)){ // 한글 검사
			alert("\n이름을 정확히 입력하세요");
			f.name.focus();
			return;
		}
		f.name.value = str; 
		
		if(f.email.value){ // 이메일 검사
			if(!isValidEmail(f.email.value)){
				alert("\n이메일을 정확히 입력하세요");
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
		
		f.action = "<%=cp %>/sboard/update_ok.do";

		f.submit();
	}
</script>
</head>
<body>
<div id = "bbs">
	<div id = "bbs_title">
		게시판
	</div>
	
	<form name = "myForm" method="post">
		<div id = "bbsCreated">
			<div class= "bbsCreated_bottomLine">
				<div>
					<dl>
						<dt>제&nbsp;&nbsp;&nbsp;&nbsp;목</dt>
						<dd><input type = "text" name = "subject" size = "68" maxlength="100" class="boxTF" value="${dto.subject }"></dd>
					</dl>
				</div>
			</div>
			
			<div class= "bbsCreated_bottomLine">
				<div>
					<dl>
						<dt>작성자</dt>
						<dd><input type = "text" name = "name" size = "35" maxlength="20" class="boxTF" value="${dto.name }"></dd>
					</dl>
				</div>
			</div>
			
			<div class= "bbsCreated_bottomLine">
				<div>
					<dl>
						<dt>E-Mail</dt>
						<dd><input type = "text" name = "email" size = "35" maxlength="50" class="boxTF" value="${dto.email }"></dd>
					</dl>
				</div>
			</div>
			
			<div id= "bbsCreated_content">
				<div>
					<dl>
						<dt>내&nbsp;&nbsp;&nbsp;&nbsp;용</dt>
						<dd><textarea rows="12" cols="63" name="content" class="boxTA" >${dto.content }</textarea></dd>
					</dl>
				</div>
			</div>
			
			<div class= "bbsCreated_noLine">
				<div>
					<dl>
						<dt>패스워드</dt>
						<dd><input type = "password" name = "pwd" size = "35" maxlength="7" class="boxTF" value="${dto.pwd }">&nbsp;(게시물 수정 및 삭제시 필요!!!)</dd>
					</dl>
				</div>
			</div>
			
			<div id = "bbsCreated_footer">
				<input type="hidden" name="num"  value="${dto.num }"/>
				<input type="hidden" name="pageNum"  value="${pageNum }"/>
				<input type="hidden" name="SearchKey"  value="${SearchKey }"/>
				<input type="hidden" name="SearchValue"  value="${SearchValue }"/>
			
				<input type ="button" value = " 수정하기 " class="btn2" onclick="sendIt();"/>
				<input type ="button" value = " 수정취소 " class="btn2" onclick="javascript:location.href='<%=cp %>/sboard/list.do?${params}';"/>
			</div>
		</div>
	</form>
</div>
</body>
</html>