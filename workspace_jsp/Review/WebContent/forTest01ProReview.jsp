<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table {
		border: 1px solid black;
		border-collapse: collapse;
	}
	
	tr {
		height: 40px;
	}
	
	th {
		background: lightgray;
	}
	
	td {
		text-align: center;
	}
	
	th, td {
		border: 1px solid black;
		width: 200px;
	}
</style>
</head>
<body>
	<p>처리페이지</p>
	<% 	
	int dan = Integer.parseInt(request.getParameter("dan"));
	%>
	
	<table>
	<tr><th><%=dan %>단</th></tr>
	<%
	for (int i = 1; i < 10; i++) {
	%>
	<tr><td><%=dan %> X <%=i %> = <%=dan * i %></td></tr>
	<%	
	}
	%>
	</table>
	<hr>
	
	<table>
	<tr><th><%=dan %>단</th></tr>
	<%for (int i = 1; i < 10; i++) {
		out.print("<tr><td>" + dan + " X " + i + " = " + dan * i + "</td></tr>");
	}%>
	</table>
</body>
</html>