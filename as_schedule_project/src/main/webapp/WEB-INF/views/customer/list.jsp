<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AS 현황</title>
<script src="/resources/js/jquery-3.7.1.min.js"></script>
</head>
<body>
	<!-- 검색 -->
    <form action="/customer/mypage" id="search_form" method="get">
     <select id="select_type" name="type">
     	<option value="proname" <c:if test="${type eq 'proname' }">selected</c:if>>제품</option>
     	<option value="issue" <c:if test="${type eq 'issue' }">selected</c:if> >고장증상</option>
     </select>
     <input type="text" id="input_keyword" name="keyword" value="${keyword}" />
     <select id="select_status" name="status_keyword">
     	<option value="">상태선택</option>
     	<option value="W" <c:if test="${status_keyword eq 'W'}">selected</c:if>>대기</option>
     	<option value="P" <c:if test="${status_keyword eq 'P'}">selected</c:if>>진행</option>
     	<option value="F" <c:if test="${status_keyword eq 'F'}">selected</c:if>>완료</option>
     </select>
     <input type="submit" id="search_btn" value="검색" />
    </form>
	<table width="100%" id="list_table">
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
        	<c:if test="${not empty clist }">
        	<c:forEach items="${clist}" var="list">
        		<tr>
	        		<td>${list.rownum }</td>
	        		<td>${list.proname }</td>
	        		<td>${list.issue }</td>
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
	        			<c:if test="${list.prostatus eq 'W'}" >대기</c:if>
	        			<c:if test="${list.prostatus eq 'P'}" >진행</c:if>
	        			<c:if test="${list.prostatus eq 'F'}" >완료</c:if>
	        		</td>
	        		<td>
        				<input type="button" value="등록" onclick="location.href='/customer/comment?cnum=${list.cnum}';" <c:if test="${list.prostatus eq 'W' or list.prostatus eq 'P'}">disabled</c:if>/>
	        		</td>
        		</tr>
        	</c:forEach>
        	</c:if>
        	<c:if test="${empty clist }">
        		<tr>
        			<td colspan="5">접수 현황이 없습니다.</td>
        		</tr>
        		
        	</c:if>
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
	               <a href="/customer/mypage?page=${pageNum}">${pageNum}</a>
	           </c:otherwise>
	       </c:choose>
	   </c:forEach>

	   <c:if test="${currentPage < totalPages}">
	       <a href="/customer/mypage?page=${currentPage + 1}" class="next">다음 &raquo;</a>
	   </c:if>
	</div>
	</c:if>
    <!-- 페이징 끝 -->
	<input type="button" value="홈" onclick="location.href='/customer/index';" />
</body>
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
</script>
</html>