<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="test.TestBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>beanTest01Pro</title>
</head>
<%--
1. 자바의 클래스를 사용하는 방법
(1) 단수명 사용, Simple Name(SN)
import java.util.Date;

// 클래스의 main 메소드 안에서
Date now = new Date();

(2) 완전 수식명 사용, Full Qualified Name(FQN)
java.util.Date now = new java.util.Date()
 --%>
<body>
	<h2>A 커뮤니티 로그인 처리</h2>
	
	<%request.setCharacterEncoding("utf-8"); %>
	
	<%-- 1번 - JSP의 액션태그를 사용하는 기본 방법 --%>
	<%-- TestBean 객체 생성 --%>
	<jsp:useBean id="testBean" class="test.TestBean"></jsp:useBean><%-- id : 인스턴스이름, class : 패키지명을 포함한 파일명 --%>
	
	<%-- TestBean 객체에 property 값을 넣음 --%>
	<jsp:setProperty property="id" name="testBean"/>
	<jsp:setProperty property="name" name="testBean"/> <%-- 값을 받아와서 넣음 --%>
	
	<%-- TestBean 객체의 property 값을 받음, getter 메소드 호출 --%>
	<%-- 
	아이디 : <jsp:getProperty property="id" name="testBean"/><br>
	이름 : <jsp:getProperty property="name" name="testBean"/>
	--%>
	아이디 : <%=testBean.getId() %>
	이름 : <%=testBean.getName() %>
	
	 <%
	 // 2번 - 자바의 방법 
	 TestBean testBean2 = new TestBean();
	 
	 String id = request.getParameter("id");
	 String name = request.getParameter("name");
	 
	 testBean2.setId(id);
	 testBean2.setName(name);
	 
	 out.print("아이디 : " + testBean2.getId() + "<br>이름 : " + testBean2.getName());
	 %>
	
</body>
</html>