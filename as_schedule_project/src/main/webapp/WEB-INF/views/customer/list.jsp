<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AS 현황</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<style>
@import url("https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/static/pretendard.css");
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
    a {
    	text-decoration : none;
    	color:black;
    }
</style>
<link type="text/css" rel="stylesheet" href="/resources/css/customer.css" />
<link href="/resources/css/include/include.css" rel="stylesheet"/>
<script src="/resources/js/jquery-3.7.1.min.js"></script>
<c:if test="${not empty message}">
    <script>
        alert("${message}");
    </script>
</c:if>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
	<div class="container mt-5">
		<h3>AS 현황</h3>
		<div class="board-wrapper">
		<!-- 검색 -->
	    <form action="/customer/mypage" id="search_form" method="get">
		     <select id="select_type" name="type">
		     	<option value="proname" <c:if test="${type eq 'proname' }">selected</c:if>>제품</option>
		     	<option value="issue" <c:if test="${type eq 'issue' }">selected</c:if> >고장증상</option>
		     </select>
		     <select id="select_status" name="status_keyword">
		     	<option value="">상태선택</option>
		     	<option value="W" <c:if test="${status_keyword eq 'W'}">selected</c:if>>대기</option>
		     	<option value="P" <c:if test="${status_keyword eq 'P'}">selected</c:if>>진행</option>
		     	<option value="F" <c:if test="${status_keyword eq 'F'}">selected</c:if>>완료</option>
		     </select>
		     <input type="text" id="input_keyword" name="keyword" value="${keyword}" />
		     <input type="submit" id="search_btn" value="검색" />
	    </form>
		<table id="list_table">
			<thead>
	            <th width="8%">번호</th>
	            <th width="15%">제품</th>
	            <th width="*">고장증상</th>
	            <th width="13%">방문예정일</th>
	            <th width="13%">방문종료일</th>
	            <th width="10%">상태</th>
	            <th width="15%">후기등록</th>
	        </thead>
	        <tbody>
	        	<c:if test="${not empty clist}">
	        	<c:forEach items="${clist}" var="list">
	        		<tr>
		        		<td style="font-weight:bold;">${list.rownum }</td>
		        		<td><a href="/customer/detail?cnum=${list.cnum}" >${list.proname }</a></td>
		        		<td><a href="/customer/detail?cnum=${list.cnum}" >${list.issue }</a></td>
		        		<td><fmt:formatDate pattern="yyyy-MM-dd" value="${list.visitdate}" /></td>
		        		<td>
		        			<c:if test="${empty list.visitend}" >
		        			<c:out value="-" />
		        			</c:if>
		        			<c:if test="${not empty list.visitend}">
		        			<fmt:formatDate pattern="yyyy-MM-dd" value="${list.visitend}" />
		        			</c:if>
		        		</td>
		        		<td>
		        			<c:if test="${list.prostatus eq 'W'}" ><span style="font-weight:bold;">대기</span></c:if>
		        			<c:if test="${list.prostatus eq 'P'}" ><span style="font-weight:bold; color:#da6264;">진행</span></c:if>
		        			<c:if test="${list.prostatus eq 'F'}" ><span style="font-weight:bold; color:#330066;">완료</span></c:if>
		        		</td>
		        		<td>
		        			<c:if test="${list.star > 0 }">
		        				<span style="font-weight:bold">등록완료</span>
		        			</c:if>
		        			<c:if test ="${list.star == 0 }">
	        				<input type="button" value="등록" class="comment_btn" onclick="openPopup(${list.cnum})"  
	        					<c:if test="${list.prostatus eq 'W' or list.prostatus eq 'P'}">disabled</c:if>
	        				/>
		        			</c:if>
		        		</td>
	        		</tr>
	        	</c:forEach>
	        	</c:if>
	        	<c:if test="${empty clist}">
	        		<tr>
	        			<td colspan="7">접수 현황이 없습니다.</td>
	        		</tr>
	        	</c:if>
	        		<tr class="home-btn-row">
	        			<td colspan="7"><input type="button" value="홈" class="btn-write" onclick="location.href='/customer/index';" /></td>
	        		</tr>
	        </tbody>
		</table>
		<!-- 페이징 시작 -->
	    <c:if test="${totalPages > 1}">
		<div class="pagination">
		    <c:if test="${currentPage > 1}">
		       <a href="/customer/mypage?page=${currentPage - 1}" class="prev">&laquo; 이전</a>
		   </c:if>
		
		   <c:forEach begin="1" end="${totalPages}" var="pageNum">
		       <c:choose>
		           <c:when test="${pageNum == currentPage}">
		               <span class="current">${pageNum}</span>
		           </c:when>
		           <c:otherwise>
		               <a class="notcurrent" href="/customer/mypage?page=${pageNum}">${pageNum}</a>
		           </c:otherwise>
		       </c:choose>
		   </c:forEach>
	
		   <c:if test="${currentPage < totalPages}">
		       <a href="/customer/mypage?page=${currentPage + 1}" class="next">다음 &raquo;</a>
		   </c:if>
		</div>
		</c:if>
	    <!-- 페이징 끝 -->
		</div>
	</div>
</body>
<!-- 레이어 팝업 영역 -->
<div id="popup-container" style="display:none; position:fixed; top:20%; left:50%; transform:translateX(-50%);
     background:#fff; border:1px solid #ccc; padding:20px; z-index:1000;"></div>
<div id="popup-overlay" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%;
     background:rgba(0,0,0,0.4); z-index:999;" onclick="closePopup()"></div>
<script>
window.addEventListener('DOMContentLoaded', function() {
    //document.getElementById('select_type').addEventListener('change', select_status);
    //select_status();  // 초기 실행
});

function select_status() {
	const type = document.getElementById("select_type").value;
  	const input = document.getElementById("input_keyword");
  	const statusSelect = document.getElementById("select_status");

  	if (type === "status") {
    	input.style.display = "none";
    	statusSelect.style.display = "inline-block";
  	} else {
    	input.style.display = "inline-block";
    	statusSelect.style.display = "none";
  	}
}

function openPopup(cnum) {
  	$.ajax({
	    url: '/customer/comment/add',
	    type: 'GET',
	    data: { cnum: cnum },
	    success: function(html) {
	      $('#popup-container').html(html).show();
	      $('#popup-overlay').show();
	    },
	    error: function() {
	      alert('팝업 로드 실패');
	    }
	  });
}

function closePopup() {
  document.getElementById('popup-container').style.display = 'none';
  document.getElementById('popup-overlay').style.display = 'none';
}
</script>
</html>