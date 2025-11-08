<%-- 
    Document   : cat-list
    Created on : Oct 23, 2025, 7:39:27 PM
    Author     : ADMINN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Danh mục - Admin</title>
    
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
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(24,39,75,0.12);
        }
        
        .btn-success {
            background: var(--brand-green);
            border: none;
            transition: all 0.2s ease;
        }
        
        .btn-success:hover {
            background: var(--brand-green-dark);
            transform: translateY(-1px);
        }
        
        .table th {
            border-top: none;
            font-weight: 600;
            color: #6c757d;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .table tbody tr {
            transition: all 0.2s ease;
        }

        .table tbody tr:hover {
            background-color: var(--brand-green-soft);
            transform: translateX(4px);
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

        /* Badge styles */
        .badge-parent {
            background: linear-gradient(135deg, #667eea, #764ba2);
        }

        .badge-child {
            background: linear-gradient(135deg, #f093fb, #f5576c);
        }

        /* Action buttons */
        .btn-action {
            transition: all 0.2s ease;
            border-radius: 8px;
        }

        .btn-action:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
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
                <a href="${pageContext.request.contextPath}/admin/categories" class="nav-link active">
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
                <h2><i class="fas fa-tags" style="margin-right:10px"></i> Quản lý Danh mục</h2>
                <p class="mb-0" style="opacity:0.9">Quản lý danh mục sản phẩm hệ thống</p>
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
                    <div class="stat-title">Tổng Danh mục</div>
                    <div class="stat-value">
                        <fmt:formatNumber value="${totalCategories}" pattern="#,###"/>
                    </div>
                </div>
                <div class="stat-icon primary">
                    <i class="fas fa-tags"></i>
                </div>
            </div>

            <div class="stat-card">
                <div>
                    <div class="stat-title">Danh mục cha</div>
                    <div class="stat-value">
                        <fmt:formatNumber value="${totalParentCategories}" pattern="#,###"/>
                    </div>
                </div>
                <div class="stat-icon success">
                    <i class="fas fa-folder"></i>
                </div>
            </div>

            <div class="stat-card">
                <div>
                    <div class="stat-title">Danh mục con</div>
                    <div class="stat-value">
                        <fmt:formatNumber value="${totalChildCategories}" pattern="#,###"/>
                    </div>
                </div>
                <div class="stat-icon warning">
                    <i class="fas fa-folder-open"></i>
                </div>
            </div>

            <div class="stat-card">
                <div>
                    <div class="stat-title">Danh mục mới (tháng)</div>
                    <div class="stat-value">
                        <fmt:formatNumber value="${newCategoriesThisMonth}" pattern="#,###"/>
                    </div>
                </div>
                <div class="stat-icon info">
                    <i class="fas fa-plus-circle"></i>
                </div>
            </div>
        </div>

        <!-- Action Buttons Card -->
        <div class="card">
            <div class="card-body">
                <div class="d-flex justify-content-between align-items-center">
                    <h5 class="card-title mb-0">Danh sách Danh mục</h5>
                    <a href="${pageContext.request.contextPath}/admin/categories?action=add" 
                       class="btn btn-success btn-action">
                        <i class="fas fa-plus-circle"></i> Thêm Danh mục
                    </a>
                </div>
            </div>
        </div>

        <!-- Categories Table Card -->
        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Tên danh mục</th>
                                <th>Danh mục cha</th>
                                <th>Số sản phẩm</th>
                                <th>Loại</th>
                                
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="category" items="${categories}">
                                <tr>
                                    <td>${category.categoryId}</td>
                                    <td>
                                        <strong>${category.categoryName}</strong>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${category.parentCategoryId == null}">
                                                <span class="text-muted">Không có</span>
                                            </c:when>
                                            <c:otherwise>
                                                ${category.parentCategoryName}
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <span class="badge bg-light text-dark">
                                            ${category.productCount} sản phẩm
                                        </span>
                                    </td>
                                    <td>
                                        <span class="badge ${category.parentCategoryId == null ? 'badge-parent' : 'badge-child'}">
                                            ${category.parentCategoryId == null ? 'Danh mục cha' : 'Danh mục con'}
                                        </span>
                                    </td>
                                    
                                    <td>
                                        <div class="btn-group">
                                            <a href="${pageContext.request.contextPath}/admin/categories?action=edit&id=${category.categoryId}" 
                                               class="btn btn-sm btn-outline-warning btn-action" title="Chỉnh sửa">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <button type="button" class="btn btn-sm btn-outline-danger btn-action" 
                                                    data-bs-toggle="modal" 
                                                    data-bs-target="#deleteModal${category.categoryId}"
                                                    title="Xóa">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>

                                        <!-- Delete Confirmation Modal -->
                                        <div class="modal fade" id="deleteModal${category.categoryId}" tabindex="-1">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title">Xác nhận xóa</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        Bạn có chắc chắn muốn xóa danh mục <strong>${category.categoryName}</strong>?
                                                        <c:if test="${category.productCount > 0}">
                                                            <br><small class="text-danger">
                                                                Cảnh báo: Danh mục này có ${category.productCount} sản phẩm. 
                                                                Xóa danh mục có thể ảnh hưởng đến các sản phẩm liên quan!
                                                            </small>
                                                        </c:if>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                                        <a href="${pageContext.request.contextPath}/admin/categories?action=delete&id=${category.categoryId}" 
                                                           class="btn btn-danger">Xóa</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            
                            <c:if test="${empty categories}">
                                <tr>
                                    <td colspan="7" class="text-center text-muted py-4">
                                        <i class="fas fa-tags fa-2x mb-3"></i>
                                        <p>Không có danh mục nào được tìm thấy</p>
                                        <a href="${pageContext.request.contextPath}/admin/categories?action=add" 
                                           class="btn btn-success mt-2">
                                            <i class="fas fa-plus-circle"></i> Thêm danh mục đầu tiên
                                        </a>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Animation for page load
        document.addEventListener('DOMContentLoaded', function() {
            const cards = document.querySelectorAll('.stat-card, .card');
            cards.forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                
                setTimeout(() => {
                    card.style.transition = 'all 0.5s ease';
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, index * 100);
            });
        });

        // Smooth scrolling for alerts
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(alert => {
            alert.style.transition = 'all 0.3s ease';
        });
    </script>
</body>
</html>