<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="utf-8">
  <title>${product.productName} | Pharmative</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico">
  <style>
    /* ----------- CĂN CHỈNH KHU VỰC NÚT ---------- */
    .quantity-wrapper {
      display: flex;
      align-items: center;
      gap: 10px;
      margin-bottom: 20px;
    }

    /* ----------- STYLE NÚT +, - ---------- */
    .qty-btn {
      background-color: white;
      border: 2px solid #8BC34A;
      color: #4CAF50;
      width: 40px;
      height: 40px;
      font-size: 20px;
      font-weight: bold;
      border-radius: 6px;
      transition: all 0.2s;
    }
    .qty-btn:hover {
      background-color: #8BC34A;
      color: white;
    }

    /* ----------- INPUT SỐ LƯỢNG ---------- */
    .qty-input {
      width: 60px;
      height: 40px;
      text-align: center;
      border: 2px solid #8BC34A;
      border-radius: 6px;
      font-weight: 600;
      color: #333;
    }

    /* ----------- NÚT THÊM GIỎ ---------- */
    .btn-add-cart {
      background-color: #4CAF50;
      color: white;
      font-weight: 600;
      border: none;
      padding: 10px 20px;
      border-radius: 6px;
      transition: all 0.2s;
      display: flex;
      align-items: center;
      gap: 8px;
    }
    .btn-add-cart:hover {
      background-color: #43A047;
    }

    /* ----------- NÚT QUAY LẠI ---------- */
    .btn-back {
      border: 2px solid #ccc;
      background: white;
      color: #333;
      border-radius: 6px;
      padding: 8px 16px;
      font-weight: 600;
      transition: all 0.2s;
    }
    .btn-back:hover {
      border-color: #4CAF50;
      color: #4CAF50;
    }
  </style>
</head>

<body>
<div class="site-wrap">
  <jsp:include page="/common/headerChinh.jsp" />

  <div class="bg-light py-3">
    <div class="container">
      <a href="${pageContext.request.contextPath}/index.jsp">Trang chủ</a>
      <span class="mx-2 mb-0">/</span>
      <strong class="text-black">${product.productName}</strong>
    </div>
  </div>

  <div class="site-section">
    <div class="container">
      <div class="row">
        <div class="col-md-6">
          <img src="${pageContext.request.contextPath}/${product.imageUrl}" 
               alt="${product.productName}" class="img-fluid rounded">
        </div>

        <div class="col-md-6">
          <h2 class="text-black mb-4">${product.productName}</h2>

          <table class="table">
            <tr>
              <th>Giá</th>
              <td class="text-success h5">
                <fmt:formatNumber value="${product.price}" pattern="#,### đ"/>
              </td>
            </tr>
            <tr>
              <th>Tồn kho</th>
              <td>${product.stockQuantity}</td>
            </tr>
            <tr>
              <th>Mô tả</th>
              <td>${product.description}</td>
            </tr>
          </table>

          <form action="${pageContext.request.contextPath}/cart" method="post">
            <input type="hidden" name="action" value="add">
            <input type="hidden" name="productId" value="${product.productId}">

            <div class="quantity-wrapper">
              <button type="button" class="qty-btn js-btn-minus">−</button>
              <input type="number" name="quantity" value="1" min="1" max="${product.stockQuantity}" class="qty-input">
              <button type="button" class="qty-btn js-btn-plus">+</button>

              <button type="submit" class="btn-add-cart">
                🛒 <span>Thêm vào giỏ hàng</span>
              </button>
            </div>
          </form>

          <a href="${pageContext.request.contextPath}/shop" class="btn-back mt-3">← Quay lại cửa hàng</a>
        </div>
      </div>
    </div>
  </div>

  <jsp:include page="/common/footerChinh.jsp" />
</div>

<script src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script>
  document.querySelectorAll(".js-btn-plus").forEach(btn => {
    btn.addEventListener("click", () => {
      let input = btn.closest("form").querySelector("input[name='quantity']");
      input.value = parseInt(input.value) + 1;
    });
  });
  document.querySelectorAll(".js-btn-minus").forEach(btn => {
    btn.addEventListener("click", () => {
      let input = btn.closest("form").querySelector("input[name='quantity']");
      if (parseInt(input.value) > 1) input.value = parseInt(input.value) - 1;
    });
  });
</script>
</body>
</html>
