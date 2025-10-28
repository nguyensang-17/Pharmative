<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="cpath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="vi">
<head>
  <title>Pharmative — Store</title>
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
<style>
  /* Giới hạn kích thước ảnh sản phẩm */
  .item-v2 img {
    width: 250px;
    height: 250px;
    object-fit: cover;
    border-radius: 10px;
    margin-bottom: 10px;
  }

  /* Canh giữa mỗi item */
  .item-v2 {
    display: flex;
    flex-direction: column;
    align-items: center;
  }
</style>
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

    <!-- form tìm kiếm -->
    <div class="py-5">
  <div class="container text-center">
    <form action="${cpath}/shop" method="get" class="d-inline-block">
      <c:if test="${cat != null}">
        <input type="hidden" name="cat" value="${cat}"/>
      </c:if>
      <div class="input-group mb-3" style="max-width: 500px; margin: 0 auto;">
        <input type="text" name="q" value="${fn:escapeXml(q)}"
               class="form-control" placeholder="Tìm theo tên...">
        <div class="input-group-append">
          <button class="btn btn-success" type="submit">TÌM</button>
        </div>
      </div>
    </form>
  </div>
</div>

    <!-- danh sách sản phẩm -->
    <div class="site-section bg-light">
      <div class="container">
        <div class="row">
          <c:if test="${empty products}">
            <div class="col-12">
              <div class="alert alert-info">Chưa có sản phẩm.</div>
            </div>
          </c:if>

          <c:forEach var="p" items="${products}">
            <div class="col-sm-6 col-lg-4 text-center item mb-4 item-v2">
              <a href="${cpath}/product-detail?id=${p.productId}">
                <img src="${cpath}/${p.imageUrl}" alt="${p.productName}">
              </a>
              <h3 class="text-dark mt-3">
                <a href="${cpath}/product-detail?id=${p.productId}">${p.productName}</a>
              </h3>
              <p class="price">
                <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫"/>
              </p>
            </div>
          </c:forEach>
        </div>

        <!-- phân trang: giữ lại q và cat -->
        <c:if test="${totalPages > 1}">
          <div class="row mt-5">
            <div class="col-md-12 text-center">
              <div class="site-block-27">
                <ul>
                  <c:url var="prevUrl" value="/shop">
                    <c:param name="page" value="${page-1}"/>
                    <c:if test="${cat != null}"><c:param name="cat" value="${cat}"/></c:if>
                    <c:if test="${not empty q}"><c:param name="q" value="${q}"/></c:if>
                  </c:url>
                  <li class="${page==1?'disabled':''}">
                    <a href="${prevUrl}">&lt;</a>
                  </li>

                  <c:forEach var="i" begin="1" end="${totalPages}">
                    <c:url var="pageUrl" value="/shop">
                      <c:param name="page" value="${i}"/>
                      <c:if test="${cat != null}"><c:param name="cat" value="${cat}"/></c:if>
                      <c:if test="${not empty q}"><c:param name="q" value="${q}"/></c:if>
                    </c:url>
                    <li class="${i==page?'active':''}">
                      <c:choose>
                        <c:when test="${i==page}">
                          <span>${i}</span>
                        </c:when>
                        <c:otherwise>
                          <a href="${pageUrl}">${i}</a>
                        </c:otherwise>
                      </c:choose>
                    </li>
                  </c:forEach>

                  <c:url var="nextUrl" value="/shop">
                    <c:param name="page" value="${page+1}"/>
                    <c:if test="${cat != null}"><c:param name="cat" value="${cat}"/></c:if>
                    <c:if test="${not empty q}"><c:param name="q" value="${q}"/></c:if>
                  </c:url>
                  <li class="${page==totalPages?'disabled':''}">
                    <a href="${nextUrl}">&gt;</a>
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
