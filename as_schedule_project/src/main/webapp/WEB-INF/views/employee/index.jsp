<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<style>
@import url("https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/static/pretendard.css");
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      background-color: #0d0d0d;
      color: white;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      text-align: center;
      overflow-x: hidden;
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

    /* 메인 타이틀 */
    .hero-title {
      font-size: 2rem;
      font-weight: bold;
      margin-top: 4rem;
    }

    .hero-subtitle {
      color: #bdbdbd;
      margin-top: 0.5rem;
      font-size: 1.1rem;
    }

    /* 동그라미 카드 */
    .circles {
      margin-top: 3rem;
      display: flex;
      justify-content: center;
      gap: 3rem;
      flex-wrap: wrap;
    }

    .circle {
      width: 240px;
      height: 240px;
      border-radius: 50%;
      overflow: hidden;
      display: flex;
      align-items: center;
      justify-content: center;
      box-shadow: 0 0 30px rgba(0, 0, 0, 0.5);
      text-align: center;
      font-size: 30px;
    }

    .circle a {
      color: black;
      text-decoration: none;
      font-weight: bold;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      width: 100%;
      height: 100%;
    }

    .circle.red {
      background-color: #5fd1b9;
    }

    .circle.green {
      background-color: #5fd1b9;
    }


    .circle img {
      width: 150px;
      height: auto;
      border-radius: 10px;
    }
  </style>
<meta charset="UTF-8">
<title>사용자 페이지</title>
<c:if test="${not empty message}">
    <script>
        alert("${message}");
    </script>
</c:if>
</head>
<body>

  <!-- Navbar -->
  <nav class="navbar">
    <a class="navbar-brand" href="ai.html">🅰 404</a>
    <div class="nav-buttons">
      <button class="btn-buy" onclick="location.href='/customer/logout';">Logout</button>
    </div>
  </nav>

  <!-- Hero Text -->
  <div class="container">
    <h1 class="hero-title">환영합니다. 기사님.</h1>
    <p class="hero-subtitle">We are responsible for your temperature.</p>

    <!-- Circles -->
    <div class="circles">
      <div class="circle red">
        <a href="/customer/board/list" id="notification">
          <span>공지사항</span>
        </a>
      </div>

      <div class="circle green">
        <a href="/employee/schedule" id="ASreceipt">
          <span>캘린더</span>
        </a>
      </div>

    </div>
  </div>
</body>
</html>
