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
  .stars img {
    width: 24px;
    height: 24px;
    cursor: pointer;
  }
</style>
<script>
	function setStar(rating) {
	    document.getElementById("star").value = rating;
	    const stars = document.querySelectorAll(".star-img");
	    stars.forEach((star, index) => {
	      star.src = index < rating ? "/resources/img/star_on.png" : "/resources/img/star_off.png";
	    });
	}

	function confirm_check() {
		return confirm("작성한 후기를 등록하시겠습니까? (수정 불가)");
	}
</script>
<link type="text/css" rel="stylesheet" href="/resources/css/customer.css" />
</head>
<body>
	<div class="popup-content">
		<form name="commentForm" id="commentForm" action="/customer/comment/add" method="post" onsubmit="return confirm_check()">
			<input type="hidden" name="cnum" value="${param.cnum}" />
			<input type="hidden" name="star" id="star" value="0" />
			<table>
				<tr>
					<td>* 별점</td>
				</tr>
				<tr>
					<td>
						<span class="stars">
							<img src="/resources/img/star_off.png" class="star-img" onclick="setStar(1)" />
							<img src="/resources/img/star_off.png" class="star-img" onclick="setStar(2)" />
							<img src="/resources/img/star_off.png" class="star-img" onclick="setStar(3)" />
							<img src="/resources/img/star_off.png" class="star-img" onclick="setStar(4)" />
							<img src="/resources/img/star_off.png" class="star-img" onclick="setStar(5)" />
						</span>
					</td>
				</tr>
				<tr>
					<td>후기(선택사항)</td>
				</tr>
				<tr>
					<td>
						<textarea name="comment" placeholder="후기를 입력해주세요."></textarea>
					</td>		
				</tr>
				<tr>
					<td>
						<div class="button-group">
							<input type="submit" value="등록" class="btn" />
							<input type="button" value="닫기" onclick="closePopup();" class="btn popup_close" />
						</div>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>