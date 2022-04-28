<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>처리페이지</h2>
	
	<%
	request.setCharacterEncoding("utf-8");
	String name = request.getParameter("name");
	int age = Integer.parseInt(request.getParameter("age"));
	
	if (age >= 20) {
		out.print(name + "님은 성인입니다.");
	} else {
		out.print(name + "님은 성인이 아닙니다.");
	}
	%>
	
	<%if (age >= 20) { %>
		<%=name %>님은 성인입니다.
	<%} else {%>
		<%=name %>님은 성인이 아닙니다.
	<%} %>
</body>
</html>