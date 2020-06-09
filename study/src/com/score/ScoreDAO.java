package com.score;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class ScoreDAO {
	
	// 이것이 없으면 디비 연동이 안돼서 아무 처리를 못함
	// dao 객체 생성과 동시에 conn 초기화
	private Connection conn;
	
	// 의존성 주입. 
	public ScoreDAO(Connection conn) {
		this.conn = conn;
	}
	
	
	
	// 매개변수로 dto를 줘야함
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
			
			// db에 넣으면 1, 못넣으면 0
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			try {pstmt.close();} catch (Exception e2) {}
			try {DBConn.close();} catch (Exception e2) {}
		}
		return result;
	}
	
	
	// 전체 데이터를 조회
	public List<ScoreDTO> getList(){
		
		List<ScoreDTO> lists = new ArrayList<ScoreDTO>();
		PreparedStatement pstmt = null;

		// 리스트를 출력해야하므로 
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "select hak,name,kor,eng,mat,(kor+eng+mat) tot,(kor+eng+mat)/3 avg, ";
			sql+= "rank() over (order by (kor+eng+mat) desc ) rank from score";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			// 몇개가 들었는지 모르므로 반복문 출력
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
				
				// 담긴 것들을 리스트에 추가
				lists.add(dto);
			}
			
			// 다 넣으면 닫기
			pstmt.close();
			rs.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
	
		return lists;
	}

	// 전체 데이터 갯수
	public int getDataCount(String searchKey, String searchValue) {
			
		int dataCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
			
		try {
				
			searchValue = "%"+ searchValue+"%";
				
				
			sql = "select nvl(count(*),0) from score ";
				// search를 하려면 조건 생성
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

		// 리스트를 출력해야하므로 
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
			
			// 몇개가 들었는지 모르므로 반복문 출력
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
				
				// 담긴 것들을 리스트에 추가
				lists.add(dto);
			}
			
			// 다 넣으면 닫기
			pstmt.close();
			rs.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
	
		return lists;
	}
	
	//수정하기위해 학번과 이름을 가져오는 메소드
	public ScoreDTO getReadData(String hak) {
		
		ScoreDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		String sql;
		
		try {
			
			sql = "select hak,name,kor,eng,mat from score where hak=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, hak);
			
			// 데이터가 없을 수 있음
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
	
	// UPDATA문, DTO를 가져와서 찾음
	// 실행되면 1, 아니면 0
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
	
	// delete문 
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
