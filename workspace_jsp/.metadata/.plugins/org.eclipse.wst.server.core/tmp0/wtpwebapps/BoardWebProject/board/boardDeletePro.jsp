<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 삭제 처리</title>
</head>
<body>

<%
	request.setCharacterEncoding("utf-8");
	int num = Integer.parseInt(request.getParameter("num"));
	String writer = request.getParameter("writer");
	String pwd = request.getParameter("pwd");
	
	BoardDAO boardDAO = BoardDAO.getInstance();
	int cnt = boardDAO.deleteBoard(num, writer, pwd);
	
	// cnt : 1 이면 삭제 성공, 0이면 삭제 실패
%>


<script>
<%if (cnt > 0) { %>
	alert('글이 삭제되었습니다.');
<% } else {%>
	alert('글이 삭제되지 않았습니다.');
<%} %>
location = "boardList.jsp";
</script>
</body>
</html>