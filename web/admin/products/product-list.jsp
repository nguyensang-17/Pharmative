<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Sản phẩm - Admin</title>
    
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
            transition: all 0.3s ease;
        }

        .card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(24,39,75,0.12);
        }
        
        .btn-success {
            background: var(--brand-green);
            border: none;
            transition: all 0.3s ease;
        }
        
        .btn-success:hover {
            background: var(--brand-green-dark);
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(117,178,57,0.3);
        }
        
        .status-instock {
            color: #28a745;
            font-weight: 600;
        }
        
        .status-outstock {
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

        .img-thumbnail {
            max-width: 60px;
            height: auto;
            border-radius: 8px;
            border: 1px solid #dee2e6;
            transition: all 0.3s ease;
        }

        .img-thumbnail:hover {
            transform: scale(1.05);
        }

        .action-buttons {
            display: flex;
            gap: 8px;
        }

        /* Search and Filter Styles */
        .search-card {
            background: linear-gradient(135deg, #ffffff, #f8f9fa);
        }

        .search-input {
            border-radius: 10px;
            border: 1px solid #dee2e6;
            padding: 12px 16px;
            transition: all 0.3s ease;
        }

        .search-input:focus {
            border-color: var(--brand-green);
            box-shadow: 0 0 0 0.2rem rgba(117, 178, 57, 0.25);
            transform: translateY(-1px);
        }

        .filter-select {
            border-radius: 10px;
            border: 1px solid #dee2e6;
            padding: 12px;
            transition: all 0.3s ease;
        }

        .filter-select:focus {
            border-color: var(--brand-green);
            box-shadow: 0 0 0 0.2rem rgba(117, 178, 57, 0.25);
        }

        /* Pagination Styles */
        .pagination {
            margin-bottom: 0;
        }

        .page-link {
            border: none;
            border-radius: 8px;
            margin: 0 4px;
            color: var(--brand-green);
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .page-link:hover {
            background-color: var(--brand-green-light);
            color: var(--brand-green-dark);
            transform: translateY(-1px);
        }

        .page-item.active .page-link {
            background: linear-gradient(135deg, var(--brand-green), var(--brand-green-dark));
            border: none;
        }

        .page-item.disabled .page-link {
            color: #6c757d;
            background-color: transparent;
        }

        /* Animation for table rows */
        .table tbody tr {
            transition: all 0.3s ease;
        }

        .table tbody tr:hover {
            background-color: var(--brand-green-soft);
            transform: translateX(4px);
        }

        /* Stats and Info */
        .page-info {
            background: var(--brand-green-soft);
            border-radius: 10px;
            padding: 12px 16px;
            border-left: 4px solid var(--brand-green);
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
            .action-buttons { flex-direction: column; }
            .search-card .row > div { margin-bottom: 12px; }
        }

        @media (max-width: 576px) {
            .main-content { padding: 15px; }
            .table-responsive { font-size: 0.9rem; }
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
                <a href="${pageContext.request.contextPath}/admin/products" class="nav-link active">
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
                <h2><i class="fas fa-box-open" style="margin-right:10px"></i> Quản lý Sản phẩm</h2>
                <p class="mb-0" style="opacity:0.9">Quản lý thông tin sản phẩm trong hệ thống</p>
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

        <!-- Search and Filter Card -->
        <div class="card search-card">
            <div class="card-body">
                <h5 class="card-title mb-4">
                    <i class="fas fa-search text-muted me-2"></i>Tìm kiếm & Lọc sản phẩm
                </h5>
                <form action="${pageContext.request.contextPath}/admin/products" method="get" id="searchForm">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <input type="text" class="form-control search-input" name="keyword" 
                                   placeholder="🔍 Tìm theo tên sản phẩm, mô tả..." 
                                   value="${param.keyword}">
                        </div>
                        <div class="col-md-3">
                            <select class="form-select filter-select" name="status">
                                <option value="">📊 Tất cả trạng thái</option>
                                <option value="instock" ${param.status == 'instock' ? 'selected' : ''}>🟢 Còn hàng</option>
                                <option value="outstock" ${param.status == 'outstock' ? 'selected' : ''}>🔴 Hết hàng</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <div class="d-grid gap-2 d-md-flex">
                                <button type="submit" class="btn btn-success flex-fill">
                                    <i class="fas fa-search me-2"></i>Tìm kiếm
                                </button>
                                <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-outline-secondary">
                                    <i class="fas fa-refresh"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Action Card -->
        <div class="card">
            <div class="card-body">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h5 class="card-title mb-0">Danh sách sản phẩm</h5>
                        <c:if test="${not empty products}">
                            <div class="page-info mt-2">
                                <small class="text-muted">
                                    <i class="fas fa-info-circle me-1"></i>
                                    Hiển thị <strong>${products.size()}</strong> sản phẩm 
                                    <c:if test="${not empty param.keyword}">
                                        cho từ khóa "<strong>${param.keyword}</strong>"
                                    </c:if>
                                </small>
                            </div>
                        </c:if>
                    </div>
                    <a href="${pageContext.request.contextPath}/admin/products?action=new" class="btn btn-success">
                        <i class="fas fa-plus me-2"></i>Thêm sản phẩm mới
                    </a>
                </div>
            </div>
        </div>

        <!-- Products Table Card -->
        <div class="card">
            <div class="card-body">
                <c:choose>
                    <c:when test="${not empty products}">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Hình ảnh</th>
                                        <th>Tên sản phẩm</th>
                                        <th>Giá</th>
                                        <th>Tồn kho</th>
                                        <th>Trạng thái</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="product" items="${products}">
                                        <tr>
                                            <td>${product.productId}</td>
                                            <td>
                                                <c:if test="${not empty product.imageUrl}">
                                                    <img src="${pageContext.request.contextPath}/${product.imageUrl}" 
                                                         alt="${product.productName}" class="img-thumbnail">
                                                </c:if>
                                                <c:if test="${empty product.imageUrl}">
                                                    <div class="img-thumbnail bg-light d-flex align-items-center justify-content-center">
                                                        <i class="fas fa-image text-muted"></i>
                                                    </div>
                                                </c:if>
                                            </td>
                                            <td>
                                                <strong>${product.productName}</strong>
                                                <c:if test="${not empty product.description}">
                                                    <br><small class="text-muted">${product.description}</small>
                                                </c:if>
                                            </td>
                                            <td>
                                                <strong>
                                                    <fmt:formatNumber value="${product.price}" type="number" 
                                                                    maxFractionDigits="0"/> ₫
                                                </strong>
                                            </td>
                                            <td>${product.stockQuantity}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${product.stockQuantity > 0}">
                                                        <span class="status-instock">
                                                            <i class="fas fa-circle" style="font-size: 8px;"></i>
                                                            Còn hàng
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-outstock">
                                                            <i class="fas fa-circle" style="font-size: 8px;"></i>
                                                            Hết hàng
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="action-buttons">
                                                    <a href="${pageContext.request.contextPath}/admin/products?action=edit&id=${product.productId}" 
                                                       class="btn btn-sm btn-outline-primary">
                                                        <i class="fas fa-edit"></i> Sửa
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/admin/products?action=delete&id=${product.productId}" 
                                                       class="btn btn-sm btn-outline-danger" 
                                                       onclick="return confirm('Bạn có chắc muốn xóa sản phẩm ${product.productName}?')">
                                                        <i class="fas fa-trash"></i> Xóa
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <!-- Pagination -->
                        <c:if test="${totalPages > 1}">
                            <nav aria-label="Page navigation" class="mt-4">
                                <ul class="pagination justify-content-center">
                                    <!-- Previous Page -->
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="${pageContext.request.contextPath}/admin/products?page=${currentPage - 1}${not empty param.keyword ? '&keyword=' += param.keyword : ''}${not empty param.status ? '&status=' += param.status : ''}">
                                            <i class="fas fa-chevron-left"></i>
                                        </a>
                                    </li>
                                    
                                    <!-- Page Numbers -->
                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                                            <a class="page-link" href="${pageContext.request.contextPath}/admin/products?page=${i}${not empty param.keyword ? '&keyword=' += param.keyword : ''}${not empty param.status ? '&status=' += param.status : ''}">
                                                ${i}
                                            </a>
                                        </li>
                                    </c:forEach>
                                    
                                    <!-- Next Page -->
                                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                        <a class="page-link" href="${pageContext.request.contextPath}/admin/products?page=${currentPage + 1}${not empty param.keyword ? '&keyword=' += param.keyword : ''}${not empty param.status ? '&status=' += param.status : ''}">
                                            <i class="fas fa-chevron-right"></i>
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                            
                            <!-- Page Info -->
                            <div class="text-center text-muted mt-3">
                                Trang <strong>${currentPage}</strong> / <strong>${totalPages}</strong>
                                - Tổng cộng <strong>${totalItems}</strong> sản phẩm
                            </div>
                        </c:if>

                        <c:if test="${totalPages <= 1}">
                            <div class="mt-3 text-muted text-center">
                                Tổng cộng: <strong>${products.size()}</strong> sản phẩm
                            </div>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center text-muted py-5">
                            <i class="fas fa-box-open fa-3x mb-3" style="color: #dee2e6;"></i>
                            <h4>Không tìm thấy sản phẩm nào</h4>
                            <p class="mb-4">Hãy thử điều chỉnh tiêu chí tìm kiếm hoặc thêm sản phẩm mới!</p>
                            <div class="d-flex justify-content-center gap-2">
                                <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-outline-secondary">
                                    <i class="fas fa-refresh me-2"></i>Hiển thị tất cả
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/products?action=new" class="btn btn-success">
                                    <i class="fas fa-plus me-2"></i>Thêm sản phẩm đầu tiên
                                </a>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Add smooth animations
        document.addEventListener('DOMContentLoaded', function() {
            // Add loading animation to table rows
            const tableRows = document.querySelectorAll('.table tbody tr');
            tableRows.forEach((row, index) => {
                row.style.opacity = '0';
                row.style.transform = 'translateX(-20px)';
                
                setTimeout(() => {
                    row.style.transition = 'all 0.5s ease';
                    row.style.opacity = '1';
                    row.style.transform = 'translateX(0)';
                }, index * 100);
            });

            // Add hover effects to cards
            const cards = document.querySelectorAll('.card');
            cards.forEach(card => {
                card.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-5px)';
                });
                card.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(0)';
                });
            });

            // Auto-focus search input
            const searchInput = document.querySelector('input[name="keyword"]');
            if (searchInput && !searchInput.value) {
                setTimeout(() => {
                    searchInput.focus();
                }, 500);
            }
        });

        // Handle form submission with loading state
        document.getElementById('searchForm')?.addEventListener('submit', function(e) {
            const submitBtn = this.querySelector('button[type="submit"]');
            if (submitBtn) {
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang tìm...';
                submitBtn.disabled = true;
            }
        });
    </script>
</body>
</html>