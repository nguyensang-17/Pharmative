<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="cpath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Pharmative &mdash; Colorlib Template</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="${cpath}/fonts/icomoon/style.css">

  <link rel="stylesheet" href="${cpath}/css/bootstrap.min.css">
  <link rel="stylesheet" href="${cpath}/fonts/flaticon/font/flaticon.css">
  <link rel="stylesheet" href="${cpath}/css/magnific-popup.css">
  <link rel="stylesheet" href="${cpath}/css/jquery-ui.css">
  <link rel="stylesheet" href="${cpath}/css/owl.carousel.min.css">
  <link rel="stylesheet" href="${cpath}/css/owl.theme.default.min.css">
  <link rel="stylesheet" href="${cpath}/css/aos.css">
  <link rel="stylesheet" href="${cpath}/css/style.css">
</head>

<body>
    <jsp:include page="/common/headerChinh.jsp" />
<div class="site-wrap">

  <!-- breadcrumb -->
  <div class="bg-light py-3">
    <div class="container">
      <div class="row">
        <div class="col-md-12 mb-0">
          <a href="${cpath}/home">Home</a>
          <span class="mx-2 mb-0">/</span>
          <strong class="text-black">Store</strong>
        </div>
      </div>
    </div>
  </div>

  <!-- Filter section (giữ nguyên giao diện) -->
  <div class="py-5">
    <div class="container">
      <div class="row">
        <div class="col-lg-6">
          <h3 class="mb-3 h6 text-uppercase text-black d-block">Filter by Price</h3>
          <div id="slider-range" class="border-primary"></div>
          <input type="text" name="text" id="amount" class="form-control border-0 pl-0 bg-white" disabled />
        </div>
        <div class="col-lg-6 text-lg-right">
          <h3 class="mb-3 h6 text-uppercase text-black d-block">Filter</h3>
          <button type="button" class="btn btn-primary btn-md dropdown-toggle px-4" id="dropdownMenuReference"
                  data-toggle="dropdown">Reference</button>
          <div class="dropdown-menu" aria-labelledby="dropdownMenuReference">
            <a class="dropdown-item" href="#">Relevance</a>
            <a class="dropdown-item" href="#">Name, A to Z</a>
            <a class="dropdown-item" href="#">Name, Z to A</a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="#">Price, low to high</a>
            <a class="dropdown-item" href="#">Price, high to low</a>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Product grid (dynamic) -->
  <div class="site-section bg-light">
    <div class="container">

      <div class="row">
        <!-- nếu rỗng -->
        <c:if test="${empty products}">
          <div class="col-12">
            <div class="alert alert-info">Chưa có sản phẩm.</div>
          </div>
        </c:if>

        <!-- danh sách sản phẩm từ DB -->
        <c:forEach var="p" items="${products}">
          <div class="col-sm-6 col-lg-4 text-center item mb-4 item-v2">
            <a href="${cpath}/product-detail?id=${p.productId}">
              <img src="${cpath}/${p.imageUrl}" alt="${p.productName}">
            </a>
            <h3 class="text-dark">
              <a href="${cpath}/product-detail?id=${p.productId}">${p.productName}</a>
            </h3>
            <p class="price">
              <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫"/>
            </p>
          </div>
        </c:forEach>
      </div>

      <!-- Pagination (dynamic) -->
      <c:if test="${totalPages > 1}">
        <div class="row mt-5">
          <div class="col-md-12 text-center">
            <div class="site-block-27">
              <ul>
                <li class="${page==1?'disabled':''}">
                  <a href="${cpath}/shop?page=${page-1}">&lt;</a>
                </li>

                <c:forEach var="i" begin="1" end="${totalPages}">
                  <li class="${i==page?'active':''}">
                    <c:choose>
                      <c:when test="${i==page}">
                        <span>${i}</span>
                      </c:when>
                      <c:otherwise>
                        <a href="${cpath}/shop?page=${i}">${i}</a>
                      </c:otherwise>
                    </c:choose>
                  </li>
                </c:forEach>

                <li class="${page==totalPages?'disabled':''}">
                  <a href="${cpath}/shop?page=${page+1}">&gt;</a>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </c:if>

    </div>
  </div>

</div>
          <jsp:include page="/common/footerChinh.jsp" />

<script src="${cpath}/js/jquery-3.3.1.min.js"></script>
<script src="${cpath}/js/jquery-ui.js"></script>
<script src="${cpath}/js/popper.min.js"></script>
<script src="${cpath}/js/bootstrap.min.js"></script>
<script src="${cpath}/js/owl.carousel.min.js"></script>
<script src="${cpath}/js/jquery.magnific-popup.min.js"></script>
<script src="${cpath}/js/aos.js"></script>
<script src="${cpath}/js/main.js"></script>
</body>
</html>
