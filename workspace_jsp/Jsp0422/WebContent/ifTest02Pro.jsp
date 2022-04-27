<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ifTest02Pro</title>
</head>
<body>
    <h2>성년 판별 처리 페이지</h2>
    
    <%
    // post 방식으로 데이터를 전달할 때 한글이 깨지는 문제를 해결
    request.setCharacterEncoding("utf-8"); 
    String name = request.getParameter("name");
    int age = Integer.parseInt(request.getParameter("age"));
    %>
    
    <%-- 1번 방법 --%>
    <%if (age >= 20) {%>
	    <%=name %>님은 성년입니다.
	<%} else {%>
		<%=name %>님은 미성년입니다.
	<%}%>
	<hr>
	
	<%-- 2번 방법 --%>
	<%
	if (age >= 20) {
		out.print(name + "님은 성년입니다.");
	} else {
		out.print(name + "님은 미성년입니다.");
	}
	%>
</body>
</html>