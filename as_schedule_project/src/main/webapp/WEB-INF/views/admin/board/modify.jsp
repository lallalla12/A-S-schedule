<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>수정 화면으로 이동...</h3>
	<form action="admin/board/modify" method="post">
		<table border="1">
		
			<tr>
				<td>제목</td>
				<td>
					<input type="hidden" value="${board.bno}" name="bno">
					<input type="text" value="${board.title}" name="title">
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
					<textarea name="content">${board.content}</textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="수정">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>