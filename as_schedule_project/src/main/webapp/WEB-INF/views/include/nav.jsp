<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

  <!-- navbar-->
  <nav class="navbar navbar-expand-lg">
    <a class="navbar-brand" href="/">🅰 404</a>
    <div class="collapse navbar-collapse">
      <ul class="navbar-nav ms-auto me-3">
      	<c:if test="${empty sessionScope.user_id}">
        <button class="btn btn-buy" onclick="location.href='/login?gubun=customer';">Login</button>
      	</c:if>
      	<c:if test="${not empty sessionScope.user_id}">
        <button class="btn btn-buy" onclick="location.href='/customer/logout';">Logout</button>
      	</c:if>
      </ul>
    </div>
  </nav>