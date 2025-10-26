<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="cpath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="vi">
<head>
  <title>Pharmative — Danh mục sản phẩm</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <!-- giữ nguyên CSS như shop.jsp -->
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

  <style>
    /* căn chỉnh danh mục dùng layout đẹp tương tự shop.jsp */
    .category-card {
      background: #fff;
      border: 1px solid #e5e7eb;
      border-radius: 10px;
      text-align: center;
      padding: 25px 10px;
      transition: all 0.2s ease;
    }
    .category-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 3px 8px rgba(0,0,0,0.1);
    }
    .category-card h4 a {
      text-decoration: none;
      color: #16a34a;
      font-weight: 700;
    }
    .category-card ul {
      margin-top: 15px;
      list-style: none;
      padding: 0;
    }
    .category-card ul li a {
      text-decoration: none;
      color: #2563eb;
    }
    .category-card ul li a:hover {
      text-decoration: underline;
    }
  </style>
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
            <strong class="text-black">Danh mục sản phẩm</strong>
          </div>
        </div>
      </div>
    </div>

    <!-- nội dung chính -->
    <div class="site-section bg-light">
      <div class="container">
        <div class="row mb-5 text-center">
          <div class="col-12">
            <h2 class="text-success font-weight-bold">Danh mục sản phẩm</h2>
            <p class="text-muted">Chọn danh mục để xem sản phẩm cùng nhóm</p>
          </div>
        </div>

        <div class="row">
          <c:forEach var="entry" items="${tree}">
            <c:set var="parent" value="${entry.key}" />
            <c:set var="children" value="${entry.value}" />

            <div class="col-sm-6 col-md-4 col-lg-3 mb-4">
              <div class="category-card">
                <h4>
                  <a href="${cpath}/shop?category=${parent.id}">
                    ${parent.name}
                  </a>
                </h4>

                <c:if test="${not empty children}">
                  <ul>
                    <c:forEach var="child" items="${children}">
                      <li>
                        <a href="${cpath}/shop?category=${child.id}">
                          ${child.name}
                        </a>
                      </li>
                    </c:forEach>
                  </ul>
                </c:if>
              </div>
            </div>
          </c:forEach>
        </div>
      </div>
    </div>
  </div>

  <jsp:include page="/common/footerChinh.jsp" />

  <!-- giữ nguyên js -->
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
