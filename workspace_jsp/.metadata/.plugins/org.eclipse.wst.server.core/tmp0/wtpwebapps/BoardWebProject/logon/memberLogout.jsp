<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>log out</title>
</head>
<body>
	<%
	/*
	< 세션 삭제 방법 2가지 >
	- session.invalidate(); 모든 세션 무효화(삭제)
	- session.removeAttribute(세션이름); 세션 이름에 해당하는 세션만 삭제
	*/
	
	
	/*
	내가 한 방법 - 세션이 null이 아니면 null로 바꿔줌 
	String memberId = (String)session.getAttribute("memberId");
	if (memberId != null) {
		memberId = null;
	*/
	
	session.removeAttribute("memberId");
	
	%>
	<script>
	alert('로그아웃 하였습니다.');
	location = 'memberLoginForm.jsp';
	</script>	
</body>
</html>