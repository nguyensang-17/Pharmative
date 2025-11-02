<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết Người dùng - Pharmative Admin</title>
    
    <!-- Bootstrap + FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --brand-green: #75b239;
            --brand-green-dark: #5fa127;
            --brand-green-light: #e8f4dc;
            --brand-green-soft: rgba(117,178,57,0.08);
            --muted: #6c6f76;
            --card-bg: #ffffff;
            --shadow: 0 6px 18px rgba(24,39,75,0.06);
            --shadow-green: 0 6px 18px rgba(117,178,57,0.12);
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f6f8f7;
            -webkit-font-smoothing: antialiased;
        }
        
        .user-detail-card {
            background: var(--card-bg);
            border-radius: 20px;
            padding: 2.5rem;
            box-shadow: var(--shadow);
            border: 1px solid rgba(117,178,57,0.1);
            margin-bottom: 2rem;
        }
        
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid var(--brand-green-light);
        }
        
        .page-title {
            color: #2b2e33;
            font-weight: 700;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .page-title i {
            color: var(--brand-green);
            font-size: 1.8rem;
        }
        
        .btn-back {
            background: transparent;
            color: var(--muted);
            border: 2px solid #e9ecef;
            border-radius: 12px;
            padding: 10px 20px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-back:hover {
            border-color: var(--brand-green);
            color: var(--brand-green);
            background: var(--brand-green-soft);
        }
        
        .user-profile-header {
            display: flex;
            align-items: center;
            gap: 2rem;
            margin-bottom: 2.5rem;
            padding-bottom: 2rem;
            border-bottom: 2px solid var(--brand-green-light);
        }
        
        .user-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: var(--brand-green-soft);
            display: flex;
            align-items: center;
            justify-content: center;
            border: 4px solid white;
            box-shadow: var(--shadow);
        }
        
        .user-avatar i {
            font-size: 3rem;
            color: var(--brand-green);
        }
        
        .user-info h2 {
            color: #2b2e33;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }
        
        .user-email {
            color: var(--muted);
            font-size: 1.1rem;
            margin-bottom: 1rem;
        }
        
        .user-badges {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }
        
        .badge {
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.85rem;
        }
        
        .badge-role {
            background: linear-gradient(135deg, var(--brand-green), var(--brand-green-dark));
            color: white;
        }
        
        .badge-status {
            background: rgba(117,178,57,0.1);
            color: var(--brand-green);
        }
        
        .badge-inactive {
            background: rgba(108,117,125,0.1);
            color: var(--muted);
        }
        
        .section-title {
            font-size: 1.3rem;
            font-weight: 600;
            color: #2b2e33;
            margin-bottom: 1.5rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid var(--brand-green-light);
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .section-title i {
            color: var(--brand-green);
            font-size: 1.2rem;
        }
        
        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .info-card {
            background: var(--card-bg);
            border-radius: 12px;
            padding: 1.5rem;
            border: 2px solid var(--brand-green-light);
            transition: all 0.3s ease;
        }
        
        .info-card:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-green);
        }
        
        .info-label {
            font-size: 0.9rem;
            color: var(--muted);
            font-weight: 600;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 6px;
        }
        
        .info-value {
            font-size: 1.1rem;
            color: #2b2e33;
            font-weight: 600;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .stat-card {
            background: var(--brand-green-soft);
            border-radius: 12px;
            padding: 1.5rem;
            text-align: center;
            border-left: 4px solid var(--brand-green);
        }
        
        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            color: var(--brand-green);
            margin-bottom: 0.5rem;
        }
        
        .stat-label {
            font-size: 0.9rem;
            color: var(--muted);
            font-weight: 600;
        }
        
        .action-buttons {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 2px solid var(--brand-green-light);
        }
        
        .btn-edit {
            background: linear-gradient(135deg, var(--brand-green), var(--brand-green-dark));
            color: white;
            border: none;
            border-radius: 12px;
            padding: 12px 24px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 4px 15px rgba(117,178,57,0.2);
        }
        
        .btn-edit:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(117,178,57,0.3);
            color: white;
        }
        
        .btn-toggle {
            background: transparent;
            color: var(--muted);
            border: 2px solid #e9ecef;
            border-radius: 12px;
            padding: 12px 24px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-toggle:hover {
            border-color: #ffc107;
            color: #856404;
            background: rgba(255,193,7,0.1);
        }
        
        .btn-delete {
            background: transparent;
            color: #dc3545;
            border: 2px solid #dc3545;
            border-radius: 12px;
            padding: 12px 24px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-delete:hover {
            background: #dc3545;
            color: white;
        }
        
        .alert-message {
            border-radius: 12px;
            border: none;
            padding: 1rem 1.5rem;
            margin-bottom: 2rem;
        }
        
        .timeline {
            position: relative;
            padding-left: 2rem;
        }
        
        .timeline-item {
            position: relative;
            margin-bottom: 1.5rem;
            padding-left: 2rem;
        }
        
        .timeline-item:before {
            content: '';
            position: absolute;
            left: -8px;
            top: 0;
            width: 16px;
            height: 16px;
            border-radius: 50%;
            background: var(--brand-green);
            border: 3px solid white;
            box-shadow: 0 0 0 2px var(--brand-green);
        }
        
        .timeline-item:after {
            content: '';
            position: absolute;
            left: 0;
            top: 16px;
            bottom: -16px;
            width: 2px;
            background: var(--brand-green-light);
        }
        
        .timeline-item:last-child:after {
            display: none;
        }
        
        .timeline-date {
            font-size: 0.85rem;
            color: var(--muted);
            margin-bottom: 0.25rem;
        }
        
        .timeline-content {
            font-weight: 500;
            color: #2b2e33;
        }
        
        @media (max-width: 768px) {
            .user-detail-card {
                padding: 1.5rem;
                border-radius: 16px;
            }
            
            .user-profile-header {
                flex-direction: column;
                text-align: center;
                gap: 1.5rem;
            }
            
            .user-badges {
                justify-content: center;
            }
            
            .page-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .btn-edit, .btn-toggle, .btn-delete {
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <!-- Main Content -->
        <main class="col-md-11 ms-sm-auto col-lg-11 px-md-4 py-4">
            <div class="user-detail-card">
                <!-- Page Header -->
                <div class="page-header">
                    <h1 class="page-title">
                        <i class="fas fa-user-circle"></i>
                        Chi tiết Người dùng
                    </h1>
                    <a href="${pageContext.request.contextPath}/admin/users" class="btn-back">
                        <i class="fas fa-arrow-left"></i>
                        Quay lại danh sách
                    </a>
                </div>
                
                <!-- Alert Messages -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-message">
                        <i class="fas fa-exclamation-circle me-2"></i>
                        ${error}
                    </div>
                </c:if>
                
                <c:if test="${not empty message}">
                    <div class="alert alert-success alert-message">
                        <i class="fas fa-check-circle me-2"></i>
                        ${message}
                    </div>
                </c:if>
                
                <c:if test="${not empty user}">
                    <!-- User Profile Header -->
                    <div class="user-profile-header">
                        <div class="user-avatar">
                            <i class="fas fa-user"></i>
                        </div>
                        <div class="user-info">
                            <h2>${user.fullname}</h2>
                            <div class="user-email">
                                <i class="fas fa-envelope me-2"></i>${user.email}
                            </div>
                            <div class="user-badges">
                                <span class="badge badge-role">
                                    <i class="fas fa-shield-alt me-1"></i>
                                    ${user.role == 'admin' ? 'Quản trị viên' : 'Khách hàng'}
                                </span>
                                <span class="badge ${user.verified ? 'badge-status' : 'badge-inactive'}">
                                    <i class="fas ${user.verified ? 'fa-check-circle' : 'fa-times-circle'} me-1"></i>
                                    ${user.verified ? 'Đã xác thực' : 'Chưa xác thực'}
                                </span>
                                <span class="badge badge-inactive">
                                    <i class="fas fa-id-card me-1"></i>
                                    ID: ${user.id}
                                </span>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Basic Information Section -->
                    <div class="section-title">
                        <i class="fas fa-info-circle"></i>
                        Thông tin cơ bản
                    </div>
                    
                    <div class="info-grid">
                        <div class="info-card">
                            <div class="info-label">
                                <i class="fas fa-user"></i>
                                Họ và tên
                            </div>
                            <div class="info-value">${user.fullname}</div>
                        </div>
                        
                        <div class="info-card">
                            <div class="info-label">
                                <i class="fas fa-envelope"></i>
                                Email
                            </div>
                            <div class="info-value">${user.email}</div>
                        </div>
                        
                        <div class="info-card">
                            <div class="info-label">
                                <i class="fas fa-phone"></i>
                                Số điện thoại
                            </div>
                            <div class="info-value">
                                <c:choose>
                                    <c:when test="${not empty user.phoneNumber}">
                                        ${user.phoneNumber}
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-muted">Chưa cập nhật</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        
                        <div class="info-card">
                            <div class="info-label">
                                <i class="fas fa-shield-alt"></i>
                                Vai trò
                            </div>
                            <div class="info-value">
                                <span class="badge badge-role">
                                    ${user.role == 'admin' ? 'Quản trị viên' : 'Khách hàng'}
                                </span>
                            </div>
                        </div>
                        
                        <div class="info-card">
                            <div class="info-label">
                                <i class="fas fa-check-circle"></i>
                                Trạng thái
                            </div>
                            <div class="info-value">
                                <span class="badge ${user.verified ? 'badge-status' : 'badge-inactive'}">
                                    ${user.verified ? 'Đã xác thực' : 'Chưa xác thực'}
                                </span>
                            </div>
                        </div>
                        
                        <div class="info-card">
                            <div class="info-label">
                                <i class="fas fa-calendar-plus"></i>
                                Ngày tạo
                            </div>
                            <div class="info-value">
                                <c:choose>
                                    <c:when test="${not empty user.createdAt}">
                                        <fmt:formatDate value="${user.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-muted">Không có dữ liệu</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                    
                    <!-- User Statistics Section -->
                    <c:if test="${not empty stats}">
                        <div class="section-title">
                            <i class="fas fa-chart-bar"></i>
                            Thống kê hoạt động
                        </div>
                        
                        <div class="stats-grid">
                            <div class="stat-card">
                                <div class="stat-number">${stats.totalOrders}</div>
                                <div class="stat-label">Tổng đơn hàng</div>
                            </div>
                            
                            <div class="stat-card">
                                <div class="stat-number">
                                    ₫<fmt:formatNumber value="${stats.totalSpent}" pattern="#,###"/>
                                </div>
                                <div class="stat-label">Tổng chi tiêu</div>
                            </div>
                            
                            <div class="stat-card">
                                <div class="stat-number">${stats.totalReviews}</div>
                                <div class="stat-label">Đánh giá</div>
                            </div>
                            
                            <div class="stat-card">
                                <div class="stat-number">
                                    <fmt:formatNumber value="${stats.averageRating}" pattern="#.##"/>
                                </div>
                                <div class="stat-label">Điểm đánh giá TB</div>
                            </div>
                        </div>
                    </c:if>
                    
                    <!-- Recent Activity Section -->
                    <div class="section-title">
                        <i class="fas fa-history"></i>
                        Hoạt động gần đây
                    </div>
                    
                    <div class="timeline">
                        <div class="timeline-item">
                            <div class="timeline-date">Hôm nay</div>
                            <div class="timeline-content">Đăng nhập vào hệ thống</div>
                        </div>
                        
                        <div class="timeline-item">
                            <div class="timeline-date">2 ngày trước</div>
                            <div class="timeline-content">Đặt hàng #ORD-2023-0015</div>
                        </div>
                        
                        <div class="timeline-item">
                            <div class="timeline-date">1 tuần trước</div>
                            <div class="timeline-content">Cập nhật thông tin cá nhân</div>
                        </div>
                        
                        <div class="timeline-item">
                            <div class="timeline-date">
                                <fmt:formatDate value="${user.createdAt}" pattern="dd/MM/yyyy"/>
                            </div>
                            <div class="timeline-content">Tạo tài khoản lần đầu</div>
                        </div>
                    </div>
                    
                    <!-- Action Buttons -->
                    <div class="action-buttons">
                        <a href="${pageContext.request.contextPath}/admin/users/edit?id=${user.id}" 
                           class="btn-edit">
                            <i class="fas fa-edit"></i>
                            Chỉnh sửa thông tin
                        </a>
                        
                        <a href="${pageContext.request.contextPath}/admin/users/toggle-status?id=${user.id}" 
                           class="btn-toggle"
                           onclick="return confirm('Bạn có chắc muốn ${user.verified ? 'vô hiệu hóa' : 'kích hoạt'} tài khoản này?')">
                            <i class="fas ${user.verified ? 'fa-lock' : 'fa-unlock'}"></i>
                            ${user.verified ? 'Vô hiệu hóa' : 'Kích hoạt'} tài khoản
                        </a>
                        
                        <a href="${pageContext.request.contextPath}/admin/users/delete?id=${user.id}" 
                           class="btn-delete"
                           onclick="return confirm('⚠️ CẢNH BÁO: Bạn sắp xóa người dùng này. Thao tác này KHÔNG THỂ hoàn tác!\\n\\nBạn có chắc chắn?')">
                            <i class="fas fa-trash"></i>
                            Xóa người dùng
                        </a>
                    </div>
                </c:if>
                
                <c:if test="${empty user}">
                    <div class="alert alert-warning text-center">
                        <i class="fas fa-exclamation-triangle fa-2x mb-3"></i>
                        <h4>Không tìm thấy người dùng</h4>
                        <p>Người dùng bạn đang tìm kiếm không tồn tại hoặc đã bị xóa.</p>
                        <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-primary mt-2">
                            <i class="fas fa-arrow-left me-2"></i>Quay lại danh sách
                        </a>
                    </div>
                </c:if>
            </div>
        </main>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Confirmation for dangerous actions
        document.addEventListener('DOMContentLoaded', function() {
            const deleteButtons = document.querySelectorAll('.btn-delete');
            deleteButtons.forEach(button => {
                button.addEventListener('click', function(e) {
                    if (!confirm('⚠️ CẢNH BÁO: Bạn sắp xóa người dùng này. Thao tác này KHÔNG THỂ hoàn tác!\n\nBạn có chắc chắn?')) {
                        e.preventDefault();
                    }
                });
            });
            
            const toggleButtons = document.querySelectorAll('.btn-toggle');
            toggleButtons.forEach(button => {
                button.addEventListener('click', function(e) {
                    const action = this.textContent.trim();
                    if (!confirm(`Bạn có chắc muốn ${action} tài khoản này?`)) {
                        e.preventDefault();
                    }
                });
            });
        });
    </script>
</body>
</html>