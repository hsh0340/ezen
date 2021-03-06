<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 상세보기</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Paytone+One&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap');

#container {
	width: 500px;
	margin: 0 auto;
}

a {
	text-decoration: none;
	color: black;
}

/* 상단 - 메인, 서브 타이틀 */

.m_title {
	font-family: 'Paytone One', sans-serif;
	font-size: 3em;
	text-align: center;
}

.s_title {
	font-family: 'Do Hyeon', sans-serif;
	font-size: 2em;
	text-align: center;
	margint-bottom: 80px;
}
	
/* 본문 - 테이블 */

table {
	width: 100%;
	border: 1px solid black;
	border-collapse: collapse;
}

tr {
	height: 40px;
}

td, th {
	border: 1px solid black;
}

th {
	background: #ced4da;
}

td {
	vertical-align: top;
	padding: 5px;
}

.content_row {
	height: 300px;
}

/* 하단 - 버튼 */
.btns {
	text-align: center;
	margin-top: 20px;
}

.btns input {
	width: 100px;
	height: 35px;
	border: none;
	background: black;
	color: white;
	cursor: pointer;
	transition: .3s;
}

.btns input:hover {
	background: white;
	border: 1px solid gray;
	color: black;
}


</style>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		let form = document.contentForm;
		let num = form.num.value;
		let btn_update = document.getElementById("btn_update");
		let btn_delete = document.getElementById("btn_delete");
		
		// 로그인 한 회원이 글 작성자와 같지 않으면 버튼 숨김
		if (form.id.value != form.writer.value) {
			btn_update.style.display = "none";
			btn_delete.style.display = "none";
		}
		
		// 글 수정 버튼을 클릭할 때
		btn_update.addEventListener("click", function() {
			location = "boardUpdateForm.jsp?num=" + num;	
		})
		
		// 글 삭제 버튼을 클릭할 때
		btn_delete.addEventListener("click", function() {
			location = "boardDeleteForm.jsp?num=" + num;
		})
		
		// 댓글 작성 버튼을 클릭할 때
		let btn_review = document.getElementById("btn_reivew");
		
		
		// 전체 게시글 버튼을 클릭할 때
		let btn_boardList = document.getElementById("btn_boardList");
		btn_boardList.addEventListener("click", function() {
			location = 'boardList.jsp';
		})
	})

</script>
</head>
<body>

<%
String memberId = (String)session.getAttribute("memberId");
if (memberId == null) {
	out.print("<script>location = '../logon/memberLoginForm.jsp'</script>");
}



request.setCharacterEncoding("utf-8");


int num = Integer.parseInt(request.getParameter("num"));

BoardDAO boardDAO = BoardDAO.getInstance();
BoardDTO board = boardDAO.getBoard(num);

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
%>
		
	<div id="container">
	
		<div class="m_title">
			<a href="boardList.jsp">EZEN MALL</a>
		</div>
		<div class="s_title">글 상세보기</div>
		
		<form action="" method="post" name="contentForm">
			<input type="hidden" name="num" value="<%=board.getNum() %>">
			<input type="hidden" name="id" value="<%=memberId %>"> <!-- 로그인한 멤버  -->
			<input type="hidden" name="writer" value="<%=board.getWriter() %>"> <!-- 작성자 -->
			<table>
				<tr>
					<th width="15%">글번호</th>
					<td width="85%"><%=board.getNum() %></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td><%=board.getWriter() %></td>
				</tr>
				<tr>
					<th>제목</th>
					<td><%=board.getSubject() %></td>
				</tr>
				<tr class="content_row">
					<th>내용</th>
					<td><%=board.getContent() %></td>
				</tr>
				<tr>
					<th>등록일</th>
					<td><%=sdf.format(board.getRegDate()) %></td>
				</tr>
				<tr>
					<th>조회수</th>
					<td><%=board.getReadcount() %></td>
				</tr>
			</table>
			<div class="btns">
				<input type="button" value="글 수정" id="btn_update">&ensp;
				<input type="button" value="글 삭제" id="btn_delete">&ensp;
				<input type="button" value="댓글 쓰기" id="btn_review">&ensp;
				<input type="button" value="게시글 보기" id="btn_boardList">
			</div>
		
		</form>
	
	</div>
	
	
	
</body>
</html>