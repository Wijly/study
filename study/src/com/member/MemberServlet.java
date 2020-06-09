package com.member;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.util.DBCPConn;

public class MemberServlet extends HttpServlet{
	
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	
	// 
	protected void forward(HttpServletRequest req, HttpServletResponse resp, String url) throws ServletException, IOException {
		
		RequestDispatcher rd = req.getRequestDispatcher(url);
		rd.forward(req, resp);
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("utf-8");
		String cp = req.getContextPath();
		
		Connection conn = DBCPConn.getConnection();
		MemberDAO dao = new MemberDAO(conn);
		
		String uri = req.getRequestURI();
		String url;
		
		if(uri.indexOf("created.do") != -1) {
			
			url = "/member/created.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("created_ok.do") != -1) {
			
			MemberDTO dto = new MemberDTO();
			
			dto.setUserId(req.getParameter("userId"));
			dto.setUserPwd(req.getParameter("userPwd"));
			dto.setUserName(req.getParameter("userName"));
			dto.setUserBirth(req.getParameter("userBirth"));
			dto.setUserTel(req.getParameter("userTel"));
			
			dao.insertData(dto);
			
			url = cp+"/join/login.do";
			resp.sendRedirect(url);
			
		}
		
// 로그인 jsp
		else if(uri.indexOf("login.do") != -1) {
			
			url = "/member/login.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("login_ok.do") != -1) {
			
			// 로그인.do에서 아이디랑 비밀번호 값이 넘어옴
			String userId = req.getParameter("userId");
			String userPwd = req.getParameter("userPwd");
			
			MemberDTO dto = dao.getReadData(userId);
			
			// 아이디가 틀리거나 없고,
			// dto의 패스워드와 받은 패스워드가 다를경우 
			if(dto==null || !dto.getUserPwd().equals(userPwd)) {
				
				// message에 담아서 보냄
				req.setAttribute("message", "아이디 또는 패스워드를 정확히 입력하세요.");
				
				// 다시 로그인 jsp로 들어감
				url = "/member/login.jsp";
				forward(req, resp, url);
				return;
			}
			
			// 세션을 만듬
			HttpSession session = req.getSession();
			
			// 세션을 담기위해 info 객체를 만듬
			CustomImfo info = new CustomImfo();
			
			// 인포에 dto의 id와 이름을 넣음
			info.setUserId(dto.getUserId());
			info.setUserName(dto.getUserName());
			
			// info를 세션에 값을 넣음
			session.setAttribute("customInfo", info);
			
			// 세션을 바꿧으므로 redirect
			url = cp;
			resp.sendRedirect(url);

		}
// 로그아웃		
		else if(uri.indexOf("logout.do") != -1) {
			
			// 로그아웃 하려면 세션을 가져와 지워야함
			HttpSession session = req.getSession();
			
			// 세션에서 customInfo를 지움
			session.removeAttribute("customInfo");
			// costomInfo라는 변수명도 지워버림
			session.invalidate();
			
			// 세션을 지웠으므로 redirect
			url = cp;
			resp.sendRedirect(url);
			
		}
// 비밀번호 찾기
		else if(uri.indexOf("searchPw.do") != -1 ) {
			
			url = "/member/searchPw.jsp";
			forward(req, resp, url);
		}
		else if(uri.indexOf("searchPw_ok.do") != -1){
			
			String userId = req.getParameter("userId");
			String userTel = req.getParameter("userTel");
			
			MemberDTO dto = dao.getReadData(userId);
			
			if(dto==null || !dto.getUserTel().equals(userTel)) {
				
				req.setAttribute("message", "회원정보가 존재하지 않습니다.");
				
				url = "/member/login.jsp";
				forward(req, resp, url);
				return;
			}
			
			req.setAttribute("message", "비밀번호는 ["+dto.getUserPwd()+"]입니다.");
			
			url ="/member/login.jsp";
			forward(req, resp, url);
		}
// 회원정보 수정
		else if(uri.indexOf("updated.do") != -1) {
			
			// 세션을 가져와서 세션객체 만듬
			HttpSession session = req.getSession();
			CustomImfo info = (CustomImfo)session.getAttribute("customInfo");
			
			// 로그인이 안됐으면 로그인 창으로 돌아감
			if(info==null) {
				url = "/member/login.jsp";
				forward(req, resp, url);
				return;
			}
			
			String userId = info.getUserId();
			
			MemberDTO dto = dao.getReadData(userId);
			
			req.setAttribute("dto",	dto);
			
			url = "/member/updated.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("updated_ok.do") !=-1) {
			
			String userId = req.getParameter("userId");
			String userName = req.getParameter("userName");
			
			MemberDTO dto = dao.getReadData(userId);
			dto.setUserId(userId);
			dto.setUserName(userName);
			dto.setUserPwd(req.getParameter("userPwd"));
			dto.setUserBirth(req.getParameter("userBirth"));
			dto.setUserTel(req.getParameter("userTel"));
			
			dao.updateMember(dto);
			
			url = cp+"/join/login.do";
			resp.sendRedirect(url);

		}
		
	}

	


}
