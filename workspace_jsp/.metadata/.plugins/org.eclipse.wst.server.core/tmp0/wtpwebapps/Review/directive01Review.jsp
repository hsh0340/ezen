<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info="페이지디렉티브 - info" %>
<%@ page import="java.sql.Timestamp, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>디렉티브 연습</h1>
	<%=getServletInfo() %>
	<%
	Timestamp now = new Timestamp(System.currentTimeMillis());
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd");
	String str = sdf.format(now); 
	%>
	현재 날짜는 <%=str %>입니다.
</body>
</html>