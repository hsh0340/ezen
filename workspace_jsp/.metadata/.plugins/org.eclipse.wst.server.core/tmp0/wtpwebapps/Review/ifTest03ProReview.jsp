<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>처리페이지</h2>
	
	<%
	request.setCharacterEncoding("utf-8"); 
	String name = request.getParameter("name");
	String local = request.getParameter("local");
	String tel1 = request.getParameter("tel");
	String tel2 = "";
	
	if (local.equals("서울")) {
		tel2 = "02";
	} else if (local.equals("경기도")) {
		tel2 = "031";
	} else if (local.equals("강원")) {
		tel2 = "033";
	} else if (local.equals("충남")) {
		tel2 = "041";
	} else if (local.equals("충북")) {
		tel2 = "043";	
	} else if (local.equals("전남")) {
		tel2 = "061";
	} else if (local.equals("전북")) {
		tel2 = "063";
	} else if (local.equals("경남")) {
		tel2 = "055";
	} else if (local.equals("경북")) {
		tel2 = "054";
	}
	%>
	<%=name %>님의 전화번호는 <%=tel2 %>) <%=tel1 %>입니다.
	<%out.print(name + "님의 전화번호는" + tel2 + ")" + tel1 + "입니다.");%>
</body>
</html>