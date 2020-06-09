package com.util;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DBCPConn {

	// DBCP ( DataBase Connection Pool)
	/*
	
	데이터베이스와 연결된 커넥션을 미리 만들어서 POOL영역에 저장하고
	필요할 경우에만 가져다가 쓰고 다시 POOL영역에 반환
		
	*/
	
	private static Connection conn = null;
	
	public static Connection getConnection() {
		if(conn==null) {
			try {
				
				// 이름과 객체를 바인딩
				Context ctx = new InitialContext();
				
				// web.xml에서 환경설정 찾음
				Context evt = (Context)ctx.lookup("java:/comp/env");
				DataSource ds = (DataSource)evt.lookup("jdbc/myOracle");
				
				conn = ds.getConnection();
							
			} catch (Exception e) {
				System.out.println(e.toString());
			}
		}
		return conn;
	}
	
	public static void close() {
		
		if(conn != null) {
			try {
				if(!conn.isClosed()) 
					conn.close();				
			} catch (Exception e) {
				System.out.println(e.toString());
			}
		}
		
		conn = null;
	}
}
