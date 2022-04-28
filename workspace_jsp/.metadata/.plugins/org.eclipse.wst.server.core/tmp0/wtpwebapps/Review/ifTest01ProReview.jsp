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
	String strNumber = request.getParameter("number");
	int number = Integer.parseInt(strNumber);
	%>
	
	<%if (number > 0) { %>
		<%=number %>는 양수입니다.
	<%} else if (number < 0) {%>
		<%=number %>는 음수입니다.
	<%} else if (number == 0) { %>
		<%=number %>는 양수도 음수도 아닙니다.
	<%}%>
	
	<%
	if (number > 0) {
		out.print(number + "는 양수입니다.");
	} else if (number < 0) {
		out.print(number + "는 음수입니다.");
	} else if (number == 0) {
		out.print(number + "는 양수도 음수도 아닙니다.");
	}
	%>
</body>
</html>