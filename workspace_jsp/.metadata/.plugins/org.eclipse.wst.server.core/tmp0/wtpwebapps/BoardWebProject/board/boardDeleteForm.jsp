<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 삭제 폼</title>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Paytone+One&display=swap');

@import
	url('https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap');

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
	height: 50px;
}

td, th {
	border: 1px solid black;
}

th {
	background: #ced4da;
}

td {
	padding-left: 5px;
}

#subject {
	height: 23px;
}

.c_text {
	padding: 5px 0 5px 5px;
}

.c_id {
	color: #1e94be;
	font-weight: bold;
}

/* 본문 */
.c_login {
	border: 1px solid black;
	margin-top: 20px;
	padding: 20px;
}

.c_login label {
	display: inline-block;
	margin-right: 30px;
	width: 65px;
	text-align: right;
	font-weight: bold;
}

.c_login div {
	margin: 30px auto;
	text-align: center;
	
}

.c_writer input {
	background-color: #dee2e6;
}

.c_login input {
	width: 280px;
	height: 40px;
}	


/* 하단 - 버튼 */
.btns {
	text-align: center;
	margin-top: 30px;
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
		
		let form = document.deleteForm;
		
		let btn_delete = document.getElementById("btn_delete");
		btn_delete.addEventListener("click", function() {
			if (!form.pwd.value) {
				alert('비밀번호를 입력하시오.');
				form.pwd.focus();
				return;
			}
			
			let answer = confirm('글을 삭제하겠습니까?');
			
			if (answer) {
				form.submit();
			} else {
				return;
			}
			
		})
		
		let btn_boardList = document.getElementById("btn_boardList");
		btn_boardList.addEventListener("click", function() {
			location = "boardList.jsp";
		})
		
		
	})
	
</script>
</head>
<body>

<%
request.setCharacterEncoding("utf-8");

// 세션 없으면 로그인폼으로 돌리기
String memberId = (String)session.getAttribute("memberId");
if (memberId == null) {
	out.print("<script>location = '../logon/memberLoginForm.jsp';</script>");
}

int num = Integer.parseInt(request.getParameter("num"));


%>
<div id="container">
	
		<div class="m_title">
			<a href="boardList.jsp">EZEN MALL</a>
		</div>
		<div class="s_title">글 삭제</div>
		
		<form action="boardDeletePro.jsp" method="post" name="deleteForm">
			<input type="hidden" name="num" value="<%=num%>">
			
			<div class="c_login">
				<div class="c_writer">
					<label>작성자</label><input type="text" name="writer" id="writer" value="<%=memberId %>" readonly><br>
				</div>
				<div class="c_pwd">
					<label>비밀번호</label><input type="password" name="pwd" id="pwd">
				</div>
				
			</div>
			
			<div class="btns">
				<input type="button" value="글 삭제" id="btn_delete">&emsp;&emsp;
				<input type="button" value="게시글 보기" id="btn_boardList">
			</div>
		
		</form>
	
</div>
</body>
</html>