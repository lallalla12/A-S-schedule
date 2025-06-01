<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<style>
@import url("https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/static/pretendard.css");
	body {
      background-color: #0d0d0d;
      color: white;
      padding: 2rem;
      font-family: 'Segoe UI', Tahoma, G
      eneva, Verdana, sans-serif;
    }
    h3 {
      text-align: center;
      margin-bottom: 2rem;
      color: #ffffff;
    }
   	.board-wrapper {
      background-color: #fff;
      border-radius: 12px;
      padding: 30px 60px;
      box-shadow: 0 0 20px rgba(0,0,0,0.3);
      color: #000;
      box-sizing: border-box;
      
      max-width : 500px;
      margin : 0 auto;
   	}
   	table {
      width: 100%;
      margin: 0;
      background-color: white;
      border-collapse: collapse;
    }
   	.btn-write {
      margin : 10px;
      float : right;
      background-color: #29c76f;
      border: none;
      color: white;
      border-radius: 20px;
      font-weight: 500;
      width : 100px;
      height : 30px;
    }
    
    /* 로그인화면 */
    .login-tabs {
	  display: flex;
	  gap: 10px;
	}
	
	.tab-btn {
	  padding: 10px 20px;
	  cursor: pointer;
	  background: #ddd;
	  border: none;
	  border-radius: 4px 4px 0 0;
	  font-weight: bold;
	}
	
	.tab-btn.active {
	  background: #39664d;
	  color: white;
	}
	
	.tab-content {
	  display: none;
	  border: 1px solid #39664d;
	  padding: 20px;
	  border-radius: 0 4px 4px 4px;
	}
	
	.tab-content.active {
	  display: block;
	}
	
	input[type=text], input[type=password] {
	    width:100%;
	    padding:12px 20px;
	    margin: 8px 0px 2px 0px;
	    box-sizing: border-box;
	    border : 2px solid #39664d;
	    border-radius: 4px;
	}
	
	input[type=submit] {
		width:100%;
	    padding: 15px 20px;
	    font-size: 14px;
	    background-color: #39664d;
	    color: white;
	    border: none;
	    border-radius: 4px;
	    cursor: pointer;
	    transition: background-color 0.3s;
	    margin-top:5px;
	}
	
	input[type=button] {
		width:100%;
	    padding: 15px 20px;
	    font-size: 14px;
	    background-color: #000;
	    color: white;
	    border: none;
	    border-radius: 4px;
	    cursor: pointer;
	    transition: background-color 0.3s;
	    margin-top:30px;
	}
	
	#signupBtn {
	  margin-top: 10px;
	  padding: 15px 20px;
	  background-color: #330066;
	  color: white;
	  border: none;
	  border-radius: 4px;
	  cursor: pointer;
	  width : 100%;
	}
</style>
<c:if test="${not empty message}">
    <script>
        alert("${message}");
    </script>
</c:if>
<script>
	function validateForm(form) {
		if (!form.id.value || !form.password.value) {
		    alert("아이디와 비밀번호를 입력하세요.");
		    return false;
		}
	}
</script>
</head>
<body>
	<div class="container mt-5">
		<h3>로그인</h3>
		<div class="board-wrapper">
			<div class="login-tabs">
				<button class="tab-btn active" data-target="admin">관리자</button>
				<button class="tab-btn" data-target="driver">기사</button>
				<button class="tab-btn" data-target="customer">고객</button>
			</div>
			
			<div class="tab-content active" id="admin">
				<form name="adm_loginForm" action="/admin/login" method="post" onsubmit="return validateForm(this)">
					<input type="hidden" name="gubun" value="adm" />
			    	<!-- 관리자 로그인 폼 -->
			    	<input type="text" id="admin_id" name="id" placeholder="관리자 아이디" /><br />
			    	<input type="password" id="admin_pass" name="password" placeholder="비밀번호" /><br />
			    	<input type="submit" value="로그인" />
				</form>
			</div>
			
			<div class="tab-content" id="driver">
				<form name="emp_loginForm" action="/employee/login" method="post" onsubmit="return validateForm(this)">
					<input type="hidden" name="gubun" value="emp" />
			    	<!-- 기사 로그인 폼 -->
			    	<input type="text" id="emp_id" name="id" placeholder="기사 아이디" /><br />
			    	<input type="password" id="emp_pass" name="password" placeholder="비밀번호" /><br />
			    	<input type="submit" value="로그인" />
				</form>
			</div>
			
			<div class="tab-content" id="customer">
				<form name="ctm_loginForm" action="/customer/login" method="post" onsubmit="return validateForm(this)">
					<input type="hidden" name="gubun" value="ctm" />
				    <!-- 고객 로그인 폼 -->
				    <input type="text" id="user_id" name="id" placeholder="고객 아이디" /><br />
				    <input type="password" id="user_password" name="password" placeholder="비밀번호" /><br />
					<input type="submit" value="로그인" />
				</form>
				<button id="signupBtn">회원가입</button>
			</div>
			<input type="button" id="main_btn" value="메인화면" onclick="location.href='/';">
		</div>
	</div>
</body>
<script>
const tabs = document.querySelectorAll('.tab-btn');
const contents = document.querySelectorAll('.tab-content');

tabs.forEach(tab => {
  tab.addEventListener('click', () => {
    // 탭 활성화 토글
    tabs.forEach(t => t.classList.remove('active'));
    tab.classList.add('active');

    // 콘텐츠 전환
    contents.forEach(c => c.classList.remove('active'));
    document.getElementById(tab.dataset.target).classList.add('active');
  });
});

// 회원가입 버튼 클릭 이벤트 (예: 모달 or 페이지 이동)
document.getElementById('signupBtn').addEventListener('click', () => {
	window.location.href = '/customer/join';
});
</script>
</html>