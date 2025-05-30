<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기등록</title>
</head>
<body>
	<form name="commentForm" id="commentForm" action="customer/comment" method="post" onsubmit="return confirm()">
		<input type="hidden" name="star" id="star" value="0" />
		별점 : <img src="" />
		<br />
		후기 : <textarea name="comment" id="comment"></textarea>
		<input type="button" value="목록" onclick="location.href='/customer/mypage';" />
	</form>
</body>
</html>