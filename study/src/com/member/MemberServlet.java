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
		
// �α��� jsp
		else if(uri.indexOf("login.do") != -1) {
			
			url = "/member/login.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("login_ok.do") != -1) {
			
			// �α���.do���� ���̵�� ��й�ȣ ���� �Ѿ��
			String userId = req.getParameter("userId");
			String userPwd = req.getParameter("userPwd");
			
			MemberDTO dto = dao.getReadData(userId);
			
			// ���̵� Ʋ���ų� ����,
			// dto�� �н������ ���� �н����尡 �ٸ���� 
			if(dto==null || !dto.getUserPwd().equals(userPwd)) {
				
				// message�� ��Ƽ� ����
				req.setAttribute("message", "���̵� �Ǵ� �н����带 ��Ȯ�� �Է��ϼ���.");
				
				// �ٽ� �α��� jsp�� ��
				url = "/member/login.jsp";
				forward(req, resp, url);
				return;
			}
			
			// ������ ����
			HttpSession session = req.getSession();
			
			// ������ ������� info ��ü�� ����
			CustomImfo info = new CustomImfo();
			
			// ������ dto�� id�� �̸��� ����
			info.setUserId(dto.getUserId());
			info.setUserName(dto.getUserName());
			
			// info�� ���ǿ� ���� ����
			session.setAttribute("customInfo", info);
			
			// ������ �مf���Ƿ� redirect
			url = cp;
			resp.sendRedirect(url);

		}
// �α׾ƿ�		
		else if(uri.indexOf("logout.do") != -1) {
			
			// �α׾ƿ� �Ϸ��� ������ ������ ��������
			HttpSession session = req.getSession();
			
			// ���ǿ��� customInfo�� ����
			session.removeAttribute("customInfo");
			// costomInfo��� ������ ��������
			session.invalidate();
			
			// ������ �������Ƿ� redirect
			url = cp;
			resp.sendRedirect(url);
			
		}
// ��й�ȣ ã��
		else if(uri.indexOf("searchPw.do") != -1 ) {
			
			url = "/member/searchPw.jsp";
			forward(req, resp, url);
		}
		else if(uri.indexOf("searchPw_ok.do") != -1){
			
			String userId = req.getParameter("userId");
			String userTel = req.getParameter("userTel");
			
			MemberDTO dto = dao.getReadData(userId);
			
			if(dto==null || !dto.getUserTel().equals(userTel)) {
				
				req.setAttribute("message", "ȸ�������� �������� �ʽ��ϴ�.");
				
				url = "/member/login.jsp";
				forward(req, resp, url);
				return;
			}
			
			req.setAttribute("message", "��й�ȣ�� ["+dto.getUserPwd()+"]�Դϴ�.");
			
			url ="/member/login.jsp";
			forward(req, resp, url);
		}
// ȸ������ ����
		else if(uri.indexOf("updated.do") != -1) {
			
			// ������ �����ͼ� ���ǰ�ü ����
			HttpSession session = req.getSession();
			CustomImfo info = (CustomImfo)session.getAttribute("customInfo");
			
			// �α����� �ȵ����� �α��� â���� ���ư�
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
