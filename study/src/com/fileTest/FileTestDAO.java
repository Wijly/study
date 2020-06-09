package com.fileTest;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class FileTestDAO {
	
	private Connection conn;
	
	public FileTestDAO(Connection conn) {
		this.conn = conn;
	}
	
	public int getDataCount() {
		
		int dataCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "select nvl(count(*),0) from fileTest";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dataCount = rs.getInt(1);
			}
			
			rs.close();
			pstmt.close();
			
			
		} catch (Exception e) {
			System.out.println(e.toString()+"getDataCount");
		}

		return dataCount;
		
	}
	
	public int getMaxNum() {
		
		int maxNum=0;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		String sql;
		
		try {
			
			sql = "select nvl(max(num),0) from fileTest";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				maxNum = rs.getInt(1);
			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString()+"getMaxNum");
		}
		
		return maxNum;
		
	}
	
// insert 문
	public int insertData(FileTestDTO dto) {
		
		int result=0;
		
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "insert into fileTest(num,subject,saveFileName,originalFileName) values (?,?,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, dto.getNum());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getSaveFileName());
			pstmt.setString(4, dto.getOriginalFileName());
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString()+"insert");
		}
		
		return result;
	}

// 전체 데이터를 가져옴
	public List<FileTestDTO> getList(int start, int end){
		
		List<FileTestDTO> lists = new ArrayList<FileTestDTO>();
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "select * from ( ";
			sql+= "select rownum rnum, data.* from (";
			sql+= "select num,subject,saveFileName,originalFileName from fileTest ";
			sql+= "order by num desc) data) ";
			sql+= "where rnum >=? and rnum<=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				FileTestDTO dto = new FileTestDTO();
				dto.setNum(rs.getInt("num"));
				dto.setSubject(rs.getString("subject"));
				dto.setSaveFileName(rs.getString("saveFileName"));
				dto.setOriginalFileName(rs.getString("originalFileName"));
				
				lists.add(dto);				
			}
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString()+"list all");
		}
		
		return lists;
		
	}

// 선택된 데이터 하나만 가져오기
	public FileTestDTO getReadData(int num){
		
		FileTestDTO dto = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "select num,subject,saveFileName,originalFileName from fileTest ";
			sql+= "where num=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				dto = new FileTestDTO();
				
				dto.setNum(rs.getInt("num"));
				dto.setSubject(rs.getString("subject"));
				dto.setSaveFileName(rs.getString("saveFileName"));
				dto.setOriginalFileName(rs.getString("originalFileName"));
			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString()+"list all");
		}
		
		return dto;
		
	}
	
// 데이터 삭제 sql
	public int deleteData(int num) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "delete fileTest where num=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString()+"delete");
		}
		return result;
	}
	
}
