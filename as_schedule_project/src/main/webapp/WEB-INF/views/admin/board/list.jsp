<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"> -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
	<style type="text/css">
	.pull-right  ul,li{
		display:inline-block;
		text-align : center;
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
      box-shadow: 0 0 20px rgba(0,0,0,0.3);
      color: #000;
      box-sizing: border-box;
    }
    
    .pagenum{
    	margin : 10px;
    }

    .btn-write{
      margin : 10px;
      float : right;
      background-color: #29c76f;
      border: none;
      color: white;
      border-radius: 20px;
      font-weight: 500;
    }

    table {
      width: 100%;
      margin: 0;
      background-color: white;
      border-collapse: collapse;
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
	</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%--<h3>게시판 목록 리스트</h3>
 	<table border="1"  width="80%" >
		<tr>
			<th width="5%">No.</th><th width="55%">제목</th><th width="10%">작성자</th><th width="10%">작성일자</th>
		</tr>
		<c:forEach items="${list}" var="board">
			<tr>
				<td style="text-align: center;">${board.bno}</td>
				
				<td><a href="/admin/get?bno=${board.bno}">${board.title}</a></td>
				
				<td style="text-align: center;">${board.writer}</td>
				
				<td style="text-align: center;"><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}" /></td>	
			</tr>
		</c:forEach>
		<tr>
			<td colspan="4"><a href="/admin/write">글쓰기</a></td>
		</tr>
	</table> --%>
	<div class="container mt-5">
    <h3>📋 공지사항</h3>
    <div class="board-wrapper">
    <form action="/admin/board/list" method="get">
    	<div class="pagenum">
			<input type="hidden" value="${pageMaker.cri.pageNum}" name="pageNum">
			<input type="hidden" value="${pageMaker.cri.amount}" name="amount">
			<select name="type">
				<option value="T">제목</option>
				<option value="C">내용</option>
				<option value="W">작성자</option>
			</select>
			
			<input type="text" name="keyword">
			<input type="submit" value="검색">
			
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
        	<c:forEach items="${list}" var="board">
          	<tr>
				<td>${board.rownum}</td>
			
				<td><a href="/admin/board/get?bno=${board.bno}">${board.title}</a></td>
				
				<td>${board.writer}</td>
				
				<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}" /></td>
          	</tr>
          	</c:forEach>
        </tbody>
      </table>
      <button class="btn btn-write" onclick="location.href='/admin/board/write'">글쓰기</button>
      <div style="text-align:center; margin-top: 5px;">
			<ul class="pull-right">
				<c:if test="${pageMaker.prev}">
					<li>
						<a href="/admin/board/list?pageNum=${pageMaker.startPage -1}
						&amount=${pageMaker.cri.amount}&type=${pageMaker.cri.type}
						&keyword=${pageMaker.cri.keyword}">Previous</a>
					</li>
				</c:if>
				
				<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
					<li>
						<a href="/admin/board/list?pageNum=${num}
						&amount=${pageMaker.cri.amount}&type=${pageMaker.cri.type}
						&keyword=${pageMaker.cri.keyword}">${num}</a>
					</li>
				</c:forEach>
				
				<c:if test="${pageMaker.next}">
					<li>
						<a href="/admin/board/list?pageNum=${pageMaker.endPage +1}
						&amount=${pageMaker.cri.amount}&type=${pageMaker.cri.type}
						&keyword=${pageMaker.cri.keyword}">Next</a>
					</li>
				</c:if>
			</ul>
		</div>
	</div>
</div>
</body>
</html>