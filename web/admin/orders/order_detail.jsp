<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết đơn hàng - Admin</title>

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

        /* Animation Keyframes */
        .main-content { animation: fadeIn 0.6s ease-out; }
        .page-header { animation: slideInDown 0.5s ease-out 0.2s both; }
        .card { animation: fadeInUp 0.5s ease-out both; }

        @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
        @keyframes fadeInUp { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
        @keyframes slideInDown { from { opacity: 0; transform: translateY(-30px); } to { opacity: 1; transform: translateY(0); } }

        /* Hover Effects */
        .card, .btn { transition: all 0.3s ease; }
        .card:hover { transform: translateY(-3px); box-shadow: 0 8px 20px rgba(24,39,75,0.12); }
        .btn:hover { transform: translateY(-2px); }
        .btn-success:hover { box-shadow: 0 4px 12px rgba(117,178,57,0.3); }

        /* Sidebar Styles (giống manage_orders.jsp) */
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

        /* Status Badges */
        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
            text-transform: capitalize;
            display: inline-block;
            min-width: 120px;
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
            padding: 0.4rem 0.8rem;
            border-radius: 12px;
            font-size: 0.85rem;
            font-weight: 500;
            background: #e9ecef;
            color: #495057;
            display: inline-block;
        }

        .payment-cod { background: #fff3cd; color: #856404; }
        .payment-vnpay { background: #cce7ff; color: #004085; }
        .payment-momo { background: #f8d7da; color: #721c24; }
        .payment-bank { background: #d4edda; color: #155724; }

        /* Order Info Styles */
        .order-info-section {
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
        }

        .info-label {
            font-weight: 600;
            color: #6c757d;
            font-size: 0.9rem;
            margin-bottom: 5px;
        }

        .info-value {
            font-weight: 500;
            color: #2c3e50;
            font-size: 1rem;
        }

        .product-image {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 8px;
            border: 2px solid #e9ecef;
        }

        .total-amount {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--brand-green);
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        /* Responsive */
        @media (max-width: 992px) {
            body { flex-direction: column; }
            .sidebar { width: 100%; height: auto; }
            .nav-menu { display: flex; overflow-x: auto; padding: 10px 0; }
            .nav-item { margin-bottom: 0; margin-right: 10px; flex-shrink: 0; }
            .nav-link { border-left: none; border-bottom: 3px solid transparent; padding: 10px 15px; white-space: nowrap; }
            .nav-link:hover, .nav-link.active { border-left-color: transparent; border-bottom-color: white; transform: translateY(-2px); }
            .user-info, .sidebar-footer { display: none; }
        }

        @media (max-width: 768px) {
            .page-header { padding: 18px; border-radius: 12px; }
            .page-header::before { width: 80px; height: 80px; }
            .action-buttons { flex-direction: column; }
        }

        @media (max-width: 576px) {
            .main-content { padding: 15px; }
        }
    </style>
</head>
<body>
    <!-- Sidebar Navigation (giống manage_orders.jsp) -->
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
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h2><i class="fas fa-file-invoice" style="margin-right:10px"></i> Chi tiết đơn hàng</h2>
                    <p class="mb-0" style="opacity:0.9">Thông tin chi tiết đơn hàng #${order.orderId}</p>
                </div>
                <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-light">
                    <i class="fas fa-arrow-left"></i> Quay lại danh sách
                </a>
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

        <c:if test="${empty order}">
            <div class="alert alert-warning">
                <i class="fas fa-exclamation-triangle"></i> Không tìm thấy thông tin đơn hàng.
            </div>
        </c:if>

        <c:if test="${not empty order}">
            <!-- Order Summary Card -->
            <div class="card">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <h5 class="card-title mb-4">
                                <i class="fas fa-info-circle text-primary me-2"></i>
                                Thông tin đơn hàng
                            </h5>
                            <div class="row mb-3">
                                <div class="col-sm-4 info-label">Mã đơn hàng:</div>
                                <div class="col-sm-8 info-value">
                                    <strong>#${order.orderId}</strong>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-sm-4 info-label">Ngày đặt:</div>
                                <div class="col-sm-8 info-value">
                                    <fmt:formatDate value="${order.orderDate}" pattern="HH:mm dd/MM/yyyy" />
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-sm-4 info-label">Trạng thái:</div>
                                <div class="col-sm-8">
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
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-sm-4 info-label">PT thanh toán:</div>
                                <div class="col-sm-8">
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
                                            <span class="payment-badge payment-bank">Bank Transfer</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="payment-badge">${order.paymentMethod}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <h5 class="card-title mb-4">
                                <i class="fas fa-user text-success me-2"></i>
                                Thông tin khách hàng
                            </h5>
                            <div class="row mb-3">
                                <div class="col-sm-4 info-label">Họ tên:</div>
                                <div class="col-sm-8 info-value">${order.customerName}</div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-sm-4 info-label">Email:</div>
                                <div class="col-sm-8 info-value">${order.customerEmail}</div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-sm-4 info-label">SĐT:</div>
                                <div class="col-sm-8 info-value">${order.customerPhone}</div>
                            </div>
                            <div class="row">
                                <div class="col-sm-4 info-label">Địa chỉ:</div>
                                <div class="col-sm-8 info-value">${order.shippingAddress}</div>
                            </div>
                        </div>
                    </div>

                    <c:if test="${not empty order.note}">
                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="info-label">Ghi chú:</div>
                                <div class="info-value p-3 bg-light rounded">${order.note}</div>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- Order Items Card -->
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title mb-4">
                        <i class="fas fa-shopping-cart text-warning me-2"></i>
                        Chi tiết sản phẩm
                    </h5>
                    
                    <c:if test="${not empty orderDetails}">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th width="60px">Hình ảnh</th>
                                        <th>Sản phẩm</th>
                                        <th class="text-center">Đơn giá</th>
                                        <th class="text-center">Số lượng</th>
                                        <th class="text-end">Thành tiền</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="detail" items="${orderDetails}">
                                        <tr>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty detail.product.imageUrl}">
                                                        <img src="${pageContext.request.contextPath}/${detail.product.imageUrl}" 
                                                             alt="${detail.product.productName}" 
                                                             class="product-image">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="product-image bg-light d-flex align-items-center justify-content-center">
                                                            <i class="fas fa-image text-muted"></i>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="fw-semibold">${detail.product.productName}</div>
                                                <small class="text-muted">Mã SP: ${detail.productId}</small>
                                            </td>
                                            <td class="text-center">
                                                <fmt:formatNumber value="${detail.pricePerUnit}" type="number" /> ₫
                                            </td>
                                            <td class="text-center">${detail.quantity}</td>
                                            <td class="text-end fw-semibold">
                                                <fmt:formatNumber value="${detail.pricePerUnit * detail.quantity}" type="number" /> ₫
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="4" class="text-end fw-bold">Tổng cộng:</td>
                                        <td class="text-end total-amount">
                                            <fmt:formatNumber value="${order.totalAmount}" type="number" /> ₫
                                        </td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </c:if>

                    <c:if test="${empty orderDetails}">
                        <div class="text-center text-muted py-4">
                            <i class="fas fa-shopping-bag fa-2x mb-3"></i>
                            <p>Không có sản phẩm nào trong đơn hàng</p>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- Action Buttons Card -->
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title mb-4">
                        <i class="fas fa-cogs text-info me-2"></i>
                        Thao tác
                    </h5>
                    
                    <div class="action-buttons">
                        <!-- Update Status Form -->
                        <form action="${pageContext.request.contextPath}/admin/orders" method="post" class="d-inline">
                            <input type="hidden" name="orderId" value="${order.orderId}">
                            <div class="input-group" style="width: 300px;">
                                <select class="form-select" name="status" id="statusSelect">
                                    <option value="pending" ${order.status == 'pending' ? 'selected' : ''}>Chờ xử lý</option>
                                    <option value="processing" ${order.status == 'processing' ? 'selected' : ''}>Đang xử lý</option>
                                    <option value="shipped" ${order.status == 'shipped' ? 'selected' : ''}>Đang giao</option>
                                    <option value="delivered" ${order.status == 'delivered' ? 'selected' : ''}>Đã giao</option>
                                    <option value="cancelled" ${order.status == 'cancelled' ? 'selected' : ''}>Đã hủy</option>
                                </select>
                                <button type="submit" class="btn btn-success">
                                    <i class="fas fa-sync-alt"></i> Cập nhật
                                </button>
                            </div>
                        </form>

                        <!-- Other Action Buttons -->
                        <a href="${pageContext.request.contextPath}/admin/orders?action=edit&id=${order.orderId}" 
                           class="btn btn-warning">
                            <i class="fas fa-edit"></i> Chỉnh sửa
                        </a>
                        
                        <a href="${pageContext.request.contextPath}/admin/orders" 
                           class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> Quay lại
                        </a>
                        
                        <button type="button" class="btn btn-outline-info">
                            <i class="fas fa-print"></i> In hóa đơn
                        </button>
                    </div>
                </div>
            </div>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Auto-submit form khi thay đổi trạng thái (tùy chọn)
            const statusSelect = document.getElementById('statusSelect');
            if (statusSelect) {
                statusSelect.addEventListener('change', function() {
                    // Tự động submit form khi chọn trạng thái mới
                    // this.form.submit();
                });
            }

            // Hiển thị loading khi submit form
            const forms = document.querySelectorAll('form');
            forms.forEach(form => {
                form.addEventListener('submit', function(e) {
                    const submitBtn = this.querySelector('button[type="submit"]');
                    if (submitBtn) {
                        const originalHTML = submitBtn.innerHTML;
                        submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang xử lý...';
                        submitBtn.disabled = true;
                        
                        setTimeout(() => {
                            submitBtn.innerHTML = originalHTML;
                            submitBtn.disabled = false;
                        }, 5000);
                    }
                });
            });
        });
    </script>
</body>
</html>