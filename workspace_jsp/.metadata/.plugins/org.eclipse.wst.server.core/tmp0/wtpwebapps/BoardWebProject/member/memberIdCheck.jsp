<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberIdCheck</title>
</head>
<body>
	<%
	// ID 중복 체크 처리 페이지
	String id = request.getParameter("id");
	
	MemberDAO memberDAO = MemberDAO.getInstance(); // 싱글톤 객체라서 new로 못만듦
	int cnt = memberDAO.checkId(id); // 액션태그에서 만든걸로 바로 사용 가능 사용중이면 0
	%>

	<script>
	<%if (cnt == 1) {%>
	<%-- 가입 가능한 아이디 --%>
		alert('사용 가능한 아이디 입니다.');
		
	<%} else { %> 
	<%-- 이미 사용중인 아이디 --%>
		alert(`이미 사용중인 아이디입니다.\n다른 아이디를 입력해주세요.`);		
		
	<%}%>
	history.back();
	</script>
	
	
	<%--
	 
	String id = request.getParameter("id");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "SELECT * FROM member WHERE id = ?";
	
	try {
		conn = JDBCUtil.getConnection();	
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();
		
		out.print("<script>");
		
		if (rs.next()) {
			// 아이디가 있다면 실행 (다음데이터가 있음)
			// 사용할 수 없는 아이디
			out.print("alert(`이미 사용중인 아이디입니다.\n다른 아이디를 입력해주세요.`);");
		} else {
			// 아이디가 없다 (다음데이터가 없음)
			// 사용할 수 있는 아이디
			out.print("alert(`사용 가능한 아이디 입니다.`);");
		}
		
		out.print("history.back()");
		out.print("</script>");	
	} catch(Exception e) {
		e.printStackTrace();
		
	} finally {
		JDBCUtil.close(conn, pstmt, rs);
	}
	*/
	
	
	%>
	 --%>
	 
	
</body>
</html>