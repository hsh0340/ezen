<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 폼</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Paytone+One&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Paytone+One&display=swap');

#container {
	width: 450px;
	margin: 0 auto;
}

a {
	text-decoration: none;
	color: black;
}

/* 상단 메인, 서브 타이틀*/
.m_title {
	font-family: 'Paytone One', sans-serif;
	font-size: 3em;
	text-align: center;
}

.s_title {
	font-family: 'Hammersmith One', sans-serif;
	font-size: 2em;
	text-align: center;
	margint-bottom: 30px;
}

/* 중단 입력창 */
.f_input {
	margin-top: 40px;
	text-align: center;
	border: 1px solid #ccc;
	padding: 10px;
}

.f_input .c_id, .f_input .c_pwd {
	height: 45px;
	margin-top: 20px;
	padding-left: 5px;
}

.f_input .f_chk {
	text-align: left;
	margin-top: 20px;
	font-size: 0.9em;
	color: gray;
}

.f_input #btn_login {
	width: 426px;
	height: 47px;
	background-color: black;
	color: white;
	font-size: 16px;
	font-weight: bold;
	cursor: pointer;
	margin-top: 25px;
	margin-bottom: 10px;
}

/* 하단 - 비밀번호 찾기, 아이디 찾기, 회원가입 */
.f_a {
	text-align: center;
	margin-top: 30px;
	font-size: 0.9em;
}

.f_a a {
	color: gray;
}
</style>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		let form = document.loginForm;
		
		// 로그인 버튼을 클릭했을 때 
		let btn_login = document.getElementById("btn_login");
		btn_login.addEventListener("click", function() {
			if (!form.id.value) {
				alert(`아이디를 입력하시오!`);
				form.id.focus();
				return;
			} 
			
			if (!form.pwd.value) {
				alert(`비밀번호를 입력하시오!`);
				form.pwd.focus();
				return;
			} 
			
			form.submit();
		})
		
		// 쿠키가 생성되어 있을 때 쿠키에 저장된 값인 id를 input에 넣어놓기
		if (document.cookie.length > 0) {
			// 쿠키가 존재한다면
			let search = "cookieId="; // 이미 쿠키가 여러개가 있고, 내가 생성한 쿠키의 위치를 찾는 것임
			let idx = document.cookie.indexOf(search); // 쿠키 중에서 'cookieId='가 나오는 위치를 리턴. 없으면 -1
			if (idx != -1) {
				// cookieId가 존재한다면
				idx += search.length // 'c'부터 'cookieId='의 길이를 더함 -> value의 첫번째 글자 위치 찾음
				let end = document.cookie.indexOf(';', idx); // idx(value 첫글자)부터 세미콜론 전까지
				
				if (end == -1) {
					end = document.cookie.length;
				}
				form.id.value = document.cookie.substring(idx, end); // idx부터 세미콜론 전까지
				form.chk.checked = true;
			}
			
		} 
		
		/*
		 로그인 상태 유지 체크박스를 체크했을 때 -> cookie
		 
		http 속성: 연결 상태를 유지하지 않음.
		
		cookie, session : 연결 상태를 유지함.
		- cookie : 연결정보를 클라이언트 쪽에 저장
		- session : 연결정보를 서버쪽에 저장
		
		escape() 함수 : *, -, _, +, ., / 를 제외한 모든 문자를 16진수로 변환하는 함수
		- 쉼표, 세미콜론등과 같은 문자가 쿠키에서 사용되는 문자열과 충돌을 방지하기 위해서 사용
		*/
		
		let chk = document.getElementById("chk");
		chk.addEventListener("click", function() {
			let now = new Date(); // 오늘 날짜
			let name = 'cookieId'; // 쿠키 이름
			let value = form.id.value; // 쿠키의 값 설정
			
			if(form.chk.checked) {
				// 체크박스를 체크했을 때
				// 쿠키를 생성하고, 만료시간을 설정해야함
				now.setDate(now.getDate() + 7) // 만료시간을 지금으로부터 7일 후로 설정 	
			} else {
				// 체크박스를 해제했을 때
				// 쿠키를 삭제
				now.setDate(now.getDate()); // 현 시점의 시간을 넣음
			}
			
			document.cookie = name + "=" + escape(value) + ";path=/;expires=" + now.toGMTString() + ";"; 
			// 쿠키 생성시에 필요한 정보 - 쿠키의 이름과 값, 위치, 만료시간
			// 쿠키는 DOM객체로 만듦. name과 값으로 구성
			// name : 이름, escape(value) : 값, ;path=/; : 패스, expires= + now.toGMTString(): 만료정보
		})
		
		
	})
	
</script>

</head>
<body>
	<div id="container">
		<div class="m_title">
			<a href="#">EZEN MALL</a>
		</div>
		<div class="s_title">LOGIN</div>

		<form action="memberLoginPro.jsp" method="post" name="loginForm">
			<div class="f_input">
				<div class="f_id">
					<input type="text" id="id" name="id" class="c_id" placeholder="아이디"size="55">
				</div>
				<div class="f_pwd">
					<input type="password" id="pwd" name="pwd" class="c_pwd" placeholder="비밀번호" size="55">
				</div>
				<div class="f_chk">
					<input type="checkbox" id="chk" class="c_chk" size="55">&nbsp;
					<label for="chk">아이디 저장</label>
				</div>
				<div class="f_submit">
					<input type="button" value="로그인" id="btn_login">
				</div>
			</div>

			<div class="f_a">
				<a href="#">비밀번호 찾기</a>&emsp;|&emsp;<a href="#">아이디 찾기</a>&emsp;|&emsp;
				<a href="../member/memberJoinForm.jsp">회원가입</a>
			</div>
		</form>
	</div>
</body>
</html>