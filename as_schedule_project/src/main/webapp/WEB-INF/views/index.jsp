<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Around Landing</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <style>
    body {
      background-color: #0d0d0d;
      color: white;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      text-align: center;
      overflow-x: hidden;
    }

    .navbar {
      background-color: #0d0d0d;
      padding: 1rem 2rem;
    }

    .navbar-brand, .nav-link, .btn-buy {
      color: white !important;
    }

    .btn-buy {
      background-color: #29c76f;
      border: none;
      padding: 0.4rem 1rem;
      border-radius: 20px;
      font-weight: 500;
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
      color: white;
      text-decoration: none;
      font-weight: bold;
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

  <!-- navbar-->
  <nav class="navbar navbar-expand-lg">
    <a class="navbar-brand" href="/">🅰 404</a>
    <div class="collapse navbar-collapse">
      <ul class="navbar-nav ms-auto me-3">
        <button class="btn btn-buy">Login</button>
        
      </ul>
      <button class="btn btn-buy">Join</button>
    </div>
  </nav>

  <!-- Hero Text -->
  <div class="container mt-5">
    <h1 class="hero-title">냉/난방 AS 기사 스케쥴 관리</h1>
    <p class="hero-subtitle">We are responsible for your temperature.</p>

    <!-- Circles -->
    <div class="circles">
      <div class="circle red">
        <a href="/admin/list" id="admin" style="display: flex; flex-direction: column; align-items: center; justify-content: center;">
        <img src="/resources/img/admin.png" alt="business" style="width: 150px" />
        <span>관리자</span>
        </a>
      </div>

      <div class="circle green">
        <a href="/employee/schedule" id="employee"style="display: flex; flex-direction: column; align-items: center; justify-content: center;">
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
