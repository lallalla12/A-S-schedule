<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<style type="text/css">
@import
	url("https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/static/pretendard.css");

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
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
	color: #000;
	box-sizing: border-box;
	max-width: 1000px;

	margin: 0 auto;
}

.pagenum {
	margin: 10px;
}

.btn-write {
	background-color: #39664d;
	border: none;
	color: white;
	border-radius: 20px;
	font-weight: 500;
	width: 100px;
	height: 30px;
	margin-left: 10px;
}

table {
	width: 100%;
	background-color: white;
	border-collapse: collapse;
	margin-bottom: 20px;
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


#popup {
  display: none;
  position: fixed;
  top: 50%;                /* 화면 세로 중앙 */
  left: 50%;               /* 화면 가로 중앙 */
  transform: translate(-50%, -50%);
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 8px 20px rgba(0,0,0,0.3);
  padding: 20px 30px;
  z-index: 1000;
  width: 400px;
  max-height: 70vh;
  overflow-y: auto;        /* 내용 많으면 스크롤 */
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

#popup h4 {
  margin-bottom: 15px;
  color: #39664d;
  font-weight: 700;
  text-align: center;
}

#engineerList {
  max-height: 300px;
  overflow-y: auto;
  margin-bottom: 20px;
  padding-left: 10px;
  border: 1px solid #ddd;
  border-radius: 8px;
  background: #f9f9f9;
}

#engineerList .form-check {
  padding: 8px 10px;
  border-bottom: 1px solid #ddd;
}

#engineerList .form-check:last-child {
  border-bottom: none;
}

#engineerList label {
  cursor: pointer;
  user-select: none;
}

#assignConfirmBtn, #closePopup {
  width: 48%;
  margin: 0 1%;
  font-weight: 600;
}

#assignConfirmBtn {
  background-color: #39664d;
  border: none;
  color: white;
  transition: background-color 0.3s ease;
}

#assignConfirmBtn:hover {
  background-color: #2f5240;
}

#closePopup {
  background-color: #ccc;
  border: none;
  color: #333;
  transition: background-color 0.3s ease;
  float : right;
}

#closePopup:hover {
  background-color: #bbb;
}

</style>
<meta charset="UTF-8">
<title>AS 현황</title>
</head>
<body>
<div class="container mt-5">
  <h3>AS 현황</h3>
  <div class="board-wrapper">
    <!-- 검색 폼 -->
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

    <!-- AS 현황 테이블 -->
    <table>
      <thead>
        <tr>
       	  <th width="10%">번호</th>          
          <th width="15%">제품명</th>
          <th width="25%">고장증상</th>
          <th width="10%">고객명</th>
          <th width="20%">방문예정일</th>
          <th width="10%">처리상태</th>
          <th width="10%">기사배정</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach items="${clist}" var="list">
          <tr>
            <td>${list.rownum}</td>            
            <td>${list.proname}</td>
            <td>${list.issue}</td>
            <td>${list.username}</td>
            <td><fmt:formatDate value="${list.visitdate}" pattern="yyyy-MM-dd" />&nbsp;&nbsp;${list.visittime }</td>
            <td>
              <c:if test="${list.prostatus eq 'W'}"><span style="font-weight:bold;">대기</span></c:if>
              <c:if test="${list.prostatus eq 'P'}"><span style="font-weight:bold; color:#da6264;">진행</span></c:if>
              <c:if test="${list.prostatus eq 'F'}"><span style="font-weight:bold; color:#330066;">완료</span></c:if>
            </td>
            <td>
            	<c:if test="${list.prostatus eq 'W' }">
            	<button class="assignBtn" data-receipt="${list.cnum}">배정</button>
            	</c:if>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>

    <!-- 페이지네이션 -->
    <div style="text-align:center; margin-top: 5px;">
      <ul class="pull-right">
        <c:if test="${pageMaker.prev}">
          <li><a href="/admin/service/asindex?pageNum=${pageMaker.startPage - 1}&type=${type}&keyword=${keyword}">Previous</a></li>
        </c:if>
        <c:forEach var="num" begin="1" end="${totalPages}">
          <li class="numPaging <c:if test='${num == currentPage}'>active-page</c:if>">
            <a href="/admin/service/asindex?pageNum=${num}&type=${type}&keyword=${keyword}">${num}</a>
          </li>
        </c:forEach>
        <c:if test="${pageMaker.next}">
          <li><a href="/admin/service/asindex?pageNum=${pageMaker.endPage + 1}&type=${type}&keyword=${keyword}">Next</a></li>
        </c:if>
      </ul>
    </div>

    <!-- 기사 배정 팝업 -->
    <div id="popup" style="display:none; position:fixed; top:20%; left:50%; transform:translateX(-50%);
         background:#fff; border:1px solid #ccc; padding:20px; z-index:1000; width:550px;">
      <h4>기사님 선택</h4>
      <form id="engineerForm">
        <div id="engineerList">
          <table class="table table-hover">
            <thead>
              <tr>
                <th>선택</th>
                <th>직원번호</th>
                <th>이름</th>
                <th>부서</th>
                <th>연락처</th>
                <th>고용일</th>
              </tr>
            </thead>
            <tbody id="engineerTableBody">
              <!-- JS로 동적으로 채움 -->
            </tbody>
          </table>
        </div>
        <br>
        <button type="button" id="assignConfirmBtn" class="btn btn-success btn-sm">배정</button>
        <button type="button" id="closePopup" class="btn btn-secondary btn-sm">닫기</button>
      </form>
    </div>
    <div style="text-align: right;">
	<button class="btn-write" 
					onclick="location.href='<c:url value='/admin/index' />'">홈</button>
  </div>
</div>

<!-- JS -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).on('click', '.assignBtn', function () {
	  const receiptNo = $(this).data('receipt');
	  $('#popup').data('receipt', receiptNo).show();

	  $.ajax({
	    url: '/admin/employee/list/json',
	    method: 'GET',
	    dataType: 'json',
	    cache: false,
	    success: function (data) {
	      const $tbody = $('#engineerTableBody');
	      $tbody.empty();

	      if (data.length === 0) {
	        $tbody.append('<tr><td colspan="6" style="text-align:center; color:black;">검색결과가 없습니다.</td></tr>');
	      } else {
	        $.each(data, function (i, emp) {
	          const hireDateFormatted = new Date(emp.hiredate).toISOString().substring(0, 10);
	          const row = '<tr>' +
	            '<td><input type="radio" name="selectedEngineer" value="' + emp.eno + '"></td>' +
	            '<td>' + emp.eno + '</td>' +
	            '<td>' + emp.ename + '</td>' +
	            '<td>' + emp.position + '</td>' +
	            '<td>' + emp.ephone + '</td>' +
	            '<td>' + hireDateFormatted + '</td>' +
	            '</tr>';
	          $tbody.append(row);
	        });
	      }
	    },
	    error: function () {
	      alert('기사 목록을 불러오는 데 실패했습니다.');
	    }
	  });
	});

	// ✅ 이벤트 핸들러는 바깥에 따로 등록!
	$('#assignConfirmBtn').on('click', function () {
	  const selectedEngineer = $('input[name="selectedEngineer"]:checked').val();
	  const receiptNo = $('#popup').data('receipt');
	
	  console.log(receiptNo + "룰루" + selectedEngineer)
	  
	  if (!selectedEngineer) {
	    alert('기사님을 선택해주세요.');
	    return;
	  }

	  $.ajax({
	    url: '/admin/service/assignEngineer/'+ receiptNo+"/"+selectedEngineer,
	    method: 'POST',
	    contentType: 'application/json',
/* 	    data: JSON.stringify({
	      receiptNo: receiptNo,
	      engineerNo: selectedEngineer
	    }), */
	    //data:receiptNo
	    success: function (response) {
	      alert('기사님이 성공적으로 배정되었습니다.');
	      $('#popup').hide();
	      location.reload();
	      
	      /* $('button.assignBtn[data-receipt="' + receiptNo + '"]').closest('tr').find('td:eq(5)').html('<span style="font-weight:bold; color:#da6264;">진행</span>');
	      $('button.assignBtn[data-receipt="' + receiptNo + '"]').remove(); */
	    },
	    error: function () {
	      alert('기사 배정 중 오류가 발생했습니다.');
	    }
	  });
	}); 

	$('#closePopup').on('click', function () {
	  $('#popup').hide();
	});
</script>
 
</body>
</html>