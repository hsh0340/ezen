<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Timestamp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Top Page</title>
</head>
<body>
	<h3>Top Page</h3>
	<%
	Timestamp now = new Timestamp(System.currentTimeMillis());
	%>
	<%=now.toString()%> <!-- 익스프레션은 세미콜론 붙이면 안됨 -->
</body>
</html>