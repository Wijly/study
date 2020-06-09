package com.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO {

	private Connection conn;
	
	public BoardDAO(Connection conn) {
		this.conn = conn;
	}
	
	//BOARD ���̺��� NUM�� �ִ��� �������� �޼ҵ�
	public int getMaxNum() {
		
		int maxNum = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "select nvl(max(num),0) from board";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				// �÷��� ��ȣ, �Ѱ��������Ƿ� 1
				maxNum = rs.getInt(1);
			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return maxNum;	
	}
	
	//  �Է�. �۾��� (create.jsp -> created_ok.jsp)
	public int insertData(BoardDTO dto) {
	
		int result = 0;
		
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			//��ȸ���� �⺻�� 0, ��¥�� sysdate
			sql = "insert into board(num,name,pwd,email,subject,content,ipaddr,hitcount,created) values(?,?,?,?,?,?,?,0,sysdate)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, dto.getNum());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getPwd());
			pstmt.setString(4, dto.getEmail());
			pstmt.setString(5, dto.getSubject());
			pstmt.setString(6, dto.getContent());
			pstmt.setString(7, dto.getIpaddr());
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	
	// ��ü ������(list.jsp) ���
	// -> �� �������� 3���� ���
	public List<BoardDTO> getLists(int start, int end, String searchKey, String searchValue){
	
		List<BoardDTO> lists = new ArrayList<BoardDTO>();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			searchValue = "%" + searchValue + "%";
			
			sql = "select * from (";
			sql+= "select rownum rnum, data.* from (";
			sql+= "select num,name,subject,hitcount,to_char(created,'YYYY-MM-DD') created from board ";
			sql+= "where " + searchKey + " like ? ";
			//num ���� ����
			sql+= "order by num desc) data) ";
			sql+= "where rnum>=? and rnum<=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, searchValue);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				BoardDTO dto = new BoardDTO();
				
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setSubject(rs.getString("subject"));
				dto.setHitCount(rs.getInt("hitcount"));
				dto.setCreated(rs.getString("created"));
				
				lists.add(dto);
			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return lists;
	}
	
	// ��ü ������ ����
	public int getDataCount(String searchKey, String searchValue) {
		
		int dataCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			searchValue = "%"+ searchValue+"%";
			
			
			sql = "select nvl(count(*),0) from board ";
			// search�� �Ϸ��� ���� ����
			sql+= "where "+ searchKey + " like ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, searchValue);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dataCount = rs.getInt(1);
			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dataCount;
	
	}
	
	
	// num���� ��ȸ�� �ϳ��� ������ ( article.jsp )
	public BoardDTO getReadData(int num) {
		
		BoardDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
		
			sql = "select num,name,pwd,email,subject,content,ipAddr,hitCount,created from board where num=?";
			
			pstmt= conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
			
				dto = new BoardDTO();
				
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setPwd(rs.getString("pwd"));
				dto.setEmail(rs.getString("email"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setIpaddr(rs.getString("ipaddr"));
				dto.setHitCount(rs.getInt("hitcount"));
				dto.setCreated(rs.getString("created"));
			
				
			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}
	
	// ��ȸ�� (article.jsp)
	public int updateHitcount(int num) {
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "update board set hitCount = hitcount+1 where num=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
		
	}
	
	// ���� ( update.jsp -> update_ok.jsp )
	public int updateData(BoardDTO dto) {
	
		int result = 0;
		
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "update board set name=?,pwd=?, email=?,subject=?,content=? where num=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getPwd());
			pstmt.setString(3, dto.getEmail());
			pstmt.setString(4, dto.getSubject());
			pstmt.setString(5, dto.getContent());
			pstmt.setInt(6, dto.getNum());
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
		
	}
	// ���� (update.jsp -> delete.jsp )
	public int deleteData(int num) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "delete board where num=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
		
	}
	
}
