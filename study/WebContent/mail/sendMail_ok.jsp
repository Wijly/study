<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="java.util.Properties"%>
<%@page import="javax.mail.Session"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");
	//주소를 찾기 위한것
	String cp = request.getContextPath();
	
	String senderName = request.getParameter("senderName");
	String senderEmail = request.getParameter("senderEmail");
	String receiverEmail = request.getParameter("receiverEmail");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	
	// 192 168 16 13
	String host = "localhost";
	
	
	//javax.mail.Session은 Java Mail API를 사용하는 출발점이 되는 클래스
		//javax.mail.Message 클래스는 메일을 표현하기 위해 사용되는 추상 클래스로
		//주제, 수신자의 이메일주소, 발송자의 이메일 주소, 보낸 날짜와 같은 
		//실제 이메일 메시지의 세부 사항을 나타낸다
		//MimeMessage 클래스는 Message 추상 클래스로부터 상속받은 인터넷 메일 클래스로
		//메일에 여러 개의 파일을 첨부시켜서 사용 (Multipurpose Internet Mail Extensions)
		//java.util.Properties는 getProperties()메소드를 사용하여 시스템의 환경변수 값을
		//얻어올 수 있다. 환경변수의 설정은 Key와 Value 쌍으로 저장되어 있다. 


		//JavaMail API를 이용하여 메일을 전송하는 과정
		
		
		
		
	//1.javax.mail.Session 클래스의 인스턴스를 구한다.
	Properties prop = System.getProperties(); // 시스템의 환경설정
	Session ssn = Session.getInstance(prop,null);	// 환경설정 세션 생성 (시스템 정보를 읽어와서 세션 생성)
	
	try{
		
		//2.javax.mail.Message 클래스를 사용하여 전송하고자 하는 메일 메시지를 작성한다.
		MimeMessage message = new MimeMessage(ssn);	// MimeMessage는 실제 메일 내용을 담음
		
		// message객체에 메일 속성 설정
		message.addRecipient(Message.RecipientType.TO, new InternetAddress(receiverEmail));	// 수신인 설정
		message.setFrom(new InternetAddress(senderEmail,senderName,"UTF-8"));	// 발신인 설정
		message.setSubject(subject, "UTF-8");	// 제목 설정
		message.setContent(content,"text/plain;charset=utf-8");	// 내용 설정
		
		// 메일 전송
		//3.javax.mail.Transport 클래스를 사용하여 작성한 메일을 전송한다.
		Transport tp = ssn.getTransport("smtp");	// 보낼 때 사용하는 프로토콜
		tp.connect(host,"","");	 // ip, id, pw 가상으로 진행하므로 생략
		tp.sendMessage(message, message.getAllRecipients());
		
		tp.close();
		
		out.print("메일 뿅");
		
	}catch(Exception e){
		System.out.print(e.toString()+"메일전송오류");
	}
	
	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>