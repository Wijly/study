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
		
		// post������� ó���� �� �ѱ��� �������ʵ��� ����
		req.setCharacterEncoding("UTF-8");

		//�ּҸ� ã�� ���Ѱ�
		String cp = req.getContextPath();
		
		Connection conn = DBCPConn.getConnection();
		ScoreDAO dao = new ScoreDAO(conn);
		
		//����¡
		MyUtil myUtil = new MyUtil();
		
		// �޺κ��� �ּ�
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
			
			//��ü ������ ���ϱ�	(34��)
			int dataCount = dao.getDataCount(searchKey, searchValue);
			
			// �� �������� ǥ���� ������ ����, 3���� ������ myUtil���� �����Ǿ�����
			int numPerPage = 3;
			
			// ��ü �������� ����(34��,3��) = 12������
			int totalPage = myUtil.getPageCount(numPerPage, dataCount);
			
			// �����͸� �����ؼ� �������� �پ����� �� ó��.
			if(currentPage > totalPage ) {
				currentPage = totalPage;
			}
			
			// ������ �������� ���۰� ��
			int start = (currentPage-1)*numPerPage+1;
			int end = currentPage*numPerPage;
			
			List<ScoreDTO> lists = dao.getLists(start, end, searchKey, searchValue);
			
			// �˻����� ��� �˻��� ����Ʈ�� �ٽ� �ҷ������� ��
			// ������ ����� ������ �ѱ��� ���� ������ decoding�ϹǷ� ���⼭ encoding ����
			String param = "";
			if(!searchValue.equals("")){
				param+= "?searchKey="+ searchKey;
				param+= "&searchValue="+URLEncoder.encode(searchValue,"UTF-8");
			}
			// �˻����� �ʾ��� ���� �ٽ� null�� ����	
			
			// ����¡ ó��
			String listUrl = cp + "/jumsu/list.do";
			String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
			
			// �������� ������, �����͸� �Ѱ���. class���� jsp��
			req.setAttribute("lists", lists);
			req.setAttribute("pageNum",pageNum);
			req.setAttribute("pageIndexList",pageIndexList);
			req.setAttribute("dataCount",dataCount);

			// ���� �ּҸ� �Է��ϰ� forward�� ��Ŵ
			url = "/sscore/list.jsp"; // jsp��� /study/sboard/list.do �� Ȩ�������� �� �� �ִ�
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
