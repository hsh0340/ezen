package util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class JDBCUtil {
	
	// 1~2 단계 - Connection Pool 사용
	public static Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env"); // 커넥션 풀을 사용하는 설정 환경을 찾음
		DataSource ds = (DataSource)envCtx.lookup("jdbc/db01");
		return ds.getConnection();
	}
	
	// Connection, PreparedStatement 객체를 닫는 메소드 - insert, update, delete 작업
	public static void close(Connection conn, PreparedStatement pstmt) {
		// PreparedStatement 닫음
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch(Exception e) {
				e.printStackTrace();	
			} 	
		}
		
		// Connection 닫음
		if (conn != null ) {
			try {
				conn.close();
			} catch(Exception e) {
				e.printStackTrace();	
			}
		} 
	}
	
	// Connection, PreparedStatement, ResultSet 객체를 닫는 메소드 - select 작업
	// ResultSet 닫음
	public static void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		// 
		if (rs != null) {
			try {
				rs.close();
			} catch(Exception e) {
				e.printStackTrace();	
			} 	
		}
		
		// PreparedStatement 닫음
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch(Exception e) {
				e.printStackTrace();	
			} 	
		}
		
		// Connection 닫음
		if (conn != null ) {
			try {
				conn.close();
			} catch(Exception e) {
				e.printStackTrace();	
			}
		} 
	}
	
}

