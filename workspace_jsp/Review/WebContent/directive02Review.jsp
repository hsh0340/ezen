<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	String name = "sleepy";
	%>
	<hr>
	<%@ include file="directive02_topReview.jsp" %>
	<hr>
	<h2>메인 페이지</h2>
	<p>메인 페이지임</p>
	<hr>
	<%@ include file="directive02_bottomReview.jsp" %>
</body>
</html>