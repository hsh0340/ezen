<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sessionTest01Pro</title>
</head>
<body>
	<h2>세션 정보 확인 페이지</h2>
	
	<%
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	
	// 세션으로 저장 - setAttribute 메소드 사용
	session.setAttribute("id", id);
	session.setAttribute("pwd", pwd);
	

	%>
	
	id와 pwd 값을 세션으로 저장하였습니다. <br>
	
	<%-- 세션의 값을 읽어올 때 - getAttribute 메소드 사용 --%>
	id의 값 : <%=session.getAttribute("id") %><br>
	pwd의 값 : <%=session.getAttribute("pwd") %>
</body>
</html>