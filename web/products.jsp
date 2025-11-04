<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Pharmative - Sản phẩm</title>
  <link rel="stylesheet" href="css/bootstrap.min.css">
  <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico">
</head>
<body class="container py-4">

  <h2 class="mb-3">Danh sách sản phẩm</h2>

  <!-- Search + Category filter (tuỳ) -->
  <form class="row g-2 mb-3" method="get" action="products">
    <div class="col-sm-4">
      <input name="search" value="${search}" class="form-control" placeholder="Tìm theo tên...">
    </div>
    <div class="col-sm-4">
      <select class="form-select form-control" name="categoryId">
        <option value="">-- Tất cả danh mục --</option>
        <c:forEach var="c" items="${categories}">
          <option value="${c.categoryId}" ${selectedCategoryId==c.categoryId?'selected':''}>
            ${c.categoryName}
          </option>
        </c:forEach>
      </select>
    </div>
    <div class="col-sm-4">
      <button class="btn btn-primary">Lọc</button>
      <a class="btn btn-outline-secondary" href="products">Xoá lọc</a>
    </div>
  </form>

  <!-- Grid sản phẩm -->
  <div class="row">
    <c:forEach var="p" items="${products}">
      <div class="col-md-4 mb-4">
        <div class="card h-100">
          <img class="card-img-top" src="${p.imageUrl}" alt="${p.productName}">
          <div class="card-body">
            <h5 class="card-title">${p.productName}</h5>
            <p class="card-text text-danger fw-bold">${p.price}</p>
            <a class="btn btn-sm btn-outline-primary" href="product?id=${p.productId}">Xem chi tiết</a>
          </div>
        </div>
      </div>
    </c:forEach>

    <c:if test="${empty products}">
      <div class="col-12"><div class="alert alert-info">Chưa có sản phẩm.</div></div>
    </c:if>
  </div>

  <!-- Phân trang -->
  <nav aria-label="pagination">
    <ul class="pagination justify-content-center">
      <li class="page-item ${currentPage==1?'disabled':''}">
        <a class="page-link" href="products?page=${currentPage-1}">«</a>
      </li>
      <c:forEach var="i" begin="1" end="${totalPages}">
        <li class="page-item ${i==currentPage?'active':''}">
          <a class="page-link"
             href="products?page=${i}&categoryId=${selectedCategoryId}&search=${search}">${i}</a>
        </li>
      </c:forEach>
      <li class="page-item ${currentPage==totalPages?'disabled':''}">
        <a class="page-link" href="products?page=${currentPage+1}">»</a>
      </li>
    </ul>
  </nav>

  <script src="js/bootstrap.min.js"></script>
</body>
</html>
