<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
      <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
        <c:set var="cpath" value="${pageContext.request.contextPath}" />

        <!DOCTYPE html>
        <html lang="vi">

        <head>
          <title>Pharmative — Cửa hàng</title>
          <meta charset="utf-8">
          <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
          <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico">
          <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800&display=swap"
            rel="stylesheet">
          <link rel="stylesheet" href="${cpath}/fonts/icomoon/style.css">
          <link rel="stylesheet" href="${cpath}/css/bootstrap.min.css">
          <link rel="stylesheet" href="${cpath}/fonts/flaticon/font/flaticon.css">
          <link rel="stylesheet" href="${cpath}/css/magnific-popup.css">
          <link rel="stylesheet" href="${cpath}/css/jquery-ui.css">
          <link rel="stylesheet" href="${cpath}/css/owl.carousel.min.css">
          <link rel="stylesheet" href="${cpath}/css/owl.theme.default.min.css">
          <link rel="stylesheet" href="${cpath}/css/aos.css">
          <link rel="stylesheet" href="${cpath}/css/style.css">
          <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

          <style>
            body {
              font-family: 'Nunito', sans-serif;
              background-color: #f8f9fa;
            }

            /* Breadcrumb */
            .breadcrumb-section {
              background: #fff;
              padding: 20px 0;
              box-shadow: 0 2px 10px rgba(0, 0, 0, 0.03);
              margin-bottom: 40px;
            }

            .breadcrumb-item a {
              color: #6c757d;
              text-decoration: none;
              transition: 0.3s;
              font-weight: 600;
            }

            .breadcrumb-item a:hover {
              color: #2e7d32;
            }

            .breadcrumb-item.active {
              color: #2e7d32;
              font-weight: 700;
            }

            .breadcrumb-separator {
              margin: 0 10px;
              color: #ccc;
            }

            /* Search Bar */
            .search-container {
              margin-bottom: 50px;
            }

            .search-form .form-control {
              border-radius: 50px 0 0 50px;
              border: 1px solid #e0e0e0;
              border-right: none;
              padding-left: 25px;
              height: 55px;
              box-shadow: none !important;
              font-size: 16px;
              background: #fff;
            }

            .search-form .form-control:focus {
              border-color: #2e7d32;
            }

            .search-form .btn {
              border-radius: 0 50px 50px 0;
              background: #2e7d32;
              border: 1px solid #2e7d32;
              color: #fff;
              height: 55px;
              padding: 0 30px;
              font-weight: 700;
              transition: 0.3s;
              font-size: 16px;
            }

            .search-form .btn:hover {
              background: #1b5e20;
              border-color: #1b5e20;
              transform: translateX(2px);
            }

            /* Product Cards */
            .product-card {
              background: #fff;
              border-radius: 20px;
              overflow: hidden;
              box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
              transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
              margin-bottom: 30px;
              position: relative;
              border: 1px solid rgba(0, 0, 0, 0.03);
              height: 100%;
              display: flex;
              flex-direction: column;
            }

            .product-card:hover {
              transform: translateY(-10px);
              box-shadow: 0 20px 40px rgba(46, 125, 50, 0.15);
              border-color: rgba(46, 125, 50, 0.3);
            }

            .product-image-wrapper {
              position: relative;
              overflow: hidden;
              padding-top: 100%;
              /* 1:1 Aspect Ratio */
            }

            .product-image-wrapper img {
              position: absolute;
              top: 0;
              left: 0;
              width: 100%;
              height: 100%;
              object-fit: cover;
              transition: transform 0.6s ease;
            }

            .product-card:hover .product-image-wrapper img {
              transform: scale(1.1);
            }

            /* Overlay Actions */
            .product-actions {
              position: absolute;
              top: 0;
              left: 0;
              width: 100%;
              height: 100%;
              background: rgba(0, 0, 0, 0.4);
              display: flex;
              align-items: center;
              justify-content: center;
              gap: 15px;
              opacity: 0;
              transition: all 0.3s ease;
              backdrop-filter: blur(2px);
            }

            .product-card:hover .product-actions {
              opacity: 1;
            }

            .action-btn {
              width: 50px;
              height: 50px;
              background: #fff;
              border-radius: 50%;
              display: flex;
              align-items: center;
              justify-content: center;
              color: #2e7d32;
              text-decoration: none;
              transform: translateY(20px);
              transition: all 0.3s ease;
              box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            }

            .product-card:hover .action-btn {
              transform: translateY(0);
            }

            .product-card:hover .action-btn:nth-child(2) {
              transition-delay: 0.1s;
            }

            .action-btn:hover {
              background: #2e7d32;
              color: #fff;
              transform: scale(1.1) !important;
            }

            .product-info {
              padding: 20px;
              text-align: center;
              flex-grow: 1;
              display: flex;
              flex-direction: column;
              justify-content: space-between;
            }

            .product-title {
              font-size: 18px;
              font-weight: 700;
              margin-bottom: 10px;
              line-height: 1.4;
            }

            .product-title a {
              color: #2c3e50;
              text-decoration: none;
              transition: 0.3s;
            }

            .product-title a:hover {
              color: #2e7d32;
            }

            .product-price {
              color: #2e7d32;
              font-weight: 800;
              font-size: 20px;
              margin-top: auto;
            }

            /* Pagination */
            .pagination-container {
              margin-top: 60px;
            }

            .custom-pagination {
              display: flex;
              justify-content: center;
              list-style: none;
              padding: 0;
              gap: 10px;
            }

            .custom-pagination li a,
            .custom-pagination li span {
              width: 45px;
              height: 45px;
              display: flex;
              align-items: center;
              justify-content: center;
              border-radius: 50%;
              background: #fff;
              color: #2c3e50;
              border: 1px solid #e0e0e0;
              text-decoration: none;
              transition: all 0.3s ease;
              font-weight: 700;
              box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
            }

            .custom-pagination li.active span,
            .custom-pagination li a:hover {
              background: #2e7d32;
              color: #fff;
              border-color: #2e7d32;
              transform: translateY(-3px);
              box-shadow: 0 5px 15px rgba(46, 125, 50, 0.3);
            }

            .custom-pagination li.disabled span {
              background: #f1f3f5;
              color: #adb5bd;
              border-color: #f1f3f5;
              cursor: not-allowed;
              box-shadow: none;
            }

            /* Empty State */
            .empty-state {
              text-align: center;
              padding: 60px 20px;
              background: #fff;
              border-radius: 20px;
              box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
            }

            .empty-icon {
              font-size: 60px;
              color: #e0e0e0;
              margin-bottom: 20px;
            }

            .empty-text {
              color: #6c757d;
              font-size: 18px;
            }
          </style>
        </head>

        <body>
          <jsp:include page="/common/headerChinh.jsp" />

          <div class="site-wrap">

            <!-- Breadcrumb -->
            <div class="breadcrumb-section">
              <div class="container">
                <div class="row align-items-center">
                  <div class="col-md-12">
                    <div class="d-flex align-items-center">
                      <span class="breadcrumb-item"><a href="${cpath}/home"><i class="fas fa-home"></i> Trang
                          chủ</a></span>
                      <span class="breadcrumb-separator"><i class="fas fa-chevron-right"
                          style="font-size: 12px;"></i></span>
                      <span class="breadcrumb-item active">
                        <c:choose>
                          <c:when test="${not empty activeCat}">Cửa hàng — ${activeCat.categoryName}</c:when>
                          <c:otherwise>Cửa hàng</c:otherwise>
                        </c:choose>
                      </span>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Search Form -->
            <div class="search-container">
              <div class="container text-center">
                <form action="${cpath}/shop" method="get" class="d-inline-block w-100 search-form">
                  <c:if test="${cat != null}">
                    <input type="hidden" name="cat" value="${cat}" />
                  </c:if>
                  <div class="input-group" style="max-width: 600px; margin: 0 auto;">
                    <input type="text" name="q" value="${fn:escapeXml(q)}" class="form-control"
                      placeholder="Tìm kiếm sản phẩm...">
                    <div class="input-group-append">
                      <button class="btn" type="submit">
                        <i class="fas fa-search"></i> TÌM KIẾM
                      </button>
                    </div>
                  </div>
                </form>
              </div>
            </div>

            <!-- Product List -->
            <div class="site-section">
              <div class="container">
                <div class="row">
                  <c:if test="${empty products}">
                    <div class="col-12">
                      <div class="empty-state">
                        <div class="empty-icon"><i class="fas fa-box-open"></i></div>
                        <p class="empty-text">
                          <c:choose>
                            <c:when test="${not empty activeCat}">
                              Chưa có sản phẩm nào trong danh mục <strong>${activeCat.categoryName}</strong>.
                            </c:when>
                            <c:otherwise>Không tìm thấy sản phẩm nào.</c:otherwise>
                          </c:choose>
                        </p>
                        <a href="${cpath}/shop" class="btn btn-primary mt-3"
                          style="background: #2e7d32; border: none; border-radius: 25px; padding: 10px 30px;">Xem tất cả
                          sản phẩm</a>
                      </div>
                    </div>
                  </c:if>

                  <!-- Locale for Currency -->
                  <fmt:setLocale value="vi_VN" />

                  <c:forEach var="p" items="${products}">
                    <div class="col-sm-6 col-lg-4 mb-4" data-aos="fade-up">
                      <div class="product-card">
                        <div class="product-image-wrapper">
                          <img src="${cpath}/${p.imageUrl}" alt="${p.productName}">
                          <div class="product-actions">
                            <a href="${cpath}/product-detail?id=${p.productId}" class="action-btn" title="Xem chi tiết">
                              <i class="fas fa-eye"></i>
                            </a>
                            <a href="${cpath}/cart-add?id=${p.productId}" class="action-btn" title="Thêm vào giỏ">
                              <i class="fas fa-shopping-cart"></i>
                            </a>
                          </div>
                        </div>
                        <div class="product-info">
                          <h3 class="product-title">
                            <a href="${cpath}/product-detail?id=${p.productId}">${p.productName}</a>
                          </h3>
                          <p class="product-price">
                            <fmt:formatNumber value="${p.price}" type="currency" />
                          </p>
                        </div>
                      </div>
                    </div>
                  </c:forEach>
                </div>

                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                  <div class="row pagination-container">
                    <div class="col-md-12">
                      <ul class="custom-pagination">
                        <!-- Prev -->
                        <c:url var="prevUrl" value="/shop">
                          <c:param name="page" value="${page-1}" />
                          <c:if test="${cat != null}">
                            <c:param name="cat" value="${cat}" />
                          </c:if>
                          <c:if test="${not empty q}">
                            <c:param name="q" value="${q}" />
                          </c:if>
                        </c:url>
                        <li class="${page==1?'disabled':''}">
                          <c:choose>
                            <c:when test="${page==1}"><span><i class="fas fa-chevron-left"></i></span></c:when>
                            <c:otherwise><a href="${prevUrl}"><i class="fas fa-chevron-left"></i></a></c:otherwise>
                          </c:choose>
                        </li>

                        <c:forEach var="i" begin="1" end="${totalPages}">
                          <c:url var="pageUrl" value="/shop">
                            <c:param name="page" value="${i}" />
                            <c:if test="${cat != null}">
                              <c:param name="cat" value="${cat}" />
                            </c:if>
                            <c:if test="${not empty q}">
                              <c:param name="q" value="${q}" />
                            </c:if>
                          </c:url>
                          <li class="${i==page?'active':''}">
                            <c:choose>
                              <c:when test="${i==page}"><span>${i}</span></c:when>
                              <c:otherwise><a href="${pageUrl}">${i}</a></c:otherwise>
                            </c:choose>
                          </li>
                        </c:forEach>

                        <!-- Next -->
                        <c:url var="nextUrl" value="/shop">
                          <c:param name="page" value="${page+1}" />
                          <c:if test="${cat != null}">
                            <c:param name="cat" value="${cat}" />
                          </c:if>
                          <c:if test="${not empty q}">
                            <c:param name="q" value="${q}" />
                          </c:if>
                        </c:url>
                        <li class="${page==totalPages?'disabled':''}">
                          <c:choose>
                            <c:when test="${page==totalPages}"><span><i class="fas fa-chevron-right"></i></span>
                            </c:when>
                            <c:otherwise><a href="${nextUrl}"><i class="fas fa-chevron-right"></i></a></c:otherwise>
                          </c:choose>
                        </li>
                      </ul>
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