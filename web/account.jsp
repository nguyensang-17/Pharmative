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

            .btn-outline-primary {
                color: var(--primary-color);
                border-color: var(--primary-color);
                border-radius: 30px;
                padding: 10px 25px;
                font-weight: 600;
                transition: var(--transition);
            }

            .btn-outline-primary:hover {
                background-color: var(--primary-color);
                color: white;
            }

            .account-container {
                max-width: 1200px;
                margin: 40px auto;
                padding: 0 15px;
            }

            .account-card {
                background: var(--white);
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                overflow: hidden;
                margin-bottom: 30px;
                transition: var(--transition);
            }

            .account-card:hover {
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
            }

            .account-header {
                padding: 25px 30px;
                border-bottom: 1px solid #eee;
                background-color: #f8f9fa;
            }

            .account-body {
                padding: 30px;
            }

            .section-title {
                position: relative;
                margin-bottom: 30px;
            }

            .section-title h3 {
                font-weight: 700;
                display: inline-block;
                position: relative;
                color: var(--primary-dark);
            }

            .section-title h3::after {
                content: '';
                position: absolute;
                width: 50px;
                height: 3px;
                background: var(--primary-color);
                bottom: -8px;
                left: 0;
            }

            .form-group {
                margin-bottom: 25px;
            }

            .form-label {
                font-weight: 600;
                margin-bottom: 8px;
                color: var(--text-dark);
            }

            .form-control {
                border-radius: var(--border-radius);
                padding: 12px 15px;
                border: 1px solid #ddd;
                transition: var(--transition);
            }

            .form-control:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.2rem rgba(46, 125, 50, 0.25);
            }

            .user-avatar {
                width: 80px;
                height: 80px;
                border-radius: 50%;
                background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-size: 2rem;
                font-weight: 700;
                margin-bottom: 20px;
            }

            .welcome-section {
                background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
                color: white;
                border-radius: var(--border-radius);
                padding: 30px;
                margin-bottom: 30px;
                text-align: center;
            }

            .stats-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
                gap: 15px;
                margin: 25px 0;
            }

            .stat-card {
                background: var(--white);
                border-radius: var(--border-radius);
                padding: 20px;
                text-align: center;
                box-shadow: var(--box-shadow);
                transition: var(--transition);
                border: 1px solid #eee;
            }

            .stat-card:hover {
                transform: translateY(-3px);
            }

            .stat-number {
                font-size: 1.8rem;
                font-weight: 700;
                color: var(--primary-color);
                margin-bottom: 5px;
            }

            .stat-label {
                color: var(--text-light);
                font-size: 0.9rem;
                font-weight: 600;
            }

            .order-table {
                width: 100%;
                border-collapse: collapse;
            }

            .order-table th {
                background-color: #f8f9fa;
                font-weight: 600;
                padding: 15px;
                text-align: left;
                border-bottom: 2px solid #eee;
                color: var(--text-dark);
            }

            .order-table td {
                padding: 15px;
                border-bottom: 1px solid #eee;
                vertical-align: middle;
            }

            .order-table tr:hover {
                background-color: #f8f9fa;
            }

            .badge {
                padding: 6px 12px;
                border-radius: 20px;
                font-size: 0.8rem;
                font-weight: 600;
            }

            .badge-success {
                background-color: rgba(46, 125, 50, 0.1);
                color: var(--primary-color);
            }

            .badge-warning {
                background-color: rgba(255, 193, 7, 0.1);
                color: #ffc107;
            }

            .badge-secondary {
                background-color: rgba(108, 117, 125, 0.1);
                color: #6c757d;
            }

            .alert {
                border-radius: var(--border-radius);
                border: none;
                padding: 15px 20px;
                margin-bottom: 25px;
            }

            .alert-success {
                background-color: rgba(46, 125, 50, 0.1);
                border: 1px solid var(--primary-color);
                color: var(--primary-dark);
            }

            .alert-danger {
                background-color: rgba(220, 53, 69, 0.1);
                border: 1px solid #dc3545;
                color: #dc3545;
            }

            .empty-state {
                text-align: center;
                padding: 40px 20px;
                color: var(--text-light);
            }

            .empty-state i {
                font-size: 3rem;
                margin-bottom: 15px;
                opacity: 0.5;
            }

            @media (max-width: 768px) {
                .account-container {
                    margin: 20px auto;
                }

                .account-body {
                    padding: 20px;
                }

                .stats-grid {
                    grid-template-columns: repeat(2, 1fr);
                }

                .order-table {
                    font-size: 0.9rem;
                }

                .order-table th,
                .order-table td {
                    padding: 10px 8px;
                }
            }
        </style>
    </head>

    <body>
        <jsp:include page="/common/headerChinh.jsp" />

        <div class="site-wrap">
            <!-- Breadcrumb -->
            <div class="bg-light py-3">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 mb-0">
                            <a href="${cpath}/home">Trang chủ</a> 
                            <span class="mx-2 mb-0">/</span>
                            <strong class="text-black">Tài khoản của tôi</strong>
                        </div>
                    </div>
                </div>
            </div>

            <div class="account-container">
                <!-- Welcome Section -->
                <div class="welcome-section">
                    <div class="user-avatar">
                        <c:set var="userName" value="${user.fullname}" />
                        <c:choose>
                            <c:when test="${not empty userName}">
                                ${userName.charAt(0)}
                            </c:when>
                            <c:otherwise>
                                <c:set var="email" value="${user.email}" />
                                <c:if test="${not empty email}">
                                    ${email.charAt(0)}
                                </c:if>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <h2 class="mb-2">Xin chào, <c:out value="${user.fullname}" default="Khách hàng"/>!</h2>
                    <p class="mb-0 opacity-75">Quản lý thông tin cá nhân và theo dõi đơn hàng của bạn</p>
                </div>

                <!-- Thông báo -->
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success">
                        <i class="icon-check"></i> ${successMessage}
                    </div>
                </c:if>

                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger">
                        <i class="icon-warning"></i> ${errorMessage}
                    </div>
                </c:if>

                <!-- Thống kê nhanh -->
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-number">
                            <c:choose>
                                <c:when test="${not empty orderHistory}">${orderHistory.size()}</c:when>
                                <c:otherwise>0</c:otherwise>
                            </c:choose>
                        </div>
                        <div class="stat-label">Đơn hàng</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number">⭐</div>
                        <div class="stat-label">Thành viên</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number">
                            <c:choose>
                                <c:when test="${not empty user.createdAt}">✓</c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </div>
                        <div class="stat-label">Đã xác thực</div>
                    </div>
                </div>

                <div class="row">
                    <!-- Thông tin cá nhân -->
                    <div class="col-lg-6 mb-4">
                        <div class="account-card">
                            <div class="account-header">
                                <h4 class="mb-0">Thông tin cá nhân</h4>
                                <p class="mb-0 text-muted">Cập nhật thông tin của bạn</p>
                            </div>
                            <div class="account-body">
                                <form method="post" action="${cpath}/account">
                                    <input type="hidden" name="action" value="updateProfile" />

                                    <div class="form-group">
                                        <label class="form-label" for="fullname">Họ và tên</label>
                                        <input type="text" class="form-control" id="fullname" name="fullname"
                                               value="<c:out value='${user.fullname}'/>" required>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label" for="email">Email</label>
                                        <input type="email" class="form-control" id="email" 
                                               value="<c:out value='${user.email}'/>" disabled>
                                        <small class="form-text text-muted">Email không thể thay đổi</small>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label" for="phone_number">Số điện thoại</label>
                                        <input type="text" class="form-control" id="phone_number" name="phone_number"
                                               value="<c:out value='${user.phoneNumber}'/>" 
                                               placeholder="Nhập số điện thoại">
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label" for="address">Địa chỉ giao hàng</label>
                                        <textarea class="form-control" id="address" name="address" rows="3" 
                                                  placeholder="Nhập địa chỉ giao hàng đầy đủ"><c:out value='${user.address}'/></textarea>
                                    </div>

                                    <button type="submit" class="btn btn-primary">
                                        <i class="icon-save"></i> Lưu thay đổi
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Đổi mật khẩu -->
                    <div class="col-lg-6 mb-4">
                        <div class="account-card">
                            <div class="account-header">
                                <h4 class="mb-0">Đổi mật khẩu</h4>
                                <p class="mb-0 text-muted">Bảo mật tài khoản của bạn</p>
                            </div>
                            <div class="account-body">
                                <form method="post" action="${cpath}/account">
                                    <input type="hidden" name="action" value="changePassword" />

                                    <div class="form-group">
                                        <label class="form-label" for="currentPassword">Mật khẩu hiện tại</label>
                                        <input type="password" class="form-control" id="currentPassword" 
                                               name="currentPassword" required>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label" for="newPassword">Mật khẩu mới</label>
                                        <input type="password" class="form-control" id="newPassword" 
                                               name="newPassword" required>
                                        <small class="form-text text-muted">Ít nhất 6 ký tự, nên kết hợp chữ hoa, chữ thường và số</small>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label" for="confirmPassword">Xác nhận mật khẩu mới</label>
                                        <input type="password" class="form-control" id="confirmPassword" 
                                               name="confirmPassword" required>
                                    </div>

                                    <button type="submit" class="btn btn-outline-primary">
                                        <i class="icon-lock"></i> Đổi mật khẩu
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Lịch sử đơn hàng -->
                <div class="account-card">
                    <div class="account-header">
                        <h4 class="mb-0">Lịch sử đơn hàng</h4>
                        <p class="mb-0 text-muted">Theo dõi các đơn hàng của bạn</p>
                    </div>
                    <div class="account-body">
                        <c:choose>
                            <c:when test="${empty orderHistory}">
                                <div class="empty-state">
                                    <i class="icon-shopping-bag"></i>
                                    <h5>Chưa có đơn hàng nào</h5>
                                    <p class="mb-4">Hãy khám phá các sản phẩm và thực hiện đơn hàng đầu tiên của bạn</p>
                                    <a href="${cpath}/shop" class="btn btn-primary">
                                        <i class="icon-store"></i> Mua sắm ngay
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="order-table">
                                        <thead>
                                            <tr>
                                                <th>Mã đơn</th>
                                                <th>Ngày đặt</th>
                                                <th>Trạng thái</th>
                                                <th>Tổng tiền</th>
                                                <th>Địa chỉ giao</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="order" items="${orderHistory}">
                                                <tr>
                                                    <td>
                                                        <strong>#${order.orderId}</strong>
                                                    </td>
                                                    <td>
                                                        <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm" />
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${order.status == 'completed' || order.status == 'COMPLETED'}">
                                                                <span class="badge badge-success">Hoàn thành</span>
                                                            </c:when>
                                                            <c:when test="${order.status == 'pending' || order.status == 'PENDING'}">
                                                                <span class="badge badge-warning">Đang xử lý</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge badge-secondary">${order.status}</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <strong>
                                                            <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫" minFractionDigits="0" />
                                                        </strong>
                                                    </td>
                                                    <td>
                                                        <small><c:out value="${order.shippingAddress}"/></small>
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
        </div>

        <script src="js/jquery-3.3.1.min.js"></script>
        <script src="js/bootstrap.bundle.min.js"></script>

        <script>
            $(document).ready(function () {
                // Kiểm tra mật khẩu khớp nhau
                $('#confirmPassword').on('input', function () {
                    const newPassword = $('#newPassword').val();
                    const confirmPassword = $(this).val();

                    if (confirmPassword && newPassword !== confirmPassword) {
                        $(this).addClass('is-invalid');
                    } else {
                        $(this).removeClass('is-invalid');
                    }
                });

                // Hiệu ứng cho card
                $('.account-card').hover(
                        function () {
                            $(this).css('transform', 'translateY(-5px)');
                        },
                        function () {
                            $(this).css('transform', 'translateY(0)');
                        }
                );
            });
        </script>
    </body>
</html>