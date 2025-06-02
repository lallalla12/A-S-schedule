<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객 회원가입</title>
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
      
      max-width : 1000px;
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
</style>
<link type="text/css" rel="stylesheet" href="/resources/css/customer.css" />
<script src="/resources/js/jquery-3.7.1.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
	$(document).ready(function() {
		$("#userId").on("input", function() {
		    isIdAvailable = false; // 아이디가 바뀌면 다시 중복 확인 필요
		    document.getElementById("idCheck").innerText = "아이디 중복 확인이 필요합니다.";
		});
		
		$("#duplicateCheck").on("click", function(e) {
			let id = $("#user_id").val();
			if(id === "") {
                document.getElementById("idCheck").innerText = "아이디를 입력해주세요.";
                return;
        	}
			$.ajax({
		        url: "/customer/idCheck",
		        type: "GET",
		        data: { user_id: id },
		        dataType: "json",
		        success: function(result) {
		            if (result === 0) {
		                isIdAvailable = true;
		                $("#idCheck").text("사용 가능한 아이디입니다.");
		            } else {
		                isIdAvailable = false;
		                $("#idCheck").text("이미 사용 중인 아이디입니다.");
		            }
		        },
		        error: function(xhr, status, error) {
		            alert("중복체크오류");
		        }
		    });
		})
	})
	
	let isIdAvailable = false;
	
	function validateForm(form) {
		let userId = form.user_Id;
		let password = form.password;
		let cname = form.username;
	    let cphone = form.phone;
	    let address = form.address;
	    let unit = form.detail;
	    
	    let idRegx = /^(?=.*[a-zA-z]).{5,20}$/;
		if(userId.value === "") {
			document.getElementById("idCheck").innerHTML = "아이디를 입력해주세요.";
			userId.focus();
			return false;
		}
		if (!isIdAvailable) {
		    document.getElementById("idCheck").innerHTML = "아이디 중복 확인을 해주세요.";
		    userId.focus();
		    return false;
		}
		if(!idRegx.test(userId.value)) {
            document.getElementById("idCheck").innerHTML = "아이디는 영문자 조합으로 5~20자리까지 입력해주세요.";
            userId.focus();
            return false;
        }
		if (password.value.trim() === '') {
	        alert("비밀번호를 입력해주세요.");
	        password.focus();
	        return false;
	    }
	    let nameRegx = /^[ᄀ-ᄒᆨ-ᇂㄱ-ㅣ가-힣ᅡ-ᅵa-zA-Z0-9 !@#$%^&*()_+\-=[\]{};':"\\|,.<>/?]*$/gi;
	    if (cname.value.trim() === '') {
	        alert("성명을 입력해주세요.");
	        cname.focus();
	        return false;
	    }
	    if(!nameRegx.test(cname.value)) {
	    	alert("한글만 입력해주세요.");
	    	cname.focus();
            return false;
        }
	    let phoneRegx = /^0\d{8,10}$/;
	    if (cphone.value.trim() === '') {
	        alert("전화번호를 입력해주세요.");
	        cphone.focus();
	        return false;
	    }
	    if(!phoneRegx.test(cphone.value)) {
	    	alert("정확한 전화번호를 입력해주세요.");
	    	cphone.focus();
            return false;
        }
	    if (address.value.trim() === '') {
	        alert("주소를 입력해주세요.");
	        address.focus();
	        return false;
	    }
	    if (unit.value.trim() === '') {
	        alert("상세주소를 입력해주세요.");
	        unit.focus();
	        return false;
	    }
	}
</script>
</head>
<body>
	<div class="container mt-5">
		<h3>회원가입</h3>
		<div class="board-wrapper">
			<form id="joinForm" name="joinForm" method="post" action="/customer/join" onsubmit="return validateForm(this)">
			<table>
				<tr>
					<td class="th">아이디</td>
					<td>
					<div class="input-flex">
					<input type="text" id="user_id" name="user_id" placeholder="아이디를 입력해주세요." />
					<input type="button" value="중복검사" id="duplicateCheck"/>
					</div>
					<span class="spanCheck" id="idCheck"></span>
					</td>
				</tr>
				<tr>
					<td class="th">비밀번호</td>
					<td><input type="password" id="password" name="password" placeholder="비밀번호를 입력해주세요." /></td>
				</tr>
				<tr>
					<td class="th">성명</td>
					<td><input type="text" id="username" name="username" placeholder="성명을 입력해주세요." /></td>
				</tr>
				<tr>
					<td class="th">전화번호</td>
					<td><input type="text" id="phone" name="phone" placeholder="전화번호를 입력해주세요. (숫자만 입력)" /></td>
				</tr>
				<tr>
					<td class="th">주소</td>
					<td>
						<div class="input-flex">
						<input type="text" id="postcode" onclick="execDaumPostcode()" readonly placeholder="우편번호">
						<input type="button" id="findPostcode" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
						</div>
						<input type="text" id="address" name="address" placeholder="주소">
					</td>
				</tr>
				<tr>
					<td class="th">상세주소</td>
					<td><input type="text" id="detail" name="detail" placeholder="상세주소를 입력해주세요."></td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="button" class="btn-write" value="홈으로" onclick="location.href='/';" />
						<input type="submit" class="btn-write" value="가입하기" />
					</td>
				</tr>
			</table>
			<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
			<script>
			    function execDaumPostcode() {
			        new daum.Postcode({
			            oncomplete: function(data) {
			                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
			
			                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
			                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			                var addr = ''; // 주소 변수
			                var extraAddr = ''; // 참고항목 변수
			
			                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
			                    addr = data.roadAddress;
			                } else { // 사용자가 지번 주소를 선택했을 경우(J)
			                    addr = data.jibunAddress;
			                }
			
			                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
			                if(data.userSelectedType === 'R'){
			                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
			                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
			                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
			                        extraAddr += data.bname;
			                    }
			                    // 건물명이 있고, 공동주택일 경우 추가한다.
			                    if(data.buildingName !== '' && data.apartment === 'Y'){
			                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
			                    }
			                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
			                    if(extraAddr !== ''){
			                        extraAddr = ' (' + extraAddr + ')';
			                    }
			                }
			
			                // 우편번호와 주소 정보를 해당 필드에 넣는다.
			                document.getElementById('postcode').value = data.zonecode;
			                document.getElementById("address").value = addr;
			                // 커서를 상세주소 필드로 이동한다.
			                document.getElementById("detail").focus();
			            }
			        }).open();
			    }
			</script>
			</form>
		</div>
	</div>
</body>
</html>