<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기등록</title>
<style>
.star-img {
  width: 32px;
  height: 32px;
  cursor: pointer;
}
</style>
</head>
<body>
	<form name="commentForm" id="commentForm" action="/customer/comment" method="post" onsubmit="return confirm()">
		<input type="hidden" name="star" id="star" value="1" />
		별점 : 
		<div id="rating">
		  <img src="/resources/images/star_off.png" class="star-img" data-value="1" />
		  <img src="/resources/images/star_off.png" class="star-img" data-value="2" />
		  <img src="/resources/images/star_off.png" class="star-img" data-value="3" />
		  <img src="/resources/images/star_off.png" class="star-img" data-value="4" />
		  <img src="/resources/images/star_off.png" class="star-img" data-value="5" />
		</div>
		<br />
		후기 : <textarea name="comment" id="comment"></textarea>
		<input type="submit" value="등록" />
		<input type="button" value="목록" onclick="location.href='/customer/mypage';" />
	</form>
</body>
<script>
document.addEventListener("DOMContentLoaded", function () {
	  const stars = document.querySelectorAll(".star-img");
	  const starValue = document.getElementById("star");

	  stars.forEach((star, index) => {
	    const val = index + 1;

	    star.addEventListener("click", function () {
	      starValue.value = val;
	      updateStars(val);
	    });
	  });

	  function updateStars(rating) {
	    stars.forEach((star, idx) => {
	      star.src = idx < rating
	        ? "/resources/images/star_on.png"
	        : "/resources/images/star_off.png";
	    });
	  }
	});
</script>
</html>