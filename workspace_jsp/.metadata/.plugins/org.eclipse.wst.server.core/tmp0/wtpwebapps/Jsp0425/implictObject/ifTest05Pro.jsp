<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ifTest05Pro</title>
</head>
<body>
	<h2>참가자 취미 활용 보고서</h2>
	<%-- 해결시간:5분 --%>
	
	<%
	request.setCharacterEncoding("utf-8");
	
	String name = request.getParameter("name");
	// String hobby = request.getParameter("hobby"); -> 값을 하나만 받을 때 사용 
	String[] hobbies = request.getParameterValues("hobby"); // 여러 값을 배열로 받아옴
	
	// 1번 방법 - out 내장객체
	
	String txt = "";
	for (int i = 0; i < hobbies.length; i++) {
		txt += hobbies[i];
		if (i < hobbies.length - 1) {
			txt += ", ";
		}
	}
	out.print(name + "님의 취미는 " + txt + "입니다.");
	
	%>
	
	
	<%-- 2번 방법 - 익스프레션 --%>
	<%
	String txt2 = "";
	for (int i = 0; i < hobbies.length; i++) {
		txt2 += hobbies[i];
		if (i < hobbies.length - 1) {
			txt2 += ", ";
		}
	}
	%>
	<%=name %>님의 취미는 <%=txt2 %>입니다.
</body>
</html>