<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>공지사항</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<style>
	@import url("https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/static/pretendard.css");
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
/* 	    .container {
	      display: flex;
	      justify-content: center;
	      align-items: center;
	      flex-direction: column;
	    } */
	    
    	.board-wrapper {
	      background-color: #fff;
	      border-radius: 12px;
	      padding: 30px 60px;
	      box-shadow: 0 0 20px rgba(0,0,0,0.3);
	      color: #000;
	      box-sizing: border-box;
	      
	      max-width : 1000px;
      	  margin : 0 auto;
    	}

    	textarea {
		  width: 100%;
		  height: 350px;
		  padding:12px 20px;
		  font-size: 15px;
		  border: 2px solid #39664d;
		  border-radius: 5px;
		  resize: none;
		  box-sizing: border-box;
		  color: #333;
		  outline: none;
    	}
    	
    	table {
	      width: 100%;
	      margin: 0;
	      background-color: white;
	      border-collapse: collapse;
	    }
    	.btn-write {
	      margin : 10px;
	      float : right;
	      background-color: #29c76f;
	      border: none;
	      color: white;
	      border-radius: 20px;
	      font-weight: 500;
	      width : 100px;
	      height : 30px;
	    }
	    
	    /* css 추가 */
	    #select_type {
			width : 40%;
			padding:12px 20px;
		    margin: 8px 0px 10px 0px;
		    box-sizing: border-box;
		    border : 2px solid #39664d;
		    border-radius: 4px;
		}
		input[type=text] {
		    width:100%;
		    padding:12px 20px;
		    margin: 8px 0px 10px 0px;
		    box-sizing: border-box;
		    border : 2px solid #39664d;
		    border-radius: 4px;
		}
	</style>
	<script>
	//제출 validation
	function validateForm(form) {
	    let title = form.title;
	    let content = form.content;
	    if (title.value.trim() === '') {
	        alert("제목을 입력해주세요.");
	        title.focus();
	        return false;
	    }
	    if(content.value.trim() === '') {
	    	alert("내용을 입력해주세요.");
	    	content.focus();
	        return false;
	    }
	}
	</script>
</head>
<body>
	<div class="container mt-5">
		<h3>게시글 수정</h3>
		<div class="board-wrapper">
		<form action="/admin/board/modify" method="post" onsubmit="return validateForm();">
			<input type="hidden" value="${board.bno}" name="bno">
			<select id="select_type" name="type">
               <option value="A" <c:if test="${board.type eq 'A' }">selected</c:if>>전체공개</option>
               <option value="E" <c:if test="${board.type eq 'E' }">selected</c:if>>직원공개</option>
               <option value="C" <c:if test="${board.type eq 'C' }">selected</c:if>>고객공개</option>
           	</select>
			<table>
				<tr>
    				<td><b>제목</b></td>
    			</tr>
				<tr>
					<td>
						<input type="text" value="${board.title}" name="title" placeholder="제목을 입력하세요" >
					</td>
				</tr>
				<tr>
    				<td><b>내용</b></td>
    			</tr>
				<tr>
					<td>
						<textarea name="content" placeholder="내용을 입력하세요">${board.content}</textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<button class="btn-write" type="button" style="background-color:#353535;" onclick="location.href='/admin/board/list';">목록</button>
						<input type="submit" class="btn-write" value="수정">
					</td>
				</tr>
			</table>
		</form>
		</div>
	</div>
</body>
</html>