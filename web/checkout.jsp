<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.math.BigDecimal" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    response.setCharacterEncoding("UTF-8");
%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />

<%
    Map<Integer, controller.CartController.CartItem> cart
              = (Map<Integer, controller.CartController.CartItem>) session.getAttribute("cart");
    BigDecimal total = BigDecimal.ZERO;
    int itemCount = 0;

    if (cart != null) {
        itemCount = cart.size();
        for (controller.CartController.CartItem it : cart.values()) {
            BigDecimal price = it.getProduct().getPrice();
            if (price == null) {
                price = BigDecimal.ZERO;
            }
            total = total.add(price.multiply(BigDecimal.valueOf(it.getQuantity())));
        }
    }

    request.setAttribute("cartTotal", total);
    request.setAttribute("itemCount", itemCount);
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <base href="${cpath}/">

        <title>Thanh toán - Pharmative</title>

        <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/style.css">

        <style>
            :root {
                --primary-color: #2e7d32;
                --primary-light: #4caf50;
                --primary-dark: #1b5e20;
                --accent-color: #8bc34a;
                --text-dark: #1a1a1a;
                --text-light: #666;
                --bg-light: #f8f9fa;
                --white: #ffffff;
                --border-radius: 8px;
                --box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
                --transition: all 0.3s ease;
            }

            body {
                font-family: 'Nunito', sans-serif;
                color: var(--text-dark);
                line-height: 1.6;
                background-color: var(--bg-light);
            }

            .text-primary {
                color: var(--primary-color) !important;
            }

            .btn-primary {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
                border-radius: 30px;
                padding: 12px 30px;
                font-weight: 600;
                transition: var(--transition);
            }

            .btn-primary:hover {
                background-color: var(--primary-dark);
                border-color: var(--primary-dark);
                transform: translateY(-2px);
                box-shadow: 0 6px 15px rgba(46, 125, 50, 0.3);
            }

            .btn-primary:disabled {
                background-color: #ccc;
                border-color: #ccc;
                transform: none;
                cursor: not-allowed;
            }

            .checkout-container {
                max-width: 1200px;
                margin: 40px auto;
                padding: 0 15px;
            }

            .checkout-card {
                background: var(--white);
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                overflow: hidden;
                margin-bottom: 30px;
            }

            .checkout-header {
                padding: 25px 30px;
                border-bottom: 1px solid #eee;
                background-color: #f8f9fa;
            }

            .checkout-body {
                padding: 30px;
            }

            .order-summary {
                background-color: #f8f9fa;
                border-radius: var(--border-radius);
                padding: 25px;
                margin-bottom: 30px;
            }

            .order-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 15px 0;
                border-bottom: 1px solid #eee;
            }

            .order-item:last-child {
                border-bottom: none;
            }

            .order-item-info {
                display: flex;
                align-items: center;
            }

            .order-item-image {
                width: 60px;
                height: 60px;
                border-radius: 8px;
                overflow: hidden;
                margin-right: 15px;
                flex-shrink: 0;
            }

            .order-item-image img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

            .order-item-details h5 {
                margin-bottom: 5px;
                font-weight: 600;
                font-size: 1rem;
            }

            .order-item-details p {
                margin-bottom: 0;
                font-size: 0.9rem;
            }

            .order-item-price {
                font-weight: 600;
                color: var(--primary-color);
                font-size: 1.05rem;
            }

            .order-total {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding-top: 20px;
                margin-top: 20px;
                border-top: 2px solid #ddd;
                font-size: 1.2rem;
                font-weight: 700;
            }

            .payment-methods {
                margin-top: 30px;
            }

            .payment-option {
                border: 2px solid #eee;
                border-radius: var(--border-radius);
                padding: 20px;
                margin-bottom: 15px;
                cursor: pointer;
                transition: var(--transition);
            }

            .payment-option:hover {
                border-color: var(--primary-light);
                background-color: rgba(46, 125, 50, 0.02);
            }

            .payment-option.selected {
                border-color: var(--primary-color);
                background-color: rgba(46, 125, 50, 0.05);
            }

            .payment-icon {
                font-size: 28px;
                margin-right: 15px;
            }

            .secure-payment {
                display: flex;
                align-items: center;
                justify-content: center;
                margin-top: 20px;
                color: var(--text-light);
                font-size: 14px;
            }

            .secure-payment i {
                margin-right: 8px;
                color: var(--primary-color);
            }

            .empty-cart {
                text-align: center;
                padding: 60px 20px;
            }

            .empty-cart-icon {
                font-size: 80px;
                margin-bottom: 20px;
            }

            .back-link {
                display: inline-flex;
                align-items: center;
                color: var(--text-dark);
                text-decoration: none;
                transition: var(--transition);
            }

            .back-link:hover {
                color: var(--primary-color);
            }

            .spinner {
                display: inline-block;
                width: 16px;
                height: 16px;
                border: 2px solid rgba(255,255,255,.3);
                border-radius: 50%;
                border-top-color: #fff;
                animation: spin 0.8s linear infinite;
                margin-right: 8px;
            }

            @keyframes spin {
                to {
                    transform: rotate(360deg);
                }
            }

            @media (max-width: 768px) {
                .checkout-body {
                    padding: 20px;
                }

                .order-item {
                    flex-direction: column;
                    align-items: flex-start;
                }

                .order-item-info {
                    width: 100%;
                    margin-bottom: 10px;
                }

                .order-item-price {
                    align-self: flex-end;
                }

                .checkout-header h2 {
                    font-size: 1.5rem;
                }
            }
        </style>
    </head>

    <body>
        <jsp:include page="/common/headerChinh.jsp" />

        <div class="site-wrap">
            <div class="checkout-container">
                <div class="checkout-card">
                    <div class="checkout-header">
                        <h2 class="mb-0">Thanh toán đơn hàng</h2>
                        <p class="mb-0 text-muted">Hoàn tất đơn hàng của bạn</p>
                    </div>

                    <div class="checkout-body">
                        <% if (cart != null && !cart.isEmpty()) { %>
                        <div class="row">
                            <!-- Chi tiết đơn hàng -->
                            <div class="col-lg-8">
                                <h4 class="mb-4">Thông tin đơn hàng</h4>

                                <div class="order-summary">
                                    <h5 class="mb-4">Chi tiết sản phẩm</h5>

                                    <%
                                        for (controller.CartController.CartItem item : cart.values()) {
                                            String productName = item.getProduct().getProductName();
                                            String imageUrl = item.getProduct().getImageUrl();
                                            if (imageUrl == null || imageUrl.isEmpty()) {
                                                imageUrl = "images/product-placeholder.jpg";
                                            }
                                            BigDecimal price = item.getProduct().getPrice();
                                            if (price == null) {
                                                price = BigDecimal.ZERO;
                                            }
                                            int quantity = item.getQuantity();
                                            BigDecimal itemTotal = price.multiply(BigDecimal.valueOf(quantity));
                                    %>
                                    <div class="order-item">
                                        <div class="order-item-info">
                                            <div class="order-item-image">
                                                <img src="${cpath}/<%= imageUrl%>" 
                                                     alt="<%= productName%>"
                                                     onerror="this.src='${cpath}/images/product-placeholder.jpg'">
                                            </div>
                                            <div class="order-item-details">
                                                <h5><%= productName%></h5>
                                                <p class="text-muted">Số lượng: <%= quantity%></p>
                                            </div>
                                        </div>
                                        <div class="order-item-price">
                                            <fmt:formatNumber value="<%= itemTotal%>" pattern="#,###₫"/>
                                        </div>
                                    </div>
                                    <% } %>

                                    <div class="order-total">
                                        <span>Tổng thanh toán:</span>
                                        <span class="text-primary">
                                            <fmt:formatNumber value="${cartTotal}" pattern="#,###₫"/>
                                        </span>
                                    </div>
                                </div>

                                <!-- Phương thức thanh toán -->
                                <div class="payment-methods">
                                    <h4 class="mb-4">Phương thức thanh toán</h4>

                                    <div class="payment-option selected" data-method="vnpay">
                                        <div class="d-flex align-items-center">
                                            <div class="payment-icon">💳</div>
                                            <div>
                                                <h5 class="mb-1">Thanh toán qua VNPAY</h5>
                                                <p class="mb-0 text-muted">Thanh toán an toàn qua cổng VNPAY</p>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="payment-option" data-method="cod">
                                        <div class="d-flex align-items-center">
                                            <div class="payment-icon">💵</div>
                                            <div>
                                                <h5 class="mb-1">Thanh toán khi nhận hàng (COD)</h5>
                                                <p class="mb-0 text-muted">Thanh toán tiền mặt khi nhận hàng</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Tóm tắt đơn hàng -->
                            <div class="col-lg-4">
                                <div class="order-summary sticky-top" style="top: 20px;">
                                    <h5 class="mb-4">Tóm tắt đơn hàng</h5>

                                    <div class="d-flex justify-content-between mb-2">
                                        <span>Số sản phẩm:</span>
                                        <span class="fw-bold">${itemCount}</span>
                                    </div>

                                    <div class="d-flex justify-content-between mb-2">
                                        <span>Tạm tính:</span>
                                        <span><fmt:formatNumber value="${cartTotal}" pattern="#,###₫"/></span>
                                    </div>

                                    <div class="d-flex justify-content-between mb-2">
                                        <span>Phí vận chuyển:</span>
                                        <span class="text-success fw-bold">MIỄN PHÍ</span>
                                    </div>

                                    <div class="d-flex justify-content-between mb-3">
                                        <span>Giảm giá:</span>
                                        <span>0₫</span>
                                    </div>

                                    <div class="order-total">
                                        <span>Tổng cộng:</span>
                                        <span class="text-primary">
                                            <fmt:formatNumber value="${cartTotal}" pattern="#,###₫"/>
                                        </span>
                                    </div>

                                    <button id="btnPay" class="btn btn-primary w-100 mt-4 py-3">
                                        🔒 Thanh toán an toàn
                                    </button>

                                    <div class="secure-payment">
                                        🛡️ Giao dịch được bảo mật & mã hóa
                                    </div>
                                </div>

                                <div class="mt-4 text-center">
                                    <a href="${cpath}/cart.jsp" class="back-link">
                                        ← Quay lại giỏ hàng
                                    </a>
                                </div>
                            </div>
                        </div>
                        <% } else { %>
                        <!-- Giỏ hàng trống -->
                        <div class="empty-cart">
                            <div class="empty-cart-icon">🛒</div>
                            <h4 class="text-muted mb-2">Giỏ hàng trống</h4>
                            <p class="text-muted mb-4">Bạn chưa có sản phẩm nào trong giỏ hàng</p>
                            <a href="${cpath}/shop" class="btn btn-primary">
                                🛍️ Tiếp tục mua sắm
                            </a>
                        </div>
                        <% }%>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="/common/footerChinh.jsp" />

        <script src="${cpath}/js/jquery-3.3.1.min.js"></script>
        <script src="${cpath}/js/bootstrap.min.js"></script>

        <script>
            $(document).ready(function () {
                let selectedMethod = 'vnpay'; // Mặc định chọn VNPAY

                // Xử lý chọn phương thức thanh toán
                $('.payment-option').click(function () {
                    $('.payment-option').removeClass('selected');
                    $(this).addClass('selected');
                    selectedMethod = $(this).data('method');
                    console.log('Selected payment method:', selectedMethod);
                });

                // Xử lý thanh toán
                $('#btnPay').click(async function (e) {
                    e.preventDefault();

                    const $btn = $(this);
                    const originalText = $btn.html();

                    // Kiểm tra phương thức thanh toán
                    if (selectedMethod === 'cod') {
                        alert('Chức năng COD đang được phát triển. Vui lòng chọn thanh toán VNPAY.');
                        return;
                    }

                    // Hiển thị loading
                    $btn.html('<span class="spinner"></span> Đang xử lý...');
                    $btn.prop('disabled', true);

                    try {
                        // Gửi request đến VNPay servlet
                        const formData = new URLSearchParams();
                        formData.append('language', 'vn'); // hoặc 'en'
                        // Có thể thêm bankCode nếu muốn: formData.append('bankCode', 'NCB');

                        const response = await fetch('${cpath}/vnpay', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8'
                            },
                            body: formData.toString()
                        });

                        if (!response.ok) {
                            throw new Error('HTTP error! status: ' + response.status);
                        }

                        const result = await response.json();
                        console.log('VNPay response:', result);

                        if (result && result.code === '00' && result.data) {
                            // Chuyển hướng đến trang thanh toán VNPay
                            window.location.href = result.data;
                        } else {
                            throw new Error(result.message || 'Không tạo được URL thanh toán');
                        }

                    } catch (error) {
                        console.error('Payment error:', error);
                        alert('Đã xảy ra lỗi khi xử lý thanh toán:\n' + error.message + '\n\nVui lòng thử lại sau.');

                        // Khôi phục nút
                        $btn.html(originalText);
                        $btn.prop('disabled', false);
                    }
                });

                // Kiểm tra nếu có thông báo từ URL
                const urlParams = new URLSearchParams(window.location.search);
                const paymentStatus = urlParams.get('vnp_ResponseCode');

                if (paymentStatus === '00') {
                    alert('✓ Thanh toán thành công!');
                } else if (paymentStatus) {
                    alert('✗ Thanh toán thất bại. Mã lỗi: ' + paymentStatus);
                }
            });
        </script>
    </body>
</html>