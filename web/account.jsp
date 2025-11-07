<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Tài khoản của tôi | Pharmative</title>
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css' />">
    <link rel="stylesheet" href="<c:url value='/css/style.css' />">
    <style>
        .account-wrapper {
            padding: 40px 0;
        }
        .account-card {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
            padding: 30px;
            margin-bottom: 30px;
        }
        .account-card h4 {
            font-size: 20px;
            margin-bottom: 20px;
            font-weight: 600;
        }
        .order-table th, .order-table td {
            vertical-align: middle;
        }
        .form-label {
            font-weight: 500;
        }
    </style>
</head>
<body>
<jsp:include page="common/headerChinh.jsp" />

<div class="container account-wrapper">
    <div class="row">
        <div class="col-12 mb-3">
            <h2 class="h4">Xin chào, <c:out value="${user.fullname}" default="Khách hàng"/></h2>
            <p class="text-muted mb-0">Quản lý thông tin cá nhân và theo dõi đơn hàng của bạn.</p>
        </div>
    </div>

    <c:if test="${not empty successMessage}">
        <div class="alert alert-success" role="alert">
            ${successMessage}
        </div>
    </c:if>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger" role="alert">
            ${errorMessage}
        </div>
    </c:if>

    <div class="row">
        <div class="col-lg-6">
            <div class="account-card">
                <h4>Thông tin cá nhân</h4>
                <form method="post" action="<c:url value='/account' />">
                    <input type="hidden" name="action" value="updateProfile" />
                    <div class="mb-3">
                        <label class="form-label" for="fullname">Họ và tên</label>
                        <input type="text" class="form-control" id="fullname" name="fullname"
                               value="<c:out value='${user.fullname}'/>" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="email">Email</label>
                        <input type="email" class="form-control" id="email" value="<c:out value='${user.email}'/>" disabled>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="phone_number">Số điện thoại</label>
                        <input type="text" class="form-control" id="phone_number" name="phone_number"
                               value="<c:out value='${user.phoneNumber}'/>">
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="address">Địa chỉ giao hàng</label>
                        <textarea class="form-control" id="address" name="address" rows="3"><c:out value='${user.address}'/></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                </form>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="account-card">
                <h4>Đổi mật khẩu</h4>
                <form method="post" action="<c:url value='/account' />">
                    <input type="hidden" name="action" value="changePassword" />
                    <div class="mb-3">
                        <label class="form-label" for="currentPassword">Mật khẩu hiện tại</label>
                        <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="newPassword">Mật khẩu mới</label>
                        <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                        <small class="form-text text-muted">Ít nhất 6 ký tự, nên kết hợp chữ hoa, chữ thường và số.</small>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="confirmPassword">Xác nhận mật khẩu mới</label>
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                    </div>
                    <button type="submit" class="btn btn-outline-primary">Đổi mật khẩu</button>
                </form>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-12">
            <div class="account-card">
                <h4>Lịch sử đơn hàng</h4>
                <c:choose>
                    <c:when test="${empty orderHistory}">
                        <p>Bạn chưa có đơn hàng nào. <a href="<c:url value='/shop.jsp' />">Tiếp tục mua sắm</a>.</p>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table table-striped order-table">
                                <thead class="table-light">
                                <tr>
                                    <th scope="col">Mã đơn</th>
                                    <th scope="col">Ngày đặt</th>
                                    <th scope="col">Trạng thái</th>
                                    <th scope="col">Tổng tiền</th>
                                    <th scope="col">Địa chỉ giao</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="order" items="${orderHistory}">
                                    <tr>
                                        <td>#${order.orderId}</td>
                                        <td><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm" /></td>
                                        <td><span class="badge bg-secondary text-uppercase">${order.status}</span></td>
                                        <td><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫" minFractionDigits="0" /></td>
                                        <td><c:out value="${order.shippingAddress}"/></td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>
<script src="<c:url value='/js/jquery-3.3.1.min.js' />"></script>
<script src="<c:url value='/js/bootstrap.min.js' />"></script>
</body>
</html>