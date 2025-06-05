<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="/resources/css/include/include.css" rel="stylesheet"/>
<style>

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
      padding:2rem;
      
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

<%@ include file="/WEB-INF/views/include/nav.jsp" %>
  

  <!-- Hero Text -->
  <div class="container">
    <h1 class="hero-title">환영합니다. 기사님.</h1>
    <p class="hero-subtitle">We are responsible for your temperature.</p>

    <!-- Circles -->
    <div class="circles">
      <div class="circle red">
        <a href="/employee/board/list" id="notification">
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
