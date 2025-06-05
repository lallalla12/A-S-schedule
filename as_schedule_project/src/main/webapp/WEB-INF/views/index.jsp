<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>냉/난방 AS 기사 스케쥴 관리</title>
  <c:if test="${not empty message}">
    <script>
        alert("${message}");
    </script>
	</c:if>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="/resources/css/include/include.css" rel="stylesheet"/>
  <style>
    body {
      background-color: #0d0d0d;
      color: white;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      text-align: center;
      overflow-x: hidden;
      padding: 2rem;
    }



    .hero-title {
      font-size: 2rem;
      font-weight: bold;
    }


    .hero-subtitle {
      color: #bdbdbd;
      margin-top: 0.5rem;
      font-size: 1.1rem;
    }

    .circles {
      margin-top: 3rem;
      display: flex;
      justify-content: center;
      gap: 3rem;
    }

    .circle {
      width: 240px;
      height: 240px;
      border-radius: 50%;
      overflow: hidden;
      display: flex;
      align-items: center;
      justify-content: center;
      box-shadow: 0 0 30px rgba(0,0,0,0.5);
    }

    .circle a {
      color: black;
      text-decoration: none;
      font-weight: bold;
      font-size: 25px;
      text-align: center;
      display: block;
      width: 100%;
      height: 100%;
    }

    .circle.red {
      background-color: #ff5e5e;
    }


    .circle.green {
      background-color: #5fd1b9;
    }

    .circle.yellow {
      background-color: #ffe15a;
    }

    .circle img {
      width: 90%;
      height: auto;
      border-radius: 10px;
    }

    .bootstrap-tag {
      position: absolute;
      bottom: 1rem;
      left: 1rem;
      background-color: black;
      color: white;
      border-radius: 30px;
      padding: 0.5rem 1rem;
      display: flex;
      align-items: center;
      gap: 0.5rem;
      font-weight: 500;
    }
  </style>
</head>
<body>

<%@ include file="/WEB-INF/views/include/nav.jsp" %>
  

  <!-- Hero Text -->
  <div class="container mt-5">
    <h1 class="hero-title">냉/난방 AS 기사 스케쥴 관리</h1>
    <p class="hero-subtitle">We are responsible for your temperature.</p>

    <!-- Circles -->
    <div class="circles">
      <div class="circle red">
        <a href="/admin/index" id="admin" style="display: flex; flex-direction: column; align-items: center; justify-content: center;">
        <img src="/resources/img/admin.png" alt="business" style="width: 150px" />
        <span>관리자</span>
        </a>
      </div>

      <div class="circle green">
        <a href="/employee/index" id="employee"style="display: flex; flex-direction: column; align-items: center; justify-content: center;">
          <img src="/resources/img/imployee.png" alt="learning" style="width: 150px"/>  
          <span>AS기사용</span>
        </a>
      </div>
      <div class="circle yellow">
         <a href="/customer/index" id="customer"style="display: flex; flex-direction: column; align-items: center; justify-content: center;">
          <img src="/resources/img/customer.png" alt="meetings" style="width: 150px"/> 
          <span>고객용</span>
        </a>
      </div>
    </div>
  </div>


</body>
</html>
