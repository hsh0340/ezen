<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateTest01Pro</title>
</head>
<body>
<div id="container">
	<%
	request.setCharacterEncoding("utf-8");
	
	// 폼에서 넘어오는 파라미터 값을 받음
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	String name = request.getParameter("name");
	int age = Integer.parseInt(request.getParameter("age"));
	
	// DB의 접속 정보
	String url = "jdbc:mysql://localhost:3306/db01?SSL=false;";
	String dbId = "ezen01"; // db에서 얻어온 id
	String dbPwd = "1234"; // db에서 얻어온 pwd
					
	// 연결, 질의, 결과테이블 객체
	Connection conn = null; // 연결
	PreparedStatement pstmt = null; // 질의
	ResultSet rs = null; // 결과 테이블 객체
		
	// sql문 - 조건의 아이디에 해당하는 사원 조회, 조건의 아이디와 비밀번호가 일치하는 사원 삭제
	String sql = "SELECT * FROM member WHERE id = ?";
	String sql2 = "UPDATE member SET name = ?, age =? WHERE id = ? AND pwd = ?";
	int cnt = 0;
	
	try {
		Class.forName("com.mysql.jdbc.Driver"); // 1단계 - 드라이버 연결
		conn = DriverManager.getConnection(url, dbId, dbPwd); // 2단계 - DB접속
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();
		
		if (rs.next()) {
			// 아이디가 존재한다면
			String t_pwd = rs.getString("pwd");
			if (pwd.equals(t_pwd)) {
				// 아이디 존재하면서 비밀번호도 일치
				// UPDATE 실행
				pstmt = conn.prepareStatement(sql2); // 위에서 쓰고있는데, 안닫고 또 써서
				// 위에 바인딩 순서대로
				pstmt.setString(1, name);
				pstmt.setInt(2, age);
				pstmt.setString(3, id);
				pstmt.setString(4, pwd);
				cnt = pstmt.executeUpdate();
				
				if (cnt > 0) { // 한번이라도 업데이트 되면 cnt가 0보다 커짐
					out.print(id + "님의 회원 정보가 수정되었습니다.");
				} else {
					out.print(id + "님의 회원정보가 수정되지않았습니다.");
				}
			} else {
				// 아이디 존재하지만 비밀번호 불일치				
				out.print("<script>alert('비밀번호가 일치하지 않습니다.');history.go(-1);</script>");
			}
		} else {
			// 아이디가 존재하지 않는다면
			out.print("<script>alert('아이디가 존재하지 않습니다.');history.go(-1);</script>");
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