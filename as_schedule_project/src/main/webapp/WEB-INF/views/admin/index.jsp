<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자 페이지</title>
<c:if test="${not empty message}">
    <script>
        alert("${message}");
    </script>
</c:if>
</head>
<body>
<a href="/admin/board/list" >[게시판관리]</a>
<a href="/admin/board/list">[as현황목록]</a>
</body>
</html>