<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Timestamp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>탑페이지임</h3>
	<%
	Timestamp now = new Timestamp(System.currentTimeMillis());
	%>
	<%=now.toString() %>
</body>
</html>