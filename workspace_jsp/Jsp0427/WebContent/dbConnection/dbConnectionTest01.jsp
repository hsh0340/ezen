<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>dbConnectionTest01</title>
</head>
<%--
< JDBC 연동 프로그래밍 >
1. JDBC(Java DataBase Connectivity)
- Java 프로그램과 RDBMS를 연결하는 인터페이스

2. JDBC 프로그래밍의 단계
- 1단계 : 드라이버명을 통해서
- 2단계 : url, 계정명, 계정 비밀번호를 통해서 RDBMS에 접속하여 Connection을 획득
- 3단계 : Connection을 사용하여 RDBMS에 질의를 하여 원하는 작업을 함. (주로 DML 작업을 함)

C(Create) : insert 
R(Read) : select
U(Update) : update
D(Delete) : delete
 --%>
<body>
	<h2>JDBC 드라이버 연결 테스트</h2>
	
	<%
	Connection conn = null;
	try {
		String url = "jdbc:mysql://localhost:3306/db01"; // MySQL url
		String dbId = "ezen01"; // 사용자 계정 이름
		String dbPwd = "1234";  // 사용자 계정 비밀번호
		
		Class.forName("com.mysql.jdbc.Driver"); // 드라이버명
		conn = DriverManager.getConnection(url, dbId, dbPwd); // DB의 사용자 계정에 접속하여 커넥션 획득
		out.print("JDBC 드라이버가 연결되었습니다.");
		
	} catch(Exception e) {
		e.printStackTrace();
		out.print("JDBC 드라이버가 연결되지 않았습니다.");
	}
	
	%>
</body>
</html>