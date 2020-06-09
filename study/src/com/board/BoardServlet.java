package com.board;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Connection;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.member.CustomImfo;
import com.util.DBCPConn;
import com.util.MyUtil;

public class BoardServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	
	// 주소를 변환해주는 메소드
	protected void forward(HttpServletRequest req, HttpServletResponse resp, String url) throws ServletException, IOException {
		
		RequestDispatcher rd = req.getRequestDispatcher(url);
		rd.forward(req, resp);
		
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	// 기존에 있던것을 한곳에 정리
		req.setCharacterEncoding("utf-8");
		
		String cp = req.getContentType();
		
		Connection conn = DBCPConn.getConnection();
		BoardDAO dao = new BoardDAO(conn);
		
		MyUtil myUtil = new MyUtil();
		
		// cp는 study까지만.
		// 자신의 위치, 입력하는 주소를 다 가져옴 (ex : test3.jsp)
		String uri = req.getRequestURI();	// study/sboard/created.do
		
		String url;
		
// created.do가 오면 실행
		if(uri.indexOf("created.do")!=-1) {
			
			
			/*
			
			// 로그인을 해야지만 글 작성 가능,
			// 세션을 만들어서 검사
			
			HttpSession session = req.getSession();
			// 세션에서 customInfo를 가져옴
			CustomImfo info = (CustomImfo)session.getAttribute("customInfo");
			
			// 로그인이 안됐으면 로그인 창으로 돌아감
			if(info==null) {
				url = "/member/login.jsp";
				forward(req, resp, url);
				return;
			}
			
			*/
			
			// 실제 주소를 입력하고 forward를 시킴
			url = "/bbs/created.jsp"; //	/study/sboard/created.do 로 홈페이지를 들어갈 수 있다
/*
 
 			// forward 메소드로 정리
			RequestDispatcher rd = req.getRequestDispatcher(url);
			rd.forward(req, resp);
			
*/		
			forward(req, resp, url);	
		}
		
// created_ok.jsp와 같은 일을 하는 것
		else if(uri.indexOf("created_ok.do")!=-1){
			
			BoardDTO dto = new BoardDTO();
			
			int maxNum = dao.getMaxNum();
			
			dto.setNum(maxNum+1);
			dto.setSubject(req.getParameter("subject"));
			dto.setName(req.getParameter("name"));
			dto.setEmail(req.getParameter("email"));
			dto.setPwd(req.getParameter("pwd"));
			dto.setContent(req.getParameter("pwd"));
			dto.setIpaddr(req.getRemoteAddr());
			
			dao.insertData(dto);
			
			// forward를 할때는 실제주소.
			// redirect할때는 가상의 주소
			url = cp + "/sboard/list.do";
			
			resp.sendRedirect(url);
			
		}

// 리스트 
		
		else if(uri.indexOf("list.do")!=-1) {
			// 페이징
			// 넘어온 페이지 번호 (myUtil, article)
			String pageNum = req.getParameter("pageNum");
			
			// 첫 시작시 현재 페이지
			int currentPage = 1;
			
			//넘어온 현재 페이지가 존재할 경우 현재페이지에 값 넣기
			if(pageNum!=null){
				currentPage= Integer.parseInt(pageNum);
			}else{
				pageNum = "1";
			}
			
			// 검색 관련 ------------------------------------------------------------
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
			
			// 검색을 했을 때
			if(searchValue != null){
				
				// 한글을 넘길때 encoding 작업을 해줘야 함. get방식일 때 압축된 한글을디코딩 방식을해서 한글을 다시 보여줌 
				if(req.getMethod().equalsIgnoreCase("GET")){
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
				param+= "?searchKey="+ searchKey;
				param+= "&searchValue="+URLEncoder.encode(searchValue,"UTF-8");
			}
			// 검색하지 않았을 때는 다시 null로 적용	
			
			// 페이징 처리
			String listUrl = "list.do" + param;
			String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
			
			// 글 내용 보기 주소정리
			String articleUrl = cp + "/sboard/article.do";
			
			// 검색하지 않았을 때
			if(param.equals("")){
				articleUrl += "?pageNum="+currentPage;	
			}else{	// 검색 했을 때
				articleUrl += param +"&pageNum="+currentPage;
			}
			
			// 포워딩할 데이터, 데이터를 넘겨줌. class에서 jsp로
			req.setAttribute("lists", lists);
			req.setAttribute("articleUrl",articleUrl);
			req.setAttribute("pageIndexList",pageIndexList);
			req.setAttribute("dataCount",dataCount);

			// 실제 주소를 입력하고 forward를 시킴
			url = "/bbs/list.jsp"; // jsp대신 /study/sboard/list.do 로 홈페이지를 들어갈 수 있다
			forward(req, resp, url);
			
		}
		
// 게시물 들어갔을 때 화면 처리
		
		else if(uri.indexOf("article.do")!=-1) {
			
			int num = Integer.parseInt(req.getParameter("num"));
			String pageNum = req.getParameter("pageNum");
			
			// 검색해서 들어왔을 경우 searchKey,Value값을 전달받음
			// 검색 관련 ------------------------------------------------------------
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
			
			// 검색을 했을 때
			if(searchValue!=null){
				
				// 한글을 넘길때 encoding 작업을 해줘야 함. get방식일 때 압축된 한글을 디코딩 방식을해서 한글을 다시 보여줌 
				if(req.getMethod().equalsIgnoreCase("GET")){
					searchValue = URLDecoder.decode(searchValue, "UTF-8");
				}
			}
			else{ // 검색을 하지 않았을 때
				searchKey = "subject";
				searchValue = "";	
			}
			//-------------------------------------------------------------------------
			// 조회수 증가
			dao.updateHitcount(num);
			
			// 글 가져오기
			BoardDTO dto = dao.getReadData(num);
			
			if( dto==null ) {
				url = cp + "/sboard/list.do";
				resp.sendRedirect(url);
			}
			// 글 line 수, enter 다위로 글을 나눠서 line의 수를 센다
			int lineSu = dto.getContent().split("\n").length;
			
			// 글 내용의 엔터를 <br>로 변경
			dto.setContent(dto.getContent().replaceAll("\n", "<br/>"));
			
			// 주소 정리
			String param= "pageNum="+ pageNum;
			// 인코딩
			if(!searchValue.equals("")){
				param+= "&searchKey="+ searchKey;
				param+= "&searchValue="+URLEncoder.encode(searchValue,"UTF-8");
			}
			
			// 값 넘기기
			req.setAttribute("dto", dto);
			req.setAttribute("lineSu",lineSu);
			req.setAttribute("pageNum",pageNum);
			req.setAttribute("params",param);
			
			url = "/bbs/article.jsp";
			forward(req, resp, url);

		}
		
// delete문 삭제-
		else if(uri.indexOf("delete_ok.do")!=-1) {
			
			int num = Integer.parseInt(req.getParameter("num"));
			String pageNum = req.getParameter("pageNum");
			
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
			
			dao.deleteData(num);
			
			String params = "pageNum="+pageNum;
			
			if(!searchValue.equals("")){
				params+= "&searchKey="+ searchKey;
				params+= "&searchValue="+URLEncoder.encode(searchValue,"UTF-8");
			}
			
			// list로 돌아감.
			url = cp+"/sboard/list.do?"+params;
			resp.sendRedirect(url);
			
		}
// 업데이트문. 수정.
		else if(uri.indexOf("update.do")!=-1) {
			
			// 바꿀 게시글의 번호 받아오기
			int num = Integer.parseInt(req.getParameter("num"));
			String pageNum = req.getParameter("pageNum");	
			
			// 검색 관련 ------------------------------------------------------------
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
				
			// 검색을 했을 때
			if(searchValue != null){
				
				// 한글을 넘길때 encoding 작업을 해줘야 함. get방식일 때 압축된 한글을디코딩 방식을해서 한글을 다시 보여줌 
				if(req.getMethod().equalsIgnoreCase("GET")){
					searchValue = URLDecoder.decode(searchValue, "UTF-8");
				}
			}
			else{ // 검색을 하지 않았을 때
				searchKey = "subject";
				searchValue = "";	
			}
			//-------------------------------------------------------------------------
			BoardDTO dto = dao.getReadData(num);
			
			if(dto==null){
				url = cp+"/sboard/list.do";
				resp.sendRedirect(url);
			}
			
			String params ="pageNum="+pageNum;
			if(searchValue!=null){
				params+= "&searchKey="+searchKey;
				params+= "&searchValue="+URLEncoder.encode(searchValue,"UTF-8");
			}

			req.setAttribute("dto", dto);
			req.setAttribute("pageNum", pageNum);
			req.setAttribute("searchKey", searchKey);
			req.setAttribute("searchValue", searchValue);
			req.setAttribute("params", params);
			
			
			url = "/bbs/update.jsp";
			forward(req, resp, url);
		}
		
// update_ok 업데이트 ok문
		else if(uri.indexOf("update_ok.do")!=-1) {
			
			int num = Integer.parseInt(req.getParameter("num"));
			String pageNum = req.getParameter("pageNum");
			
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
						
			BoardDTO dto = new BoardDTO();
			dto.setNum(num);
			dto.setName(req.getParameter("name"));
			dto.setSubject(req.getParameter("subject"));
			dto.setEmail(req.getParameter("email"));
			dto.setPwd(req.getParameter("pwd"));
			dto.setContent(req.getParameter("content"));
			
			dao.updateData(dto);
			
			String params = "pageNum="+pageNum;
			
			if(!searchValue.equals("") && searchValue!=null){
				params+= "&searchKey="+ searchKey;
				params+= "&searchValue="+URLEncoder.encode(searchValue,"UTF-8");
			}

			url = cp + "/bbs/list.do?"+params;
			resp.sendRedirect(url);
			
		}
	}

}
