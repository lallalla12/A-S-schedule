<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AS 접수</title>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<style>
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
      background-color: #39664d;
      border: none;
      color: white;
      border-radius: 20px;
      font-weight: 500;
      width : 100px;
      height : 30px;
    }
</style>
<link href="/resources/css/include/include.css" rel="stylesheet"/>
<link type="text/css" rel="stylesheet" href="/resources/css/customer.css" />
<script src="/resources/js/jquery-3.7.1.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
	$(function(){
	    $('#datepicker').datepicker({
	    	dateFormat: 'yy-mm-dd' //달력 날짜 형태
			,changeYear: false //option값 년 선택 가능
	        ,changeMonth: false //option값  월 선택 가능
	    	,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
	        ,buttonImageOnly: true //버튼 이미지만 깔끔하게 보이게함
	        ,buttonText: "선택" //버튼 호버 텍스트              
	        ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
	        ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
	        ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
	        ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
	        ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
	        ,showMonthAfterYear: true
	        ,showButtonPanel: true
	        ,closeText: '닫기'
	        ,currentText: '오늘'
	    	,minDate: 0
	    	,maxDate: "+5y"
	    	,beforeShowDay : disableAllTheseDays
	    });
	    $('#datepicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
	 })
	 
	 function disableAllTheseDays(date) {
          var day = date.getDay();
          return [(day != 0 && day != 6)]; // 0=일, 6=토 => 안나오게 할 것 
     }
	 
	 function selectTime(button, time) {
        // 기존 선택 제거
        document.querySelectorAll('.time-button').forEach(btn => btn.classList.remove('selected'));
        
        // 현재 버튼만 선택
        button.classList.add('selected');
        
        // hidden input에 값 저장
        document.getElementById('selectedTime').value = time;
    }

	//제출 validation
	function validateForm(form) {
	    let model = form.model;
	    let selectedTime = form.selectedTime;
	    let yn = form.yn;
	    if (model.value.trim() === '') {
	        alert("모델명을 입력해주세요.");
	        model.focus();
	        return false;
	    }
	    if(selectedTime.value.trim() === '') {
	    	alert("시간을 선택해주세요.");
	    	selectedTime.focus();
	        return false;
	    }
	    if (!yn.checked) {
	        alert("개인정보 이용에 동의해주세요.");
	        yn.focus();
	        return false;
	    }
	}
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
	<div class="container mt-5">
	<h3>AS 접수</h3>
		<div class="board-wrapper">
			<form name="registerForm" id="registerForm" action="/customer/register" method="post" onsubmit="return validateForm(this)">
				<input type="hidden" name="uid" value="${userInfo.uid }" />
				<h5>고객 정보</h5>
				<table class="info-table">
					<tr>
						<td class="th">성명</td>
						<td>${userInfo.username }</td>
					</tr>
					<tr>
						<td class="th">전화번호</td>
						<td>${phone_formated }</td>
					</tr>
					<tr>
						<td class="th">주소</td>
						<td>${userInfo.address }</td>
					</tr>
					<tr>
						<td class="th">상세주소</td>
						<td>${userInfo.detail }</td>
					</tr>
				</table>
				<br />
				<h5>제품 및 증상을 입력해주세요.</h5>
				<table>
					<tr>
						<td class="th">제품 분류</td>
						<td>
							<select id="proname" name="proname">
								<c:forEach items="${productList }" var="product">
									<option>${product.proname}</option>
								</c:forEach> 
							</select>
						</td>
					</tr>
					<tr>
						<td class="th">모델명</td>
						<td><input type="text" name="model" id="model" placeholder="모델명을 입력해주세요."/></td>
					</tr>					
					<tr>
						<td class="th">고장 증상</td>
						<td>
							<select name="issue" id="issue">
							  <option value="전원이 안 켜짐">전원이 안 켜짐</option>
							  <option value="작동 중 멈춤">작동 중 멈춤</option>
							  <option value="소음이 심함">소음이 심함</option>
							  <option value="물 새는 현상">물 새는 현상</option>
							  <option value="이상한 냄새 발생">이상한 냄새 발생</option>
							  <option value="온도가 이상함">온도가 이상함</option>
							  <option value="디스플레이/화면 문제">디스플레이/화면 문제</option>
							  <option value="버튼/터치가 안됨">버튼/터치가 안됨</option>
							  <option value="설정이 초기화됨">설정이 초기화됨</option>
							  <option value="기타">기타</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="th">세부 증상</td>
						<td><textarea name="detail" id="detail" placeholder="세부증상을 입력해주세요."></textarea></td>
					</tr>					
					<tr>
						<td class="th">희망 방문 일시</td>
						<td><input type="text" id="datepicker" name="visitdate" readonly /></td>
					</tr>					
					<tr>
						<td class="th">희망 방문 시간</td>
						<td>
							<div id="time-buttons">
							    <c:forEach var="i" begin="9" end="17">
							        <button type="button" class="time-button" onclick="selectTime(this, '${i}:00')">${i}:00</button>
							    </c:forEach>
							</div>
							<input type="hidden" name="visittime" id="selectedTime" />
						</td>
					</tr>					
					<tr>
						<td colspan="2">
							<div class="agree-wrap">
						      <label for="yn" class="agree-label">
						        개인정보 이용에 동의합니다.
						        <input type="checkbox" name="yn" id="yn" value="1" />
						      </label>
						    </div>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<input type="submit" class="btn-write" value="접수하기" />
							<input type="button" class="btn-write" value="홈으로"  onclick="location.href='/customer/index';"/>
						</td>
					</tr>					
				</table>
			</form>
		</div>
	</div>
</body>
</html>