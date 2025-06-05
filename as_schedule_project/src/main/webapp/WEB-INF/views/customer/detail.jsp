<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AS 접수 상세내용</title>
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
	    $('#datepicker').datepicker('setDate', $('#datepicker').val()); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
	 })
	 
	 function disableAllTheseDays(date) {
          var day = date.getDay();
          return [(day != 0 && day != 6)]; // 0=일, 6=토 => 안나오게 할 것 
     }
	 
	function selectTime(button, time) {
		if (document.getElementById("selectedTime").dataset.disabled === "true") return;
	    // 모든 버튼에서 selected 클래스 제거
	    document.querySelectorAll('.time-button').forEach(btn => {
	        btn.classList.remove('selected');
	    });

	    // 클릭한 버튼에 selected 클래스 추가
	    button.classList.add('selected');

	    // hidden input에 선택된 시간 값 저장
	    document.getElementById('selectedTime').value = time;
	}

	//제출 validation
	function validateForm(form) {
	    let selectedTime = form.selectedTime;
	    if(selectedTime.value.trim() === '') {
	    	alert("시간을 선택해주세요.");
	    	selectedTime.focus();
	        return false;
	    }
	}
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
	<div class="container mt-5">
	<h3>AS 접수 상세</h3>
		<div class="board-wrapper">
			<form name="detailForm" id="detailForm" action="/customer/detailUpdate" method="post" onsubmit="return validateForm(this)">
				<input type="hidden" name="cnum" value="${customer.cnum}" />
				<h5 style="margin-bottom:20px;">제품 및 증상</h5>
				<table>
					<tr class="tr-gap">
						<td class="th">제품 분류</td>
						<td>
							${customer.proname }
						</td>
					</tr>
					<tr class="tr-gap">
						<td class="th">모델명</td>
						<td>${customer.model }</td>
					</tr>					
					<tr class="tr-gap">
						<td class="th">고장 증상</td>
						<td>
							${customer.issue }
						</td>
					</tr>
					<tr class="tr-gap">
						<td class="th">세부 증상</td>
						<td>${customer.detail }</td>
					</tr>					
					<tr>
						<td class="th">희망 방문 일시</td>
						<td>
							<fmt:formatDate value="${customer.visitdate}" var="formattedDate" pattern="yyyy-MM-dd" />
							<input type="text" id="datepicker" name="visitdate" value="${formattedDate}" ${customer.prostatus eq 'F' ? 'disabled' : ''}/>
						</td>
					</tr>					
					<tr>
						<td class="th">희망 방문 시간</td>
						<td>
							<c:if test="${customer.prostatus eq 'F'}">
								<input type="text" value="${customer.visittime }" readonly />
							</c:if>
							<c:if test="${customer.prostatus eq 'W' or customer.prostatus eq 'P'}">
							<div id="time-buttons">
							    <c:forEach var="i" begin="9" end="17">
							        <c:set var="timeStr" value="${i}:00" />
							        <button 
							            type="button" 
							            class="time-button ${timeStr == customer.visittime ? 'selected' : ''}" 
							            onclick="selectTime(this, '${timeStr}')" data-disabled="${customer.prostatus eq 'F'}">
							            ${timeStr}
							        </button>
							    </c:forEach>
							</div>
							<input type="hidden" name="visittime" id="selectedTime" value="${customer.visittime}" />
							</c:if>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<c:if test="${customer.prostatus eq 'W' or  customer.prostatus eq 'P'}">
								<input type="submit" class="btn-write" value="수정하기" />
							</c:if>
							<input type="button" class="btn-write" value="홈으로"  onclick="location.href='/customer/index';"/>
						</td>
					</tr>					
				</table>
			</form>
		</div>
	</div>
</body>
</html>