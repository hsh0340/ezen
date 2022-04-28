<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<p>전화번호를 입력하셩</p>
	<form action="ifTest03ProReview.jsp" method="post">
	이름 : <input type="text" name="name"><br>
	전화번호 :
	<select name="local">
		<option value="서울">서울</option>
		<option value="경기도">경기도</option>
		<option value="강원도">강원도</option>
		<option value="충남">충남</option>
		<option value="충북">충북</option>
		<option value="전남">전남</option>
		<option value="전북">전북</option>
		<option value="경남">경남</option>
		<option value="경북">경북</option>
	</select>
	<input type="text" name="tel"><br>
	<input type="submit" value="입력완료">
	</form>
</body>
</html>