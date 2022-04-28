<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>참가자 취미 활용 보고서</h2>
	
	<%
	request.setCharacterEncoding("utf-8");
	String name = request.getParameter("name");
	String[] hobbies = request.getParameterValues("hobby"); // getParameterValues : 여러값을 받아올 때
	
	String txt= "";
	for (int i = 0; i < hobbies.length; i++) {
		txt += hobbies[i];
		if (i < hobbies.length - 1) {
			txt += ", ";
		}
	}
	out.print(name + "님의 취미는 " + txt + "입니다.");
	%>
</body>
</html>