package com.naver;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


public class NaverDAO {
	
	private Connection conn;
	
	public NaverDAO(Connection conn) {
		this.conn= conn;
	}
	
	public int insertData(NaverDTO dto) { 
		
		int result=0;
		
		String sql;
		PreparedStatement pstmt = null;
		
		try {
			
			sql = "insert into naver (id,pwd,name,birth1,birth2,birth3,gender,email,tel1) values (?,?,?,?,?,?,?,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPwd());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getBirth1());
			pstmt.setString(5, dto.getBirth2());
			pstmt.setString(6, dto.getBirth3());
			pstmt.setString(7, dto.getGender());
			pstmt.setString(8, dto.getEmail());
			pstmt.setInt(9, dto.getTel1());
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	public List<NaverDTO> getList(){
		
		List<NaverDTO> lists = new ArrayList<NaverDTO>();
		PreparedStatement pstmt = null;
		
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "select id,pwd,name,birth1,birth2,birth3,gender,email,tel1 from naver";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				NaverDTO dto = new NaverDTO();
				dto.setId(rs.getString("id"));
				dto.setPwd(rs.getString("pwd"));
				dto.setName(rs.getString("name"));
				dto.setBirth1(rs.getString("birth1"));
				dto.setBirth2(rs.getString("birth2"));
				dto.setBirth3(rs.getString("birth3"));
				dto.setGender(rs.getString("gender"));
				dto.setEmail(rs.getString("email"));
				dto.setTel1(rs.getInt("tel1"));
				
				lists.add(dto);
			
			}
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return lists;
	}
	
	// 아이디를 읽어들여서 회원변경
	public NaverDTO getReadData(String id) {
		
		NaverDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "select id,pwd,name,birth1,birth2,birth3,gender,email,tel1 from naver where id=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new NaverDTO();
				
				dto.setId(rs.getString("id"));
				dto.setPwd(rs.getString("pwd"));
				dto.setName(rs.getString("name"));
				dto.setBirth1(rs.getString("birth1"));
				dto.setBirth2(rs.getString("birth2"));
				dto.setBirth3(rs.getString("birth3"));
				dto.setGender(rs.getString("gender"));
				dto.setEmail(rs.getString("email"));
				dto.setTel1(rs.getInt("tel1"));
			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}
	
	// 없데이트
	public int updateData(NaverDTO dto) {
	
		int result=0;
		PreparedStatement pstmt=null;
		String sql;
		
		try {
			
			sql = "update naver set pwd=?,name=?,email=?,tel1=? where id=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getPwd());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getEmail());
			pstmt.setInt(4, dto.getTel1());
			pstmt.setString(5, dto.getId());
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	
	public int deleteData(String id) {
		
		int result = 0;
		
		String sql;
		PreparedStatement pstmt = null;
		
		try {
			
			sql = "delete naver where id=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		
		return result;
	}
}
