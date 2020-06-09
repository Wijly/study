<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");
	
	// 세션에있는 유저 아이디를 받음, (String) 으로 다운캐스팅
	String userId = (String)session.getAttribute("userId");
	
	//시간 변경 위해. 초단위
	session.setMaxInactiveInterval(5);
	
	Calendar cal = Calendar.getInstance();
	
	//오늘 날짜 구하기
	int nowYear = cal.get(Calendar.YEAR);
	int nowMonth = cal.get(Calendar.MONTH)+1;	// 기본 0 부터 시작하므로 +1 을해야 현재 월
	int nowDay = cal.get(Calendar.DAY_OF_MONTH);
	
	// 클라이언트에서 넘어온 년, 월 받기
	String strYear = request.getParameter("year");	// 넘어오는 year값
	String strMonth = request.getParameter("month"); 	// 넘어오는 month값
	
	// 현재 년, 월
	int year = nowYear;
	int month = nowMonth;
	
	// 널이 아닐경우. 버튼을 클릭했을 경우
	if(strYear != null){
		// 현재의 데이터에 전달받은 날짜를 집어넣음 (다음달, 전달) 
		year = Integer.parseInt(strYear);
	}
	// 버튼을 클릭했을 경우
	if(strMonth != null) {
		// 현재의 월에 전달받은 날짜를 집어넣음, 다음달 혹은 이전달
		month = Integer.parseInt(strMonth);
	}
	
	// 이전 버튼 ◀
	int preYear = year;
	int preMonth = month-1;
	// 1월보다 작아질 경우, 년도 -1, 월= 12월 고정
	if(preMonth<1){
		preYear = year -1;
		preMonth = 12;
	}
	
	// 다음 버튼 ▶
	int nextYear = year;
	int nextMonth = month+1;
	// 12월보다 커질 경우, 년도 +1, 월=1월 고정
	if(nextMonth>12){
		nextYear = year +1;
		nextMonth = 1;
	}
	
	// 표시할 달력 세팅, 현재 년도, 월, 1일부터 시작
	cal.set(year, month-1,1);
	
	// 달의 첫날을 구하는 코딩
	int startDay = 1;
	// 마지막 날을 구하는 코딩
	int endDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	
	// 주(week) 의 수
	int week = cal.get(Calendar.DAY_OF_WEEK);

	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	
	// 버튼사용을 위한 스크립트
	function sendIt(){
		
		var f = document.myForm;
		
		if(!f.userId.value){
			alert("아이디 입력");
			f.userId.focus();
			return;
		}
		if(!f.userPwd.value){
			alert("패스워드 입력");
			f.userPwd.focus();
			return;
		}
		
		f.submit();
	}
	


</script>


</head>
<body style="font-size: 10pt">
<table border="1" width="600" align="center" style="font:10">
	<tr height="20">
		<td colspan="2" align="right">
		|게시판|
		<% if(userId==null){ 
		// 로그인 아이디가 없으면 일정관리 비활성화
		%>
				일정관리
		 
		<%}else{%>
		<a href="schedule.jsp">일정관리</a>
		<%} %>
		</td>
	</tr>
	
	<tr height="400">
		<td width="100" valign="top">
		<%if(userId==null){ %>
		<form action="login_ok.jsp" method="post" name="myForm">
			아이디 : <input type="text" name="userId" size="10"/><br/>
			패스워드 : <input type="password" name="userPwd" size="10"/><br/>
			<input type="button" value="로그인" onclick="sendIt();"/>		
		</form>
		<%}else{ %>
			<font color="aqua"><b><%=userId %></b></font>님 환영합니다<br/>
			<a href="logout_calendar.jsp">로그아웃</a><br/>
		<%} %>
		</td>
		<td valign="middle" align="center">
		<%if(userId==null) {%>
		<b>로그인하면 새로운 세상이 보입니다</b>
		<%}else{ %>		
		<table align="center" width="210" cellpadding="2" cellspacing="1">
		<tr>
		<td align="center">
			
			<!-- 오늘 이미지 클릭 시 오늘 날짜로 이동 -->
			<a href ="calendar.jsp">
			<img src="./img/today.jpg" align="left"  >
			</a>
			
			<!-- 년,월을 표시하는 부분   -->	
			<a href ="calendar.jsp?year=<%=preYear %>&month=<%=preMonth %>">◀</a>
			<b>&nbsp;<%=year %>년&nbsp;&nbsp;<%=month %>월</b>
			<a href ="calendar.jsp?year=<%=nextYear %>&month=<%=nextMonth %>">▶</a>
		</td>
	</tr>
</table>
<table align="center" width="210" cellpadding="0" cellspacing="1" bgcolor="#cccccc">
	<tr>
		<td bgcolor="#e6e4e6" align="center"><font color="red">일</font></td>
		<td bgcolor="#e6e4e6" align="center">월</td>
		<td bgcolor="#e6e4e6" align="center">화</td>
		<td bgcolor="#e6e4e6" align="center">수</td>
		<td bgcolor="#e6e4e6" align="center">목</td>
		<td bgcolor="#e6e4e6" align="center">금</td>
		<td bgcolor="#e6e4e6 " align="center"><font color="blue">토</font></td>
	</tr>
	
	<%
	// 날짜 출력
	int newLine = 0;
	
	out.print("<tr height='20'>");
	
	// week보다 작을 때까지 공백 생성, 2020 4월은 수요일 시작이므로 화요일까지 공백
	for(int i=1; i<week;i++){
		out.print("<td bgcolor='#ffffff'>&nbsp;</td>");
		newLine++;
	}
	
	// day을 출력, 토요일과 일요일에 색상 
	for(int i=startDay; i<=endDay; i++){
		
		// 글자 색 week이 0(일요일) 이면 레드, 6(토요일)이면 블루, 그외 검정
		String fontColor= (newLine==0?"red":(newLine==6)?"blue":"black");
		
		// 오늘의 날짜는 회색, 나머진 검은색
		String bgColor = (nowYear==year)&&(nowMonth==month)&&(nowDay==i)?"b0e0e6":"#ffffff";
		
		// <td align='center' bgcolor="#ffffff"><font color="black"> i </font></td>;
		out.print("<td align='center' bgcolor='"+bgColor+"'><font color='"+fontColor+"'>"+i+"</font></td>");
		
		newLine++;
		
		// week 마다 줄 넘김
		if(newLine==7 && i != endDay){
			// tr을 닫아서 줄넘김
			// 다음줄에서 다시 출력
			out.print("</tr><tr height='20'>");
			newLine=0;
		}
	}
	
	// 달력의 마지막 일이 끝난 후 공백 출력
	while(newLine>0 && newLine<7){
		out.print("<td bgcolor='#ffffff'>&nbsp;</td>");
		newLine++;
	}
	
	// 달력 tr 닫아주기
	out.print("</tr>");
	
	%>
</table>
	
	<%} %>

	</td>
</tr>
</table>
</body>
</html>