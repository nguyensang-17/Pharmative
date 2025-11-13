<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <base href="${cpath}/">

        <title>Đặt hàng thành công - Pharmative</title>

        <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/style.css">

        <style>
            :root {
                --primary-color: #2e7d32;
                --primary-light: #4caf50;
                --success-color: #4caf50;
                --bg-light: #f8f9fa;
                --white: #ffffff;
            }

            body {
                font-family: 'Nunito', sans-serif;
                background-color: var(--bg-light);
            }

            .success-container {
                max-width: 800px;
                margin: 60px auto;
                padding: 0 15px;
            }

            .success-card {
                background: var(--white);
                border-radius: 12px;
                box-shadow: 0 4px 20px rgba(0,0,0,0.1);
                padding: 50px 40px;
                text-align: center;
            }

            .success-icon {
                width: 100px;
                height: 100px;
                background: linear-gradient(135deg, #4caf50, #66bb6a);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 30px;
                animation: scaleIn 0.5s ease-out;
            }

            .success-icon::before {
                content: "✓";
                font-size: 50px;
                color: white;
                font-weight: bold;
            }

            @keyframes scaleIn {
                from {
                    transform: scale(0);
                    opacity: 0;
                }
                to {
                    transform: scale(1);
                    opacity: 1;
                }
            }

            .success-title {
                font-size: 2rem;
                font-weight: 700;
                color: var(--success-color);
                margin-bottom: 15px;
            }

            .success-message {
                font-size: 1.1rem;
                color: #555;
                margin-bottom: 30px;
                line-height: 1.6;
            }

            .order-info {
                background: #f8f9fa;
                border-radius: 8px;
                padding: 25px;
                margin: 30px 0;
                text-align: left;
            }

            .order-info-row {
                display: flex;
                justify-content: space-between;
                padding: 12px 0;
                border-bottom: 1px solid #e0e0e0;
            }

            .order-info-row:last-child {
                border-bottom: none;
            }

            .order-info-label {
                font-weight: 600;
                color: #333;
            }

            .order-info-value {
                color: #666;
            }

            .order-id {
                color: var(--primary-color);
                font-weight: 700;
                font-size: 1.2rem;
            }

            .action-buttons {
                display: flex;
                gap: 15px;
                justify-content: center;
                margin-top: 30px;
            }

            .btn-primary {
                background: var(--primary-color);
                border: none;
                padding: 12px 30px;
                border-radius: 25px;
                font-weight: 600;
                transition: all 0.3s;
            }

            .btn-primary:hover {
                background: #1b5e20;
                transform: translateY(-2px);
                box-shadow: 0 6px 15px rgba(46, 125, 50, 0.3);
            }

            .btn-outline-primary {
                border: 2px solid var(--primary-color);
                color: var(--primary-color);
                padding: 12px 30px;
                border-radius: 25px;
                font-weight: 600;
                transition: all 0.3s;
            }

            .btn-outline-primary:hover {
                background: var(--primary-color);
                color: white;
            }

            .payment-method {
                display: inline-block;
                padding: 6px 15px;
                border-radius: 20px;
                font-size: 0.9rem;
                font-weight: 600;
            }

            .payment-cod {
                background: #fff3cd;
                color: #856404;
            }

            .payment-vnpay {
                background: #d1ecf1;
                color: #0c5460;
            }

            .next-steps {
                background: #e8f5e9;
                border-left: 4px solid var(--success-color);
                padding: 20px;
                margin: 30px 0;
                text-align: left;
                border-radius: 4px;
            }

            .next-steps h5 {
                color: var(--primary-color);
                margin-bottom: 15px;
            }

            .next-steps ul {
                margin: 0;
                padding-left: 20px;
            }

            .next-steps li {
                margin: 8px 0;
                color: #555;
            }
        </style>
    </head>

    <body>
        <jsp:include page="/common/headerChinh.jsp" />

        <div class="success-container">
            <div class="success-card">
                <div class="success-icon"></div>

                <h1 class="success-title">Đặt hàng thành công!</h1>

                <p class="success-message">
                    Cảm ơn bạn đã mua sắm tại Pharmative. 
                    <br>Đơn hàng của bạn đã được ghi nhận và đang được xử lý.
                </p>

                <div class="order-info">
                    <div class="order-info-row">
                        <span class="order-info-label">Mã đơn hàng:</span>
                        <span class="order-id">#${param.orderId}</span>
                    </div>
                    <div class="order-info-row">
                        <span class="order-info-label">Phương thức thanh toán:</span>
                        <c:choose>
                            <c:when test="${param.method == 'cod'}">
                                <span class="payment-method payment-cod">💵 Thanh toán khi nhận hàng (COD)</span>
                            </c:when>
                            <c:otherwise>
                                <span class="payment-method payment-vnpay">💳 VNPay</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="order-info-row">
                        <span class="order-info-label">Trạng thái:</span>
                        <span class="order-info-value" style="color: #ff9800; font-weight: 600;">Đang xử lý</span>
                    </div>
                </div>

                <div class="next-steps">
                    <h5>📦 Bước tiếp theo:</h5>
                    <ul>
                        <c:choose>
                            <c:when test="${param.method == 'cod'}">
                                <li>Chúng tôi sẽ liên hệ xác nhận đơn hàng trong 24h</li>
                                <li>Vui lòng chuẩn bị số tiền thanh toán khi nhận hàng</li>
                                <li>Thời gian giao hàng dự kiến: 2-3 ngày làm việc</li>
                                </c:when>
                                <c:otherwise>
                                <li>Đơn hàng đã được thanh toán thành công qua VNPay</li>
                                <li>Chúng tôi sẽ tiến hành đóng gói và giao hàng sớm nhất</li>
                                <li>Thời gian giao hàng dự kiến: 2-3 ngày làm việc</li>
                                </c:otherwise>
                            </c:choose>
                        <li>Email xác nhận đã được gửi đến hộp thư của bạn</li>
                        <li>Bạn có thể theo dõi đơn hàng trong mục "Lịch sử đơn hàng"</li>
                    </ul>
                </div>

                <div class="action-buttons">
                    <a href="${cpath}/" class="btn btn-primary">
                        🏠 Về trang chủ
                    </a>
                    <a href="${cpath}/account" class="btn btn-outline-primary">
                        📋 Xem đơn hàng
                    </a>
                </div>

                <p style="margin-top: 30px; color: #888; font-size: 0.9rem;">
                    Nếu có bất kỳ thắc mắc nào, vui lòng liên hệ:<br>
                    📞 Hotline: 1900 1234 | 📧 Email: support@pharmative.com
                </p>
            </div>
        </div>

        <jsp:include page="/common/footerChinh.jsp" />

        <script src="${cpath}/js/jquery-3.3.1.min.js"></script>
        <script src="${cpath}/js/bootstrap.min.js"></script>
    </body>
</html>