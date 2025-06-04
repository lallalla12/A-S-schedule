<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<style type="text/css">
@import url("https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/static/pretendard.css");

.pull-right ul, li {
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
  box-shadow: 0 0 20px rgba(0,0,0,0.3);
  color: #000;
  box-sizing: border-box;
  
  max-width : 1000px;
  margin : 0 auto;
}

.pagenum {
  margin: 10px;
}

.btn-write {
  margin: 10px;
  float: right;
  background-color: #39664d;
  border: none;
  color: white;
  border-radius: 20px;
  font-weight: 500;
}

table {
  width: 100%;
  background-color: white;
  border-collapse: collapse;
  margin-bottom : 20px;
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

#input_keyword {
  width: 55%;
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

#search_form select,
#search_form input[type="text"],
#search_form input[type="submit"] {
  height: 50px;
  vertical-align: middle;
  font-size: 14px;
  box-sizing: border-box;
}

.numPaging a {
  text-decoration: none;
  margin: 10px 0px;
  color: black;
  padding: 6px 10px;
  border-radius: 4px;
}

.numPaging.active-page a {
 
  background-color: #39664d;
  color: #fff;
  font-weight: bold;
}

.clearfix::after {
  content: "";
  display: table;
  clear: both;
}
</style>
<meta charset="UTF-8">
<title>AS 현황</title>
</head>
<body>
<div class="container mt-5">
  <h3>AS 현황</h3>
  <div class="board-wrapper">
    <form action="/admin/service/asindex" method="get">
      <div class="pagenum">
        <input type="hidden" name="pageNum" value="${currentPage}">
        <input type="hidden" name="amount" value="${pageMaker.cri.amount}">

        <select name="type" id="select_type">
          <option value="proname" <c:if test="${type == 'proname'}">selected</c:if>>제품명</option>
          <option value="issue" <c:if test="${type == 'issue'}">selected</c:if>>고장증상</option>
          <option value="username" <c:if test="${type == 'username'}">selected</c:if>>고객명</option>
        </select>

        <input type="text" name="keyword" id="input_keyword" value="${keyword}">
        <input type="submit" id="search_btn" value="검색">
      </div>
    </form>

    <table>
      <thead>
        <tr>
          <th>접수번호</th>
          <th>제품명</th>
          <th>고장증상</th>
          <th>고객명</th>
          <th>방문예정일</th>
          <th>처리상태</th>
          <th>기사배정</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach items="${clist}" var="list">
          <tr>
            <td>${list.rownum}</td>
            <td>${list.proname}</td>
            <td>${list.issue}</td>
            <td>${list.username}</td>
            <td><fmt:formatDate value="${list.visitdate}" pattern="yyyy-MM-dd" /></td>
            <td>
              <c:if test="${list.prostatus eq 'W'}"><span style="font-weight:bold;">대기</span></c:if>
              <c:if test="${list.prostatus eq 'P'}"><span style="font-weight:bold; color:#da6264;">진행</span></c:if>
              <c:if test="${list.prostatus eq 'F'}"><span style="font-weight:bold; color:#330066;">완료</span></c:if>
            </td>
            <td><button class="assignBtn" data-receipt="${list.rownum}">기사 배정</button></td>
          </tr>
        </c:forEach>
      </tbody>
    </table>

	<div style="text-align:center; margin-top: 5px;">
	  <ul class="pull-right">
	    <c:if test="${pageMaker.prev}">
	      <li>
	        <a href="/admin/service/asindex?pageNum=${pageMaker.startPage - 1}&type=${type}&keyword=${keyword}">Previous</a>
	      </li>
	    </c:if>
	
		<c:forEach var="num" begin="1" end="${totalPages}">
		  <li class="numPaging <c:if test='${num == currentPage}'>active-page</c:if>">
		    <a href="/admin/service/asindex?pageNum=${num}&type=${type}&keyword=${keyword}">${num}</a>
		  </li>
		</c:forEach>
	
	    <c:if test="${pageMaker.next}">
	      <li>
	        <a href="/admin/service/asindex?pageNum=${pageMaker.endPage + 1}&type=${type}&keyword=${keyword}">Next</a>
	      </li>
	    </c:if>
	  </ul>
	</div>
	
		<!-- 팝업 -->
		<div id="popup" style="display:none; position:fixed; top:20%; left:50%; transform:translateX(-50%);
     		background:#fff; border:1px solid #ccc; padding:20px; z-index:1000;">
		  <h3>기사님 선택</h3>
		  <select id="engineerList">
		    <option>불러오는 중...</option>
		  </select>
		  <br><br>
		  <button id="assignConfirmBtn">배정</button>
		  <button id="closePopup">닫기</button>
		</div>
	
  </div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(function() {
	  // 버튼을 클래스 기준으로 바인딩 (동적으로 생성된 요소 포함)
	  $(document).on('click', '.assignBtn', function() {
	    const receiptNo = $(this).data('receipt'); // 접수번호 추출 (필요 시 서버에 전달 가능)

	    // 팝업 열기
	    $('#popup').show();

	    // 기사 리스트 AJAX로 불러오기
	    $.ajax({
	      url: '/getEngineers',
	      method: 'GET',
	      dataType: 'json',
	      success: function(data) {
	        $('#engineerList').empty();
	        $.each(data, function(i, engineer) {
	          $('#engineerList').append(
	            $('<option>', {
	              value: engineer.eno,
	              text: engineer.ename + ' (' + engineer.ephone + ')'
	            })
	          );
	        });

	        // 선택된 접수번호를 숨겨서 저장 (필요하면)
	        $('#popup').data('receipt', receiptNo);
	      },
	      error: function() {
	        alert('기사 리스트를 불러오지 못했습니다.');
	      }
	    });
	  });

	  // 팝업 닫기
	  $('#closePopup').on('click', function() {
	    $('#popup').hide();
	  });

	  // 기사 배정 확인
	  $('#assignConfirmBtn').on('click', function() {
	    const selectedId = $('#engineerList').val();
	    const receiptNo = $('#popup').data('receipt'); // 팝업에 저장된 접수번호

	    alert('기사 ID: ' + selectedId + '\n접수번호: ' + receiptNo);

	    // 👉 실제 기사 배정 처리 AJAX 요청 추가 가능
	    /*
	    $.post('/assignEngineer', {
	      eno: selectedId,
	      receiptNo: receiptNo
	    }, function(response) {
	      alert('배정 완료!');
	      $('#popup').hide();
	    });
	    */
	    $('#popup').hide();
	  });
	});
</script>



</body>
</html>