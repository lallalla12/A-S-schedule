<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>기사접수 내역</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #0d0d0d;
            color: white;
            padding: 2rem;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        h2 {
            text-align: center;
            margin-bottom: 2rem;
            color: #ffffff;
        }

        .board-wrapper {
            background-color: #fff;
            border-radius: 12px;
            padding: 1rem;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
            color: #000;
            box-sizing: border-box;
            max-width: 1000px;
            margin: 0 auto;
        }

        table {
            width: 100%;
            background-color: white;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        thead {
            background-color: #f0f0f0;
        }

        th, td {
            padding: 1rem;
            text-align: center;
            border-bottom: 1px solid #ccc;
        }

        tbody tr:hover {
            background-color: #f9f9f9;
            cursor: pointer;
        }

        .check {
            background-color: #39664d;
            border: none;
            color: white;
            border-radius: 5px;
            font-weight: 500;
            width: 80px;
            height: 40px;
            margin-left: 10px;
        }

        #finishbtn {
            background-color: #A9A9A9;
            border: none;
            color: white;
            border-radius: 5px;
            font-weight: 500;
            width: 80px;
            height: 40px;
            margin-left: 10px;
        }
    </style>
    <link href="/resources/css/include/include.css" rel="stylesheet"/>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<div class="container mt-5">
<h2>기사접수 내역</h2>
    <div class="board-wrapper">
    
    <form action="searchCustomer" method="get" class="mb-3 d-flex justify-content-center align-items-center gap-2">
    <select name="searchField" class="form-select" style="width: 150px;">
        <option value="proname" <c:if test="${type == 'proname'}">selected</c:if>>제품명</option>
          <option value="issue" <c:if test="${type == 'issue'}">selected</c:if>>고장증상</option>
          <option value="username" <c:if test="${type == 'username'}">selected</c:if>>고객명</option>
    </select>
    <input type="text" name="keyword" class="form-control" placeholder="검색어를 입력하세요" style="width: 300px;" />
    <button type="submit" class="btn btn-primary">검색</button>
	</form>
    
        
        <table>
            <thead>
                <tr>
                    <th width="10%">고객명</th>
                    <th width="10%">제품명</th>
                    <th width="10%">모델명</th>
                    <th width="20%">고장증상</th>
                    <th width="15%">접수일자</th>
                    <th width="15%">종료일자</th>
                    <th width="10%">진행상태</th>
                    <th width="10%">후기</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${customerList}">
                    <tr>
                        <td>${item.username}</td>
                        <td>${item.proname}</td>
                        <td>${item.model}</td>
                        <td>${item.issue}</td>
                        <td>
                            <fmt:formatDate value="${item.visitdate}" pattern="yyyy.MM.dd (E) a hh:mm" />
                        </td>
                        <td>
						    <c:choose>
						        <c:when test="${empty item.visitend}">
						            -
						        </c:when>
						        <c:otherwise>
						            <fmt:formatDate value="${item.visitend}" pattern="yyyy.MM.dd (E)" />
						        </c:otherwise>
						    </c:choose>
						</td>

                        <td>
                            <c:choose>
                                <c:when test="${item.prostatus eq 'W'}">대기중</c:when>
                                <c:when test="${item.prostatus eq 'P'}">진행중</c:when>
                                <c:when test="${item.prostatus eq 'F'}">완료</c:when>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${item.prostatus eq 'F'}">
                                    <button id="finishbtn">후기</button>
                                </c:when>
                                <c:otherwise>
                                    <button class="check">후기</button>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty customerList}">
                    <tr>
                        <td colspan="8">접수된 내역이 없습니다.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
    </div>
</body>
</html>
