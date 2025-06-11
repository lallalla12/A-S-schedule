<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기</title>
<style>
.star-img {
  width: 32px;
  height: 32px;
  cursor: pointer;
}
</style>
</head>
<body>
	<div class="popup-content">
		<div id="commentForm">
			<input type="hidden" name="star" id="star" value="${comment.star}" />
			<table>
				<tr>
					<td>* 별점</td>
				</tr>
				<tr>
					<td>
						<span class="stars">
					    <c:forEach var="i" begin="1" end="5">
					        <img src="/resources/img/<c:choose><c:when test="${i <= comment.star}">star_on.png</c:when><c:otherwise>star_off.png</c:otherwise></c:choose>"
					             class="star-img" />
					    </c:forEach>
					</span>
					</td>
				</tr>
				<tr>
					<td>후기</td>
				</tr>
				<tr>
					<td>
						<textarea name="comment" readonly >${comment.comment }</textarea>
					</td>		
				</tr>
				<tr>
					<td>
						<div class="button-group">
							<input type="button" value="닫기" onclick="closePopup();" class="btn popup_close" />
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>
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