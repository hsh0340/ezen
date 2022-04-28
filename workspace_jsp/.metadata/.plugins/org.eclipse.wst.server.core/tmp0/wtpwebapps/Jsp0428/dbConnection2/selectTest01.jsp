<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>selectTest01</title>
<style>
	#container {
		width: 600px;
		margin: 20px auto;
	}
	
	h2 {
		text-align: center;
	}
	
	table {
	 	width: 100%;
		border: 1px solid black;
		border-collapse: collapse;
		text-align: center;
	}
	
	tr {
		height: 35px;
	}
	
	th, td {
		border: 1px solid black;
	}
	
	th {
		background-color: #ccc;
	}
</style>
</head>
<%--
< JDBC 연동 프로그래밍 >

2. R(Read)- SELECT * FROM 테이블명, 테이블의 전체 데이터를 조회
< JSP 페이지에서 DB로 데이터를 조회(검색)하는 작업 >
1단계 : 드라이버명으로 DB를 확인
2단계 : url, 계정명, 계정비밀번호를 사용하여 DB에 접속 -> 커넥션을 획득 (Connection 객체)

3단계 : Statement, PreparedStatement, CallableStatment 3가지 중에 하나의 객체를 생성
- PreparedStatement : SQL문을 사용할 수 있는 객체
	-- sql을 연결하여 질의하는 방법을 제공
	-- Statement 객체의 단점을 보완
	-- 장점: sql문 간결, 바인딩(binding, 연결한다)변수(홀더라고도 함)를 사용
pstmt = conn.prepareStatement(sql); // pstmt 객체를 생성
	
4단계 : PreparedStatement 객체를 사용하여 sql문을 실행함.
- pstmt.executeUpdate() : insert, update, delete를 할 때 사용 -> 결과는 추가/수정/삭제된 행의 수를 리턴, 없을 때는 0을 리턴
- pstmt.executeQuery() : select를 할 때 사용 -> 결과는 조회한 결과를 테이블 형태로 가져오는 ResultSet 객체를 리턴

5단계 : rs의 결과를 화면으로 출력해준다.
rs는 결과테이블 첫행 바로 위에 있다가 다음 데이터가 있는지의 여부를 질문
while(rs.next()) -> 다음 데이터가 있다면 ? true : false


 --%>
<body>

	<div id="container">
		<h2>전체 회원 정보 확인</h2>
		
		<%
		request.setCharacterEncoding("utf-8");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH:mm:ss");
		
		// DB의 접속 정보
		String url = "jdbc:mysql://localhost:3306/db01?SSL=false;";
		String dbId = "ezen01"; // db에서 얻어온 id
		String dbPwd = "1234"; // db에서 얻어온 pwd
				
		// 연결, 질의, 결과테이블 객체
		Connection conn = null; // 연결
		PreparedStatement pstmt = null; // 질의
		ResultSet rs = null; // 결과테이블 객체
		
		// sql문 - SELECT 일 때
		String sql = "SELECT * FROM member";
		
		try {
			Class.forName("com.mysql.jdbc.Driver"); // 1단계 - 드라이버 연결
			conn = DriverManager.getConnection(url, dbId, dbPwd); // 2단계 - DB 접속
			
			pstmt = conn.prepareStatement(sql); // 3단계 - PreparedStatement 객체 생성 
			rs = pstmt.executeQuery(); // 4단계 - sql 실행
			
			out.print("<table><tr><th>아이디</th><th>비밀번호</th><th>이름</th><th>나이</th><th>가입일자</th></tr>");
			// 
			while (rs.next()) { // rs로 가져온 결과 테이블에 다음 데이터가 있다면,
				// rs는 첫 행 바로 위 가리키고있음. next() : 다음행이 있는지?
				String id = rs.getString("id");
				String pwd = rs.getString("pwd");
				String name = rs.getString("name");
				int age = rs.getInt("age");
				Timestamp regDate = rs.getTimestamp("regDate");
				
				out.print("<tr>");
				out.print("<td width='15%'>" + id + "</td>");
				out.print("<td width='15%'>" + pwd + "</td>");
				out.print("<td width='15%'>" + name + "</td>");
				out.print("<td width='10%'>" + age + "</td>");
				out.print("<td width='45%'>" + sdf.format(regDate) + "</td>");
				out.print("</tr>");	
			}	
			out.print("</table>");
		} catch(Exception e) {
			e.printStackTrace();
			out.print("데이터 조회시에 예외가 발생하였습니다.");
		} finally { // 연 순서 역순으로 닫기
			if (rs != null) try {rs.close();} catch(Exception e) {e.printStackTrace();} // 닫으면서 예외처리
			
			if (pstmt != null) try {pstmt.close();} catch(Exception e) {e.printStackTrace();} // 닫으면서 예외처리
			
			if (conn != null)  try {conn.close();} catch(Exception e) {e.printStackTrace();} // 닫으면서 예외처리
		}
		%>
	</div>

</body>
</html>