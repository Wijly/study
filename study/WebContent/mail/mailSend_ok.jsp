<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.mail.MailSend"%>
<%@page import="java.io.File"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	// post방식으로 처리할 때 한글이 깨지지않도록 선언
	request.setCharacterEncoding("UTF-8");
	//주소를 찾기 위한것
	String cp = request.getContextPath();
	
	String root = getServletContext().getRealPath("/");
	String path = root + File.separator + "pds" + File.separator + "mailFile";
	
	File f = new File(path);
	
	if(!f.exists()){
		f.mkdirs();
	}
	
	String encType = "UTF-8";
	int maxFileSize = 10*1024*1024;
	
	// 객체 생성
	MailSend mail = new MailSend();
	
	// 파일 업로드
	MultipartRequest mr = new MultipartRequest(request,path,maxFileSize,encType,new DefaultFileRenamePolicy());
		
	// 필요한 정보를 뽑아옴
	mail.setSenderName(mr.getParameter("senderName"));
	mail.setSenderEmail(mr.getParameter("senderEmail"));
	mail.setReceiverEmail(mr.getParameter("receiverEmail"));
	mail.setSubject(mr.getParameter("subject"));
	mail.setContent(mr.getParameter("content"));
	
	// 업로드한파일이름
	String fileName = mr.getFilesystemName("fileName");
	
	if(fileName!=null && !fileName.equals("")){
		String fileFullPath = path + File.separator + fileName;
		
		mail.setFileFullPath(fileFullPath);
		mail.setOriginalFileName(mr.getParameter("fileName"));
	}
	mail.sendMail();
	out.print("전송 뾰로롱");
%>
