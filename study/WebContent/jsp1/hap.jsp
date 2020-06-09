<%@ page contentType="text/html; charset=UTF-8" %>
<%
/*
	contentType="text/html"
	
	MIME [Multipurpose Internet Mail Extensions]의 종류
	메세지의 내용이 어떤 형식인지 알려주기위해 정의한 인터넷 표준
	
	text/plain : 일반 텍스트문서
	text/html : HTML 문서 
	text/css  :CSS 문서
	text/xml : XML 문서
	image/jpeg,image/png : JPEG파일, PNG파일 
	video/mpeg,audio/mp3 : MPEG 비디오파일, MP3 음악파일
	application/zip : zip 압축파일
*/

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- 
	post 방식 : 액션의 주소만 보여줌
	get 방식 : 모든 별의별것들을 다 보여줌 (name값 등등) ex(.jsp?su1=1&su2=10&username=즐리)
	
	post : 한글 깨짐,
	get : 깨지지않음
	
	password 등 값을 숨기고 사용자에게 값을 받아낼 때 = post (값을 숨김)
	사용자가 모르는 외의 값을 넘겨받을 때 = get
		
 -->
<form action="hap_ok.jsp" method="post">

수1 : <input type="text" name="su1"/><br/>
수2 : <input type="text" name="su2"/><br/>
이름 : <input type="text" name="username"/><br/> 

<!--
  결과 버튼 생성,button을 자바스크립트를 사용하지않을때는 submit으로 생성
  button으로 생성할 때는 onclick으로 함수처리 
  submit은 무조건 form의 action을 찾아가서 처리한다 (hap_ok.jsp)로 찾아가서 처리 
  submit은 넘어갈때 form안의 있는 name값을 모두 가지고 넘어간다 
-->
<input type="submit" value="결과"/><br/>

</form>

<br/><br/><br/><br/>

<a href="hap_ok.jsp?su1=172&su2=50&username=즐리">Get방식 :</a>



</body>
</html>