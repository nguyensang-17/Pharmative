<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Users - Admin</title>
    
    <!-- Bootstrap + FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
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

        .table tbody tr {
            animation: fadeInLeft 0.4s ease-out both;
        }

        .table tbody tr:nth-child(1) { animation-delay: 0.5s; }
        .table tbody tr:nth-child(2) { animation-delay: 0.6s; }
        .table tbody tr:nth-child(3) { animation-delay: 0.7s; }
        .table tbody tr:nth-child(4) { animation-delay: 0.8s; }

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

        @keyframes fadeInLeft {
            from { 
                opacity: 0;
                transform: translateX(-20px);
            }
            to { 
                opacity: 1;
                transform: translateX(0);
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

        .btn {
            transition: all 0.3s ease;
        }

        .btn:hover {
            transform: translateY(-2px);
        }

        .btn-success:hover {
            box-shadow: 0 4px 12px rgba(117,178,57,0.3);
        }

        .nav-link {
            transition: all 0.3s ease;
        }

        .nav-link:hover {
            transform: translateX(5px);
        }

        .table tbody tr {
            transition: all 0.3s ease;
        }

        .table tbody tr:hover {
            background-color: var(--brand-green-soft);
            transform: translateX(5px);
        }

        .btn-group .btn {
            transition: all 0.3s ease;
        }

        .btn-group .btn:hover {
            transform: scale(1.1);
        }

        .badge {
            transition: all 0.3s ease;
        }

        .badge:hover {
            transform: scale(1.05);
        }

        /* Original Styles (giữ nguyên) */
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
            scrollbar-width: none; /* Firefox */
            -ms-overflow-style: none; /* IE and Edge */
            max-height: calc(100vh - 200px); /* Giới hạn chiều cao */
        }

        /* Ẩn scrollbar trên Chrome, Safari và Opera */
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
        
        .status-verified {
            color: #28a745;
            font-weight: 600;
        }
        
        .status-unverified {
            color: #dc3545;
            font-weight: 600;
        }
        
        .table th {
            border-top: none;
            font-weight: 600;
            color: #6c757d;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
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
                max-height: none; /* Bỏ giới hạn chiều cao trên mobile */
                scrollbar-width: none; /* Firefox */
                -ms-overflow-style: none; /* IE and Edge */
            }

            /* Ẩn scrollbar ngang trên mobile */
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
        }

        @media (max-width: 576px) {
            .stats-cards { grid-template-columns: 1fr; }
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
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link">
                    <i class="fas fa-tachometer-alt"></i>
                    <span>Dashboard</span>
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/users" class="nav-link active">
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
                <h2><i class="fas fa-users" style="margin-right:10px"></i> Quản lý Users</h2>
                <p class="mb-0" style="opacity:0.9">Quản lý thông tin người dùng hệ thống</p>
            </div>
        </div>

        <!-- Messages -->
        <c:if test="${not empty sessionScope.message}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${sessionScope.message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="message" scope="session"/>
        </c:if>

        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${sessionScope.error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="error" scope="session"/>
        </c:if>

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
                    <div class="stat-title">Khách hàng</div>
                    <div class="stat-value">
                        <fmt:formatNumber value="${totalCustomers}" pattern="#,###"/>
                    </div>
                </div>
                <div class="stat-icon success">
                    <i class="fas fa-user-friends"></i>
                </div>
            </div>

            <div class="stat-card">
                <div>
                    <div class="stat-title">Quản trị viên</div>
                    <div class="stat-value">
                        <fmt:formatNumber value="${totalAdmins}" pattern="#,###"/>
                    </div>
                </div>
                <div class="stat-icon warning">
                    <i class="fas fa-user-shield"></i>
                </div>
            </div>

            <div class="stat-card">
                <div>
                    <div class="stat-title">User mới (tháng)</div>
                    <div class="stat-value">
                        <fmt:formatNumber value="${newUsersThisMonth}" pattern="#,###"/>
                    </div>
                </div>
                <div class="stat-icon info">
                    <i class="fas fa-user-plus"></i>
                </div>
            </div>
        </div>

        <!-- Search and Filter Card -->
        <div class="card">
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/admin/users" method="get" class="row g-3">
                    <div class="col-md-6">
                        <input type="text" class="form-control" name="keyword" 
                               placeholder="Tìm kiếm theo tên, email, số điện thoại..." 
                               value="${param.keyword}">
                    </div>
                    <div class="col-md-3">
                        <select class="form-select" name="role">
                            <option value="">Tất cả vai trò</option>
                            <option value="customer" ${param.role == 'customer' ? 'selected' : ''}>Khách hàng</option>
                            <option value="admin" ${param.role == 'admin' ? 'selected' : ''}>Quản trị viên</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <button type="submit" class="btn btn-success w-100">
                            <i class="fas fa-search"></i> Tìm kiếm
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Users Table Card -->
        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Họ tên</th>
                                <th>Email</th>
                                <th>Số điện thoại</th>
                                <th>Vai trò</th>
                                <th>Xác thực</th>
                                <th>Ngày tạo</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" items="${users}">
                                <tr>
                                    <td>${user.id}</td>
                                    <td>
                                        <strong>${user.fullname}</strong>
                                    </td>
                                    <td>${user.email}</td>
                                    <td>${user.phoneNumber != null ? user.phoneNumber : 'N/A'}</td>
                                    <td>
                                        <span class="badge bg-${user.role == 'admin' ? 'warning' : 'success'}">
                                            ${user.role == 'admin' ? 'Quản trị' : 'Khách hàng'}
                                        </span>
                                    </td>
                                    <td>
                                        <span class="${user.verified ? 'status-verified' : 'status-unverified'}">
                                            <i class="fas fa-circle ${user.verified ? 'text-success' : 'text-danger'}" style="font-size: 8px;"></i>
                                            ${user.verified ? 'Đã xác thực' : 'Chưa xác thực'}
                                        </span>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${user.createdAt}" pattern="dd/MM/yyyy"/>
                                    </td>
                                    <td>
                                        <div class="btn-group">
                                            <a href="${pageContext.request.contextPath}/admin/users?action=view&id=${user.id}" 
                                               class="btn btn-sm btn-outline-primary" title="Xem chi tiết">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/users?action=edit&id=${user.id}" 
                                               class="btn btn-sm btn-outline-warning" title="Chỉnh sửa">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/users?action=toggle-status&id=${user.id}" 
                                               class="btn btn-sm btn-outline-${user.verified ? 'danger' : 'success'}" 
                                               title="${user.verified ? 'Khóa' : 'Mở khóa'}">
                                                <i class="fas fa-${user.verified ? 'lock' : 'unlock'}"></i>
                                            </a>
                                            <button type="button" class="btn btn-sm btn-outline-danger" 
                                                    data-bs-toggle="modal" 
                                                    data-bs-target="#deleteModal${user.id}"
                                                    title="Xóa">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>

                                        <!-- Delete Confirmation Modal -->
                                        <div class="modal fade" id="deleteModal${user.id}" tabindex="-1">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title">Xác nhận xóa</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        Bạn có chắc chắn muốn xóa user <strong>${user.fullname}</strong>?
                                                        <br><small class="text-danger">Hành động này không thể hoàn tác!</small>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                                        <a href="${pageContext.request.contextPath}/admin/users?action=delete&id=${user.id}" 
                                                           class="btn btn-danger">Xóa</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            
                            <c:if test="${empty users}">
                                <tr>
                                    <td colspan="8" class="text-center text-muted py-4">
                                        <i class="fas fa-users fa-2x mb-3"></i>
                                        <p>Không có user nào được tìm thấy</p>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <nav aria-label="Page navigation">
                        <ul class="pagination justify-content-center">
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="?page=${currentPage - 1}${param.keyword != null ? '&keyword=' += param.keyword : ''}${param.role != null ? '&role=' += param.role : ''}">Trước</a>
                            </li>
                            
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" href="?page=${i}${param.keyword != null ? '&keyword=' += param.keyword : ''}${param.role != null ? '&role=' += param.role : ''}">${i}</a>
                                </li>
                            </c:forEach>
                            
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="?page=${currentPage + 1}${param.keyword != null ? '&keyword=' += param.keyword : ''}${param.role != null ? '&role=' += param.role : ''}">Sau</a>
                            </li>
                        </ul>
                    </nav>
                </c:if>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>