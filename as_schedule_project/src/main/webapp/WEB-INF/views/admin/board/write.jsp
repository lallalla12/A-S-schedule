<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<meta charset="UTF-8">

<title>Insert title here</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
	<style>
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
    	}

    	textarea {
    		width : 100%;
            margin: 5px;
            resize: none;
            font-size: 20px;
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
	</style>
</head>
<body>
	<div class="container mt-5">
    	<h3>📋 글 쓰기</h3>
    	<div class="board-wrapper">
			<form action="write" method="post" role="form">
                <select>
                    <option>전체</option>
                    <option>기사님</option>
                    <option>고객님</option>
                </select>
	    		<table>
	    			<tr>
	    				<td><b>제목</b></td>
	    			</tr>
	    			<tr>
	    				<td>
							<input type="text" name="title" style="width:100%; margin: 5px; font-size: 20px;" placeholder="제목을 입력하세요"  />
						</td>
	    			</tr>
	    			<tr>
	    				<td><b>내용</b></td>
	    			</tr>
	    			<tr>
	    				<td>
							<textarea rows="12" cols="60" name="content" placeholder="내용을 입력하세요"></textarea><br>
	    				</td>
	    			</tr>
	    			<tr>
	    				<td><button class="btn-write" type="submit">등록</button></td>
	    			</tr>
	    		</table>
				
			</form>
		</div>
	</div>
</body>
</html>