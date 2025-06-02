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
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.17/index.global.min.js'></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<script>
document.addEventListener('DOMContentLoaded', function() {
	var calendarEl = document.getElementById('calendar');
	//customer 데이터
	var eventsData=[
		<c:forEach items="${schedule}" var="sche" varStatus="status">
			{
				title: '${sche.username }',
				start: '${sche.visitDateTime}',
				extendedProps: {
					addr: '${sche.address}',
					addrDetail: '${sche.detail}'
				}
			}<c:if test="${!status.last}">,</c:if>
		</c:forEach>
	];

	var calendar = new FullCalendar.Calendar(calendarEl, {
		themeSystem: 'bootstrap5',
        locale: 'ko',
		//initialDate : '2023-01-12', //없애면 오늘 날짜
		nowIndicator: true,
		editable : true,
		selectable : true,
		businessHours : true,
		dayMaxEvents : true, // allow "more" link when too many events
		events : eventsData,

		eventClick : function(info) {
			const start = info.event.start;
			const timeStr = start.toLocaleTimeString('ko-KR', {
				hour : '2-digit',
				minute : '2-digit',
				hour12 : false
			});

			document.getElementById("cus").innerText = info.event.title;
			document.getElementById("time").innerText = timeStr;
			document.getElementById("addr").innerText = info.event.extendedProps.addr;
			document.getElementById("addrDetail").innerText = info.event.extendedProps.addrDetail;
		}
	});

	calendar.render();
});
</script>
<style>
    body {
      background-color: #0d0d0d;
      color: white;
    }
  .fc {
    font-family: 'Segoe UI', 'Apple SD Gothic Neo', sans-serif;
  }

  .fc-toolbar-title {
    font-size: 1.5rem;
    font-weight: bold;
  }

  .fc-button {
    font-size: 0.9rem;
  }

  .fc-event {
    font-size: 0.85rem;
    padding: 2px 4px;
  }

a{
    text-decoration: none;
    color: white;
}

.fc-day-sun a {
    color: #f86a61 !important;
  }

  /* 토요일 텍스트 파란색 */
  .fc-day-sat a {
    color: #578df9 !important;
  }

  .fc .fc-non-business {
  background: none !important;
}

.fc-daygrid-event-dot {
  border-color: #5fd1b9 !important; /* 원하는 색상 (예: 녹색) */
}

#calendar {
	max-width: 1100px;
	margin: 0 auto;
}

.fc .fc-button {
  background-color: #29c76f;
  border: none
}

.fc .fc-button:hover {
  background-color: #25b163;
  border: none;
}

.fc .fc-button:active {
  background-color: #1f9553;
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