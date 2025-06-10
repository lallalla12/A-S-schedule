<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<style>
	@import url("https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/static/pretendard.css");
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
	      padding: 30px 60px;
	      box-shadow: 0 0 20px rgba(0,0,0,0.3);
	      color: #000;
	      box-sizing: border-box;
	      
	      max-width : 1000px;
      	  margin : 0 auto;
    	}

    	textarea {
		  width: 100%;
		  height: 350px;
		  padding:12px 20px;
		  font-size: 15px;
		  border: 2px solid #39664d;
		  border-radius: 5px;
		  resize: none;
		  box-sizing: border-box;
		  color: #333;
		  outline: none;
    	}
    	
    	table {
	    width: 100%;
	    border-collapse: collapse;
	    margin-bottom: 20px;
	  }
	
	  table td {
	    padding: 20px 15px;
	    border-bottom: 1px solid #ddd;
	    vertical-align: top;
	  }
	
	  table tr:last-child td {
	    border-bottom: none;
	  }
	
	  table td:first-child {
	    width: 120px;
	    font-weight: bold;
	    background-color: #f7f7f7;
	    color: #555;
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
	    
	    /* css 추가 */
	  .label-cell {
		  text-align: center;
		  font-weight: bold;
		  background-color: #f7f7f7;
		  color: #555;
		  width: 120px;
	  }
	  .data-cell {
		padding-left : 30px;
	  }
	  
	  .btn-group {
	  	float:right;
	  	margin-bottom: 30px;
	  }
	  
	  .no-bg td:first-child {
	  	background-color: transparent !important;
	  }
	  
	  
</style>
<link href="/resources/css/include/include.css" rel="stylesheet"/>
<script>
function confirmDelete(bno) {
	  if (confirm("정말 삭제하시겠습니까?")) {
	    location.href = '/admin/board/remove?bno=' + bno;
	  }
	}
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
	<div class="container mt-5">
		<h3>상세내용</h3>
		<div class="board-wrapper">
		<table>
			<tr>
		      <td class="label-cell">공개 범위</td>
		      <td style="font-weight:bold;" class="data-cell">
		        <c:choose>
		          <c:when test="${board.type eq 'A'}">전체공개</c:when>
		          <c:when test="${board.type eq 'E'}">직원공개</c:when>
		          <c:when test="${board.type eq 'C'}">고객공개</c:when>
		        </c:choose>
		      </td>
		    </tr>
			<tr>
				<td class="label-cell">제목</td>
				<td class="data-cell">${board.title}</td>
			</tr>
			<tr>
				<td class="label-cell">작성자</td>
				<td class="data-cell">관리자</td>
			</tr>
			<tr>
				<td class="label-cell">내용</td>
				<td class="data-cell" style="white-space: pre-wrap; padding-bottom:300px">${board.content}</td>
			</tr>
			<tr class="no-bg">
				<td colspan="2">
					<button class="btn-write" type="button" style="background-color:#da6264;" onclick="confirmDelete(${board.bno});">삭제</button>
					<button class="btn-write" type="button" onclick="location.href='/admin/board/modify?bno=${board.bno}'">수정</button>
					<button class="btn-write" type="button" style="background-color:#353535;" onclick="location.href='/admin/board/list';">목록</button>
				</td>
			</tr>
		</table>
		</div>
	</div>
</body>
</html>