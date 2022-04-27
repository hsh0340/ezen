<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ifTest02Form</title>
</head>
<%--
문제) 이름과 나이를 폼페이지에서 입력하고, 처리 페이지에서는 그 결과를 출력하도록 작성하시오.
나이는 20세 이상을 성년, 20세 미만은 미성년

< 입력 페이지 >
이름: 박서준
나이: 35

< 결과 페이지 >
박서준님은 성년입니다.
 --%>
<body>
	<h2>성년 판별 폼 페이지</h2>
	<form action="ifTest02Pro.jsp" method="post"> <!-- post방식으로 하면 한글이 깨짐 -->
	이름 : <input type="text" name="name"><br>
	나이 : <input type="text" name="age"><br>
	<input type="submit" value="입력완료">
	</form>
</body>
</html>