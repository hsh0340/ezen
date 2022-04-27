<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>clubUserPro</title>
<style>
	table {
		border: 1px solid black;
		border-collapse: collapse;
	}
	
	tr {
		height: 35px;
	}
	
	th {
		background: #ccc;
	}
	
	td {
		text-align: center;
	}
	
	th, td {
		border: 1px solid black;
		width: 200px;
	}
</style>
</head>
<body>

	<h2>G 클럽 사용자 정보 처리 확인</h2>
	<%request.setCharacterEncoding("utf-8"); %>

	<%-- 1단계 : 객체 생성 --%>
	<jsp:useBean id="clubUser" class="test.ClubUser" />
	
	<%-- 2단계 : setProperty --%>
	<jsp:setProperty property="*" name="clubUser" />

	<table>
		<tr><th>아이디</th><td><jsp:getProperty property="id" name="clubUser" /></td></tr>
		<tr><th>비밀번호</th><td><jsp:getProperty property="pwd" name="clubUser" /></td></tr>
		<tr><th>이름</th><td><jsp:getProperty property="name" name="clubUser" /></td></tr>
		<tr><th>클럽명</th><td><jsp:getProperty property="clubname" name="clubUser" /></td></tr>
		<tr><th>나이</th><td><jsp:getProperty property="age" name="clubUser" /></td></tr>
		<tr><th>전화번호</th><td><jsp:getProperty property="tel" name="clubUser" /></td></tr>
		<tr><th>이메일</th><td><jsp:getProperty property="email" name="clubUser" /></td></tr>
		<tr><th>주소</th><td><jsp:getProperty property="addr" name="clubUser" /></td></tr>
	</table>


</body>
</html>