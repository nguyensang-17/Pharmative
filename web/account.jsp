<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    response.setCharacterEncoding("UTF-8");
%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Tài khoản của tôi | Pharmative</title>
        <base href="${cpath}/">

        <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <style>
            :root {
                --primary: #2e7d32;
                --primary-light: #4caf50;
                --primary-dark: #1b5e20;
                --secondary: #8bc34a;
                --success: #4caf50;
                --warning: #ff9800;
                --danger: #f44336;
                --info: #2196f3;
                --dark: #1a1a1a;
                --light: #f8f9fa;
                --white: #ffffff;
                --shadow: 0 2px 20px rgba(0,0,0,0.08);
                --shadow-hover: 0 8px 30px rgba(46,125,50,0.15);
                --radius: 16px;
                --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Nunito', sans-serif;
                background: linear-gradient(135deg, #f5f7fa 0%, #e8f5e9 100%);
                color: var(--dark);
                min-height: 100vh;
            }

            /* Header Banner */
            .account-banner {
                background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
                color: white;
                padding: 60px 0 40px;
                margin-bottom: -50px;
                position: relative;
                overflow: hidden;
            }

            .account-banner::before {
                content: '';
                position: absolute;
                top: 0;
                right: 0;
                width: 400px;
                height: 400px;
                background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
                border-radius: 50%;
            }

            .user-profile-header {
                position: relative;
                z-index: 1;
                display: flex;
                align-items: center;
                gap: 30px;
            }

            .user-avatar-large {
                width: 120px;
                height: 120px;
                border-radius: 50%;
                background: linear-gradient(135deg, var(--secondary), var(--primary-light));
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 3rem;
                font-weight: 800;
                color: white;
                border: 5px solid rgba(255,255,255,0.3);
                box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            }

            .user-info h1 {
                font-size: 2.5rem;
                font-weight: 800;
                margin-bottom: 8px;
            }

            .user-info p {
                font-size: 1.1rem;
                opacity: 0.9;
            }

            /* Container */
            .account-container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 20px 60px;
            }

            /* Stats Cards */
            .stats-row {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 20px;
                margin-bottom: 40px;
            }

            .stat-card {
                background: white;
                border-radius: var(--radius);
                padding: 30px;
                box-shadow: var(--shadow);
                transition: var(--transition);
                position: relative;
                overflow: hidden;
            }

            .stat-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 4px;
                height: 100%;
                background: linear-gradient(180deg, var(--primary), var(--secondary));
            }

            .stat-card:hover {
                transform: translateY(-5px);
                box-shadow: var(--shadow-hover);
            }

            .stat-icon {
                width: 60px;
                height: 60px;
                border-radius: 12px;
                background: linear-gradient(135deg, var(--primary-light), var(--primary));
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.8rem;
                color: white;
                margin-bottom: 15px;
            }

            .stat-value {
                font-size: 2rem;
                font-weight: 800;
                color: var(--primary);
                margin-bottom: 5px;
            }

            .stat-label {
                font-size: 0.95rem;
                color: #666;
                font-weight: 600;
            }

            /* Content Cards */
            .content-card {
                background: white;
                border-radius: var(--radius);
                box-shadow: var(--shadow);
                margin-bottom: 30px;
                overflow: hidden;
                transition: var(--transition);
            }

            .content-card:hover {
                box-shadow: var(--shadow-hover);
            }

            .card-header {
                padding: 25px 30px;
                background: linear-gradient(135deg, #f8f9fa, #e8f5e9);
                border-bottom: 2px solid var(--primary);
            }

            .card-header h3 {
                font-size: 1.5rem;
                font-weight: 700;
                color: var(--primary-dark);
                margin: 0 0 5px;
            }

            .card-header p {
                color: #666;
                margin: 0;
            }

            .card-body {
                padding: 30px;
            }

            /* Form Styles */
            .form-group {
                margin-bottom: 25px;
            }

            .form-label {
                font-weight: 600;
                color: var(--dark);
                margin-bottom: 8px;
                display: block;
                font-size: 0.95rem;
            }

            .form-control {
                width: 100%;
                padding: 12px 16px;
                border: 2px solid #e0e0e0;
                border-radius: 10px;
                font-size: 1rem;
                transition: var(--transition);
                background: #fafafa;
            }

            .form-control:focus {
                outline: none;
                border-color: var(--primary);
                background: white;
                box-shadow: 0 0 0 4px rgba(46,125,50,0.1);
            }

            .form-control:disabled {
                background: #f5f5f5;
                cursor: not-allowed;
            }

            /* Buttons */
            .btn {
                padding: 12px 30px;
                border-radius: 25px;
                font-weight: 600;
                font-size: 1rem;
                border: none;
                cursor: pointer;
                transition: var(--transition);
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }

            .btn-primary {
                background: linear-gradient(135deg, var(--primary), var(--primary-dark));
                color: white;
                box-shadow: 0 4px 15px rgba(46,125,50,0.3);
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(46,125,50,0.4);
            }

            .btn-outline-primary {
                background: white;
                color: var(--primary);
                border: 2px solid var(--primary);
            }

            .btn-outline-primary:hover {
                background: var(--primary);
                color: white;
            }

            /* Alerts */
            .alert {
                padding: 16px 20px;
                border-radius: 12px;
                margin-bottom: 25px;
                border: none;
                display: flex;
                align-items: center;
                gap: 12px;
                font-weight: 600;
            }

            .alert-success {
                background: #e8f5e9;
                color: var(--success);
            }

            .alert-danger {
                background: #ffebee;
                color: var(--danger);
            }

            /* Order Table */
            .order-table-wrapper {
                overflow-x: auto;
            }

            .order-table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0 12px;
            }

            .order-table thead th {
                background: #f8f9fa;
                padding: 15px 20px;
                font-weight: 700;
                color: var(--dark);
                text-align: left;
                border: none;
                white-space: nowrap;
            }

            .order-table tbody tr {
                background: white;
                box-shadow: 0 2px 8px rgba(0,0,0,0.05);
                transition: var(--transition);
            }

            .order-table tbody tr:hover {
                box-shadow: 0 4px 15px rgba(0,0,0,0.1);
                transform: translateY(-2px);
            }

            .order-table tbody td {
                padding: 20px;
                border: none;
            }

            .order-table tbody tr td:first-child {
                border-radius: 12px 0 0 12px;
            }

            .order-table tbody tr td:last-child {
                border-radius: 0 12px 12px 0;
            }

            .order-id {
                font-weight: 700;
                color: var(--primary);
                font-size: 1.1rem;
            }

            .badge {
                padding: 8px 16px;
                border-radius: 20px;
                font-size: 0.85rem;
                font-weight: 700;
                display: inline-block;
            }

            .badge-pending {
                background: #fff3cd;
                color: #ff9800;
            }

            .badge-processing {
                background: #cfe2ff;
                color: #0d6efd;
            }

            .badge-shipped {
                background: #d1ecf1;
                color: #0c5460;
            }

            .badge-delivered {
                background: #d4edda;
                color: var(--success);
            }

            .badge-cancelled {
                background: #f8d7da;
                color: var(--danger);
            }

            /* Empty State */
            .empty-state {
                text-align: center;
                padding: 60px 20px;
            }

            .empty-state-icon {
                width: 120px;
                height: 120px;
                margin: 0 auto 25px;
                background: linear-gradient(135deg, var(--primary-light), var(--primary));
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 3rem;
                color: white;
            }

            .empty-state h4 {
                font-size: 1.5rem;
                font-weight: 700;
                color: var(--dark);
                margin-bottom: 15px;
            }

            .empty-state p {
                color: #666;
                margin-bottom: 25px;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .account-banner {
                    padding: 40px 0 30px;
                }

                .user-profile-header {
                    flex-direction: column;
                    text-align: center;
                }

                .user-info h1 {
                    font-size: 2rem;
                }

                .stats-row {
                    grid-template-columns: repeat(2, 1fr);
                }

                .card-body {
                    padding: 20px;
                }

                .order-table {
                    font-size: 0.9rem;
                }

                .order-table thead {
                    display: none;
                }

                .order-table tbody tr {
                    display: grid;
                    gap: 10px;
                    padding: 15px;
                    margin-bottom: 15px;
                }

                .order-table tbody tr td:first-child,
                .order-table tbody tr td:last-child {
                    border-radius: 0;
                }
            }
        </style>
    </head>

    <body>
        <jsp:include page="/common/headerChinh.jsp" />

        <!-- Banner -->
        <div class="account-banner">
            <div class="container">
                <div class="user-profile-header">
                    <div class="user-avatar-large">
                        <c:set var="userName" value="${user.fullname}" />
                        <c:choose>
                            <c:when test="${not empty userName}">
                                ${userName.substring(0,1).toUpperCase()}
                            </c:when>
                            <c:otherwise>
                                <i class="fas fa-user"></i>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="user-info">
                        <h1>Xin chào, <c:out value="${user.fullname}" default="Khách hàng"/>!</h1>
                        <p><i class="fas fa-envelope"></i> <c:out value="${user.email}"/></p>
                    </div>
                </div>
            </div>
        </div>

        <div class="account-container">
            <!-- Alerts -->
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle fa-lg"></i>
                    <span>${successMessage}</span>
                </div>
            </c:if>

            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle fa-lg"></i>
                    <span>${errorMessage}</span>
                </div>
            </c:if>

            <!-- Stats -->
            <div class="stats-row">
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-shopping-bag"></i>
                    </div>
                    <div class="stat-value">
                        <c:choose>
                            <c:when test="${not empty orderHistory}">${orderHistory.size()}</c:when>
                            <c:otherwise>0</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="stat-label">Đơn hàng</div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-star"></i>
                    </div>
                    <div class="stat-value">VIP</div>
                    <div class="stat-label">Thành viên</div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <div class="stat-value">
                        <i class="fas fa-check" style="color: var(--success);"></i>
                    </div>
                    <div class="stat-label">Đã xác thực</div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-gift"></i>
                    </div>
                    <div class="stat-value">0</div>
                    <div class="stat-label">Ưu đãi</div>
                </div>
            </div>

            <!-- Content Grid -->
            <div class="row">
                <!-- Thông tin cá nhân -->
                <div class="col-lg-6 mb-4">
                    <div class="content-card">
                        <div class="card-header">
                            <h3><i class="fas fa-user-edit"></i> Thông tin cá nhân</h3>
                            <p>Cập nhật thông tin của bạn</p>
                        </div>
                        <div class="card-body">
                            <form method="post" action="${cpath}/account">
                                <input type="hidden" name="action" value="updateProfile" />

                                <div class="form-group">
                                    <label class="form-label">
                                        <i class="fas fa-user"></i> Họ và tên
                                    </label>
                                    <input type="text" class="form-control" name="fullname"
                                           value="<c:out value='${user.fullname}'/>" required>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">
                                        <i class="fas fa-envelope"></i> Email
                                    </label>
                                    <input type="email" class="form-control" 
                                           value="<c:out value='${user.email}'/>" disabled>
                                    <small style="color: #666; font-size: 0.85rem;">
                                        <i class="fas fa-info-circle"></i> Email không thể thay đổi
                                    </small>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">
                                        <i class="fas fa-phone"></i> Số điện thoại
                                    </label>
                                    <input type="text" class="form-control" name="phone_number"
                                           value="<c:out value='${user.phoneNumber}'/>" 
                                           placeholder="Nhập số điện thoại">
                                </div>

                                <div class="form-group">
                                    <label class="form-label">
                                        <i class="fas fa-map-marker-alt"></i> Địa chỉ giao hàng
                                    </label>
                                    <textarea class="form-control" name="address" rows="3" 
                                              placeholder="Nhập địa chỉ giao hàng đầy đủ"><c:out value='${user.address}'/></textarea>
                                </div>

                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> Lưu thay đổi
                                </button>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Đổi mật khẩu -->
                <div class="col-lg-6 mb-4">
                    <div class="content-card">
                        <div class="card-header">
                            <h3><i class="fas fa-lock"></i> Đổi mật khẩu</h3>
                            <p>Bảo mật tài khoản của bạn</p>
                        </div>
                        <div class="card-body">
                            <form method="post" action="${cpath}/account" id="changePasswordForm">
                                <input type="hidden" name="action" value="changePassword" />

                                <div class="form-group">
                                    <label class="form-label">
                                        <i class="fas fa-key"></i> Mật khẩu hiện tại
                                    </label>
                                    <input type="password" class="form-control" 
                                           name="currentPassword" required>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">
                                        <i class="fas fa-lock"></i> Mật khẩu mới
                                    </label>
                                    <input type="password" class="form-control" 
                                           name="newPassword" id="newPassword" required>
                                    <small style="color: #666; font-size: 0.85rem;">
                                        <i class="fas fa-info-circle"></i> Ít nhất 6 ký tự
                                    </small>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">
                                        <i class="fas fa-check-circle"></i> Xác nhận mật khẩu mới
                                    </label>
                                    <input type="password" class="form-control" 
                                           name="confirmPassword" id="confirmPassword" required>
                                </div>

                                <button type="submit" class="btn btn-outline-primary">
                                    <i class="fas fa-shield-alt"></i> Đổi mật khẩu
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Lịch sử đơn hàng -->
            <div class="content-card">
                <div class="card-header">
                    <h3><i class="fas fa-history"></i> Lịch sử đơn hàng</h3>
                    <p>Theo dõi các đơn hàng của bạn</p>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${empty orderHistory}">
                            <div class="empty-state">
                                <div class="empty-state-icon">
                                    <i class="fas fa-shopping-cart"></i>
                                </div>
                                <h4>Chưa có đơn hàng nào</h4>
                                <p>Hãy khám phá các sản phẩm và thực hiện đơn hàng đầu tiên của bạn!</p>
                                <a href="${cpath}/shop" class="btn btn-primary">
                                    <i class="fas fa-store"></i> Mua sắm ngay
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="order-table-wrapper">
                                <table class="order-table">
                                    <thead>
                                        <tr>
                                            <th>Mã đơn</th>
                                            <th>Ngày đặt</th>
                                            <th>Trạng thái</th>
                                            <th>Phương thức</th>
                                            <th>Tổng tiền</th>
                                            <th>Địa chỉ</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="order" items="${orderHistory}">
                                            <tr>
                                                <td>
                                                    <span class="order-id">#${order.orderId}</span>
                                                </td>
                                                <td>
                                                    <i class="far fa-calendar"></i>
                                                    <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy" />
                                                    <br>
                                                    <small style="color: #999;">
                                                        <fmt:formatDate value="${order.orderDate}" pattern="HH:mm" />
                                                    </small>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${order.status == 'pending'}">
                                                            <span class="badge badge-pending">
                                                                <i class="fas fa-clock"></i> Đang xử lý
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${order.status == 'processing'}">
                                                            <span class="badge badge-processing">
                                                                <i class="fas fa-cog fa-spin"></i> Đang chuẩn bị
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${order.status == 'shipped'}">
                                                            <span class="badge badge-shipped">
                                                                <i class="fas fa-shipping-fast"></i> Đang giao
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${order.status == 'delivered'}">
                                                            <span class="badge badge-delivered">
                                                                <i class="fas fa-check-circle"></i> Hoàn thành
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${order.status == 'cancelled'}">
                                                            <span class="badge badge-cancelled">
                                                                <i class="fas fa-times-circle"></i> Đã hủy
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge badge-pending">${order.status}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${order.paymentMethod == 'cod'}">
                                                            <i class="fas fa-money-bill-wave" style="color: #4caf50;"></i> COD
                                                        </c:when>
                                                        <c:when test="${order.paymentMethod == 'vnpay'}">
                                                            <i class="fas fa-credit-card" style="color: #2196f3;"></i> VNPay
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${order.paymentMethod}
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <strong style="color: var(--primary); font-size: 1.1rem;">
                                                        <fmt:formatNumber value="${order.totalAmount}" pattern="#,###₫"/>
                                                    </strong>
                                                </td>
                                                <td>
                                                    <small style="color: #666; max-width: 200px; display: block;">
                                                        <i class="fas fa-map-marker-alt"></i>
                                                        <c:out value="${order.shippingAddress}"/>
                                                    </small>
                                                </td>
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

        <jsp:include page="/common/footerChinh.jsp" />

        <script src="js/jquery-3.3.1.min.js"></script>
        <script src="js/bootstrap.bundle.min.js"></script>
        <script>
            $(document).ready(function () {
                // Password match validation
                $('#confirmPassword').on('input', function () {
                    const newPassword = $('#newPassword').val();
                    const confirmPassword = $(this).val();

                    if (confirmPassword && newPassword !== confirmPassword) {
                        $(this).css('border-color', 'var(--danger)');
                    } else {
                        $(this).css('border-color', 'var(--primary)');
                    }
                });

                // Form validation
                $('#changePasswordForm').on('submit', function (e) {
                    const newPassword = $('#newPassword').val();
                    const confirmPassword = $('#confirmPassword').val();

                    if (newPassword !== confirmPassword) {
                        e.preventDefault();
                        alert('Mật khẩu mới và xác nhận không khớp!');
                        return false;
                    }

                    if (newPassword.length < 6) {
                        e.preventDefault();
                        alert('Mật khẩu phải có ít nhất 6 ký tự!');
                        return false;
                    }
                });

                // Auto hide alerts
                setTimeout(function () {
                    $('.alert').fadeOut('slow');
                }, 5000);
            });
        </script>
    </body>
</html>