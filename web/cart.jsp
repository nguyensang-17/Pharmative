<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="utf-8">
  <title>Giỏ hàng | Pharmative</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

  <style>
    .table th, .table td {
      vertical-align: middle !important;
    }
    .btn-update {
      background-color: #4CAF50;
      border: none;
      color: white;
      font-weight: 600;
      padding: 5px 12px;
      border-radius: 6px;
      transition: 0.2s;
    }
    .btn-update:hover {
      background-color: #43A047;
    }
    .btn-remove {
      border: none;
      background-color: #f44336;
      color: white;
      font-weight: 600;
      padding: 5px 12px;
      border-radius: 6px;
      transition: 0.2s;
    }
    .btn-remove:hover {
      background-color: #e53935;
    }
    .alert-success {
      background-color: #d4edda;
      color: #155724;
      border: 1px solid #c3e6cb;
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
      <strong class="text-black">Giỏ hàng</strong>
    </div>
  </div>

  <div class="site-section">
    <div class="container">

      <c:if test="${param.success == 'added'}">
        <div class="alert alert-success text-center mb-4">✅ Sản phẩm đã được thêm vào giỏ hàng!</div>
      </c:if>

      <c:choose>
        <c:when test="${not empty sessionScope.cart}">
          <c:set var="cartTotal" value="0" scope="page"/>

          <div class="row mb-5">
            <div class="col-md-12">
              <div class="site-blocks-table">
                <table class="table table-bordered text-center align-middle">
                  <thead class="thead-light">
                    <tr>
                      <th>Ảnh</th>
                      <th>Sản phẩm</th>
                      <th>Giá</th>
                      <th>Số lượng</th>
                      <th>Tổng</th>
                      <th>Thao tác</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="item" items="${sessionScope.cart.values()}">
                      <c:if test="${not empty item and not empty item.product}">
                        <c:set var="lineTotal" value="${item.product.price * item.quantity}" />
                        <c:set var="cartTotal" value="${cartTotal + lineTotal}" scope="page" />

                        <tr data-product-id="${item.product.productId}">
                          <td>
                            <img src="${pageContext.request.contextPath}/${item.product.imageUrl}"
                                 alt="${item.product.productName}"
                                 class="img-thumbnail rounded"
                                 style="width:80px; height:80px; object-fit:cover;">
                          </td>
                          <td><strong>${item.product.productName}</strong></td>
                          <td><fmt:formatNumber value="${item.product.price}" pattern="#,###₫" /></td>
                          <td>
                            <input type="number" min="1" value="${item.quantity}" 
                                   class="form-control text-center quantity-input"
                                   style="width:80px; display:inline-block;">
                          </td>
                          <td class="line-total"><fmt:formatNumber value="${lineTotal}" pattern="#,###₫" /></td>
                          <td>
                            <button class="btn-update update-btn">Cập nhật</button>
                            <form action="${pageContext.request.contextPath}/cart" method="post" class="d-inline">
                              <input type="hidden" name="action" value="remove">
                              <input type="hidden" name="productId" value="${item.product.productId}">
                              <button type="submit" class="btn-remove">Xóa</button>
                            </form>
                          </td>
                        </tr>
                      </c:if>
                    </c:forEach>
                  </tbody>
                </table>
              </div>
            </div>
          </div>

          <div class="row justify-content-end">
            <div class="col-md-5">
              <div class="p-4 border bg-light rounded">
                <h4 class="mb-3">Tổng cộng</h4>
                <div class="d-flex justify-content-between mb-3">
                  <span>Tạm tính:</span>
                  <strong id="subtotal"><fmt:formatNumber value="${cartTotal}" pattern="#,###₫"/></strong>
                </div>
                <hr>
                <div class="d-flex justify-content-between mb-3">
                  <span>Tổng thanh toán:</span>
                  <strong id="grandtotal" class="text-primary"><fmt:formatNumber value="${cartTotal}" pattern="#,###₫"/></strong>
                </div>
                <a href="checkout.jsp" class="btn btn-primary btn-block">Thanh toán</a>
                <a href="shop" class="btn btn-outline-secondary btn-block mt-2">← Tiếp tục mua hàng</a>
              </div>
            </div>
          </div>
        </c:when>

        <c:otherwise>
          <div class="alert alert-warning text-center">
            <h4>🛒 Giỏ hàng của bạn đang trống.</h4>
            <a href="shop" class="btn btn-outline-primary mt-3">Tiếp tục mua sắm</a>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <jsp:include page="/common/footerChinh.jsp" />
</div>

<script src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>

<script>
  $(document).ready(function() {
    $(".update-btn").click(function() {
      const row = $(this).closest("tr");
      const productId = row.data("product-id");
      const quantity = row.find(".quantity-input").val();

      $.ajax({
        url: "${pageContext.request.contextPath}/cart",
        type: "POST",
        data: {
          action: "update",
          productId: productId,
          quantity: quantity
        },
        success: function(response) {
          // Cập nhật lại dòng sản phẩm và tổng tiền
          row.find(".line-total").text(response.lineTotalFormatted);
          $("#subtotal").text(response.cartTotalFormatted);
          $("#grandtotal").text(response.cartTotalFormatted);
        },
        error: function() {
          alert("Cập nhật giỏ hàng thất bại, vui lòng thử lại.");
        }
      });
    });
  });
</script>

</body>
</html>
