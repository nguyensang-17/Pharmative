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
            .stat-icon.danger {
                background: linear-gradient(135deg, #f44336, #e53935);
            }

            /* Status Badges */
            .status-badge {
                padding: 0.35rem 0.75rem;
                border-radius: 20px;
                font-size: 0.8rem;
                font-weight: 600;
                text-transform: capitalize;
            }

            .status-pending {
                background: #fff3cd;
                color: #856404;
            }

            .status-processing {
                background: #cce7ff;
                color: #004085;
            }

            .status-completed, .status-delivered {
                background: #d4edda;
                color: #155724;
            }

            .status-cancelled {
                background: #f8d7da;
                color: #721c24;
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
                .page-header {
                    padding: 18px;
                    border-radius: 12px;
                }
                .page-header::before {
                    width: 80px;
                    height: 80px;
                }
                .stats-cards {
                    grid-template-columns: 1fr 1fr;
                }
            }

            @media (max-width: 576px) {
                .stats-cards {
                    grid-template-columns: 1fr;
                }
                .main-content {
                    padding: 15px;
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
                <button class="logout-btn" onclick="location.href = '${pageContext.request.contextPath}/logout'">
                    <i class="fas fa-sign-out-alt"></i> Đăng xuất
                </button>
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
                        <div class="col-md-4">
                            <input type="text" class="form-control" name="keyword" 
                                   placeholder="Tìm kiếm theo mã đơn hàng, tên khách hàng..." 
                                   value="${param.keyword}">
                        </div>
                        <div class="col-md-3">
                            <select class="form-select" name="status">
                                <option value="">Tất cả trạng thái</option>
                                <option value="pending" ${param.status == 'pending' ? 'selected' : ''}>Chờ xử lý</option>
                                <option value="processing" ${param.status == 'processing' ? 'selected' : ''}>Đang xử lý</option>
                                <option value="delivered" ${param.status == 'delivered' ? 'selected' : ''}>Đã giao</option>
                                <option value="cancelled" ${param.status == 'cancelled' ? 'selected' : ''}>Đã hủy</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <input type="date" class="form-control" name="dateFrom" 
                                   value="${param.dateFrom}">
                        </div>
                        <div class="col-md-2">
                            <button type="submit" class="btn btn-success w-100">
                                <i class="fas fa-search"></i> Tìm kiếm
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Orders Table Card -->
            <div class="card">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="card-title mb-0">Danh sách đơn hàng</h5>
                        <div>
                            <button class="btn btn-outline-secondary me-2">
                                <i class="fas fa-download"></i> Xuất file
                            </button>
                            <button class="btn btn-success">
                                <i class="fas fa-plus"></i> Đơn hàng mới
                            </button>
                        </div>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Mã đơn hàng</th>
                                    <th>Khách hàng</th>
                                    <th>Ngày đặt</th>
                                    <th>Tổng tiền</th>
                                    <th>Trạng thái</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="order" items="${orderList}">
    <tr>
        <td><strong>#${order.orderId}</strong></td>
        <td>${order.customerName}</td> <!-- Sử dụng customerName từ DAO -->
        <td>
            <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy" />
        </td>
        <td>
            <strong>
                <fmt:formatNumber value="${order.totalAmount}" type="number" /> VNĐ
            </strong>
        </td>
        <td>
            <c:choose>
                <c:when test="${order.status == 'PENDING' || order.status == 'pending'}">
                    <span class="status-badge status-pending">Chờ xử lý</span>
                </c:when>
                <c:when test="${order.status == 'PROCESSING' || order.status == 'processing'}">
                    <span class="status-badge status-processing">Đang xử lý</span>
                </c:when>
                <c:when test="${order.status == 'DELIVERED' || order.status == 'delivered'}">
                    <span class="status-badge status-delivered">Đã giao</span>
                </c:when>
                <c:when test="${order.status == 'CANCELLED' || order.status == 'cancelled'}">
                    <span class="status-badge status-cancelled">Đã hủy</span>
                </c:when>
                <c:otherwise>
                    <span class="status-badge">${order.status}</span>
                </c:otherwise>
            </c:choose>
        </td>
        <td>
            <div class="btn-group">
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
        <td colspan="6" class="text-center text-muted py-4">
            <i class="fas fa-shopping-bag fa-2x mb-3"></i>
            <p>Không có đơn hàng nào được tìm thấy</p>
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
                                    <a class="page-link" href="?page=${currentPage - 1}${param.keyword != null ? '&keyword=' += param.keyword : ''}${param.status != null ? '&status=' += param.status : ''}${param.dateFrom != null ? '&dateFrom=' += param.dateFrom : ''}">Trước</a>
                                </li>

                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                                        <a class="page-link" href="?page=${i}${param.keyword != null ? '&keyword=' += param.keyword : ''}${param.status != null ? '&status=' += param.status : ''}${param.dateFrom != null ? '&dateFrom=' += param.dateFrom : ''}">${i}</a>
                                    </li>
                                </c:forEach>

                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                    <a class="page-link" href="?page=${currentPage + 1}${param.keyword != null ? '&keyword=' += param.keyword : ''}${param.status != null ? '&status=' += param.status : ''}${param.dateFrom != null ? '&dateFrom=' += param.dateFrom : ''}">Sau</a>
                                </li>
                            </ul>
                        </nav>
                    </c:if>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                            --brand - green: #75b239;
                    --brand - green - dark: #5fa127;
                    --brand - green - light: #e8f4dc;
                    --brand - green - soft: rgba(117, 178, 57, 0.08);
                    --bg: #f6f8f7;
                    --card - bg: #ffffff;
                    --shadow: 0 6px 18px rgba(24, 39, 75, 0.06);
                }
                
            body {
                            font - family: 'Segoe UI', Tahoma, Geneva, Verdana, sans - serif;
                    background - color: var (--bg);
                    color: #333;
                    display: flex;
                    min - height: 100vh;
                    margin: 0;
                }
                
                /* Sidebar Styles */
                .sidebar {
                            width: 260px;
                    background: linear - gradient(180deg, var (--brand - green), var (--brand - green - dark));
                    color: white;
                    padding: 0;
                    box - shadow: 4px 0 20px rgba(0, 0, 0, 0.08);
                    z - index: 100;
                    display: flex;
                    flex - direction: column;
                }
                
                .sidebar-header {
                            padding: 24px 20px;
                    border - bottom: 1px solid rgba(255, 255, 255, 0.1);
                    text - align: center;
                }
                
                .sidebar-header h3 {
                            margin: 0;
                    font - weight: 700;
                    font - size: 1.4rem;
                    display: flex;
                    align - items: center;
                    justify - content: center;
                    gap: 10px;
                }
                
                .user-info {
                            padding: 16px 20px;
                    border - bottom: 1px solid rgba(255, 255, 255, 0.1);
                    display: flex;
                    align - items: center;
                    gap: 12px;
            }
                
                .user-avatar {
                            width: 42px;
                    height: 42px;
                    border - radius: 50 % ;
                    background: rgba(255, 255, 255, 0.2);
                    display: flex;
                    align - items: center;
                    justify - content: center;
                    font - size: 1.2rem;
                }
                
                .user-details {
                            flex: 1;
                }
                
                .user-name {
                            font - weight: 600;
                    font - size: 0.95rem;
                    margin - bottom: 4px;
                }
                
                .user-role {
                            font - size: 0.8rem;
                    opacity: 0.8;
                    background: rgba(255, 255, 255, 0.15);
                    padding: 2px 8px;
                    border - radius: 12px;
                    display: inline - block;
                }
                
                .nav-menu {
                            flex: 1;
                    padding: 20px 0;
                    overflow - y: auto;
                }
                
                .nav-item {
                            margin - bottom: 4px;
                }
                
                .nav-link {
                            display: flex;
                    align - items: center;
                    padding: 14px 20px;
                    color: rgba(255, 255, 255, 0.85);
                    text - decoration: none;
                    transition: all 0.2s ease;
                    font - weight: 500;
                    border - left: 3px solid transparent;
            }
            
                .nav-link:hover, .nav-link.active {
                            background: rgba(255, 255, 255, 0.1);
                    color: white;
                    border - left - color: white;
            }
            
            .nav-link i {
                            width: 24px;
                    margin - right: 12px;
                    font - size: 1.1rem;
                }
                
                .sidebar-footer {
                            padding: 16px 20px;
                    border - top: 1px solid rgba(255, 255, 255, 0.1);
                }
                
                .logout-btn {
                            display: flex;
                    align - items: center;
                    justify - content: center;
                    gap: 10px;
                                                width: 100 % ;
                                                padding: 12px;
                    background: rgba(255, 255, 255, 0.15);
                                                    color: white;
                                                border: none;
                                                border - radius: 8px;
                    font - weight: 600;
                                                    transition: all 0.2s ease;
                }
                
                .logout-btn:hover {
                            background: rgba(255, 255, 255, 0.25);
                  }
                    
                  /* Ma i n Content */
                    .main - conte n t {
                    fle x : 1;
                    pad ding: 28px;
                    overflow - y: auto;
              }
                    
                .page-he ade r { 
                    background: linear - gradien t (135deg, var (--bra nd - gre en), var  (--brand  - gr e en - dark));
                      color:  white;
                    padding: 24px 28px;
                    border -   radius: 16px;
                                                margin - bottom: 26px;
                    box - shadow: 0 6px 18px rgba(117, 178, 57, 0.12);
                    posit i on: relative;
                        ov erfl ow: hidd e n;
                    }
            
                    .page-header::before {
                              content:  "" ;
                    p osition: absolute;
                    top: 0;
                                                right: 0;
                                                width: 120px;
                    height: 120px;
                      background: rgba(255, 25 5, 2 55,  0.1);
                                                    border - radius: 50 % ;
                    transform: translate(30px, - 30px);
                  }
                    
              .card {
                    border: none;
                    border - radius: 1 2 px;
                                                   box - shadow: var (--shadow);
                            margin - bottom: 24px;
                    borde r : 1px solid rgba(117, 178,  57,  0.1) ;
                    }
                    
                    .btn-success {
                            background: var (--brand - green);
                    border: none;
                    }
            
                    .btn-success:hover {
                    background: var (--brand - green - dark);
                  }
                    
                    .table th {
                                                        border - top: none;
                                                    font - weight: 600;
                            color: #6c757d;
                    font - size:  0 .85rem;
                                            text  -  transform: uppercase;
                            letter - spacing:  0 .5px;
                    }
                    
                /* Stats Cards * /
                    .stats-cards {
                    di s play: grid;
                            grid - te m plate - columns: repeat(auto - fit, minmax(230px, 1fr));
                    gap: 18px;
                                                            m argin - bottom: 28px;
                }
                            
                                                            .stat-card {
                    background: var (--card - bg);
                    border - radius: 16px;
                    padding: 20px;
                    box - shado w : var (--shadow);
                    transition: transform .18s ease, bo x  - shadow .18s ease;
                      display: flex;
                                                            align - items: center;
                            justify - content: space - bet ween ;
                    min - height: 110px;
                                                        border: 1px solid rgba(117, 178, 57, 0.1);
                            }
                    
                    .stat-card:hover {
                            transform: translateY( - 6px);
                    box - shadow: 0 10px 30px r g ba(117, 178, 57, 0.12);
                            border - color: rgba(117, 178, 57, 0.3);
                    }
            
                    .stat-title {
                    font - size: 0.8rem;
                    color:   #6c6f76;
                    text - transform: uppercase;
                    font - weight: 700;
                    letter - spacing: .08em;
                }
                 
                    .stat-value {
                                            margin - top: 6px;
                            font - size: 1.9rem;
                                font - weight: 800;
                                color: #2b2e33;
                            }
                    
                    .stat-icon {
                                        width: 60px;
                            height: 60px;
                      border - radius : 12 px;
                        disp l ay: f l ex;
                    align - items: center;
                    justify - content :  center;
                    fon t  - size: 1.3rem;
                      color: #fff;
                    box - shadow: 0 6px 14px rgba(117, 178, 57, 0.18);
                        flex - shrink: 0;
                            }
                    
                    .stat-icon.primary {
                    background: linear - gradient(135deg, var (--brand - green), var (--brand - green - dark)) ;
                    }
                    .stat-i c on.success {
                            b ackground: linear - gradient(135deg, #8bc34a, #7cb342);
                    }
                    .stat-icon.warning {
                    background: linear  -  gradient(135deg, #cddc39, #d4e157);
            }
                                    .stat-icon.info {
                    background: linear - gradi ent(135d e g, #4caf50, #66bb6a);
                                }
                                .stat-icon.danger {
                                    backg round: l i near  -  gradient(135deg, #f44336, #e53935);
                            }
                  
                    /* S t atus Badges */
                    .status-badge {
                    padding: 0 . 35rem 0.75rem;
                                        borde r  - radius: 20px;
                                    font - size: 0.8rem;
                            font - weight: 600;
                    t e xt - tra n sform: capitalize;
                   }
                    
                    .status-pending {
                                    background: #fff3cd;
                            color: #856404;
               }
                    
                    .status-processing {
                    b a ckground: # cce7ff;
                    color: #004085;
                  } 
                
                    .status-completed, .status-d e livered {
                      background:   #d4edda;
                    color: #155724;
                    }
                       
        .status-cancelled {
                    backgrou n d: #f8d7da;
                      color: #721c24;
                    }
                  
                / * Re spo nsive */
                            @media (max-width: 992px) {
                    body {
                    fl e x - direction: column;
                    }

                      .sidebar {
        width: 100 % ;
                    height: auto;
                      }

                    .nav - menu {
        display: flex;
                            overflow - x: auto;
                    padding: 10px 0;
                      }

                    .nav - item {
                    margin - bottom: 0;
                    margin - right: 10px;
                    flex - shrink: 0;
                    }
 
                     .nav - l ink  {
                            bord e r - left: none;
                            border - bottom: 3px solid transparent;
                    padding: 10px 15px;
                    white - space: nowrap;
                    }

                    .nav - link:hover, .nav - link.active {
                    border - left - color: transparent;
                    border - bottom - color: white;
                    }

                    .user - info, .sidebar - footer {
                    display: none;
                    }
                    }
                
                @media (max-width: 768px) {
                            .page - header { padding: 18px; border - radius: 12px; }
                    .page - header::before { width: 80px; height: 80px; }
                    .stats - cards { grid - template - columns: 1fr 1fr; }
                    }

        @media (max - width: 576px) {
                    .stats - cards { grid - template - columns: 1fr; }
                    .main - content { padding: 15px; }
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
                        <div class="col-md-4">
                            <input type="text" class="form-control" name="keyword" 
                                    placeholder="Tìm kiếm theo mã đơn hàng, tên khách hàng..." 
                                    value="${param.keyword}">
                                    </div>
                                    <div class="col-md-3">
                                    <select class="form-select" name="status">
                            <option value="">Tất cả trạng thái</option>
                                <option value="pending" ${param.status == 'pending' ? 'selected' : ''}>Chờ xử lý</option>
                                    <option value="processing" ${param.status == 'processing' ? 'selected' : ''}>Đang xử lý</option>
                                        <option value="delivered" ${param.status == 'delivered' ? 'selected' : ''}>Đã giao</option>
                                        <option value="cancelled" ${param.status == 'cancelled' ? 'selected' : ''}>Đã hủy</option>
                                            </select>
                                            </div>
                                        <div class="col-md-3">
                                        <input type="date" class="form-control" name="dateFrom" 
                                                value="${param.dateFrom}">
                                                </div>
                                            <div class="col-md-2">
                                        <button type="submit" class="btn btn-success w-100">
                                            <i class="fas fa-search"></i> Tìm kiếm
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Orders Table Card -->
        <div class="card">
            <div class="card-body">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="card-title mb-0">Danh sách đơn hàng</h5>
                    <div>
                        <button class="btn btn-outline-secondary me-2">
                            <i class="fas fa-download"></i> Xuất file
                        </button>
                        <button class="btn btn-success">
                            <i class="fas fa-plus"></i> Đơn hàng mới
                        </button>
                    </div>
                </div>
                
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Mã đơn hàng</th>
                                <th>Khách hàng</th>
                                <th>Ngày đặt</th>
                                <th>Tổng tiền</th>
                                <th>Trạng thái</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
            <c:forEach var="order" items="${orderList}">
                                <tr>
                                    <td><strong>#${order.orderId}</strong></td>
                                    <td>${order.customerName != null ? order.customerName : 'Khách hàng ' += order.userId}</td>
                                    <td>
                <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy" />
                                    </td>
                                    <td>
                                        <strong>
                <fmt:formatNumber value="${order.totalAmount}" type="number" /> VNĐ
                                        </strong>
                                    </td>
                                    <td>
                <c:choose>
                    <c:when test="${order.status == 'PENDING' || order.status == 'pending'}">
                                                <span class="status-badge status-pending">Chờ xử lý</span>
                    </c:when>
                    <c:when test="${order.status == 'PROCESSING' || order.status == 'processing'}">
                                                <span class="status-badge status-processing">Đang xử lý</span>
                    </c:when>
                    <c:when test="${order.status == 'DELIVERED' || order.status == 'delivered'}">
                                                <span class="status-badge status-delivered">Đã giao</span>
                    </c:when>
                    <c:when test="${order.status == 'CANCELLED' || order.status == 'cancelled'}">
                                                <span class="status-badge status-cancelled">Đã hủy</span>
                    </c:when>
                    <c:otherwise>
                                                <span class="status-badge">${order.status}</span>
                    </c:otherwise>
                </c:choose>
                                    </td>
                                    <td>
                                        <div class="btn-group">
                                            <a href="${pageContext.request.contextPath}/admin/orders?action=view&id=${order.orderId}" 
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
                            
            <c:if test="${empty orders}">
                                <tr>
                                    <td colspan="6" class="text-center text-muted py-4">
                                        <i class="fas fa-shopping-bag fa-2x mb-3"></i>
                                        <p>Không có đơn hàng nào được tìm thấy</p>
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
                                <a class="page-link" href="?page=${currentPage - 1}${param.keyword != null ? '&keyword=' += param.keyword : ''}${param.status != null ? '&status=' += param.status : ''}${param.dateFrom != null ? '&dateFrom=' += param.dateFrom : ''}">Trước</a>
                            </li>
                            
                <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" href="?page=${i}${param.keyword != null ? '&keyword=' += param.keyword : ''}${param.status != null ? '&status=' += param.status : ''}${param.dateFrom != null ? '&dateFrom=' += param.dateFrom : ''}">${i}</a>
                                </li>
                </c:forEach>
                            
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="?page=${currentPage + 1}${param.keyword != null ? '&keyword=' += param.keyword : ''}${param.status != null ? '&status=' += param.status : ''}${param.dateFrom != null ? '&dateFrom=' += param.dateFrom : ''}">Sau</a>
                            </li>
                        </ul>
                    </nav>
            </c:if>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html></script>
</body>
</html>