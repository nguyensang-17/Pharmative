<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Pharmative</title>

    <!-- Bootstrap + FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        /* Theme màu xanh lá chính - cải tiến */
        :root{
            --brand-green: #75b239;
            --brand-green-dark: #5fa127;
            --brand-green-light: #e8f4dc;
            --brand-green-soft: rgba(117,178,57,0.08);
            --brand-green-muted: #8bc34a;
            --muted: #6c6f76;
            --bg: #f6f8f7;
            --card-bg: #ffffff;
            --accent: rgba(117,178,57,0.06);
            --shadow: 0 6px 18px rgba(24,39,75,0.06);
            --shadow-green: 0 6px 18px rgba(117,178,57,0.12);
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--bg);
            color: #333;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar Navigation */
        .sidebar {
            width: 260px;
            background: linear-gradient(180deg, var(--brand-green), var(--brand-green-dark));
            color: white;
            padding: 0;
            box-shadow: 4px 0 20px rgba(0,0,0,0.08);
            z-index: 100;
            display: flex;
            flex-direction: column;
            transition: all 0.3s ease;
        }

        .sidebar-header {
            padding: 24px 20px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            text-align: center;
        }

        .sidebar-header h3 {
            margin: 0;
            font-weight: 700;
            font-size: 1.4rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .sidebar-header h3 i {
            font-size: 1.6rem;
        }

        .user-info {
            padding: 16px 20px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .user-avatar {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            background: rgba(255,255,255,0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
        }

        .user-details {
            flex: 1;
        }

        .user-name {
            font-weight: 600;
            font-size: 0.95rem;
            margin-bottom: 4px;
        }

        .user-role {
            font-size: 0.8rem;
            opacity: 0.8;
            background: rgba(255,255,255,0.15);
            padding: 2px 8px;
            border-radius: 12px;
            display: inline-block;
        }

        .nav-menu {
            flex: 1;
            padding: 20px 0;
            overflow-y: auto;
        }

        .nav-item {
            margin-bottom: 4px;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 14px 20px;
            color: rgba(255,255,255,0.85);
            text-decoration: none;
            transition: all 0.2s ease;
            font-weight: 500;
            border-left: 3px solid transparent;
        }

        .nav-link:hover, .nav-link.active {
            background: rgba(255,255,255,0.1);
            color: white;
            border-left-color: white;
        }

        .nav-link i {
            width: 24px;
            margin-right: 12px;
            font-size: 1.1rem;
        }

        .sidebar-footer {
            padding: 16px 20px;
            border-top: 1px solid rgba(255,255,255,0.1);
        }

        .logout-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            width: 100%;
            padding: 12px;
            background: rgba(255,255,255,0.15);
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.2s ease;
        }

        .logout-btn:hover {
            background: rgba(255,255,255,0.25);
            transform: translateY(-2px);
        }

        /* Main Content Area */
        .main-content {
            flex: 1;
            padding: 28px;
            overflow-y: auto;
        }

        .page-header {
            background: linear-gradient(135deg, var(--brand-green), var(--brand-green-dark));
            padding: 24px 28px;
            border-radius: 16px;
            margin-bottom: 26px;
            box-shadow: var(--shadow-green);
            color: white;
            position: relative;
            overflow: hidden;
        }

        .page-header::before {
            content: "";
            position: absolute;
            top: 0;
            right: 0;
            width: 120px;
            height: 120px;
            background: rgba(255,255,255,0.1);
            border-radius: 50%;
            transform: translate(30px, -30px);
        }

        .page-header h2 {
            margin: 0;
            font-weight: 700;
            letter-spacing: 0.2px;
            position: relative;
            z-index: 1;
        }

        .welcome-text {
            margin-top: 8px;
            font-size: 0.95rem;
            opacity: 0.9;
            position: relative;
            z-index: 1;
        }

        /* Stats Cards - cải tiến với theme xanh lá */
        .stats-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(230px, 1fr));
            gap: 18px;
            margin-bottom: 28px;
        }

        .stat-card {
            background: var(--card-bg);
            border-radius: 16px;
            padding: 20px;
            box-shadow: var(--shadow);
            transition: transform .18s ease, box-shadow .18s ease;
            display: flex;
            align-items: center;
            justify-content: space-between;
            min-height: 110px;
            border: 1px solid rgba(117,178,57,0.1);
        }
        .stat-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 10px 30px rgba(117,178,57,0.12);
            border-color: rgba(117,178,57,0.3);
        }

        .stat-title {
            font-size: 0.8rem;
            color: var(--muted);
            text-transform: uppercase;
            font-weight: 700;
            letter-spacing: .08em;
        }

        .stat-value {
            margin-top: 6px;
            font-size: 1.9rem;
            font-weight: 800;
            color: #2b2e33;
        }

        /* icon box - cải tiến với xanh lá */
        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.3rem;
            color: #fff;
            box-shadow: 0 6px 14px rgba(117,178,57,0.18);
            flex-shrink: 0;
        }

        .stat-icon.primary { 
            background: linear-gradient(135deg, var(--brand-green), var(--brand-green-dark)); 
        }
        .stat-icon.success { 
            background: linear-gradient(135deg, var(--brand-green-muted), #7cb342); 
        }
        .stat-icon.info { 
            background: linear-gradient(135deg, #4caf50, #66bb6a); 
        }
        .stat-icon.warning { 
            background: linear-gradient(135deg, #cddc39, #d4e157); 
        }

        /* Quick Actions - cải tiến */
        .quick-actions {
            background: var(--card-bg);
            border-radius: 16px;
            padding: 24px;
            box-shadow: var(--shadow);
            margin-bottom: 28px;
            border: 1px solid rgba(117,178,57,0.1);
        }

        .quick-actions h5 {
            margin: 0;
            font-weight: 700;
            color: #2b2e33;
            display: flex;
            align-items: center;
        }

        .action-buttons {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(210px, 1fr));
            gap: 16px;
            margin-top: 20px;
        }

        .action-btn {
            padding: 20px;
            border: 1px solid rgba(117,178,57,0.15);
            border-radius: 12px;
            text-align: center;
            text-decoration: none;
            transition: all 0.18s ease;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 12px;
            background: #fff;
            min-height: 120px;
            justify-content: center;
        }
        .action-btn:hover {
            border-color: var(--brand-green);
            background: var(--brand-green-light);
            transform: translateY(-4px);
            box-shadow: 0 8px 30px rgba(117,178,57,0.12);
        }
        .action-btn i {
            font-size: 1.8rem;
            color: var(--brand-green);
            background: var(--brand-green-soft);
            padding: 14px;
            border-radius: 10px;
            transition: all 0.18s ease;
        }
        .action-btn:hover i {
            background: var(--brand-green);
            color: white;
            transform: scale(1.05);
        }
        .action-btn span { 
            font-weight: 700; 
            color: #333; 
            font-size: 0.95rem;
        }

        /* Recent Activity */
        .recent-activity {
            background: var(--card-bg);
            border-radius: 16px;
            padding: 24px;
            box-shadow: var(--shadow);
            margin-bottom: 28px;
            border: 1px solid rgba(117,178,57,0.1);
        }

        .recent-activity h5 {
            margin: 0 0 20px 0;
            font-weight: 700;
            color: #2b2e33;
            display: flex;
            align-items: center;
        }

        .activity-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .activity-item {
            display: flex;
            align-items: center;
            padding: 14px 0;
            border-bottom: 1px solid rgba(0,0,0,0.05);
        }

        .activity-item:last-child {
            border-bottom: none;
        }

        .activity-icon {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 14px;
            background: var(--brand-green-soft);
            color: var(--brand-green);
            flex-shrink: 0;
        }

        .activity-content {
            flex: 1;
        }

        .activity-title {
            font-weight: 600;
            font-size: 0.95rem;
            margin-bottom: 4px;
        }

        .activity-time {
            font-size: 0.8rem;
            color: var(--muted);
        }

        /* Mobile responsive */
        @media (max-width: 992px) {
            body {
                flex-direction: column;
            }
            
            .sidebar {
                width: 100%;
                height: auto;
            }
            
            .nav-menu {
                display: flex;
                overflow-x: auto;
                padding: 10px 0;
            }
            
            .nav-item {
                margin-bottom: 0;
                margin-right: 10px;
                flex-shrink: 0;
            }
            
            .nav-link {
                border-left: none;
                border-bottom: 3px solid transparent;
                padding: 10px 15px;
                white-space: nowrap;
            }
            
            .nav-link:hover, .nav-link.active {
                border-left-color: transparent;
                border-bottom-color: white;
            }
            
            .user-info, .sidebar-footer {
                display: none;
            }
        }

        @media (max-width: 768px) {
            .page-header { padding: 18px; border-radius: 12px; }
            .page-header::before { width: 80px; height: 80px; }
            .stat-icon { width: 50px; height: 50px; font-size: 1.1rem; }
            .stat-value { font-size: 1.5rem; }
            .action-buttons { grid-template-columns: 1fr 1fr; }
        }

        @media (max-width: 576px) {
            .action-buttons { grid-template-columns: 1fr; }
            .stats-cards { grid-template-columns: 1fr 1fr; }
        }

        /* subtle helpers */
        .muted { color: var(--muted); font-weight: 600; }
        
        /* Thêm hiệu ứng cho các phần tử chính */
        .main-content > * {
            animation: fadeInUp 0.5s ease-out;
        }
        
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
    <!-- Sidebar Navigation -->
    <div class="sidebar">
        <div class="sidebar-header">
            <h3><i class="fas fa-capsules"></i> Pharmative</h3>
        </div>
        
        <div class="user-info">
            <div class="user-avatar">
                <i class="fas fa-user"></i>
            </div>
            <div class="user-details">
                <div class="user-name">${sessionScope.currentUser != null ? sessionScope.currentUser.fullname : "Admin"}</div>
                <div class="user-role">Administrator</div>
            </div>
        </div>
        
        <div class="nav-menu">
            <div class="nav-item">
                <a href="#" class="nav-link active">
                    <i class="fas fa-tachometer-alt"></i>
                    <span>Dashboard</span>
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/users" class="nav-link">
                    <i class="fas fa-users-cog"></i>
                    <span>Quản lý Users</span>
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/orders" class="nav-link">
                    <i class="fas fa-file-invoice"></i>
                    <span>Quản lý Orders</span>
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/products" class="nav-link">
                    <i class="fas fa-box-open"></i>
                    <span>Quản lý Products</span>
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/categories" class="nav-link">
                    <i class="fas fa-tags"></i>
                    <span>Quản lý Danh mục</span>
                </a>
            </div>
            <div class="nav-item">
                <a href="#" class="nav-link">
                    <i class="fas fa-chart-bar"></i>
                    <span>Báo cáo & Thống kê</span>
                </a>
            </div>
            <div class="nav-item">
                <a href="#" class="nav-link">
                    <i class="fas fa-cog"></i>
                    <span>Cài đặt hệ thống</span>
                </a>
            </div>
        </div>
        
        <div class="sidebar-footer">
            <button class="logout-btn" onclick="location.href='${pageContext.request.contextPath}/logout'">
                <i class="fas fa-sign-out-alt"></i> Đăng xuất
            </button>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Page Header với gradient xanh lá -->
        <div class="page-header">
            <h2><i class="fas fa-tachometer-alt" style="margin-right:10px"></i> Dashboard Admin</h2>
            <p class="welcome-text">
                Tổng quan về hoạt động và hiệu suất của hệ thống
            </p>
        </div>

        <!-- Stats Cards -->
        <div class="stats-cards">
            <div class="stat-card">
                <div>
                    <div class="stat-title">Tổng Users</div>
                    <div class="stat-value">
                        <fmt:formatNumber value="${totalUsers}" pattern="#,###"/>
                    </div>
                </div>
                <div class="stat-icon primary">
                    <i class="fas fa-users"></i>
                </div>
            </div>

            <div class="stat-card">
                <div>
                    <div class="stat-title">Đơn hàng</div>
                    <div class="stat-value">
                        <fmt:formatNumber value="${totalOrders}" pattern="#,###"/>
                    </div>
                </div>
                <div class="stat-icon success">
                    <i class="fas fa-shopping-cart"></i>
                </div>
            </div>

            <div class="stat-card">
                <div>
                    <div class="stat-title">Doanh thu</div>
                    <div class="stat-value">
                        ₫<fmt:formatNumber value="${totalRevenue}" pattern="#,###"/>
                    </div>
                </div>
                <div class="stat-icon info">
                    <i class="fas fa-coins"></i>
                </div>
            </div>

            <div class="stat-card">
                <div>
                    <div class="stat-title">Sản phẩm</div>
                    <div class="stat-value">
                        <fmt:formatNumber value="${totalProducts}" pattern="#,###"/>
                    </div>
                </div>
                <div class="stat-icon warning">
                    <i class="fas fa-box"></i>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="quick-actions">
            <h5><i class="fas fa-bolt" style="color:var(--brand-green); margin-right:8px"></i> Thao tác nhanh</h5>
            <div class="action-buttons">
                <a href="${pageContext.request.contextPath}/admin/users" class="action-btn">
                    <i class="fas fa-users-cog"></i>
                    <span>Quản lý Users</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/orders" class="action-btn">
                    <i class="fas fa-file-invoice"></i>
                    <span>Quản lý Orders</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/products" class="action-btn">
                    <i class="fas fa-box-open"></i>
                    <span>Quản lý Products</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/categories" class="action-btn">
                    <i class="fas fa-tags"></i>
                    <span>Quản lý Danh mục</span>
                </a>
            </div>
        </div>
        
        <!-- Recent Activity (mẫu) -->
        <div class="recent-activity">
            <h5><i class="fas fa-history" style="color:var(--brand-green); margin-right:8px"></i> Hoạt động gần đây</h5>
            <ul class="activity-list">
                <li class="activity-item">
                    <div class="activity-icon">
                        <i class="fas fa-user-plus"></i>
                    </div>
                    <div class="activity-content">
                        <div class="activity-title">Người dùng mới đã đăng ký</div>
                        <div class="activity-time">2 giờ trước</div>
                    </div>
                </li>
                <li class="activity-item">
                    <div class="activity-icon">
                        <i class="fas fa-shopping-cart"></i>
                    </div>
                    <div class="activity-content">
                        <div class="activity-title">Đơn hàng mới #ORD-2023-0015</div>
                        <div class="activity-time">4 giờ trước</div>
                    </div>
                </li>
                <li class="activity-item">
                    <div class="activity-icon">
                        <i class="fas fa-box"></i>
                    </div>
                    <div class="activity-content">
                        <div class="activity-title">Sản phẩm mới đã được thêm</div>
                        <div class="activity-time">6 giờ trước</div>
                    </div>
                </li>
                <li class="activity-item">
                    <div class="activity-icon">
                        <i class="fas fa-tags"></i>
                    </div>
                    <div class="activity-content">
                        <div class="activity-title">Danh mục mới đã được tạo</div>
                        <div class="activity-time">1 ngày trước</div>
                    </div>
                </li>
            </ul>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>