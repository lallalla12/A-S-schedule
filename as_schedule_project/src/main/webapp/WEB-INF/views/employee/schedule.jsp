<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.17/index.global.min.js'></script>
<script
	src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.17/index.global.min.js'></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
	const modalElement = document.getElementById('eventModal');
	let selectedAddr = ''; // 전역 주소 변수

	modalElement.addEventListener('shown.bs.modal', function () {
		map.relayout(); // 모달 열린 직후 지도 다시 그리기

		// 지도 위치 및 목적지 마커 세팅
		if (selectedAddr) {
			setBounds(selectedAddr, function([x, y]) {
				const link = document.getElementById("nav");
				if (link) {
					link.href = 'https://map.kakao.com/link/to/' + selectedAddr + ',' + y + ',' + x;
				}
			});
		}
	});

	const calendarEl = document.getElementById('calendar');

	// customer 데이터
	const eventsData = [
		<c:forEach items="${schedule}" var="sche" varStatus="status">
			{
				title: '${sche.username}',
				start: '${sche.visitDateTime}',
				extendedProps: {
					addr: '${sche.address}',
					addrDetail: '${sche.detail}',
					cnum: '${sche.cnum}'
				}
			}<c:if test="${!status.last}">,</c:if>
		</c:forEach>
	];

	const calendar = new FullCalendar.Calendar(calendarEl, {
		themeSystem: 'bootstrap5',
		locale: 'ko',
		nowIndicator: true,
		editable: true,
		selectable: true,
		businessHours: true,
		dayMaxEvents: true,
		events: eventsData,

		eventClick: function(info) {
			const start = info.event.start;
			const timeStr = start.toLocaleTimeString('ko-KR', {
				hour: '2-digit',
				minute: '2-digit',
				hour12: false
			});

			document.getElementById("cus").innerText = info.event.title;
			document.getElementById("time").innerText = timeStr;
			document.getElementById("addr").innerText = info.event.extendedProps.addr;
			document.getElementById("addrDetail").innerText = info.event.extendedProps.addrDetail;
			document.getElementById("cnum").value = info.event.extendedProps.cnum;

			// 선택된 주소를 저장 (모달 열린 후 setBounds에서 사용)
			selectedAddr = info.event.extendedProps.addr;

			// Bootstrap 5 모달 띄우기
			const modal = new bootstrap.Modal(modalElement);
			modal.show();
		}
	});

	calendar.render();
});
</script>

<style>
body {
	background-color: #0d0d0d;
	padding: 2rem;
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

a {
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
	border-color: #5fd1b9 !important;
}

#calendar {
	max-width: 1100px;
	margin: 0 auto;
	color: white;
	padding: 15px;
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

.fc .fc-popover {
	background: #252525;
}
</style>
</head>
<body>
	<div>
		<h3 style='color: white; text-align:center;'>일정</h3>
		<div id='calendar'></div>
	</div>
	
	<!-- 이벤트 상세 모달 -->
	<div class="modal fade" id="eventModal" tabindex="-1"
		aria-labelledby="eventModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content" style='width: 650px;'>
				<div class="modal-header">
					<h5 class="modal-title" id="eventModalLabel">상세내용</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="닫기"></button>
				</div>
				<div class="modal-body">
					<!-- 정보 -->
					<div style='text-align: center;'>
						<input type=hidden id="cnum">
						<p>
							<strong>이름:</strong> <span id="cus"></span>
						</p>
						<p>
							<strong>시간:</strong> <span id="time"></span>
						</p>
						<p>
							<strong>주소:</strong> <span id="addr"></span>
						</p>
						<p>
							<strong>세부주소:</strong> <span id="addrDetail"></span>
						</p>
					</div>

					<!-- 지도 -->
					<div id="map" style="width: 600px; height: 350px;"></div>

					<div class='mt-2'>
						<input type="date" id="endDate">
						<button class='btn btn-secondary' onclick='submitEndDate()'>종료</button>
					</div>
					<a href="#" id='nav' class='btn btn-success mt-2'>길찾기</a>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c0188c27d8674de540884bb9ebc03fc1&libraries=services"></script>
	<script>
		var deptPosition = null;
		var desMarker=null;
		var polyline=null;
		
		//마커 이미지
		var startImgSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/red_b.png';
		var arrImgSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/blue_b.png';
		var imageSize = new kakao.maps.Size(50, 45);
		
		var mapContainer = document.getElementById('map');
		var mapOption = {
			center : new kakao.maps.LatLng(35.907757, 127.766922), // 초기 중심
			level : 3
		};

		var map = new kakao.maps.Map(mapContainer, mapOption);

		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		
		function setBounds(addr, callback){
			// 주소로 좌표를 검색합니다
			geocoder.addressSearch(addr, function(result, status) {

				// 정상적으로 검색이 완료됐으면 
				if (status === kakao.maps.services.Status.OK) {
					const x=result[0].x;
					const y=result[0].y;
					
					var desPosition = new kakao.maps.LatLng(y, x);
					
					// 기존 목적지 마커 제거
					if (desMarker) {
						desMarker.setMap(null);
					}
					
					var arrMarkerImg = new kakao.maps.MarkerImage(arrImgSrc, imageSize);
					// 결과값으로 받은 위치를 마커로 표시합니다
					desMarker = new kakao.maps.Marker({
						map: map,
						position: desPosition,
						image: arrMarkerImg
					});
					
					// 두 위치 기준으로 지도 중심 이동
					var bounds = new kakao.maps.LatLngBounds();
					bounds.extend(deptPosition);
					bounds.extend(desPosition);
					map.setBounds(bounds);
					
					//makeRoute(); //경로 그리기
					makeRoute(desPosition);
					
					// x, y를 콜백으로 넘김
					callback([x, y]);
				} 
			});
		}
		
		function makeRoute(desPosition){
			// 선을 구성하는 좌표 배열입니다. 이 좌표들을 이어서 선을 표시합니다
			var linePath = [
				deptPosition,
				desMarker.getPosition()
			];
			
			// 기존 선 제거
			if(polyline){
				polyline.setMap(null);
			}

			// 지도에 표시할 선을 생성합니다
			polyline = new kakao.maps.Polyline({
			    path: linePath, // 선을 구성하는 좌표배열 입니다
			    strokeWeight: 5, // 선의 두께 입니다
			    strokeColor: '#29c76f', // 선의 색깔입니다
			    //strokeOpacity: 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
			    strokeStyle: 'solid' // 선의 스타일입니다
			});

			// 지도에 선을 표시합니다 
			polyline.setMap(map);
		}
		
		
		// 현재 위치 가져오기
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(function(position) {
				var lat = position.coords.latitude;
				var lon = position.coords.longitude;

				deptPosition = new kakao.maps.LatLng(lat, lon);
					
				var startMarkerImg = new kakao.maps.MarkerImage(startImgSrc, imageSize);
				var deptMarker = new kakao.maps.Marker({
					position : deptPosition,
					map : map,
					image: startMarkerImg
				});

				
			}, function(error) {
				alert("현재 위치를 가져올 수 없습니다.");
			});
		} else {
			alert("이 브라우저는 Geolocation을 지원하지 않습니다.");
		}
	</script>
	<script>
		function submitEndDate() {
			const customer = document.getElementById("cnum").value;
			const endDate = document.getElementById("endDate").value;
	
		  if (!customer || !endDate) {
		    alert("고객을 선택하고 날짜를 입력하세요.");
		    return;
		  }
	
		  // AJAX 요청
		  fetch('/customer/updateEndDate', {
		    method: 'POST',
		    headers: {
		      'Content-Type': 'application/json'
		    },
		    body: JSON.stringify({
		      cnum: customer,
		      endDate: endDate
		    })
		  })
		  .then(response => {
		    if (response.ok) {
		      alert("종료일이 저장되었습니다.");
		    } else {
		      alert("저장 실패");
		    }
		  });
		}

	</script>
</body>
</html>