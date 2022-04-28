<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>selectTest02Form</title>
<style>
	#container {
		width: 400px;
		margin: 20px auto;
	}
	
	p {
		text-align: center;
	}
	
	h2 {
		text-align: center;
		margin-bottom: 30px;
	}
	
	form {
		border: 1px solid black;
		padding: 10px;
	}
	
	.d_in {
		width: 100%;
		margin: 10px;
		padding: 10px;
	}
	
	.d_in label {
		display: inline-block;
		width: 80px;
		text-align: right;
		margin-right: 20px;
	}
	
	.d_in input[type="text"], .d_in input[type="password"] {
		width: 200px;
	}
	
	.btns {
		text-align: center;
		margin-top: 20px;
		padding-bottom: 10px;
	}
	
	.btns input {
		width: 100px;
		height: 35px;
		border: none;
		background-color: black;
		color: white;
		cursor: pointer;
		font-weight: bold;
	}
	
	.btns input:hover {
		background-color: white;
		color: black;
		border: 1px solid black;
	}
</style>
</head>
<body>
<div id="container">
		<h2>회원 정보 조회 폼</h2>
		<p>회원의 아이디와 비밀번호를 입력하시오.</p>
		<form action="selectTest02Pro.jsp" method="post">
			<div class="d_in">
				<label for="id">아이디</label>
				<input type="text" id="id" name="id">
			</div>
			<div class="d_in">
				<label for="pwd">비밀번호</label>
				<input type="password" id="pwd" name="pwd">
			</div>
			<div class="btns">
				<input type="submit" value="회원 조회">&ensp;&ensp;
				<input type="reset" value="삭제">			
			</div>
		</form>
	</div>
</body>
</html>