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
	
	// �ּҸ� ��ȯ���ִ� �޼ҵ�
	protected void forward(HttpServletRequest req, HttpServletResponse resp, String url) throws ServletException, IOException {
		
		RequestDispatcher rd = req.getRequestDispatcher(url);
		rd.forward(req, resp);
		
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	// ������ �ִ����� �Ѱ��� ����
		req.setCharacterEncoding("utf-8");
		
		String cp = req.getContentType();
		
		Connection conn = DBCPConn.getConnection();
		BoardDAO dao = new BoardDAO(conn);
		
		MyUtil myUtil = new MyUtil();
		
		// cp�� study������.
		// �ڽ��� ��ġ, �Է��ϴ� �ּҸ� �� ������ (ex : test3.jsp)
		String uri = req.getRequestURI();	// study/sboard/created.do
		
		String url;
		
// created.do�� ���� ����
		if(uri.indexOf("created.do")!=-1) {
			
			
			/*
			
			// �α����� �ؾ����� �� �ۼ� ����,
			// ������ ���� �˻�
			
			HttpSession session = req.getSession();
			// ���ǿ��� customInfo�� ������
			CustomImfo info = (CustomImfo)session.getAttribute("customInfo");
			
			// �α����� �ȵ����� �α��� â���� ���ư�
			if(info==null) {
				url = "/member/login.jsp";
				forward(req, resp, url);
				return;
			}
			
			*/
			
			// ���� �ּҸ� �Է��ϰ� forward�� ��Ŵ
			url = "/bbs/created.jsp"; //	/study/sboard/created.do �� Ȩ�������� �� �� �ִ�
/*
 
 			// forward �޼ҵ�� ����
			RequestDispatcher rd = req.getRequestDispatcher(url);
			rd.forward(req, resp);
			
*/		
			forward(req, resp, url);	
		}
		
// created_ok.jsp�� ���� ���� �ϴ� ��
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
			
			// forward�� �Ҷ��� �����ּ�.
			// redirect�Ҷ��� ������ �ּ�
			url = cp + "/sboard/list.do";
			
			resp.sendRedirect(url);
			
		}

// ����Ʈ 
		
		else if(uri.indexOf("list.do")!=-1) {
			// ����¡
			// �Ѿ�� ������ ��ȣ (myUtil, article)
			String pageNum = req.getParameter("pageNum");
			
			// ù ���۽� ���� ������
			int currentPage = 1;
			
			//�Ѿ�� ���� �������� ������ ��� ������������ �� �ֱ�
			if(pageNum!=null){
				currentPage= Integer.parseInt(pageNum);
			}else{
				pageNum = "1";
			}
			
			// �˻� ���� ------------------------------------------------------------
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
			
			// �˻��� ���� ��
			if(searchValue != null){
				
				// �ѱ��� �ѱ涧 encoding �۾��� ����� ��. get����� �� ����� �ѱ������ڵ� ������ؼ� �ѱ��� �ٽ� ������ 
				if(req.getMethod().equalsIgnoreCase("GET")){
					searchValue = URLDecoder.decode(searchValue, "UTF-8");
				}
			}
			else{ // �˻��� ���� �ʾ��� ��
				searchKey = "subject";
				searchValue = "";	
			}
			//-------------------------------------------------------------------------
			
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
			
			List<BoardDTO> lists = dao.getLists(start,end,searchKey,searchValue);
			
			// �˻����� ��� �˻��� ����Ʈ�� �ٽ� �ҷ������� ��
			// ������ ����� ������ �ѱ��� ���� ������ decoding�ϹǷ� ���⼭ encoding ����
			String param = "";
			if(!searchValue.equals("")){
				param+= "?searchKey="+ searchKey;
				param+= "&searchValue="+URLEncoder.encode(searchValue,"UTF-8");
			}
			// �˻����� �ʾ��� ���� �ٽ� null�� ����	
			
			// ����¡ ó��
			String listUrl = "list.do" + param;
			String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
			
			// �� ���� ���� �ּ�����
			String articleUrl = cp + "/sboard/article.do";
			
			// �˻����� �ʾ��� ��
			if(param.equals("")){
				articleUrl += "?pageNum="+currentPage;	
			}else{	// �˻� ���� ��
				articleUrl += param +"&pageNum="+currentPage;
			}
			
			// �������� ������, �����͸� �Ѱ���. class���� jsp��
			req.setAttribute("lists", lists);
			req.setAttribute("articleUrl",articleUrl);
			req.setAttribute("pageIndexList",pageIndexList);
			req.setAttribute("dataCount",dataCount);

			// ���� �ּҸ� �Է��ϰ� forward�� ��Ŵ
			url = "/bbs/list.jsp"; // jsp��� /study/sboard/list.do �� Ȩ�������� �� �� �ִ�
			forward(req, resp, url);
			
		}
		
// �Խù� ���� �� ȭ�� ó��
		
		else if(uri.indexOf("article.do")!=-1) {
			
			int num = Integer.parseInt(req.getParameter("num"));
			String pageNum = req.getParameter("pageNum");
			
			// �˻��ؼ� ������ ��� searchKey,Value���� ���޹���
			// �˻� ���� ------------------------------------------------------------
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
			
			// �˻��� ���� ��
			if(searchValue!=null){
				
				// �ѱ��� �ѱ涧 encoding �۾��� ����� ��. get����� �� ����� �ѱ��� ���ڵ� ������ؼ� �ѱ��� �ٽ� ������ 
				if(req.getMethod().equalsIgnoreCase("GET")){
					searchValue = URLDecoder.decode(searchValue, "UTF-8");
				}
			}
			else{ // �˻��� ���� �ʾ��� ��
				searchKey = "subject";
				searchValue = "";	
			}
			//-------------------------------------------------------------------------
			// ��ȸ�� ����
			dao.updateHitcount(num);
			
			// �� ��������
			BoardDTO dto = dao.getReadData(num);
			
			if( dto==null ) {
				url = cp + "/sboard/list.do";
				resp.sendRedirect(url);
			}
			// �� line ��, enter ������ ���� ������ line�� ���� ����
			int lineSu = dto.getContent().split("\n").length;
			
			// �� ������ ���͸� <br>�� ����
			dto.setContent(dto.getContent().replaceAll("\n", "<br/>"));
			
			// �ּ� ����
			String param= "pageNum="+ pageNum;
			// ���ڵ�
			if(!searchValue.equals("")){
				param+= "&searchKey="+ searchKey;
				param+= "&searchValue="+URLEncoder.encode(searchValue,"UTF-8");
			}
			
			// �� �ѱ��
			req.setAttribute("dto", dto);
			req.setAttribute("lineSu",lineSu);
			req.setAttribute("pageNum",pageNum);
			req.setAttribute("params",param);
			
			url = "/bbs/article.jsp";
			forward(req, resp, url);

		}
		
// delete�� ����-
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
			
			// list�� ���ư�.
			url = cp+"/sboard/list.do?"+params;
			resp.sendRedirect(url);
			
		}
// ������Ʈ��. ����.
		else if(uri.indexOf("update.do")!=-1) {
			
			// �ٲ� �Խñ��� ��ȣ �޾ƿ���
			int num = Integer.parseInt(req.getParameter("num"));
			String pageNum = req.getParameter("pageNum");	
			
			// �˻� ���� ------------------------------------------------------------
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
				
			// �˻��� ���� ��
			if(searchValue != null){
				
				// �ѱ��� �ѱ涧 encoding �۾��� ����� ��. get����� �� ����� �ѱ������ڵ� ������ؼ� �ѱ��� �ٽ� ������ 
				if(req.getMethod().equalsIgnoreCase("GET")){
					searchValue = URLDecoder.decode(searchValue, "UTF-8");
				}
			}
			else{ // �˻��� ���� �ʾ��� ��
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
		
// update_ok ������Ʈ ok��
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
