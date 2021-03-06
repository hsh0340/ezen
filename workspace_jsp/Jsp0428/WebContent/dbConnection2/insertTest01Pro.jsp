<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ page import="java.sql.Connection, java.sql.Statement" %>  --%>
<%@ page import="java.sql.*" %> <%-- on-demand import 방법  --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertTest01Pro</title>
<style>

</style>
</head>

<%--
< JDBC 연동 프로그래밍 >

1. C(Create)- insert
< JSP 페이지에서 DB로 데이터를 삽입하는 작업 >
1단계 : 드라이버명으로 DB를 확인
2단계 : url, 계정명, 계정비밀번호를 사용하여 DB에 접속 -> 커넥션을 획득 (Connection 객체)
3단계 : Statement, PreparedStatement, CallableStatment 3가지 중에 하나의 객체를 생성
- Statement : SQL을 사용할 수 있는 객체
	-- sql을 연결하여 질의하는 방법을 제공
	-- 단점 : 연결된 sql문이 길어지고, 복잡함.
- PreparedStatement : SQL문을 사용할 수 있는 객체
	-- sql을 연결하여 질의하는 방법을 제공
	-- Statement 객체의 단점을 보완
	-- 장점: sql문 간결, 바인딩(binding, 연결한다)변수(홀더라고도 함)를 사용
- CallableStatement : PL/SQL을 사용할 수 있는 객체
4단계 : Statement, PreparedStatement 객체를 사용하여 sql문을 실행함.

 --%>

<body>

	<div id="container">
		<h2>회원 정보 확인</h2>
		
		<%
		request.setCharacterEncoding("utf-8");
		
		// 1번 - 폼에서 넘어오는 데이터 받는 방법(request)
		/*
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		String name = request.getParameter("name");
		int age = Integer.parseInt(request.getParameter("age"));
		*/
		
		%>
		
		<%-- 2번 - 폼에서 넘어오는 데이터 받는 방법(action tag 중에서 useBean 사용) --%>
		<jsp:useBean id="member" class="bean.Member"/>
		<jsp:setProperty property="*" name="member"/>
		<%
		String id = member.getId();
		String pwd = member.getPwd();
		String name = member.getName();
		int age = member.getAge();
		
		// --------------------------------------------
		
		// DB의 접속 정보
		String url = "jdbc:mysql://localhost:3306/db01?SSL=false;";
		String dbId = "ezen01"; // db에서 얻어온 id
		String dbPwd = "1234"; // db에서 얻어온 pwd
		
		// 연결, 질의 객체
		Connection conn = null;
		//Statement stmt = null;
		PreparedStatement pstmt = null;
		
		// SQL 문 - INSERT문
		// 1번 - Statement 객체에서 사용하는 sql문
		// String sql = "INSERT INTO member VALUES('"+id+"', '"+pwd+"', '"+name+"', "+age+", NOW())"; -> statement 객체쓸 때 sql
		
		// 2번 - PreparedStatement 객체에서 사용하는 sql문
		String sql = "INSERT INTO member VALUES(?, ?, ?, ?, NOW())"; // ? : 바인딩 변수
		int cnt = 0;
		
		try {
			Class.forName("com.mysql.jdbc.Driver"); // 1단계 : MySQL DB 드라이버를 확인
			conn = DriverManager.getConnection(url, dbId, dbPwd); // 2단계 : DB 접속 -> 커넥션 획득
			
			// 1번 - Statement 객체 사용
			//stmt = conn.createStatement(); // 3단계: statement 객체를 생성
			//cnt = stmt.executeUpdate(sql); // 4단계: statement 객체를 사용하여 sql문을 실행 -> 결과는 insert, update, delete인 경우에는
			  						 		//											 행의 수를 리턴
			  						 		
			// 2번 - PreparedStatement 객체 사용
			pstmt = conn.prepareStatement(sql); // 실행할 때 바로 sql문 집어넣고 씀 // 3단계: preparedStatement 객체를 생성하고, 바이딩 변수에 값을 삽입
			pstmt.setString(1, id); // 첫번째 바인딩변수에 id를 넣음 : setString(바인딩변수 순서, 넣을값)
			pstmt.setString(2, pwd);
			pstmt.setString(3, name);
			pstmt.setInt(4, age);
			cnt = pstmt.executeUpdate(); // 4단계: sql문을 실행 -> 결과는 insert, update, delete의 경우에 행 수를 리턴한다. 성공 못하면 0
			
			if (cnt > 0) { // insert 성공;
				out.print("데이터 추가에 성공하였습니다.");	
			} else { // insert 실패
				out.print("데이터 추가에 실패하였습니다.");
			}
		} catch(Exception e) {
			e.printStackTrace();
			out.print("데이터 추가시에 예외가 발생하였습니다.");
		} finally {
			if (pstmt != null) {
				// 닫다가 또 예외발생할 수 도 있음.
				try {
					pstmt.close();					
				} catch(Exception e) {
					e.printStackTrace();
				} // end of try-catch
			} // end of if
			
			if (conn != null) {
				// 닫다가 또 예외발생할 수 도 있음.
				try {
					conn.close();
				} catch(Exception e) {
					e.printStackTrace();
				}	
			}
		}
		%>
	</div>
	<%--
	hu Apr 28 13:08:07 KST 2022 WARN: Establishing SSL connection without server's identity verification is not recommended. 
	According to MySQL 5.5.45+, 5.6.26+ and 5.7.6+ requirements SSL connection must be established by default if explicit option isn't set. 
	For compliance with existing applications not using SSL the verifyServerCertificate property is set to 'false'. 
	You need either to explicitly disable SSL by setting useSSL=false, 
	or set useSSL=true and provide truststore for server certificate verification.
	url에 SSL=false
	 --%>

		
</body>
</html>