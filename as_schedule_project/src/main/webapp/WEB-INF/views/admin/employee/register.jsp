<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 등록</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<style>
@import url("https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/static/pretendard.css");
body {
    background-color: #0d0d0d;
    color: white;
    padding: 0px;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

h2 {
    text-align: center;
    margin-bottom: 2rem;
    color: #ffffff;
}
    /* 네비게이션바 */
    .navbar {
      background-color: #0d0d0d;
      padding: 1rem 2rem;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .navbar-brand {
      font-size: 1.5rem;
      text-decoration: none;
      color: white;
    }

    .nav-buttons {
      display: flex;
      gap: 1rem;
    }

    .navbar-brand:hover {
  color: white;
  text-decoration: none;
}
 /* 버튼 스타일 */
    .btn-buy {
      background-color: #29c76f;
      border: none;
      padding: 0.4rem 1rem;
      border-radius: 20px;
      font-weight: 500;
      color: white;
      cursor: pointer;
    }

.form-wrapper {
    background-color: #fff;
    border-radius: 12px;
    padding: 30px 60px;
    box-shadow: 0 0 20px rgba(0,0,0,0.3);
    color: #000;
    box-sizing: border-box;
    max-width: 1000px;
    margin: 0 auto;
}

table {
    width: 100%;
}

td {
    padding: 10px 0;
}

input[type="text"],
input[type="password"],
input[type="date"] {
    width: 100%;
    padding: 10px;
    border-radius: 6px;
    border: 1px solid #ccc;
    font-size: 16px;
}

input[type="submit"] {
    background-color: #29c76f;
    color: white;
    border: none;
    padding: 12px 30px;
    border-radius: 25px;
    font-size: 16px;
    font-weight: 500;
    cursor: pointer;
    margin-top: 20px;

}
input[type="button"] {
    background-color: #29c76f;
    color: white;
    border: none;
    padding: 12px 36px;
    border-radius: 25px;
    font-size: 16px;
    font-weight: 500;
    cursor: pointer;
    margin: 20px 0px 0px 0px;
}

input[type="submit"]:hover {
    background-color: #1ea55c;
}

.btn-write{
  margin : 10px;
  background-color: #39664d!important;
  border: none;
  color: white;
  border-radius: 20px;
  font-weight: 500;
}
   
#btn{
text-align:right;
}
</style>
</head>
<body>
  <!-- Navbar -->
  <nav class="navbar">
    <a class="navbar-brand" href="/">🅰 404</a>
    <div class="nav-buttons">
      <button class="btn-buy" onclick="location.href='/customer/logout';">Logout</button>
    </div>
  </nav>

<h2> 직원 등록</h2>

<div class="form-wrapper">
    <form action="/admin/employee/register" method="post">
        <table>
            <tr>
                <td>직원 이름</td>
                <td><input type="text" name="ename" required></td>  
            </tr>
            <tr>
                <td>직원번호</td>
                <td><input type="text" name="eno" required></td>
            </tr>
            <tr>
                <td>비밀번호</td>
                <td><input type="password" name="password" required></td>
            </tr>
            <tr>
                <td>전화번호</td>
                <td><input type="text" name="ephone"></td>
            </tr>
            <tr>
                <td>직급</td>
                <td><input type="text" name="position"></td>
            </tr>
            <tr>
                <td>고용일</td>
                <td><input type="date" name="hiredate"></td>
            </tr>
        </table>
		
		<div id="btn">
        	<input type="submit"  class="btn-write" value="등록">
        	<input type="button"  class="btn-write" onclick="location.href='/admin/index';" value="홈">
        </div>
    </form>
</div>

</body>
</html>
