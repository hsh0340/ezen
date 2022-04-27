<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>requestTest01Pro</title>
</head>
<body>
	<h2>학생 정보를 처리하는 페이지</h2>
	
	<%
	request.setCharacterEncoding("utf-8");
	String no = request.getParameter("no");
	String name = request.getParameter("name");
	String grade = request.getParameter("grade");
	String subject = request.getParameter("subject");
	%>
	<table>
	<tr><th>학번</th><th>이름</th><th>학년</th><th>선택과목</th></tr>
	<tr><td><%=no %></td><td><%=name %></td><td><%=grade %></td><td><%=subject %></td></tr>
	</table>
	
</body>
</html>