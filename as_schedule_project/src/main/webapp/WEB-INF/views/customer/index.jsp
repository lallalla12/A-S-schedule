<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객 페이지</title>
<c:if test="${not empty message}">
    <script>
        alert("${message}");
    </script>
</c:if>
</head>
<body>
<a href="#" >공지사항</a>
<a href="/customer/register">AS 접수</a>
<a href="/customer/mypage">AS 현황</a>
<input type="button" value="로그아웃" onclick="location.href='/customer/logout';"/>
</body>
</html>