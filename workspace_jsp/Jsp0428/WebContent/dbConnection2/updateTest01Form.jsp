<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#container {
		width: 400px;
		margin: 20px auto;
	}
	
	h2 {
		text-align: center;
		margin-bottom: 30px;
	}
	
	p {
		text-align: center;
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
	
	.d_in span {
		display: block;
		text-align: center;
		color: blue;
		font-weight: bold;
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
		
		<h2>회원정보 수정 폼</h2>
		<p>회원의 이름과 나이 정보를 수정합니다.</p>
		
		<form action="updateTest01Pro.jsp" method="post">
			<div class="d_in">
				<label for="id">아이디</label>
				<input type="text" id="id" name="id">
			</div>
			<div class="d_in">
				<label for="pwd">비밀번호</label>
				<input type="password" id="pwd" name="pwd">
			</div>
			<div class="d_in"><span>수정할 이름과 나이를 입력하시오.</span></div>
			<div class="d_in">
				<label for="name">이름</label>
				<input type="text" id="name" name="name">
			</div>
			<div class="d_in">
				<label for="age">나이</label>
				<input type="text" id="age" name="age">
			</div>
			<div class="btns">
				<input type="submit" value="입력 완료">&ensp;&ensp;
				<input type="reset" value="삭제">			
			</div>
		</form>
	
	</div>
</body>
</html>