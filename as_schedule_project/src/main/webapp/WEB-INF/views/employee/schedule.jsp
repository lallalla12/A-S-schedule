<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.17/index.global.min.js'></script>
<script>
	document.addEventListener('DOMContentLoaded', function() {
		var calendarEl = document.getElementById('calendar');

		var calendar = new FullCalendar.Calendar(calendarEl, {
			locale: 'ko',
			initialDate : '2023-01-12', //없애면 오늘 날짜
			//nowIndicator: true,
			editable : true,
			selectable : true,
			businessHours : true,
			dayMaxEvents : true, // allow "more" link when too many events
			events : [ {
				title : '이름',
				start : '2023-01-12T14:30:00',
				backgroundColor:"#bfd9fa"
			}, {
				title : '이름',
				start : '2023-01-12T17:30:00'
			}, {
				title : '이름',
				start : '2023-01-12T20:00:00'
			}, {
				title : '이름',
				start : '2023-01-13T07:00:00'
			}, {
				title : 'Click for Google',
				url : 'http://google.com/',
				start : '2023-01-28'
			} ],

			eventClick : function(info) {
				const start = info.event.start;
				const timeStr = start.toLocaleTimeString('ko-KR', {
					hour : '2-digit',
					minute : '2-digit',
					hour12 : false
				});

				document.getElementById("cus").innerText = info.event.title;
				document.getElementById("time").innerText = timeStr;
				document.getElementById("addr").innerText = '주소';
				document.getElementById("addrDetail").innerText = '상세주소';
			}
		});

		calendar.render();
	});
</script>
<style>
body {
	margin: 40px 10px;
	padding: 0;
	font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
	font-size: 14px;
}

#calendar {
	max-width: 1100px;
	margin: 0 auto;
}

.fc .fc-button {
  background-color: #bfd9fa;
  color: #fff;
  border: none
}

.fc .fc-button:hover {
  background-color: #84bafc;
  color: #fff;
  border: none;
}
</style>
</head>
<body>
	<div>
		<div id='calendar'></div>

		<div>
			고객: <span id="cus"></span> <br> 시간: <span id="time"></span> <br>
			주소: <span id="addr"></span> <br> 세부주소: <span id="addrDetail"></span>
			<br>
		</div>

		<div id="map" style="width: 600px; height: 350px;"></div>
	</div>
	
	<c:forEach items="${schedule}" var="sche">
		<p>${sche.cname }</p>
	</c:forEach>
	
	
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c0188c27d8674de540884bb9ebc03fc1"></script>
	<script>
		var mapContainer = document.getElementById('map');
		var mapOption = {
			center : new kakao.maps.LatLng(33.542094, 129.339453), // 초기 중심
			level : 3
		};

		var map = new kakao.maps.Map(mapContainer, mapOption);

		// 임의 지정 위치
		var fixedPosition = new kakao.maps.LatLng(35.542094, 129.339453);
		var fixedMarker = new kakao.maps.Marker({
			position : fixedPosition,
			map : map,
			title : "목적지"
		});

		// 현재 위치 가져오기
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(function(position) {
				var lat = position.coords.latitude;
				var lon = position.coords.longitude;

				var currentPosition = new kakao.maps.LatLng(lat, lon);

				var currentMarker = new kakao.maps.Marker({
					position : currentPosition,
					map : map,
					title : "현재 위치"
				});

				// 두 위치 기준으로 지도 중심 이동
				var bounds = new kakao.maps.LatLngBounds();
				bounds.extend(currentPosition);
				bounds.extend(fixedPosition);
				map.setBounds(bounds);
			}, function(error) {
				alert("현재 위치를 가져올 수 없습니다.");
			});
		} else {
			alert("이 브라우저는 Geolocation을 지원하지 않습니다.");
		}
	</script>
</body>
</html>