<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
  response.setCharacterEncoding("UTF-8");
%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Tài khoản | Pharmative</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
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
            padding: 10px 25px;
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
        }
        
        .account-header {
            padding: 25px 30px;
            border-bottom: 1px solid #eee;
            background-color: #f8f9fa;
        }
        
        .account-body {
            padding: 30px;
        }
        
        .user-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 3rem;
            font-weight: 700;
            margin: 0 auto 20px;
        }
        
        .info-item {
            display: flex;
            justify-content: between;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid #eee;
        }
        
        .info-item:last-child {
            border-bottom: none;
        }
        
        .info-label {
            font-weight: 600;
            color: var(--text-dark);
            min-width: 150px;
        }
        
        .info-value {
            color: var(--text-light);
            flex: 1;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin: 30px 0;
        }
        
        .stat-card {
            background: var(--white);
            border-radius: var(--border-radius);
            padding: 25px;
            text-align: center;
            box-shadow: var(--box-shadow);
            transition: var(--transition);
            border: 1px solid #eee;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }
        
        .stat-number {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 10px;
        }
        
        .stat-label {
            color: var(--text-light);
            font-weight: 600;
        }
        
        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }
        
        .action-card {
            background: var(--white);
            border-radius: var(--border-radius);
            padding: 25px;
            text-align: center;
            box-shadow: var(--box-shadow);
            transition: var(--transition);
            border: 1px solid #eee;
            text-decoration: none;
            color: inherit;
        }
        
        .action-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            text-decoration: none;
            color: inherit;
        }
        
        .action-icon {
            font-size: 2.5rem;
            color: var(--primary-color);
            margin-bottom: 15px;
        }
        
        .action-title {
            font-weight: 600;
            margin-bottom: 10px;
            color: var(--text-dark);
        }
        
        .action-description {
            color: var(--text-light);
            font-size: 0.9rem;
        }
        
        .welcome-section {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            color: white;
            border-radius: var(--border-radius);
            padding: 40px;
            text-align: center;
            margin-bottom: 30px;
        }
        
        @media (max-width: 768px) {
            .account-container {
                margin: 20px auto;
            }
            
            .account-body {
                padding: 20px;
            }
            
            .stats-grid, .quick-actions {
                grid-template-columns: 1fr;
            }
            
            .info-item {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .info-label {
                margin-bottom: 5px;
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
                        <strong class="text-black">Tài khoản</strong>
                    </div>
                </div>
            </div>
        </div>

        <div class="account-container">
            <!-- Welcome Section -->
            <div class="welcome-section">
                <h2>Chào mừng trở lại!</h2>
                <p class="mb-0">Quản lý thông tin tài khoản và đơn hàng của bạn</p>
            </div>

            <div class="row">
                <!-- Sidebar -->
                <div class="col-lg-4 mb-4">
                    <div class="account-card">
                        <div class="account-body text-center">
                            <div class="user-avatar">
                                <c:set var="userName" value="${currentUser.fullName}" />
                                <c:choose>
                                    <c:when test="${not empty userName}">
                                        ${userName.charAt(0)}
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="email" value="${currentUser.email}" />
                                        <c:if test="${not empty email}">
                                            ${email.charAt(0)}
                                        </c:if>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <h4 class="mb-2">${currentUser.fullName}</h4>
                            <p class="text-muted mb-3">${currentUser.email}</p>
                            <div class="member-badge" style="
                                background: linear-gradient(135deg, #ffd700, #ffed4e);
                                color: #8b6914;
                                padding: 5px 15px;
                                border-radius: 20px;
                                font-weight: 600;
                                font-size: 0.9rem;
                                display: inline-block;
                                margin-bottom: 20px;
                            ">
                                ⭐ Thành viên vàng
                            </div>
                            
                            <div class="d-grid gap-2">
                                <a href="${cpath}/change-password" class="btn btn-primary">
                                    <i class="icon-lock"></i> Đổi mật khẩu
                                </a>
                                <a href="${cpath}/order-history" class="btn btn-outline-primary">
                                    <i class="icon-shopping-bag"></i> Lịch sử đơn hàng
                                </a>
                                <a href="${cpath}/logout" class="btn btn-outline-secondary">
                                    <i class="icon-log-out"></i> Đăng xuất
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Main Content -->
                <div class="col-lg-8">
                    <!-- Thông tin tài khoản -->
                    <div class="account-card">
                        <div class="account-header">
                            <h3 class="mb-0">Thông tin tài khoản</h3>
                            <p class="mb-0 text-muted">Quản lý thông tin cá nhân của bạn</p>
                        </div>
                        <div class="account-body">
                            <div class="info-item">
                                <span class="info-label">Họ và tên:</span>
                                <span class="info-value">${currentUser.fullName}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Email:</span>
                                <span class="info-value">${currentUser.email}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Số điện thoại:</span>
                                <span class="info-value">
                                    <c:choose>
                                        <c:when test="${not empty currentUser.phone}">
                                            ${currentUser.phone}
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">Chưa cập nhật</span>
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Địa chỉ:</span>
                                <span class="info-value">
                                    <c:choose>
                                        <c:when test="${not empty currentUser.address}">
                                            ${currentUser.address}
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">Chưa cập nhật</span>
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Ngày tham gia:</span>
                                <span class="info-value">
                                    <c:choose>
                                        <c:when test="${not empty currentUser.createdAt}">
                                            ${currentUser.createdAt}
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">Không có thông tin</span>
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                        </div>
                    </div>

                    <!-- Thống kê -->
                    <div class="stats-grid">
                        <div class="stat-card">
                            <div class="stat-number">5</div>
                            <div class="stat-label">Đơn hàng</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-number">12</div>
                            <div class="stat-label">Sản phẩm đã mua</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-number">3,250,000₫</div>
                            <div class="stat-label">Tổng chi tiêu</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-number">15</div>
                            <div class="stat-label">Ngày thành viên</div>
                        </div>
                    </div>

                    <!-- Quick Actions -->
                    <div class="quick-actions">
                        <a href="${cpath}/order-history" class="action-card">
                            <div class="action-icon">📦</div>
                            <div class="action-title">Lịch sử đơn hàng</div>
                            <div class="action-description">Theo dõi và quản lý đơn hàng của bạn</div>
                        </a>
                        <a href="${cpath}/change-password" class="action-card">
                            <div class="action-icon">🔒</div>
                            <div class="action-title">Bảo mật</div>
                            <div class="action-description">Đổi mật khẩu và cài đặt bảo mật</div>
                        </a>
                        <a href="${cpath}/address-book" class="action-card">
                            <div class="action-icon">🏠</div>
                            <div class="action-title">Sổ địa chỉ</div>
                            <div class="action-description">Quản lý địa chỉ giao hàng</div>
                        </a>
                        <a href="${cpath}/support" class="action-card">
                            <div class="action-icon">💬</div>
                            <div class="action-title">Hỗ trợ</div>
                            <div class="action-description">Liên hệ hỗ trợ khách hàng</div>
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="/common/footerChinh.jsp" />
    </div>

    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>