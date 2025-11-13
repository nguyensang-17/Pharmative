<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý Orders - Admin</title>

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

            /* Animation Keyframes và Hover Effects (giữ nguyên) */
            .main-content { animation: fadeIn 0.6s ease-out; }
            .page-header { animation: slideInDown 0.5s ease-out 0.2s both; }
            .stat-card { animation: fadeInUp 0.5s ease-out both; }
            .stat-card:nth-child(1) { animation-delay: 0.3s; }
            .stat-card:nth-child(2) { animation-delay: 0.4s; }
            .stat-card:nth-child(3) { animation-delay: 0.5s; }
            .stat-card:nth-child(4) { animation-delay: 0.6s; }
            .stat-card:nth-child(5) { animation-delay: 0.7s; }

            @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
            @keyframes fadeInUp { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
            @keyframes fadeInLeft { from { opacity: 0; transform: translateX(-20px); } to { opacity: 1; transform: translateX(0); } }
            @keyframes slideInDown { from { opacity: 0; transform: translateY(-30px); } to { opacity: 1; transform: translateY(0); } }

            .stat-card, .card, .btn, .nav-link, .table tbody tr, .btn-group .btn, .badge, .status-badge {
                transition: all 0.3s ease;
            }

            .stat-card:hover { transform: translateY(-5px); box-shadow: 0 10px 25px rgba(117,178,57,0.15); }
            .card:hover { transform: translateY(-3px); box-shadow: 0 8px 20px rgba(24,39,75,0.12); }
            .btn:hover { transform: translateY(-2px); }
            .btn-success:hover { box-shadow: 0 4px 12px rgba(117,178,57,0.3); }
            .nav-link:hover { transform: translateX(5px); }
            .table tbody tr:hover { background-color: var(--brand-green-soft); transform: translateX(5px); }
            .btn-group .btn:hover { transform: scale(1.1); }
            .badge:hover, .status-badge:hover { transform: scale(1.05); }

            /* Sidebar Styles (giữ nguyên) */
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

            .sidebar-header { padding: 24px 20px; border-bottom: 1px solid rgba(255,255,255,0.1); text-align: center; }
            .sidebar-header h3 { margin: 0; font-weight: 700; font-size: 1.4rem; display: flex; align-items: center; justify-content: center; gap: 10px; }
            .user-info { padding: 16px 20px; border-bottom: 1px solid rgba(255,255,255,0.1); display: flex; align-items: center; gap: 12px; }
            .user-avatar { width: 42px; height: 42px; border-radius: 50%; background: rgba(255,255,255,0.2); display: flex; align-items: center; justify-content: center; font-size: 1.2rem; }
            .user-details { flex: 1; }
            .user-name { font-weight: 600; font-size: 0.95rem; margin-bottom: 4px; }
            .user-role { font-size: 0.8rem; opacity: 0.8; background: rgba(255,255,255,0.15); padding: 2px 8px; border-radius: 12px; display: inline-block; }
            .nav-menu { flex: 1; padding: 20px 0; overflow-y: auto; }
            .nav-item { margin-bottom: 4px; }
            .nav-link { display: flex; align-items: center; padding: 14px 20px; color: rgba(255,255,255,0.85); text-decoration: none; transition: all 0.2s ease; font-weight: 500; border-left: 3px solid transparent; }
            .nav-link:hover, .nav-link.active { background: rgba(255,255,255,0.1); color: white; border-left-color: white; }
            .nav-link i { width: 24px; margin-right: 12px; font-size: 1.1rem; }
            .sidebar-footer { padding: 16px 20px; border-top: 1px solid rgba(255,255,255,0.1); }
            .logout-btn { display: flex; align-items: center; justify-content: center; gap: 10px; width: 100%; padding: 12px; background: rgba(255,255,255,0.15); color: white; border: none; border-radius: 8px; font-weight: 600; transition: all 0.2s ease; }
            .logout-btn:hover { background: rgba(255,255,255,0.25); }

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

            .table th {
                border-top: none;
                font-weight: 600;
                color: #6c757d;
                font-size: 0.85rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                white-space: nowrap;
            }

            /* Stats Cards */
            .stats-cards {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
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

            .stat-icon.primary { background: linear-gradient(135deg, var(--brand-green), var(--brand-green-dark)); }
            .stat-icon.success { background: linear-gradient(135deg, #8bc34a, #7cb342); }
            .stat-icon.warning { background: linear-gradient(135deg, #cddc39, #d4e157); }
            .stat-icon.info { background: linear-gradient(135deg, #4caf50, #66bb6a); }
            .stat-icon.danger { background: linear-gradient(135deg, #f44336, #e53935); }

            /* Status Badges */
            .status-badge {
                padding: 0.35rem 0.75rem;
                border-radius: 20px;
                font-size: 0.8rem;
                font-weight: 600;
                text-transform: capitalize;
                display: inline-block;
                min-width: 100px;
                text-align: center;
            }

            .status-pending { background: #fff3cd; color: #856404; }
            .status-processing { background: #cce7ff; color: #004085; }
            .status-delivered { background: #d4edda; color: #155724; }
            .status-cancelled { background: #f8d7da; color: #721c24; }
            .status-payment_failed { background: #f8d7da; color: #721c24; }
            .status-shipped { background: #d1ecf1; color: #0c5460; }

            /* Payment Method Badges */
            .payment-badge {
                padding: 0.25rem 0.5rem;
                border-radius: 12px;
                font-size: 0.75rem;
                font-weight: 500;
                background: #e9ecef;
                color: #495057;
                display: inline-block;
            }

            .payment-cod { background: #fff3cd; color: #856404; }
            .payment-vnpay { background: #cce7ff; color: #004085; }
            .payment-momo { background: #f8d7da; color: #721c24; }
            .payment-bank { background: #d4edda; color: #155724; }

            /* Customer Info Styles */
            .customer-info {
                font-size: 0.85rem;
                line-height: 1.4;
            }

            .customer-name {
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 2px;
            }

            .customer-contact {
                color: #6c757d;
                font-size: 0.8rem;
            }

            .customer-email {
                word-break: break-all;
            }

            /* Shipping Address */
            .shipping-address {
                font-size: 0.8rem;
                color: #6c757d;
                line-height: 1.4;
                max-width: 200px;
            }

            /* Table responsive improvements */
            .table-responsive {
                border-radius: 8px;
                overflow: hidden;
            }

            .table td {
                vertical-align: middle;
                padding: 12px 8px;
            }

            .order-id {
                font-weight: 700;
                color: var(--brand-green);
            }

            .amount {
                font-weight: 600;
                color: #2c3e50;
            }

            .action-buttons {
                white-space: nowrap;
            }

            /* Responsive */
            @media (max-width: 1200px) {
                .stats-cards { grid-template-columns: repeat(auto-fit, minmax(180px, 1fr)); }
                .table th:nth-child(4),
                .table td:nth-child(4) { display: none; }
            }

            @media (max-width: 992px) {
                body { flex-direction: column; }
                .sidebar { width: 100%; height: auto; }
                .nav-menu { display: flex; overflow-x: auto; padding: 10px 0; }
                .nav-item { margin-bottom: 0; margin-right: 10px; flex-shrink: 0; }
                .nav-link { border-left: none; border-bottom: 3px solid transparent; padding: 10px 15px; white-space: nowrap; }
                .nav-link:hover, .nav-link.active { border-left-color: transparent; border-bottom-color: white; transform: translateY(-2px); }
                .user-info, .sidebar-footer { display: none; }
                .stats-cards { grid-template-columns: repeat(3, 1fr); }
                .table th:nth-child(3),
                .table td:nth-child(3) { display: none; }
            }

            @media (max-width: 768px) {
                .page-header { padding: 18px; border-radius: 12px; }
                .page-header::before { width: 80px; height: 80px; }
                .stats-cards { grid-template-columns: 1fr 1fr; }
                .table th:nth-child(5),
                .table td:nth-child(5) { display: none; }
            }

            @media (max-width: 576px) {
                .stats-cards { grid-template-columns: 1fr; }
                .main-content { padding: 15px; }
                .table th:nth-child(2),
                .table td:nth-child(2),
                .table th:nth-child(6),
                .table td:nth-child(6) { display: none; }
                .btn-group { display: flex; flex-direction: column; gap: 4px; }
                .btn-group .btn { margin: 0; }
            }
        </style>
    </head>
    <body>
        <!-- Sidebar Navigation (giữ nguyên) -->
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
                    <a href="${pageContext.request.contextPath}/admin/users" class="nav-link">
                        <i class="fas fa-users-cog"></i>
                        <span>Quản lý Users</span>
                    </a>
                </div>
                <div class="nav-item">
                    <a href="${pageContext.request.contextPath}/admin/orders" class="nav-link active">
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
                    <a href="${pageContext.request.contextPath}/logout" class="nav-link logout-link">
                        <i class="fas fa-sign-out-alt"></i>
                        <span>Đăng xuất</span>
                    </a>
                </div>
            </div>
        </div>

        <!-- Main content -->
        <div class="main-content">
            <!-- Page Header -->
            <div class="page-header">
                <div>
                    <h2><i class="fas fa-file-invoice" style="margin-right:10px"></i> Quản lý Orders</h2>
                    <p class="mb-0" style="opacity:0.9">Quản lý thông tin đơn hàng hệ thống</p>
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
                        <div class="stat-title">Tổng Orders</div>
                        <div class="stat-value">
                            <fmt:formatNumber value="${totalOrders}" pattern="#,###"/>
                        </div>
                    </div>
                    <div class="stat-icon primary">
                        <i class="fas fa-shopping-bag"></i>
                    </div>
                </div>

                <div class="stat-card">
                    <div>
                        <div class="stat-title">Chờ xử lý</div>
                        <div class="stat-value">
                            <fmt:formatNumber value="${pendingOrders}" pattern="#,###"/>
                        </div>
                    </div>
                    <div class="stat-icon warning">
                        <i class="fas fa-clock"></i>
                    </div>
                </div>

                <div class="stat-card">
                    <div>
                        <div class="stat-title">Đang xử lý</div>
                        <div class="stat-value">
                            <fmt:formatNumber value="${processingOrders}" pattern="#,###"/>
                        </div>
                    </div>
                    <div class="stat-icon info">
                        <i class="fas fa-truck"></i>
                    </div>
                </div>

                <div class="stat-card">
                    <div>
                        <div class="stat-title">Đã giao</div>
                        <div class="stat-value">
                            <fmt:formatNumber value="${deliveredOrders}" pattern="#,###"/>
                        </div>
                    </div>
                    <div class="stat-icon success">
                        <i class="fas fa-check-circle"></i>
                    </div>
                </div>

                <div class="stat-card">
                    <div>
                        <div class="stat-title">Đã hủy</div>
                        <div class="stat-value">
                            <fmt:formatNumber value="${cancelledOrders}" pattern="#,###"/>
                        </div>
                    </div>
                    <div class="stat-icon danger">
                        <i class="fas fa-times-circle"></i>
                    </div>
                </div>
            </div>

            <!-- Search and Filter Card -->
            <div class="card">
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/admin/orders" method="get" class="row g-3">
                        <div class="col-md-3">
                            <input type="text" class="form-control" name="keyword" 
                                   placeholder="Tìm kiếm theo mã đơn hàng, tên khách hàng..." 
                                   value="${param.keyword}">
                        </div>
                        <div class="col-md-2">
                            <select class="form-select" name="status">
                                <option value="">Tất cả trạng thái</option>
                                <option value="pending" ${param.status == 'pending' ? 'selected' : ''}>Chờ xử lý</option>
                                <option value="processing" ${param.status == 'processing' ? 'selected' : ''}>Đang xử lý</option>
                                <option value="shipped" ${param.status == 'shipped' ? 'selected' : ''}>Đang giao</option>
                                <option value="delivered" ${param.status == 'delivered' ? 'selected' : ''}>Đã giao</option>
                                <option value="cancelled" ${param.status == 'cancelled' ? 'selected' : ''}>Đã hủy</option>
                                <option value="payment_failed" ${param.status == 'payment_failed' ? 'selected' : ''}>Lỗi thanh toán</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <select class="form-select" name="payment_method">
                                <option value="">Tất cả PT thanh toán</option>
                                <option value="cod" ${param.payment_method == 'cod' ? 'selected' : ''}>COD</option>
                                <option value="vnpay" ${param.payment_method == 'vnpay' ? 'selected' : ''}>VNPAY</option>
                                <option value="momo" ${param.payment_method == 'momo' ? 'selected' : ''}>MOMO</option>
                                <option value="bank" ${param.payment_method == 'bank' ? 'selected' : ''}>Bank Transfer</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <input type="date" class="form-control" name="dateFrom" 
                                   value="${param.dateFrom}">
                        </div>
                        <div class="col-md-2">
                            <input type="date" class="form-control" name="dateTo" 
                                   value="${param.dateTo}">
                        </div>
                        <div class="col-md-1">
                            <button type="submit" class="btn btn-success w-100">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                        
                        <c:if test="${not empty param.keyword or not empty param.status or not empty param.payment_method or not empty param.dateFrom}">
                            <div class="col-12">
                                <div class="d-flex justify-content-between align-items-center">
                                    <small class="text-muted">
                                        <c:if test="${not empty param.keyword}">Từ khóa: "${param.keyword}" </c:if>
                                        <c:if test="${not empty param.status}">
                                            <c:choose>
                                                <c:when test="${param.status == 'pending'}">Trạng thái: Chờ xử lý</c:when>
                                                <c:when test="${param.status == 'processing'}">Trạng thái: Đang xử lý</c:when>
                                                <c:when test="${param.status == 'shipped'}">Trạng thái: Đang giao</c:when>
                                                <c:when test="${param.status == 'delivered'}">Trạng thái: Đã giao</c:when>
                                                <c:when test="${param.status == 'cancelled'}">Trạng thái: Đã hủy</c:when>
                                                <c:when test="${param.status == 'payment_failed'}">Trạng thái: Lỗi thanh toán</c:when>
                                            </c:choose>
                                        </c:if>
                                        <c:if test="${not empty param.payment_method}">
                                            <c:choose>
                                                <c:when test="${param.payment_method == 'cod'}">PT thanh toán: COD</c:when>
                                                <c:when test="${param.payment_method == 'vnpay'}">PT thanh toán: VNPAY</c:when>
                                                <c:when test="${param.payment_method == 'momo'}">PT thanh toán: MOMO</c:when>
                                                <c:when test="${param.payment_method == 'bank'}">PT thanh toán: Bank Transfer</c:when>
                                            </c:choose>
                                        </c:if>
                                        <c:if test="${not empty param.dateFrom}">Từ ngày: ${param.dateFrom}</c:if>
                                        <c:if test="${not empty param.dateTo}">Đến ngày: ${param.dateTo}</c:if>
                                    </small>
                                    <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-sm btn-outline-secondary">
                                        <i class="fas fa-times"></i> Xóa bộ lọc
                                    </a>
                                </div>
                            </div>
                        </c:if>
                    </form>
                </div>
            </div>

            <!-- Orders Table Card -->
            <div class="card">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="card-title mb-0">
                            Danh sách đơn hàng 
                            <c:if test="${not empty orderList}">
                                <span class="badge bg-success ms-2">${orderList.size()} đơn hàng</span>
                            </c:if>
                        </h5>
                        <div>
                            <a href="${pageContext.request.contextPath}/admin/orders/export" 
                               class="btn btn-outline-secondary me-2" id="exportBtn">
                                <i class="fas fa-download"></i> Xuất file CSV
                            </a>
                        </div>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Mã đơn hàng</th>
                                    <th>Thông tin khách hàng</th>
                                    <th>Ngày đặt</th>
                                    <th>Địa chỉ giao hàng</th>
                                    <th>PT thanh toán</th>
                                    <th>Tổng tiền</th>
                                    <th>Trạng thái</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="order" items="${orderList}">
                                    <tr>
                                        <td>
                                            <div class="order-id">#${order.orderId}</div>
                                            <small class="text-muted">
                                                <fmt:formatDate value="${order.orderDate}" pattern="HH:mm" />
                                            </small>
                                        </td>
                                        <td>
                                            <div class="customer-info">
                                                <div class="customer-name">${order.customerName}</div>
                                                <div class="customer-contact">
                                                    <i class="fas fa-envelope me-1"></i>
                                                    <span class="customer-email">${order.customerEmail}</span>
                                                </div>
                                                <div class="customer-contact">
                                                    <i class="fas fa-phone me-1"></i>
                                                    ${order.customerPhone}
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy" />
                                        </td>
                                        <td>
                                            <div class="shipping-address">
                                                ${order.shippingAddress}
                                            </div>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${order.paymentMethod == 'cod'}">
                                                    <span class="payment-badge payment-cod">COD</span>
                                                </c:when>
                                                <c:when test="${order.paymentMethod == 'vnpay'}">
                                                    <span class="payment-badge payment-vnpay">VNPAY</span>
                                                </c:when>
                                                <c:when test="${order.paymentMethod == 'momo'}">
                                                    <span class="payment-badge payment-momo">MOMO</span>
                                                </c:when>
                                                <c:when test="${order.paymentMethod == 'bank'}">
                                                    <span class="payment-badge payment-bank">Bank</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="payment-badge">${order.paymentMethod}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="amount">
                                                <fmt:formatNumber value="${order.totalAmount}" type="number" /> ₫
                                            </div>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${order.status == 'PENDING' || order.status == 'pending'}">
                                                    <span class="status-badge status-pending">Chờ xử lý</span>
                                                </c:when>
                                                <c:when test="${order.status == 'PROCESSING' || order.status == 'processing'}">
                                                    <span class="status-badge status-processing">Đang xử lý</span>
                                                </c:when>
                                                <c:when test="${order.status == 'SHIPPED' || order.status == 'shipped'}">
                                                    <span class="status-badge status-shipped">Đang giao</span>
                                                </c:when>
                                                <c:when test="${order.status == 'DELIVERED' || order.status == 'delivered'}">
                                                    <span class="status-badge status-delivered">Đã giao</span>
                                                </c:when>
                                                <c:when test="${order.status == 'CANCELLED' || order.status == 'cancelled'}">
                                                    <span class="status-badge status-cancelled">Đã hủy</span>
                                                </c:when>
                                                <c:when test="${order.status == 'PAYMENT_FAILED' || order.status == 'payment_failed'}">
                                                    <span class="status-badge status-payment_failed">Lỗi thanh toán</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-badge">${order.status}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="btn-group action-buttons">
                                                <a href="${pageContext.request.contextPath}/admin/orders?action=detail&id=${order.orderId}" 
                                                   class="btn btn-sm btn-outline-primary" title="Xem chi tiết">
                                                    <i class="fas fa-eye"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/admin/orders?action=edit&id=${order.orderId}" 
                                                   class="btn btn-sm btn-outline-warning" title="Chỉnh sửa">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <button type="button" class="btn btn-sm btn-outline-danger" 
                                                        data-bs-toggle="modal" 
                                                        data-bs-target="#deleteModal${order.orderId}"
                                                        title="Xóa">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </div>

                                            <!-- Delete Confirmation Modal -->
                                            <div class="modal fade" id="deleteModal${order.orderId}" tabindex="-1">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title">Xác nhận xóa</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            Bạn có chắc chắn muốn xóa đơn hàng <strong>#${order.orderId}</strong>?
                                                            <br><small class="text-danger">Hành động này không thể hoàn tác!</small>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                                            <a href="${pageContext.request.contextPath}/admin/orders?action=delete&id=${order.orderId}" 
                                                               class="btn btn-danger">Xóa</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>

                                <c:if test="${empty orderList}">
                                    <tr>
                                        <td colspan="8" class="text-center text-muted py-4">
                                            <i class="fas fa-shopping-bag fa-2x mb-3"></i>
                                            <p>Không có đơn hàng nào được tìm thấy</p>
                                            <c:if test="${not empty param.keyword or not empty param.status}">
                                                <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-sm btn-success">
                                                    <i class="fas fa-times"></i> Xóa bộ lọc
                                                </a>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>

                    <!-- Pagination (giữ nguyên) -->
                    <c:if test="${totalPages > 1}">
                        <nav aria-label="Page navigation">
                            <ul class="pagination justify-content-center">
                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link" 
                                       href="?page=${currentPage - 1}
                                       <c:if test="${not empty param.keyword}">&keyword=${param.keyword}</c:if>
                                       <c:if test="${not empty param.status}">&status=${param.status}</c:if>
                                       <c:if test="${not empty param.payment_method}">&payment_method=${param.payment_method}</c:if>
                                       <c:if test="${not empty param.dateFrom}">&dateFrom=${param.dateFrom}</c:if>
                                       <c:if test="${not empty param.dateTo}">&dateTo=${param.dateTo}</c:if>">
                                       Trước
                                    </a>
                                </li>
                                
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                                        <a class="page-link" 
                                           href="?page=${i}
                                           <c:if test="${not empty param.keyword}">&keyword=${param.keyword}</c:if>
                                           <c:if test="${not empty param.status}">&status=${param.status}</c:if>
                                           <c:if test="${not empty param.payment_method}">&payment_method=${param.payment_method}</c:if>
                                           <c:if test="${not empty param.dateFrom}">&dateFrom=${param.dateFrom}</c:if>
                                           <c:if test="${not empty param.dateTo}">&dateTo=${param.dateTo}</c:if>">
                                           ${i}
                                        </a>
                                    </li>
                                </c:forEach>
                                
                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                    <a class="page-link" 
                                       href="?page=${currentPage + 1}
                                       <c:if test="${not empty param.keyword}">&keyword=${param.keyword}</c:if>
                                       <c:if test="${not empty param.status}">&status=${param.status}</c:if>
                                       <c:if test="${not empty param.payment_method}">&payment_method=${param.payment_method}</c:if>
                                       <c:if test="${not empty param.dateFrom}">&dateFrom=${param.dateFrom}</c:if>
                                       <c:if test="${not empty param.dateTo}">&dateTo=${param.dateTo}</c:if>">
                                       Sau
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </c:if>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                // Xử lý nút export
                const exportBtn = document.getElementById('exportBtn');
                if (exportBtn) {
                    exportBtn.addEventListener('click', function(e) {
                        console.log('Bắt đầu xuất file CSV...');
                        const originalHTML = exportBtn.innerHTML;
                        exportBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang xuất file...';
                        exportBtn.classList.add('disabled');
                        
                        setTimeout(() => {
                            exportBtn.innerHTML = originalHTML;
                            exportBtn.classList.remove('disabled');
                        }, 15000);
                    });
                }
                
                // Tự động submit form khi thay đổi select
                const statusSelect = document.querySelector('select[name="status"]');
                const paymentSelect = document.querySelector('select[name="payment_method"]');
                
                if (statusSelect) {
                    statusSelect.addEventListener('change', function() {
                        this.form.submit();
                    });
                }
                
                if (paymentSelect) {
                    paymentSelect.addEventListener('change', function() {
                        this.form.submit();
                    });
                }
                
                // Hiển thị loading khi tìm kiếm
                const searchForm = document.querySelector('form');
                if (searchForm) {
                    searchForm.addEventListener('submit', function(e) {
                        const submitBtn = this.querySelector('button[type="submit"]');
                        if (submitBtn) {
                            const originalHTML = submitBtn.innerHTML;
                            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
                            submitBtn.disabled = true;
                            
                            setTimeout(() => {
                                submitBtn.innerHTML = originalHTML;
                                submitBtn.disabled = false;
                            }, 3000);
                        }
                    });
                }
            });
        </script>
    </body>
</html>