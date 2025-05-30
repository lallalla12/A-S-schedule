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
<style>
.time-button {
    padding: 8px 12px;
    margin: 3px;
    background-color: #eee;
    border: 1px solid #ccc;
    cursor: pointer;
    border-radius: 4px;
}
.time-button.selected {
    background-color: #007bff;
    color: white;
    font-weight: bold;
}
</style>
<script src="/resources/js/jquery-3.7.1.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
	$(function(){
	    $('#datepicker').datepicker({
	    	dateFormat: 'yy-mm-dd' //달력 날짜 형태
			,changeYear: true //option값 년 선택 가능
	        ,changeMonth: true //option값  월 선택 가능
	    	,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
		        ,buttonImageOnly: true //버튼 이미지만 깔끔하게 보이게함
		        ,buttonText: "선택" //버튼 호버 텍스트              
		        ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
		        ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
		        ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
		        ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
		        ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
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
	    let cname = form.cname;
	    let cphone = form.cphone;
	    let model = form.model;
	    let address = form.address;
	    let unit = form.unit;
	    let selectedTime = form.selectedTime;
	    let yn = form.yn;
	    
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
	    if(yn.value.trim() === '') {
	    	alert("개인정보 이용에 동의해주세요.");
	    	yn.focus();
	    	return false;
	    }
	    
	}
</script>
</head>
<body>
<form name="registerForm" id="registerForm" action="/customer/register" method="post" onsubmit="return validateForm(this)">
	<h4>고객 정보 입력</h4>
	성명 : <input type="text" name="cname" id="cname" placeholder="성명을 입력해주세요." /><br />
	전화번호 : <input type="text" name="cphone" id="cphone" placeholder="숫자만 입력해주세요." /><br />
	주소 : 
	<input type="text" id="postcode" onclick="execDaumPostcode()" readonly placeholder="우편번호">
	<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
	<input type="text" id="address" name="address" placeholder="주소">
	<input type="text" id="unit" name="unit" placeholder="상세주소">
	
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
	                document.getElementById("unit").focus();
	            }
	        }).open();
	    }
	</script>
	<br />
	
	<h4>제품 및 증상 입력</h4>
	제품 분류 : 
	<select id="proname" name="proname">
		<c:forEach items="${productList }" var="product">
			<option>${product.proname}</option>
		</c:forEach> 
	</select>
	<br />
	모델명 : <input type="text" name="model" id="model" placeholder="모델명을 입력해주세요."/><br />
	고장 증상 :
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
	<br />
	세부 증상 : <textarea name="detail" id="detail" placeholder="세부증상을 입력해주세요."></textarea>
	<br />
	희망 방문 일시
	<input type="text" id="datepicker" name="visitdate" readonly /><br />
	<div id="time-buttons">
	    <c:forEach var="i" begin="9" end="17">
	        <button type="button" class="time-button" onclick="selectTime(this, '${i}:00')">${i}:00</button>
	    </c:forEach>
	</div>
	<input type="hidden" name="visittime" id="selectedTime" />
	<br />
	개인정보 이용에 동의해주세요.<input type="radio" name="yn" id="yn" value="1" />
	<input type="submit" value="접수하기" />
	<input type="button" value="홈으로"  onclick="location.href='/customer/index';"/>
</form>
</body>
</html>