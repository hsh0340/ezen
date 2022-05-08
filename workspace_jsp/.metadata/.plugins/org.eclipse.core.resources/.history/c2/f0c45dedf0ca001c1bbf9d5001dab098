<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deleteTest01Pro</title>
</head>
<body>
	<div id="container">
		<%
		request.setCharacterEncoding("utf-8");
		
		// 폼에서 넘어오는 파라미터값 받음
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		
		// DB의 접속 정보
		String url = "jdbc:mysql://localhost:3306/db01?SSL=false;";
		String dbId = "ezen01"; // db에서 얻어온 id
		String dbPwd = "1234"; // db에서 얻어온 pwd
						
		// 연결, 질의, 결과테이블 객체
		Connection conn = null; // 연결
		PreparedStatement pstmt = null; // 질의
		ResultSet rs = null; // 결과 테이블 객체
			
		// sql문 - 조건의 아이디에 해당하는 사원 조회, 조건의 아이디와 비밀번호가 일치하는 사원 삭제(탈퇴)
		String sql = "SELECT * FROM member WHERE id = ?";
		String sql2 = "DELETE FROM member WHERE id = ? AND pwd = ?";
		int cnt = 0;
		
		try {
			Class.forName("com.mysql.jdbc.Driver"); // 1단계 - 드라이버 연결
			conn = DriverManager.getConnection(url, dbId, dbPwd); // 2단계 - DB접속
			
			pstmt = conn.prepareStatement(sql); // 질의를 하고
			pstmt.setString(1, id);
			rs = pstmt.executeQuery(); // 쿼리 실행하고 rs에 넣음
			
			if (rs.next()) {
				// 아이디가 존재함
				String t_pwd = rs.getString("pwd");
				if (pwd.equals(t_pwd)) {
					// 아이디 존재하고, 비밀번호도 일치
					// DELETE 쿼리 실행
					pstmt = conn.prepareStatement(sql2); // sql2 를 실행
					// 위에 바인딩 순서대로
					pstmt.setString(1, id);
					pstmt.setString(2, pwd);
					cnt = pstmt.executeUpdate();
					
					if (cnt > 0) { // 쿼리 실행 됐으면 0보다 커짐
						// 성공
						out.print(id + "님의 회원 정보가 삭제되었습니다.");
					} else {
						// 실패
						out.print(id + "님의 회원 정보가 삭제되지 않았습니다.");
					}
				} else {
					// 아이디 존재하지만 비밀번호는 불일치
					out.print("<script>alert('비밀번호가 일치하지 않습니다.');history.back();</script>");
				}
			} else {
				// 아이디가 존재하지 않음
				out.print("<script>alert('아이디가 존재하지 않습니다.');history.back();</script>");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) try {rs.close();} catch(Exception e) {e.printStackTrace();} // 닫으면서 예외처리
			
			if (pstmt != null) try {pstmt.close();} catch(Exception e) {e.printStackTrace();} // 닫으면서 예외처리
			
			if (conn != null)  try {conn.close();} catch(Exception e) {e.printStackTrace();} // 닫으면서 예외처리
		}
		%>
	</div>
</body>
</html>