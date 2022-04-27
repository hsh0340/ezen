<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>beanTest02Pro</title>
</head>
<body>

	<h2>B 카페 로그인 처리</h2>
	<%request.setCharacterEncoding("utf-8"); %>
	
	<%-- 액션태그를 사용하는 방법 : 파라미터의 값을 한번에  --%>
	<%-- 1단계 : 객체 생성 --%>
	<jsp:useBean id="testBean" class="test.TestBean"/>
	
	<%-- 2단계: 값을 받아서 setProperty 값을 객체에 저장 --%>	
	<%-- property="*" : 프로퍼티로 넘어오는 모든 값을 받아서 객체에 저장한다. 
		주의 : 파라미터로 넘어오는 값의 이름과 개수가 프로퍼티의 이름과 개수가 일치해야한다. 자바빈의 멤버변수명&개수 같아야함 
	--%>
	
	<jsp:setProperty property="*" name="testBean"/> <%-- name에는 useBean의 아이디를 적어야함  --%>
	
	<%-- 3단계 : property에 저장된 값을 출력 --%>
	아이디 : <jsp:getProperty property="id" name="testBean"/><br>
	이름 : <jsp:getProperty property="name" name="testBean"/>
</body>
</html>