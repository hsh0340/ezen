<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>clubUserForm</title>
</head>
<body>
	
	<h2>G 클럽 사용자 정보 입력 폼</h2>
	
	<form action="clubUserPro.jsp" method="post">
		아이디 : <input type="text" name="id"><br>
		패스워드 : <input type="password" name="pwd"><br>
		이름 : <input type="text" name="name"><br>
		클럽명 : <input type="text" name="clubname"><br>
		나이 : <input type="text" name="age"><br>
		전화번호 : <input type="text" name="tel"><br>
		이메일 : <input type="text" name="email"><br>
		주소 : <input type="text" name="addr"><br>
		<input type="submit" value="입력완료">
	</form>
	
</body>
</html>