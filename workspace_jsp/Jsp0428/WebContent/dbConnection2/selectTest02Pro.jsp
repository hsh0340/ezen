<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>selectTest02Pro</title>
<style>
	# container {
		width: 400px;
		margin: 20px auto;
	}
	
	h2 {
		text-align: center;
	}
	
	table {
		width: 100%;
		border: 1px solid black;
		border-collapse: collapse;
	}
	
	tr {
		height: 40px;
	}
	
	th, td {
		border: 1px solid black;
	}
	
	th {
		background-color: #ccc;
	}
	
	td {
		text-align: center;
	}
</style>
</head>
<body>
    <div id="container">
    	<%
    	request.setCharacterEncoding("utf-8");
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH:mm:ss");
    	
    	// 폼의 파라미터 값을 받음
    	String id = request.getParameter("id");
    	String pwd = request.getParameter("pwd");
    	
		// DB의 접속 정보
		String url = "jdbc:mysql://localhost:3306/db01?SSL=false;";
		String dbId = "ezen01"; // db에서 얻어온 id
		String dbPwd = "1234"; // db에서 얻어온 pwd
				
		// 연결, 질의, 결과테이블 객체
		Connection conn = null; // 연결
		PreparedStatement pstmt = null; // 질의
		ResultSet rs = null; // 결과테이블 객체
		
		// sql문 - SELECT 일 때 - 조건의 아이디에 해당하는 사원 조회
		String sql = "SELECT * FROM member WHERE id = ?";
		
		try {
			Class.forName("com.mysql.jdbc.Driver"); // 1단계
			conn = DriverManager.getConnection(url, dbId, dbPwd); // 2단계 - DB접속
			
			pstmt = conn.prepareStatement(sql); // 3단계 - pstmt 생성, 바인딩 변수 값을 설정
			pstmt.setString(1, id);
			pstmt.executeQuery();
			rs = pstmt.executeQuery(); // 4단계 - sql문 실행, rs로 결과를 받음
			
			// 1건의 데이터는 if문 사용, 여러건의 데이터는 while문 사용 
			if (rs.next()) { // id가 존재한다.
				String t_pwd = rs.getString("pwd"); 
				if (pwd.equals(t_pwd)) { // 아이디가 존재하고, 그 아이디의 비밀번호와 일치할 때
					String name = rs.getString("name");
					int age = rs.getInt("age");
					Timestamp regDate = rs.getTimestamp("regDate");
					out.print("<h2>" + id + "님의 회원정보</h2><br>");
					out.print("<table>");
					out.print("<tr><th>아이디</th><td>" + id + "</td></tr>");
					out.print("<tr><th>비밀번호</th><td>" + pwd + "</td></tr>");
					out.print("<tr><th>이름</th><td>" + name + "</td></tr>");
					out.print("<tr><th>나이</th><td>" + age + "</td></tr>");
					out.print("<tr><th>가입일자</th><td>" + sdf.format(regDate) + "</td></tr>");
					out.print("</table>");
				} else {  // id가 존재하지 않는 상태, 아이디는 존재하지만 그 아이디의 비밀번호가 일치하지 않을 때
				out.print("<script>alert('비밀번호가 일치하지 않습니다.');history.back();</script>");	
				}
			} else { // 아이디가 존재하지 않음
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