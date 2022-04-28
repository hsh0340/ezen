<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>참가자 직업조사 완료</h2>

<%
request.setCharacterEncoding("utf-8");
String name = request.getParameter("name");
String job = request.getParameter("job");
out.print(name + "의 직업은 " + job + "입니다.");
%>

</body>
</html>