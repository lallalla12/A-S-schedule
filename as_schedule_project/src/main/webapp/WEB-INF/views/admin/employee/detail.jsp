<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>기사접수 내역</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<style>
body {
	background-color: #0d0d0d;
	color: white;
	padding: 2rem;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

h2 {
	text-align: center;
	margin-bottom: 2rem;
	color: #ffffff;
}

.board-wrapper {
	background-color: #fff;
	border-radius: 12px;
	padding: 30px 60px;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
	color: #000;
	box-sizing: border-box;
	max-width: 1000px;
	margin: 0 auto;
}

table {
	width: 100%;
	margin: 0;
	background-color: white;
	border-collapse: collapse;
}

thead th {
	background-color: #f0f0f0 !important;
}

th, td {
	padding: 12px 14px !important;
	text-align: center;
	border-bottom: 1px solid #ccc;
}

tbody tr:hover {
	background-color: #f9f9f9;
	cursor: pointer;
}

.btn-write {
	background-color: #39664d;
	border: none;
	color: white;
	border-radius: 20px;
	font-weight: 500;
	width: 100px;
	height: 30px;
	margin-left:10px;
	margin-top:20px;
}


.check {
	background-color: #39664d;
	border: none;
	color: white;
	border-radius: 5px;
	font-weight: 500;
	width: 80px;
	height: 40px;
	margin-left: 10px;
}

.finishbtn {
	background-color: #A9A9A9;
	border: none;
	color: white;
	border-radius: 5px;
	font-weight: 500;
	width: 80px;
	height: 40px;
	margin-left: 10px;
}

/* 팝업창 스타일 */
#reviewPopup {
	display: none;
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	background: #fff;
	color: #000;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
	z-index: 1000;
	max-width: 500px;
	width: 90%;
	max-height: 70vh;
	overflow-y: auto;
}

#popupBackground {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.6);
	z-index: 999;
}

#reviewPopup h4 {
	margin-bottom: 1rem;
}

#reviewList {
	max-height: 50vh;
	overflow-y: auto;
	border: 1px solid #ccc;
	padding: 10px;
	background: #f9f9f9;
	color: #000;
	border-radius: 5px;
}

#reviewList p {
	margin-bottom: 0.8rem;
	padding-bottom: 0.5rem;
	border-bottom: 1px solid #ddd;
}

form.search-form {
	margin-bottom: 1rem;
	width: 100%;
	max-width: 1000px; /* 테이블과 같은 최대 너비 */
	display: flex; /* 가로 정렬 */
	gap: 10px; /* 입력창과 버튼 사이 간격 */
}

form.search-form select {
	border: 2px solid #134d2f;
	border-radius: 4px;
	padding: 8px 12px;
	font-size: 16px;
	background-color: white;
	color: #000;
	height: 50px;
}

form.search-form input[type="text"] {
	border: 2px solid #134d2f;
	border-radius: 4px;
	padding: 8px 12px;
	font-size: 16px;
	background-color: white;
	color: #000;
	height: 50px;
}

form.search-form input[type="submit"] {
	background-color: #134d2f !important;
	color: white;
	border: none;
	padding: 0 20px;
	font-size: 16px;
	border-radius: 4px;
	cursor: pointer;
	height: 50px;
	flex-shrink: 0; /* 크기 줄어들지 않도록 */
}

#gum {
	background-color: #134d2f;
	height: 50px;
}

.form-control {
	width: 650px !important;
}

.search-form select:focus, .search-form input[type="text"]:focus {
	outline: none;
	box-shadow: none;
	border-color: #134d2f !important;
}

#finishbtn{
	background-color: #134d2f;
}

#reviewPopup {
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background: #fff;
  padding: 25px 30px;
  border-radius: 12px;
  box-shadow: 0 6px 18px rgba(0, 0, 0, 0.15);
  max-width: 420px;
  width: 90%;
  display: none;
  color: #222;
  font-family: 'Noto Sans KR', sans-serif;
  line-height: 1.5;
  user-select: none;
}

#reviewPopup h4 {
  margin-bottom: 18px;
  font-weight: 700;
  font-size: 1.6rem;
  border-bottom: 2px solid #134d2f;
  padding-bottom: 8px;
  color: #134d2f;
}

#reviewList {
  max-height: 300px;
  overflow-y: auto;
  border: 1px solid #ddd;
  border-radius: 8px;
  padding: 15px 20px;
  background-color: #f7f9fc;
  font-size: 1rem;
  color: #444;
}

#reviewList p {
  margin-bottom: 1rem;
  border-bottom: 1px solid #eee;
  padding-bottom: 8px;
}

#closePopup {
  background-color: #134d2f;
  color: white;
  border: none;
  padding: 10px 24px;
  border-radius: 25px;
  cursor: pointer;
  font-weight: 600;
  transition: background-color 0.2s ease;
}




</style>

<link href="/resources/css/include/include.css" rel="stylesheet" />
</head>
<body>
	<%@ include file="/WEB-INF/views/include/nav.jsp"%>

	<div class="container mt-5">
		<h2>기사접수 내역</h2>
		<div class="board-wrapper">

			<form action="<c:url value='/admin/employee/searchCustomer' />"
				method="get"
				class="search-form d-flex align-items-center justify-content-start">
				<input type="hidden" name="eno" value="${eno}" /> <select
					name="searchField" class="form-select" style="width: 150px;">
					<option value="proname"
						<c:if test="${type == 'proname'}">selected</c:if>>제품명</option>
					<option value="issue"
						<c:if test="${type == 'issue'}">selected</c:if>>고장증상</option>
					<option value="username"
						<c:if test="${type == 'username'}">selected</c:if>>고객명</option>
				</select> <input type="text" name="keyword" class="form-control"
					placeholder="검색어를 입력하세요" style="width: 300px;" />
				<button type="submit" class="btn btn-primary" id="gum">검색</button>
			</form>

			<table>
				<thead>
					<tr>
						<th width="10%">고객명</th>
						<th width="10%">제품명</th>
						<th width="10%">모델명</th>
						<th width="20%">고장증상</th>
						<th width="15%">접수일자</th>
						<th width="15%">종료일자</th>
						<th width="10%">진행상태</th>
						<th width="10%">후기</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="item" items="${customerList}">
						<tr>
							<td>${item.username}</td>
							<td>${item.proname}</td>
							<td>${item.model}</td>
							<td>${item.issue}</td>
							<td><fmt:formatDate value="${item.visitdate}"
									pattern="yyyy.MM.dd (E) " />${item.visittime}</td>
							<td><c:choose>
									<c:when test="${empty item.visitend}">
                                -
                            </c:when>
									<c:otherwise>
										<fmt:formatDate value="${item.visitend}"
											pattern="yyyy.MM.dd (E)" />
									</c:otherwise>
								</c:choose></td>

							<td>
								<c:choose>
									<c:when test="${item.prostatus eq 'P'}"><span style="font-weight:bold; color:#da6264;">진행</span></c:when>
									<c:when test="${item.prostatus eq 'F'}"><span style="font-weight:bold; color:#330066;">완료</span></c:when>
								</c:choose>
							</td>
							<td><c:choose>
									<c:when test="${item.prostatus eq 'F'}">
										<button type="button" class="finishbtn btn btn-success btn-sm"
											id="finishbtn" data-eno="${param.eno}"
											data-cnum="${item.cnum}" data-proname="${item.proname}"
											data-username="${item.username}">후기</button>
									</c:when>
									<c:otherwise>
										<button type="button" class="check btn btn-secondary btn-sm"
											disabled>후기</button>
									</c:otherwise>
								</c:choose></td>
						</tr>
					</c:forEach>
					<c:if test="${empty customerList}">
						<tr>
							<td colspan="8">접수된 내역이 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<div style="text-align: right;">
			<button class="btn-write" 
					onclick="location.href='<c:url value='/admin/employee/list' />'">목록</button>
			</div>
		</div>
	</div>

	<!-- 후기 리스트 팝업 -->
	<div id="reviewPopup">
		<h4>후기 리스트</h4>
		<div>
			<strong>고객명:</strong> <span id="popupUsername"></span>
		</div>
		<div>
			<strong>제품명:</strong> <span id="popupProname"></span>
		</div>
		<hr />
		<div id="reviewList">후기가 없습니다.</div>
		<div style="text-align: right; margin-top: 10px;">
			<button id="closePopup" class="btn btn-secondary btn-sm">닫기</button>
		</div>
	</div>
	<div id="popupBackground"></div>
	<script src="/resources/js/jquery-3.7.1.min.js"></script>
	<script>
    // 후기 버튼 클릭 시
    document.querySelectorAll('.finishbtn').forEach(button => {
        button.addEventListener('click', () => {
            const eno = button.dataset.eno;
            const cnum = button.dataset.cnum;
            const username = button.dataset.username;
            const proname = button.dataset.proname;

            document.getElementById('popupUsername').textContent = username;
            document.getElementById('popupProname').textContent = proname;
            const $reviewListDiv = $('#reviewList');
            $reviewListDiv.text("후기 로딩 중...");

            // AJAX로 후기 리스트 요청 (아래 URL, 파라미터, 응답 형식은 서버 구현에 맞게 변경 필요)
            $.ajax({
                url: '/admin/review/list/',
                method: 'GET',
                dataType: 'json',
                data: { eno : eno, cnum : cnum },
                success: function(data) {
                    if (data.length === 0) {
                        $('#reviewList').text("등록된 후기가 없습니다.");
                        return;
                    }
                    $reviewListDiv.empty();
                    data.forEach(function(review) {
                    	const html = "<p>별점 : " + review.star + "점" + "<br />" + "상세후기 : "+ review.comment + "</p>"
                        //const html = `<p>(${review.star}):<br>${review.comment}</p>`;
                        $reviewListDiv.append(html);
                    });
                },
                error: function(xhr, status, error) {
                    $('#reviewList').text("후기 불러오기 실패");
                    console.error(error);
                }
            });

            // 팝업 및 배경 보이기
            document.getElementById('reviewPopup').style.display = 'block';
            document.getElementById('popupBackground').style.display = 'block';
        });
    });

    // 팝업 닫기
    document.getElementById('closePopup').addEventListener('click', () => {
        document.getElementById('reviewPopup').style.display = 'none';
        document.getElementById('popupBackground').style.display = 'none';
    });

    // 배경 클릭 시 팝업 닫기
    document.getElementById('popupBackground').addEventListener('click', () => {
        document.getElementById('reviewPopup').style.display = 'none';
        document.getElementById('popupBackground').style.display = 'none';
    });
</script>
</body>
</html>
