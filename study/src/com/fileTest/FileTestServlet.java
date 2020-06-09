package com.fileTest;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
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

public class FileTestServlet extends HttpServlet{
	
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	
	protected void forward(HttpServletRequest req, HttpServletResponse resp,String url) throws ServletException, IOException {
		RequestDispatcher rd = req.getRequestDispatcher(url);
		rd.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("utf-8");
		String cp = req.getContextPath();
		
		Connection conn = DBCPConn.getConnection();
		FileTestDAO dao = new FileTestDAO(conn);
		
		String uri = req.getRequestURI();
		String url;
		
		// 파일 입출력을 위해 생성
		String root = getServletContext().getRealPath("/");
		String path = root + File.separator + "pds" + File.separator + "saveFile";
		
		File f = new File(path);
		
		if(!f.exists()) {
			f.mkdirs();
		}
	
// db에 파일 이름, 제목, 번호 등을 넣기
		if(uri.indexOf("write.do")!= -1) {
			
			url = "/fileTest/write.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("write_ok.do")!=-1) {
			
			String encType = "UTF-8";
			int maxSize = 10*1024*1024;
			
			MultipartRequest mr = new MultipartRequest(req, path, maxSize, encType, new DefaultFileRenamePolicy());
			
			if(mr.getFile("upload")!=null) {
				
				int maxNum = dao.getMaxNum();
				
				FileTestDTO dto = new FileTestDTO();
				dto.setNum(maxNum + 1);
				dto.setSubject(mr.getParameter("subject"));
				dto.setSaveFileName(mr.getFilesystemName("upload"));
				dto.setOriginalFileName(mr.getOriginalFileName("upload"));
				
				dao.insertData(dto);
			}
			
			url = cp + "/file/list.do";
			resp.sendRedirect(url);
					
			
		}else if(uri.indexOf("list.do")!=-1) {
			
			MyUtil myUtil = new MyUtil();
			
			String pageNum= req.getParameter("pageNum");
			
			int currentPage = 1;
			
			if(pageNum != null) {
				currentPage = Integer.parseInt(pageNum);
			}else {
				pageNum = "1";
			}
			// 전체 데이터 가져오기
			int dataCount = dao.getDataCount();
			
			//표시할 데이터 개수
			int numPerPage = 3;
			
			// 전체 페이지의 개수
			int totalPage = myUtil.getPageCount(numPerPage, dataCount);
			
			//데이터 삭제시 페이지 줄었을 때 처리
			if(currentPage > totalPage) {
				currentPage = totalPage;
			}
			
			int start = (currentPage-1)*numPerPage+1;
			int end = currentPage*numPerPage;
			
			List<FileTestDTO> lists = dao.getList(start,end);
			
			String listUrl = "list.do";
			String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
			
			// 파일명 클릭시 다운로드
			// 다운로드 .do로 이동시 다운로드 주소를 가지고감
			// 삭제시 파일 주소를 가지고 감
			String downloadPath = cp + "/file/download.do";
			String deletePath = cp + "/file/delete.do";
			
			// 이미지 파일
			String imagePath = cp + "/pds/saveFile";
			
			req.setAttribute("imagePath", imagePath);
			req.setAttribute("downloadPath", downloadPath);
			req.setAttribute("deletePath", deletePath);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("lists", lists);
			req.setAttribute("pageIndexList", pageIndexList);
			
			url = "/fileTest/list.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("download.do")!=-1){
			int num = Integer.parseInt(req.getParameter("num"));
			
			FileTestDTO dto = dao.getReadData(num);
			
			if(dto == null)
				return;
			
			// 다운로드 메소드를 불러옴, flag=false || flag = true;
			boolean flag = FileManager.doFileDownload(resp, dto.getSaveFileName(), dto.getOriginalFileName(), path);
			
			if(flag==false) {
				resp.setContentType("text/html;charset=utf-8");
				
				PrintWriter out = resp.getWriter();
				out.print("<script type='text/javascript'>");
				out.print("alert('Download false');");
				out.print("history.back()");
				out.print("</script>");
				
			}
						
			
		}else if(uri.indexOf("delete.do")!=-1){
			
			int num = Integer.parseInt(req.getParameter("num"));

			FileTestDTO dto = dao.getReadData(num);
			
			if(dto == null)
				return;
			
			// 파일 삭제			
			FileManager.doFileDelete(dto.getSaveFileName(), path);
			
			// 테이블 정보 삭제 (db삭제)
			dao.deleteData(num);
			
			// 삭제 했으므로 redirect
			url = cp + "/file/list.do";
			resp.sendRedirect(url);
			
			
		}
	}
}
