package com.score;

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

import com.board.BoardDTO;
import com.util.DBCPConn;
import com.util.MyUtil;

public class ScoreServlet extends HttpServlet{
	
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	protected void forward(HttpServletRequest req, HttpServletResponse resp, String url) throws ServletException, IOException {
		
		RequestDispatcher rd = req.getRequestDispatcher(url);
		rd.forward(req, resp);
		
	}
	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// post방식으로 처리할 때 한글이 깨지지않도록 선언
		req.setCharacterEncoding("UTF-8");

		//주소를 찾기 위한것
		String cp = req.getContextPath();
		
		Connection conn = DBCPConn.getConnection();
		ScoreDAO dao = new ScoreDAO(conn);
		
		//페이징
		MyUtil myUtil = new MyUtil();
		
		// 뒷부분의 주소
		String uri = req.getRequestURI();
		String url;
		
		if(uri.indexOf("list.do") != -1) {
			
			String pageNum = req.getParameter("pageNum");
			int currentPage = 1;
			
			if(pageNum != null) {
				currentPage = Integer.parseInt(pageNum);
			}else {
				pageNum= "1";
			}
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
			
			if(searchValue ==null || searchValue.equals("")) {
				searchKey = "hak";
				searchValue ="";
			}else {
				if(req.getMethod().equalsIgnoreCase("GET")) {
					searchValue = URLDecoder.decode(searchValue,"UTF-8");
				}
			}
			
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
			
			List<ScoreDTO> lists = dao.getLists(start, end, searchKey, searchValue);
			
			// 검색했을 경우 검색한 리스트를 다시 불러오도록 함
			// 포워드 방식은 무조건 한글이 깨짐 받을때 decoding하므로 여기서 encoding 해줌
			String param = "";
			if(!searchValue.equals("")){
				param+= "?searchKey="+ searchKey;
				param+= "&searchValue="+URLEncoder.encode(searchValue,"UTF-8");
			}
			// 검색하지 않았을 때는 다시 null로 적용	
			
			// 페이징 처리
			String listUrl = cp + "/jumsu/list.do";
			String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
			
			// 포워딩할 데이터, 데이터를 넘겨줌. class에서 jsp로
			req.setAttribute("lists", lists);
			req.setAttribute("pageNum",pageNum);
			req.setAttribute("pageIndexList",pageIndexList);
			req.setAttribute("dataCount",dataCount);

			// 실제 주소를 입력하고 forward를 시킴
			url = "/sscore/list.jsp"; // jsp대신 /study/sboard/list.do 로 홈페이지를 들어갈 수 있다
			forward(req, resp, url);
			
		}		
		else if(uri.indexOf("write.do")!= -1) {
			url = "/sscore/write.jsp";
			forward(req, resp, url);
		}
		else if(uri.indexOf("write_ok.do") !=-1) {
			
			ScoreDTO dto = new ScoreDTO();
			
			dto.setName(req.getParameter("name"));
			dto.setHak(req.getParameter("hak"));
			dto.setKor(Integer.parseInt(req.getParameter("kor")));
			dto.setEng(Integer.parseInt(req.getParameter("eng")));
			dto.setMat(Integer.parseInt(req.getParameter("mat")));
			
			dao.insertData(dto);
			
			url = cp + "/jumsu/list.do";
			resp.sendRedirect(url);
		}
		else if(uri.indexOf("update.do") != -1) {
			
			String hak = req.getParameter("hak");
			String pageNum = req.getParameter("pageNum");
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
			
			if(searchValue != null) {
				searchValue = URLDecoder.decode(searchValue,"UTF-8");
			}
			
			ScoreDTO dto = dao.getReadData(hak);
			
			if(dto==null) {
				url = cp + "/jumsu/list.do";
				resp.sendRedirect(url);
			}
			
			String params = "pageNum="+pageNum;
			
			if(searchValue !=null) {
				params += "&searchKey=" + searchKey;
				params += "&searchValue="+URLEncoder.encode(searchValue,"UTF-8");
				
			}
			
			req.setAttribute("dto", dto);
			req.setAttribute("pageNum", pageNum);
			req.setAttribute("params", params);
			url = "/sscore/update.jsp";
			forward(req, resp, url);
			
		}
		else if(uri.indexOf("update_ok.do")!=-1) {
			
			String params = req.getParameter("params");
			ScoreDTO dto = new ScoreDTO();
			
			dto.setName(req.getParameter("name"));
			dto.setHak(req.getParameter("hak"));
			dto.setKor(Integer.parseInt(req.getParameter("kor")));
			dto.setEng(Integer.parseInt(req.getParameter("eng")));
			dto.setMat(Integer.parseInt(req.getParameter("mat")));
			
			dao.updateData(dto);
			
			url = cp+"/jumsu/list.do?"+params;
			resp.sendRedirect(url);
			
		}
		else if(uri.indexOf("delete_ok.do")!= -1) {
			
			String hak = req.getParameter("hak");
			String pageNum = req.getParameter("pageNum");
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
			
			if( searchValue!=null) {
				searchValue = URLDecoder.decode(searchValue,"UTF-8");
			}
			
			String params = "pageNum="+pageNum;
			
			if(searchValue!=null) {
				
				params += "&searchKey="+searchKey;
				params += "&searchValue="+URLEncoder.encode(searchValue,"UTF-8");
			}
			dao.deleteData(hak);
			
			url =cp + "/jumsu/list.do?"+params;
			resp.sendRedirect(url);
		}
		
	}

}
