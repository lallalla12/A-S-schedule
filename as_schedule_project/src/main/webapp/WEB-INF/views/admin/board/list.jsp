<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"> -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet" />
	  <link href="/resources/css/include/include.css" rel="stylesheet"/>
<style type="text/css">
.pull-right  ul, li {
	display: inline-block;
	text-align: center;
}

body {
	background-color: #0d0d0d;
	color: white;
	padding: 2rem;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

h3 {
	text-align: center;
	margin-bottom: 2rem;
	color: #ffffff;
}

.board-wrapper {
	background-color: #fff;
	border-radius: 12px;
	padding: 1rem;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
	color: #000;
	box-sizing: border-box;
	max-width: 1000px;
	margin: 0 auto;
}

.pagenum {
	margin: 5px;
}

.btn-write {
	margin: 10px;
	float: right;
	background-color: #39664d;
	border: none;
	color: white;
	border-radius: 20px;
	font-weight: 500;
	width: 100px;
	height: 36px;
}

table {
	width: 100%;
	margin: 0;
	background-color: white;
	border-collapse: collapse;
}

table a {
	text-decoration: none;
	color: black;
}

thead {
	background-color: #f0f0f0;
}

th, td {
	padding: 1rem;
	text-align: center;
	border-bottom: 1px solid #ccc;
}

tbody tr:hover {
	background-color: #f9f9f9;
	cursor: pointer;
}

.table-title {
	font-weight: bold;
	color: #333;
}

/* css 추가 */
#input_keyword {
	width: 73%;
	padding: 12px 20px;
	margin: 8px 0px 2px 0px;
	box-sizing: border-box;
	border: 2px solid #39664d;
	border-radius: 4px;
}

#select_type {
	width: 15%;
	padding: 12px 20px;
	margin: 8px 0px 2px 0px;
	box-sizing: border-box;
	border: 2px solid #39664d;
	border-radius: 4px;
}

#search_btn {
	width: 10%;
	padding: 15px 20px;
	font-size: 14px;
	background-color: #39664d;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	transition: background-color 0.3s;
	margin-top: 5px;
}

#search_form select, #search_form input[type="text"], #search_form input[type="submit"]
	{
	height: 50px; /* 원하는 높이로 통일 */
	vertical-align: middle; /* 요소들 수직 중앙 정렬 */
	font-size: 14px;
	box-sizing: border-box; /* 패딩, 보더가 높이에 포함되도록 */
}

/* #numPaging  a {
		text-decoration : none;
		background-color: #39664d;
		margin : 10px;
		color: white;
		padding : 6px 10px;
	} */

/* 현재 페이지 스타일 */
#numPaging.active-page a {
	background-color: #39664d;
	color: #fff;
	font-weight: bold;
}

#numPaging a {
	text-decoration: none;
	margin: 10px 0px;
	color: black;
	padding: 6px 10px;
	border-radius: 4px;
}

.clearfix::after {
	content: "";
	display: table;
	clear: both;
}

.btn-write:hover {
	background-color: #39664d; /* 기존 색 그대로 유지 */
	color: white; /* 글자색도 유지 */
	box-shadow: none;
	filter: none;
	text-decoration: none;
}
</style>
<meta charset="UTF-8">
<title>공지사항</title>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
	<div class="container mt-5">
		<h3>📋 공지사항</h3>
		<div class="board-wrapper">
			<form action="/admin/board/list" id="search_form" method="get">
				<div class="pagenum">
					<input type="hidden" value="${pageMaker.cri.pageNum}"
						name="pageNum"> <input type="hidden"
						value="${pageMaker.cri.amount}" name="amount"> <select
						name="type" id="select_type">
						<option value="T">제목</option>
						<option value="C">내용</option>
					</select> <input type="text" name="keyword" id="input_keyword"
						value="${keyword }"> <input type="submit" id="search_btn"
						value="검색">
				</div>
			</form>
			<table>
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${not empty list }">
						<c:forEach items="${list}" var="board">
							<tr>
								<td style="font-weight: bold;">${board.rownum}</td>

								<td><a href="/admin/board/get?bno=${board.bno}">${board.title}</a></td>

								<td>${board.writer}</td>

								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${board.regdate}" /></td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty list }">
						<tr>
							<td colspan="4">등록된 게시글이 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<div style="text-align: center; margin-top: 20px;">
				<ul class="pull-right">
					<c:if test="${pageMaker.prev}">
						<li><a
							href="/admin/board/list?pageNum=${pageMaker.startPage -1}
						&amount=${pageMaker.cri.amount}&type=${pageMaker.cri.type}
						&keyword=${pageMaker.cri.keyword}">Previous</a>
						</li>
					</c:if>

					<c:forEach var="num" begin="${pageMaker.startPage }"
						end="${pageMaker.endPage }">
						<li id="numPaging"
							<c:if test="${num == pageMaker.cri.pageNum}">class="active-page"</c:if>>
							<a
							href="/admin/board/list?pageNum=${num}
				      &amount=${pageMaker.cri.amount}&type=${pageMaker.cri.type}
				      &keyword=${pageMaker.cri.keyword}">${num}</a>
						</li>
					</c:forEach>


					<c:if test="${pageMaker.next}">
						<li><a
							href="/admin/board/list?pageNum=${pageMaker.endPage +1}
						&amount=${pageMaker.cri.amount}&type=${pageMaker.cri.type}
						&keyword=${pageMaker.cri.keyword}">Next</a>
						</li>
					</c:if>
				</ul>
			</div>
			<div class="clearfix">
				<button class="btn btn-write" onclick="location.href='/admin/index'">홈</button>
				<button class="btn btn-write"
					onclick="location.href='/admin/board/write'">글쓰기</button>
			</div>
		</div>
	</div>
</body>
</html>