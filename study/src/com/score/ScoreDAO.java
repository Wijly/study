package com.score;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class ScoreDAO {
	
	// �̰��� ������ ��� ������ �ȵż� �ƹ� ó���� ����
	// dao ��ü ������ ���ÿ� conn �ʱ�ȭ
	private Connection conn;
	
	// ������ ����. 
	public ScoreDAO(Connection conn) {
		this.conn = conn;
	}
	
	
	
	// �Ű������� dto�� �����
	public int insertData(ScoreDTO dto) {
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "insert into score (hak,name,kor,eng,mat) values (?,?,?,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getHak());
			pstmt.setString(2, dto.getName());
			pstmt.setInt(3, dto.getKor());
			pstmt.setInt(4, dto.getEng());
			pstmt.setInt(5, dto.getMat());
			
			// db�� ������ 1, �������� 0
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			try {pstmt.close();} catch (Exception e2) {}
			try {DBConn.close();} catch (Exception e2) {}
		}
		return result;
	}
	
	
	// ��ü �����͸� ��ȸ
	public List<ScoreDTO> getList(){
		
		List<ScoreDTO> lists = new ArrayList<ScoreDTO>();
		PreparedStatement pstmt = null;

		// ����Ʈ�� ����ؾ��ϹǷ� 
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "select hak,name,kor,eng,mat,(kor+eng+mat) tot,(kor+eng+mat)/3 avg, ";
			sql+= "rank() over (order by (kor+eng+mat) desc ) rank from score";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			// ��� ������� �𸣹Ƿ� �ݺ��� ���
			while(rs.next()) {
				ScoreDTO dto = new ScoreDTO();
				dto.setHak(rs.getString("hak"));
				dto.setName(rs.getString("name"));
				dto.setKor(rs.getInt("kor"));
				dto.setEng(rs.getInt("eng"));
				dto.setMat(rs.getInt("mat"));
				dto.setTot(rs.getInt("tot"));
				dto.setAvg(rs.getInt("avg"));
				dto.setRank(rs.getInt("rank"));
				
				// ��� �͵��� ����Ʈ�� �߰�
				lists.add(dto);
			}
			
			// �� ������ �ݱ�
			pstmt.close();
			rs.close();
			
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
				
				
			sql = "select nvl(count(*),0) from score ";
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
	
	public List<ScoreDTO> getLists(int start, int end, String searchKey, String searchValue){
		
		List<ScoreDTO> lists = new ArrayList<ScoreDTO>();
		PreparedStatement pstmt = null;

		// ����Ʈ�� ����ؾ��ϹǷ� 
		ResultSet rs = null;
		String sql;
		
		try {
			searchValue = "%" + searchValue +"%";
			
			sql = "select * from (";
			sql+= "select rownum rnum, hak,name,kor,eng,mat,(kor+eng+mat) tot,(kor+eng+mat)/3 avg, ";
			sql+= "rank() over (order by (kor+eng+mat) desc) rank from score ";
			sql+= "where "+searchKey+" like ?) ";
			sql+= "where rnum>=? and rnum <=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchValue);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			
			// ��� ������� �𸣹Ƿ� �ݺ��� ���
			while(rs.next()) {
				ScoreDTO dto = new ScoreDTO();
				dto.setHak(rs.getString("hak"));
				dto.setName(rs.getString("name"));
				dto.setKor(rs.getInt("kor"));
				dto.setEng(rs.getInt("eng"));
				dto.setMat(rs.getInt("mat"));
				dto.setTot(rs.getInt("tot"));
				dto.setAvg(rs.getInt("avg"));
				dto.setRank(rs.getInt("rank"));
				
				// ��� �͵��� ����Ʈ�� �߰�
				lists.add(dto);
			}
			
			// �� ������ �ݱ�
			pstmt.close();
			rs.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
	
		return lists;
	}
	
	//�����ϱ����� �й��� �̸��� �������� �޼ҵ�
	public ScoreDTO getReadData(String hak) {
		
		ScoreDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		String sql;
		
		try {
			
			sql = "select hak,name,kor,eng,mat from score where hak=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, hak);
			
			// �����Ͱ� ���� �� ����
			rs = pstmt.executeQuery();
					
			if(rs.next()) {
				dto = new ScoreDTO();
				
				dto.setHak(rs.getString("hak"));
				dto.setName(rs.getString("name"));
				dto.setKor(rs.getInt("kor"));
				dto.setEng(rs.getInt("eng"));
				dto.setMat(rs.getInt("mat"));
			}
			rs.close();
			pstmt.close();			
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}
	
	// UPDATA��, DTO�� �����ͼ� ã��
	// ����Ǹ� 1, �ƴϸ� 0
	public int updateData(ScoreDTO dto) {
		
		int result=0;
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "update score set kor=?,eng=?,mat=? where hak=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, dto.getKor());
			pstmt.setInt(2, dto.getEng());
			pstmt.setInt(3, dto.getMat());
			pstmt.setString(4, dto.getHak());
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	
	// delete�� 
	public int deleteData(String hak) {
		
		int result=0;
		
		String sql;
		PreparedStatement pstmt = null;
		
		try {
			
			sql = "delete score where hak=?";
			
			pstmt= conn.prepareStatement(sql);
			
			pstmt.setString(1, hak);
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}
	
}
