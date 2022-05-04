<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴(삭제)</title>
</head>
<body>

	<% request.setCharacterEncoding("utf-8");%>
	<jsp:useBean id="member" class="member.MemberDTO"/>
	<jsp:setProperty property="*" name="member"/>
	
	<%	
	MemberDAO memberDAO = MemberDAO.getInstance();
	int cnt = memberDAO.deleteMember(member.getId(), member.getPwd()); // 삭제 되면 cnt = 1
	%>
	
	<script>
	<%if (cnt == 0) {%>
		// delete 실패
		alert('회원 탈퇴 실패');
		history.back();
	<%} else {%>
		// delete 성공
		alert('회원 탈퇴');
		location = '../logon/memberLoginForm.jsp';
	<%}%>
	</script>
</body>
</html>