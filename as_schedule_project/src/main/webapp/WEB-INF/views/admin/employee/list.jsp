<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 목록</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<style>

body {
	background-color: #0d0d0d;
	color: white;
	padding: 0px;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	padding: 2rem;
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
}

.pagination-wrapper {
	display: flex;
	justify-content: center;
	align-items: center;
	margin-top: 1rem;
}

.pagination-wrapper ul {
	list-style: none;
	padding: 0;
	margin: 0;
	display: flex;
	gap: 0.5rem;
}

.pagination-wrapper li a {
	display: inline-block;
	padding: 0.5rem 0.75rem;
	border-radius: 5px;
	text-decoration: none;
}


form.search-form {
	margin-bottom: 1rem;
	width: 100%;
	max-width: 880px;
}

form.search-form select, form.search-form input[type="text"] {
	border: 2px solid #134d2f;
	border-radius: 4px;
	padding: 8px 12px;
	font-size: 16px;
	background-color: white;
	color: #000;
	height: 40px;
}

form.search-form select:focus {
	outline: none;
	box-shadow: none;
	border: 2px solid #134d2f;
}

form.search-form input:focus {
	outline: none;
	box-shadow: none;
	border: 2px solid #134d2f;
}

form.search-form input[type="submit"] {
	background-color: #134d2f;
	color: white;
	border: none;
	padding: 10px 20px;
	font-size: 16px;
	border-radius: 4px;
	cursor: pointer;
	height: 40px;
}

form.search-form input[type="submit"]:hover {
	background-color: #0f3e26;
}

.pagination-wrapper li a {
	color: black; /* 기본 텍스트 색상 */
	transition: background-color 0.2s ease;
}

.pagination-wrapper li a.active {
	background-color: #39664d;
	color: white !important;
	font-weight: bold;
	border: 1px solid #39664d;
}
</style>
<link href="/resources/css/include/include.css" rel="stylesheet"/>
</head>
<body>

<%@ include file="/WEB-INF/views/include/nav.jsp" %>

	<div class="container">
		<h3>📋직원 목록</h3>

		<div class="board-wrapper">

			<!-- 검색창 -->
			<form action="<c:url value='/admin/employee/list' />" method="get"
				class="search-form d-flex align-items-center justify-content-start"
				style="width: 100%; max-width: 880px; margin: 0 auto 1rem auto;">
				<select name="type" class="form-select me-2" style="width: 150px;">
					<option value="ename" ${param.type == 'ename' ? 'selected' : ''}>이름</option>
					<option value="eno" ${param.type == 'eno' ? 'selected' : ''}>직원번호</option>
					<option value="position"
						${param.type == 'position' ? 'selected' : ''}>직급</option>
				</select> <input type="text" name="keyword" placeholder="검색어 입력"
					value="${param.keyword}" class="form-control me-2"
					style="flex-grow: 1; min-width: 0;" /> <input type="submit"
					value="검색" class="btn btn-primary" />
			</form>


			<!-- 테이블 -->
			<table class="table table-hover">
				<thead>
					<tr>
						<th>직원번호</th>
						<th>이름</th>
						<th>직급</th>
						<th>연락처</th>
						<th>고용일</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty employeeList}">
						<tr>
							<td colspan="5" style="text-align: center; color: black;">검색결과가
								없습니다.</td>
						</tr>
					</c:if>
					<c:forEach var="emp" items="${employeeList}">
						<tr class="clickable-row" data-href="<c:url value='/admin/employee/detail?eno=${emp.eno}' />">
							<td>${emp.eno}</td>
							<td>${emp.ename}</td>
							<td>${emp.position}</td>
							<td>${emp.ephone}</td>
							<td><fmt:formatDate value="${emp.hiredate}" pattern="yyyy-MM-dd" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<!-- 해당 <td>클릭시 이벤트 script -->
			<script>
			// domcontentload
			document.addEventListener("DOMContentLoaded", function(){
				// .clickable-row 클래스를 가진 모든 <tr> 요소를 찾아 rows에 저장
				const rows = document.querySelectorAll(".clickable-row");
				// rows 안에 있는 각 <tr> 요소에 대해 하나씩 반복
				rows.forEach(row => {
					// 각각의 <tr>에 클릭 이벤트 리스너를 추가
					row.addEventListener("click", () =>{
						// data-href 링크로 이동
						window.location.href = row.dataset.href;
					})
				})
			})
			</script>

			<!-- 페이징 + 등록버튼 -->
			<div class="pagination-wrapper">
				<div>
					<c:if test="${not empty employeeList && totalPage > 1}">
						<nav>
							<ul>
								<c:if test="${hasPrev}">
									<li><a
										href="?page=${startPage - 1}&type=${param.type}&keyword=${param.keyword}">이전</a></li>
								</c:if>

								<c:forEach var="i" begin="${startPage}" end="${endPage}">
									<li id="numPaging"><a
										href="?page=${i}&type=${param.type}&keyword=${param.keyword}"
										class="${i == currentPage ? 'active' : ''}"> ${i} </a></li>
								</c:forEach>

								<c:if test="${hasNext}">
									<li><a
										href="?page=${endPage + 1}&type=${param.type}&keyword=${param.keyword}">다음</a></li>
								</c:if>
							</ul>
						</nav>
					</c:if>
				</div>
			</div>

			<div style="text-align: right;">
				<button class="btn-write"
					onclick="location.href='<c:url value='/admin/employee/register' />'">등록</button>
				<button class="btn-write" 
					onclick="location.href='<c:url value='/admin/index' />'">홈</button>
			</div>

		</div>
	</div>
</body>
</html>
