package com.imageTest;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.util.DBCPConn;
import com.util.FileManager;
import com.util.MyUtil;

public class ImageTestServlet extends HttpServlet{
	
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
		
		req.setCharacterEncoding("utf-8");
		String cp = req.getContextPath();
		
		Connection conn = DBCPConn.getConnection();
		ImageTestDAO dao = new ImageTestDAO(conn);
		
		MyUtil myUtil = new MyUtil();
		
		// 파일 입출력을 위해 생성
		String root = getServletContext().getRealPath("/");
		String path = root + File.separator + "pds" + File.separator + "imageFile";
		
		File f = new File(path);
		
		if(!f.exists()) {
			f.mkdir();
		}
				
		String uri = req.getRequestURI();
		String url;if(uri.indexOf("write.do")!= -1) {
			
			url = "/imageTest/write.jsp";
			forward(req, resp, url);
			
		}

		else if(uri.indexOf("write_ok.do")!= -1) {
			
			String encType = "UTF-8";
			int maxSize = 10*1024*1024;
			
			MultipartRequest mr = new MultipartRequest(req, path, maxSize, encType, new DefaultFileRenamePolicy());
			
			if(mr.getFile("upload") != null) {
				
				int maxNum = dao.getMaxNum();
				
				ImageTestDTO dto = new ImageTestDTO();
				
				dto.setNum(maxNum +1 );
				dto.setSubject(mr.getParameter("subject"));
				dto.setSaveFileName(mr.getFilesystemName("upload"));
				
				dao.insertData(dto);
			}
			url = cp + "/image/list.do";
			resp.sendRedirect(url);
			
		}else if(uri.indexOf("list.do")!=-1) {
			
			String pageNum = req.getParameter("pageNum");
			
			int currentPage = 1;
			
			if(pageNum != null) {
				currentPage = Integer.parseInt(pageNum);
			}else {
				pageNum = "1";
			}
			
			// 전체 데이터 가져오기
			int dataCount = dao.getDataCount();
			// 페이지 개수
			int numPerPage = 9;
			// 전체 페이지 개수
			int totalPage = myUtil.getPageCount(numPerPage, dataCount);
			
			//데이터 삭제시 페이지 처리
			if(currentPage>totalPage) {
				currentPage = totalPage;
			}
			
			int start = (currentPage-1)*numPerPage+1;
			int end = currentPage*numPerPage;
			
			List<ImageTestDTO> lists = dao.getList(start,end);
			
			String listUrl = cp + "/image/list.do";
			String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
			
			String imagePath = cp + "/pds/imageFile";
			// 삭제 경로
			String deletePath = cp + "/image/delete.do";
			
			
			req.setAttribute("imagePath", imagePath);
			req.setAttribute("deletePath", deletePath);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("totalPage", totalPage);
			req.setAttribute("pageIndexList", pageIndexList);
			req.setAttribute("pageNum", pageNum);
			req.setAttribute("lists", lists);
			
			url = "/imageTest/list.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("delete.do")!=-1) {
			
			int num = Integer.parseInt(req.getParameter("num"));
			String pageNum = req.getParameter("pageNum");
			
			ImageTestDTO dto = dao.getReadData(num);
			
			if(dto == null)
				return;
			
			FileManager.doFileDelete(dto.getSaveFileName(), path);
			
			dao.deleteData(num);
			
			String param= "?pageNum="+pageNum;
			
			url = cp + "/image/list.do"+param;
			resp.sendRedirect(url);
		}
				
		
		
	}

}
