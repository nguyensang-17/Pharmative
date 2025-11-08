<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="cpath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt hàng thành công - Pharmative</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <style>
        .success-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 30px;
            text-align: center;
        }
        .success-icon {
            font-size: 80px;
            color: #28a745;
            margin-bottom: 20px;
        }
        .alert-info {
            text-align: left;
        }
    </style>
</head>
<body>
    <jsp:include page="/common/headerChinh.jsp" />
    
    <div class="container">
        <div class="success-container">
            <div class="success-icon">✓</div>
            <h2>Đặt hàng thành công!</h2>
            <p class="lead">Cảm ơn bạn đã mua sắm tại Pharmative</p>
            
            <c:if test="${not empty param.orderId}">
                <p><strong>Mã đơn hàng:</strong> #${param.orderId}</p>
            </c:if>
            
            <c:choose>
                <c:when test="${param.method == 'cod'}">
                    <div class="alert alert-info">
                        <h5>Thanh toán khi nhận hàng (COD)</h5>
                        <p>Đơn hàng của bạn đã được xác nhận. Chúng tôi sẽ liên hệ với bạn trong thời gian sớm nhất để xác nhận và giao hàng.</p>
                        <p>Vui lòng chuẩn bị số tiền thanh toán khi nhận hàng.</p>
                    </div>
                </c:when>
                <c:when test="${param.method == 'vnpay'}">
                    <div class="alert alert-success">
                        <h5>Thanh toán VNPAY thành công</h5>
                        <p>Đơn hàng của bạn đã được thanh toán và xác nhận. Chúng tôi sẽ xử lý và giao hàng sớm nhất.</p>
                    </div>
                </c:when>
            </c:choose>
            
            <p>Thông tin chi tiết về đơn hàng đã được gửi đến email của bạn.</p>
            
            <div class="mt-4">
                <a href="${cpath}/shop" class="btn btn-primary">Tiếp tục mua sắm</a>
                <a href="${cpath}/order-history" class="btn btn-outline-secondary">Xem đơn hàng</a>
            </div>
        </div>
    </div>
    
    <jsp:include page="/common/footerChinh.jsp" />
</body>
</html>