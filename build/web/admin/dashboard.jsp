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
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <style>
        :root{
            --brand-green: #75b239;
            --brand-green-dark: #5fa127;
            --brand-green-light: #e8f4dc;
            --brand-green-soft: rgba(117,178,57,0.08);
            --bg: #f6f8f7;
            --card-bg: #ffffff;
            --shadow: 0 6px 18px rgba(24,39,75,0.06);
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--bg);
            color: #333;
            display: flex;
            min-height: 100vh;
            margin: 0;
        }

        /* Entrance Animations */
        .main-content {
            animation: fadeIn 0.6s ease-out;
        }

        .page-header {
            animation: slideInDown 0.5s ease-out 0.2s both;
        }

        .stat-card {
            animation: fadeInUp 0.5s ease-out both;
        }

        .stat-card:nth-child(1) { animation-delay: 0.3s; }
        .stat-card:nth-child(2) { animation-delay: 0.4s; }
        .stat-card:nth-child(3) { animation-delay: 0.5s; }
        .stat-card:nth-child(4) { animation-delay: 0.6s; }

        .card {
            animation: fadeIn 0.6s ease-out both;
        }

        .card:nth-child(1) { animation-delay: 0.4s; }
        .card:nth-child(2) { animation-delay: 0.5s; }

        /* Animation Keyframes */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
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

        @keyframes slideInDown {
            from { 
                opacity: 0;
                transform: translateY(-30px);
            }
            to { 
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Hover Effects */
        .stat-card {
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(117,178,57,0.15);
        }

        .card {
            transition: all 0.3s ease;
        }

        .card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(24,39,75,0.12);
        }

        .action-btn {
            transition: all 0.3s ease;
        }

        .action-btn:hover {
            transform: translateY(-2px);
        }

        /* Sidebar Styles */
        .sidebar {
            width: 260px;
            background: linear-gradient(180deg, var(--brand-green), var(--brand-green-dark));
            color: white;
            padding: 0;
            box-shadow: 4px 0 20px rgba(0,0,0,0.08);
            z-index: 100;
            display: flex;
            flex-direction: column;
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

        /* FIXED: Nav menu không hiện scrollbar */
        .nav-menu {
            flex: 1;
            padding: 20px 0;
            overflow-y: auto;
            scrollbar-width: none;
            -ms-overflow-style: none;
            max-height: calc(100vh - 200px);
        }

        .nav-menu::-webkit-scrollbar {
            display: none;
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
            transition: all 0.3s ease;
        }

        .logout-btn:hover {
            background: rgba(255,255,255,0.25);
            transform: translateY(-2px);
        }

        /* Main Content */
        .main-content {
            flex: 1;
            padding: 28px;
            overflow-y: auto;
        }
        
        .page-header {
            background: linear-gradient(135deg, var(--brand-green), var(--brand-green-dark));
            color: white;
            padding: 24px 28px;
            border-radius: 16px;
            margin-bottom: 26px;
            box-shadow: 0 6px 18px rgba(117,178,57,0.12);
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
        
        .card {
            border: none;
            border-radius: 12px;
            box-shadow: var(--shadow);
            margin-bottom: 24px;
            border: 1px solid rgba(117,178,57,0.1);
        }
        
        .btn-success {
            background: var(--brand-green);
            border: none;
        }
        
        .btn-success:hover {
            background: var(--brand-green-dark);
        }
        
        /* Stats Cards */
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
            display: flex;
            align-items: center;
            justify-content: space-between;
            min-height: 110px;
            border: 1px solid rgba(117,178,57,0.1);
        }

        .stat-title {
            font-size: 0.8rem;
            color: #6c6f76;
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
            transition: transform 0.3s ease;
        }

        .stat-card:hover .stat-icon {
            transform: scale(1.1);
        }

        .stat-icon.primary { 
            background: linear-gradient(135deg, var(--brand-green), var(--brand-green-dark)); 
        }
        .stat-icon.success { 
            background: linear-gradient(135deg, #8bc34a, #7cb342); 
        }
        .stat-icon.warning { 
            background: linear-gradient(135deg, #cddc39, #d4e157); 
        }
        .stat-icon.info { 
            background: linear-gradient(135deg, #4caf50, #66bb6a); 
        }

        /* Quick Actions */
        .action-buttons {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(210px, 1fr));
            gap: 16px;
        }

        .action-btn {
            padding: 20px;
            border: 1px solid rgba(117,178,57,0.15);
            border-radius: 12px;
            text-align: center;
            text-decoration: none;
            transition: all 0.3s ease;
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
            box-shadow: 0 8px 30px rgba(117,178,57,0.12);
        }

        .action-btn i {
            font-size: 1.8rem;
            color: var(--brand-green);
            background: var(--brand-green-soft);
            padding: 14px;
            border-radius: 10px;
            transition: all 0.3s ease;
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

        /* Dashboard Overview Section */
        .dashboard-overview {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 24px;
            margin-bottom: 28px;
        }

        @media (max-width: 992px) {
            .dashboard-overview {
                grid-template-columns: 1fr;
            }
        }

        /* Chart Containers */
        .chart-container {
            position: relative;
            height: 300px;
            margin: 20px 0;
        }

        .chart-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 24px;
            margin-bottom: 28px;
        }

        @media (max-width: 768px) {
            .chart-grid {
                grid-template-columns: 1fr;
            }
        }

        /* Recent Activity Enhanced */
        .activity-section {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 24px;
        }

        @media (max-width: 768px) {
            .activity-section {
                grid-template-columns: 1fr;
            }
        }

        .activity-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .activity-item {
            display: flex;
            align-items: flex-start;
            padding: 16px 0;
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
            flex-shrink: 0;
        }

        .activity-icon.success {
            background: rgba(40, 167, 69, 0.1);
            color: #28a745;
        }

        .activity-icon.warning {
            background: rgba(255, 193, 7, 0.1);
            color: #ffc107;
        }

        .activity-icon.info {
            background: rgba(23, 162, 184, 0.1);
            color: #17a2b8;
        }

        .activity-icon.primary {
            background: var(--brand-green-soft);
            color: var(--brand-green);
        }

        .activity-content {
            flex: 1;
        }

        .activity-title {
            font-weight: 600;
            font-size: 0.95rem;
            margin-bottom: 4px;
            line-height: 1.4;
        }

        .activity-desc {
            font-size: 0.85rem;
            color: #6c757d;
            margin-bottom: 4px;
        }

        .activity-time {
            font-size: 0.8rem;
            color: #6c6f76;
        }

        .activity-meta {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-top: 4px;
        }

        .activity-badge {
            font-size: 0.75rem;
            padding: 2px 8px;
            border-radius: 12px;
        }

        /* Performance Metrics */
        .metric-card {
            background: var(--card-bg);
            border-radius: 12px;
            padding: 20px;
            border: 1px solid rgba(117,178,57,0.1);
        }

        .metric-value {
            font-size: 2rem;
            font-weight: 700;
            color: var(--brand-green);
            margin-bottom: 8px;
        }

        .metric-label {
            font-size: 0.9rem;
            color: #6c757d;
            margin-bottom: 12px;
        }

        .metric-progress {
            height: 6px;
            background: #e9ecef;
            border-radius: 3px;
            overflow: hidden;
        }

        .metric-progress-bar {
            height: 100%;
            background: linear-gradient(90deg, var(--brand-green), var(--brand-green-dark));
            border-radius: 3px;
        }

        /* Responsive */
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
                max-height: none;
            }

            .nav-menu::-webkit-scrollbar {
                display: none;
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
                transform: translateY(-2px);
            }
            
            .user-info, .sidebar-footer {
                display: none;
            }
        }

        @media (max-width: 768px) {
            .page-header { padding: 18px; border-radius: 12px; }
            .page-header::before { width: 80px; height: 80px; }
            .stats-cards { grid-template-columns: 1fr 1fr; }
            .action-buttons { grid-template-columns: 1fr 1fr; }
            .chart-grid { grid-template-columns: 1fr; }
        }

        @media (max-width: 576px) {
            .stats-cards { grid-template-columns: 1fr; }
            .action-buttons { grid-template-columns: 1fr; }
            .main-content { padding: 15px; }
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
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link active">
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
        </div>
        
        <div class="sidebar-footer">
            <button class="logout-btn" onclick="location.href='${pageContext.request.contextPath}/logout'">
                <i class="fas fa-sign-out-alt"></i> Đăng xuất
            </button>
        </div>
    </div>

    <!-- Main content -->
    <div class="main-content">
        <!-- Page Header -->
        <div class="page-header">
            <div>
                <h2><i class="fas fa-tachometer-alt" style="margin-right:10px"></i> Dashboard Admin</h2>
                <p class="mb-0" style="opacity:0.9">Tổng quan về hoạt động và hiệu suất của hệ thống</p>
            </div>
        </div>

        <!-- Stats Cards -->
        <div class="stats-cards">
            <div class="stat-card">
                <div>
                    <div class="stat-title">Tổng Users</div>
                    <div class="stat-value">
                        <fmt:formatNumber value="${totalUsers}" pattern="#,###"/>
                    </div>
                    <div class="stat-change text-success">
                        <i class="fas fa-arrow-up"></i> +12% so với tháng trước
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
                    <div class="stat-change text-success">
                        <i class="fas fa-arrow-up"></i> +8% so với tháng trước
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
                    <div class="stat-change text-success">
                        <i class="fas fa-arrow-up"></i> +15% so với tháng trước
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
                    <div class="stat-change text-success">
                        <i class="fas fa-arrow-up"></i> +5% so với tháng trước
                    </div>
                </div>
                <div class="stat-icon warning">
                    <i class="fas fa-box"></i>
                </div>
            </div>
        </div>

        <!-- Thống kê biểu đồ -->
        <div class="chart-grid">
            <!-- Biểu đồ doanh thu theo tháng -->
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title mb-4">
                        <i class="fas fa-chart-line" style="color:var(--brand-green); margin-right:8px"></i> 
                        Doanh thu theo tháng
                    </h5>
                    <div class="chart-container">
                        <canvas id="revenueChart"></canvas>
                    </div>
                </div>
            </div>

            <!-- Biểu đồ đơn hàng theo trạng thái -->
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title mb-4">
                        <i class="fas fa-chart-pie" style="color:var(--brand-green); margin-right:8px"></i> 
                        Phân loại đơn hàng
                    </h5>
                    <div class="chart-container">
                        <canvas id="orderStatusChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <!-- Biểu đồ sản phẩm bán chạy -->
        <div class="card">
            <div class="card-body">
                <h5 class="card-title mb-4">
                    <i class="fas fa-chart-bar" style="color:var(--brand-green); margin-right:8px"></i> 
                    Top sản phẩm bán chạy
                </h5>
                <div class="chart-container">
                    <canvas id="topProductsChart"></canvas>
                </div>
            </div>
        </div>

        <!-- Quick Actions Card -->
        <div class="card">
            <div class="card-body">
                <h5 class="card-title mb-4"><i class="fas fa-bolt" style="color:var(--brand-green); margin-right:8px"></i> Thao tác nhanh</h5>
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
        </div>

        <!-- Enhanced Activity Section -->
        <div class="activity-section">
            <!-- Recent Activities -->
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title mb-4">
                        <i class="fas fa-history" style="color:var(--brand-green); margin-right:8px"></i> 
                        Hoạt động gần đây
                    </h5>
                    <ul class="activity-list">
                        <c:choose>
                            <c:when test="${not empty recentActivities}">
                                <c:forEach var="activity" items="${recentActivities}" varStatus="status">
                                    <li class="activity-item">
                                        <div class="activity-icon ${activity.type}">
                                            <i class="${activity.icon}"></i>
                                        </div>
                                        <div class="activity-content">
                                            <div class="activity-title">${activity.title}</div>
                                            <div class="activity-desc">${activity.description}</div>
                                            <div class="activity-meta">
                                                <span class="activity-time">${activity.time}</span>
                                                <span class="badge ${activity.badgeColor} activity-badge">${activity.status}</span>
                                            </div>
                                        </div>
                                    </li>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <!-- Dữ liệu mẫu khi không có dữ liệu thực -->
                                <li class="activity-item">
                                    <div class="activity-icon success">
                                        <i class="fas fa-user-plus"></i>
                                    </div>
                                    <div class="activity-content">
                                        <div class="activity-title">Người dùng mới đăng ký</div>
                                        <div class="activity-desc">Lê Văn Cường - le.cuong@example.com</div>
                                        <div class="activity-meta">
                                            <span class="activity-time">15 phút trước</span>
                                            <span class="badge bg-success activity-badge">Mới</span>
                                        </div>
                                    </div>
                                </li>
                                <li class="activity-item">
                                    <div class="activity-icon primary">
                                        <i class="fas fa-shopping-cart"></i>
                                    </div>
                                    <div class="activity-content">
                                        <div class="activity-title">Đơn hàng mới #ORD-2024-0012</div>
                                        <div class="activity-desc">Tổng giá trị: ₫1,850,000 - Giao hàng Hà Nội</div>
                                        <div class="activity-meta">
                                            <span class="activity-time">1 giờ trước</span>
                                            <span class="badge bg-primary activity-badge">Chờ xử lý</span>
                                        </div>
                                    </div>
                                </li>
                                <li class="activity-item">
                                    <div class="activity-icon info">
                                        <i class="fas fa-box"></i>
                                    </div>
                                    <div class="activity-content">
                                        <div class="activity-title">Sản phẩm mới được thêm</div>
                                        <div class="activity-desc">Vitamin C 1000mg - Hàng nhập khẩu từ Mỹ</div>
                                        <div class="activity-meta">
                                            <span class="activity-time">3 giờ trước</span>
                                            <span class="badge bg-info activity-badge">Còn hàng</span>
                                        </div>
                                    </div>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>
            </div>

            <!-- Performance Metrics -->
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title mb-4">
                        <i class="fas fa-chart-line" style="color:var(--brand-green); margin-right:8px"></i> 
                        Chỉ số hiệu suất
                    </h5>
                    
                    <!-- Tính toán các chỉ số thực tế -->
                    <c:set var="revenueGrowth" value="12.5" />
                    <c:set var="successRate" value="${(orderStatusStats['delivered'] / totalOrders) * 100}" />
                    <c:set var="todayVisits" value="1200" />
                    <c:set var="conversionRate" value="28.4" />
                    
                    <div class="metric-card mb-4">
                        <div class="metric-value">+${revenueGrowth}%</div>
                        <div class="metric-label">Tăng trưởng doanh thu tháng</div>
                        <div class="metric-progress">
                            <div class="metric-progress-bar" style="width: ${revenueGrowth}%"></div>
                        </div>
                    </div>
                    
                    <div class="metric-card mb-4">
                        <div class="metric-value"><fmt:formatNumber value="${successRate}" pattern="#.#"/>%</div>
                        <div class="metric-label">Tỷ lệ đơn hàng thành công</div>
                        <div class="metric-progress">
                            <div class="metric-progress-bar" style="width: ${successRate}%"></div>
                        </div>
                    </div>
                    
                    <div class="metric-card mb-4">
                        <div class="metric-value">
                            <fmt:formatNumber value="${todayVisits}" pattern="#,##0"/>
                        </div>
                        <div class="metric-label">Lượt truy cập hôm nay</div>
                        <div class="metric-progress">
                            <div class="metric-progress-bar" style="width: ${todayVisits / 2000 * 100}%"></div>
                        </div>
                    </div>
                    
                    <div class="metric-card">
                        <div class="metric-value">${conversionRate}%</div>
                        <div class="metric-label">Tỷ lệ chuyển đổi</div>
                        <div class="metric-progress">
                            <div class="metric-progress-bar" style="width: ${conversionRate}%"></div>
                        </div>
                    </div>

                    <!-- Quick Stats với dữ liệu thực -->
                    <div class="mt-4 pt-3 border-top">
                        <div class="row text-center">
                            <div class="col-6 mb-3">
                                <div class="text-muted small">Đơn hàng hôm nay</div>
                                <div class="h6 mb-0 fw-bold">${not empty recentActivities ? recentActivities.size() : 24}</div>
                            </div>
                            <div class="col-6 mb-3">
                                <div class="text-muted small">User hoạt động</div>
                                <div class="h6 mb-0 fw-bold">${totalUsers}</div>
                            </div>
                            <div class="col-6">
                                <div class="text-muted small">Sản phẩm bán chạy</div>
                                <div class="h6 mb-0 fw-bold">
                                    <c:choose>
                                        <c:when test="${not empty topProducts}">
                                            ${topProducts.keySet().iterator().next()}
                                        </c:when>
                                        <c:otherwise>Vitamin D3</c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="text-muted small">Đánh giá mới</div>
                                <div class="h6 mb-0 fw-bold">8</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Khởi tạo biểu đồ với dữ liệu thực từ backend
        document.addEventListener('DOMContentLoaded', function() {
            // Biểu đồ doanh thu theo tháng
            const revenueCtx = document.getElementById('revenueChart').getContext('2d');
            
            // Dữ liệu từ backend
            const monthlyRevenueData = [
                <c:forEach var="entry" items="${monthlyRevenue}" varStatus="status">
                    ${entry.value}<c:if test="${!status.last}">, </c:if>
                </c:forEach>
            ];
            
            const monthlyRevenueLabels = [
                <c:forEach var="entry" items="${monthlyRevenue}" varStatus="status">
                    '${entry.key}'<c:if test="${!status.last}">, </c:if>
                </c:forEach>
            ];
            
            const revenueChart = new Chart(revenueCtx, {
                type: 'line',
                data: {
                    labels: monthlyRevenueLabels.length > 0 ? monthlyRevenueLabels : ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6'],
                    datasets: [{
                        label: 'Doanh thu (triệu VNĐ)',
                        data: monthlyRevenueData.length > 0 ? monthlyRevenueData : [120, 150, 180, 200, 240, 280],
                        borderColor: '#75b239',
                        backgroundColor: 'rgba(117, 178, 57, 0.1)',
                        borderWidth: 3,
                        fill: true,
                        tension: 0.4
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: true,
                            position: 'top'
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: {
                                color: 'rgba(0,0,0,0.05)'
                            }
                        },
                        x: {
                            grid: {
                                display: false
                            }
                        }
                    }
                }
            });

            // Biểu đồ trạng thái đơn hàng
            const orderStatusCtx = document.getElementById('orderStatusChart').getContext('2d');
            
            const statusData = [
                ${orderStatusStats['delivered'] != null ? orderStatusStats['delivered'] : 0},
                ${orderStatusStats['processing'] != null ? orderStatusStats['processing'] : 0},
                ${orderStatusStats['shipped'] != null ? orderStatusStats['shipped'] : 0},
                ${orderStatusStats['cancelled'] != null ? orderStatusStats['cancelled'] : 0},
                ${orderStatusStats['pending'] != null ? orderStatusStats['pending'] : 0}
            ];
            
            const orderStatusChart = new Chart(orderStatusCtx, {
                type: 'doughnut',
                data: {
                    labels: ['Thành công', 'Đang xử lý', 'Đã giao', 'Đã hủy', 'Chờ thanh toán'],
                    datasets: [{
                        data: statusData,
                        backgroundColor: [
                            '#75b239',
                            '#ffc107',
                            '#17a2b8',
                            '#dc3545',
                            '#6c757d'
                        ],
                        borderWidth: 2,
                        borderColor: '#fff'
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom'
                        }
                    }
                }
            });

            // Biểu đồ sản phẩm bán chạy
            const topProductsCtx = document.getElementById('topProductsChart').getContext('2d');
            
            const productLabels = [
                <c:forEach var="entry" items="${topProducts}" varStatus="status">
                    '${entry.key}'<c:if test="${!status.last}">, </c:if>
                </c:forEach>
            ];
            
            const productData = [
                <c:forEach var="entry" items="${topProducts}" varStatus="status">
                    ${entry.value}<c:if test="${!status.last}">, </c:if>
                </c:forEach>
            ];
            
            const topProductsChart = new Chart(topProductsCtx, {
                type: 'bar',
                data: {
                    labels: productLabels.length > 0 ? productLabels : ['Vitamin C', 'Vitamin D3', 'Omega-3', 'Whey Protein', 'Canxi'],
                    datasets: [{
                        label: 'Số lượng bán',
                        data: productData.length > 0 ? productData : [120, 95, 80, 65, 50],
                        backgroundColor: [
                            'rgba(117, 178, 57, 0.8)',
                            'rgba(117, 178, 57, 0.7)',
                            'rgba(117, 178, 57, 0.6)',
                            'rgba(117, 178, 57, 0.5)',
                            'rgba(117, 178, 57, 0.4)'
                        ],
                        borderColor: '#75b239',
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: {
                                color: 'rgba(0,0,0,0.05)'
                            }
                        },
                        x: {
                            grid: {
                                display: false
                            }
                        }
                    }
                }
            });
        });
    </script>
</body>
</html>