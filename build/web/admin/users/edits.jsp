<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa Người dùng - Pharmative Admin</title>
    
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
        
        .edit-user-card {
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
        
        .form-section {
            margin-bottom: 2.5rem;
        }
        
        .section-title {
            font-size: 1.2rem;
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
        
        .form-label {
            font-weight: 600;
            color: #2b2e33;
            margin-bottom: 8px;
        }
        
        .form-control {
            border: 2px solid #e9ecef;
            border-radius: 12px;
            padding: 12px 16px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: var(--brand-green);
            box-shadow: 0 0 0 3px rgba(117,178,57,0.1);
        }
        
        .form-select {
            border: 2px solid #e9ecef;
            border-radius: 12px;
            padding: 12px 16px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }
        
        .form-select:focus {
            border-color: var(--brand-green);
            box-shadow: 0 0 0 3px rgba(117,178,57,0.1);
        }
        
        .form-check-input:checked {
            background-color: var(--brand-green);
            border-color: var(--brand-green);
        }
        
        .btn-save {
            background: linear-gradient(135deg, var(--brand-green), var(--brand-green-dark));
            color: white;
            border: none;
            border-radius: 12px;
            padding: 14px 30px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(117,178,57,0.2);
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-save:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(117,178,57,0.3);
        }
        
        .btn-cancel {
            background: transparent;
            color: var(--muted);
            border: 2px solid #e9ecef;
            border-radius: 12px;
            padding: 14px 30px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-cancel:hover {
            border-color: var(--muted);
            color: #2b2e33;
        }
        
        .user-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: var(--brand-green-soft);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            border: 4px solid white;
            box-shadow: var(--shadow);
        }
        
        .user-avatar i {
            font-size: 3rem;
            color: var(--brand-green);
        }
        
        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }
        
        .status-active {
            background: rgba(117,178,57,0.1);
            color: var(--brand-green);
        }
        
        .status-inactive {
            background: rgba(108,117,125,0.1);
            color: var(--muted);
        }
        
        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .info-card {
            background: var(--brand-green-soft);
            border-radius: 12px;
            padding: 1.5rem;
            border-left: 4px solid var(--brand-green);
        }
        
        .info-label {
            font-size: 0.9rem;
            color: var(--muted);
            font-weight: 600;
            margin-bottom: 4px;
        }
        
        .info-value {
            font-size: 1.1rem;
            color: #2b2e33;
            font-weight: 600;
        }
        
        .alert-message {
            border-radius: 12px;
            border: none;
            padding: 1rem 1.5rem;
            margin-bottom: 2rem;
        }
        
        @media (max-width: 768px) {
            .edit-user-card {
                padding: 1.5rem;
                border-radius: 16px;
            }
            
            .page-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }
            
            .btn-group {
                width: 100%;
            }
            
            .btn-save, .btn-cancel {
                flex: 1;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <!-- Main Content -->
        <main class="col-md-11 ms-sm-auto col-lg-11 px-md-4 py-4">
            <div class="edit-user-card">
                <!-- Page Header -->
                <div class="page-header">
                    <h1 class="page-title">
                        <i class="fas fa-user-edit"></i>
                        Chỉnh sửa Người dùng
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
                
                <!-- User Info -->
                <div class="form-section">
                    <h3 class="section-title">
                        <i class="fas fa-id-card"></i>
                        Thông tin cơ bản
                    </h3>
                    
                    <div class="row align-items-center">
                        <div class="col-md-3 text-center">
                            <div class="user-avatar">
                                <i class="fas fa-user"></i>
                            </div>
                            <div class="text-center">
                                <span class="status-badge ${user.verified ? 'status-active' : 'status-inactive'}">
                                    <i class="fas ${user.verified ? 'fa-check-circle' : 'fa-times-circle'} me-1"></i>
                                    ${user.verified ? 'Đã xác thực' : 'Chưa xác thực'}
                                </span>
                            </div>
                        </div>
                        
                        <div class="col-md-9">
                            <form action="${pageContext.request.contextPath}/admin/users" method="post">
    <input type="hidden" name="action" value="update">
    <input type="hidden" name="userId" value="${user.id}">
    
    <div class="row">
        <div class="col-md-6 mb-3">
            <label class="form-label">Họ và tên</label>
            <input type="text" class="form-control" name="fullname" 
                   value="${user.fullname}" required>
        </div>
        
        <div class="col-md-6 mb-3">
            <label class="form-label">Email</label>
            <input type="email" class="form-control" name="email" 
                   value="${user.email}" required>
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-6 mb-3">
            <label class="form-label">Số điện thoại</label>
            <input type="text" class="form-control" name="phoneNumber" 
                   value="${user.phoneNumber != null ? user.phoneNumber : ''}">
        </div>
        
        <div class="col-md-6 mb-3">
            <label class="form-label">Vai trò</label>
            <select class="form-select" name="role" required>
                <option value="customer" ${user.role == 'customer' ? 'selected' : ''}>Khách hàng</option>
                <option value="admin" ${user.role == 'admin' ? 'selected' : ''}>Quản trị viên</option>
            </select>
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-12 mb-3">
            <div class="form-check form-switch">
                <input class="form-check-input" type="checkbox" name="isVerified" 
                       ${user.verified ? 'checked' : ''} id="flexSwitchCheckVerified" value="true">
                <label class="form-check-label" for="flexSwitchCheckVerified">
                    Tài khoản đã xác thực
                </label>
            </div>
            <!-- Hidden input để gửi false khi unchecked -->
            <input type="hidden" name="isVerified" value="false">
        </div>
    </div>
    
    <!-- Action Buttons -->
    <div class="row mt-4">
        <div class="col-md-12">
            <div class="d-flex gap-3 flex-wrap">
                <button type="submit" class="btn btn-save">
                    <i class="fas fa-save"></i>
                    Lưu thay đổi
                </button>
                <a href="${pageContext.request.contextPath}/admin/users?action=view&id=${user.id}" 
                   class="btn btn-cancel">
                    <i class="fas fa-times"></i>
                    Hủy bỏ
                </a>
            </div>
        </div>
    </div>
</form>
                        </div>
                    </div>
                </div>
                
                <!-- User Statistics -->
                <c:if test="${not empty stats}">
                    <div class="form-section">
                        <h3 class="section-title">
                            <i class="fas fa-chart-bar"></i>
                            Thống kê người dùng
                        </h3>
                        
                        <div class="info-grid">
                            <div class="info-card">
                                <div class="info-label">Tổng đơn hàng</div>
                                <div class="info-value">${stats.totalOrders}</div>
                            </div>
                            <div class="info-card">
                                <div class="info-label">Tổng chi tiêu</div>
                                <div class="info-value">₫<fmt:formatNumber value="${stats.totalSpent}" pattern="#,###"/></div>
                            </div>
                            <div class="info-card">
                                <div class="info-label">Đánh giá đã gửi</div>
                                <div class="info-value">${stats.totalReviews}</div>
                            </div>
                            <div class="info-card">
                                <div class="info-label">Ngày tham gia</div>
                                <div class="info-value">
                                    <fmt:formatDate value="${user.createdAt}" pattern="dd/MM/yyyy"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
                
                <!-- Danger Zone -->
                <div class="form-section">
                    <h3 class="section-title text-danger">
                        <i class="fas fa-exclamation-triangle"></i>
                        Khu vực nguy hiểm
                    </h3>
                    
                    <div class="alert alert-warning">
                        <h5><i class="fas fa-warning me-2"></i>Cảnh báo</h5>
                        <p class="mb-2">Các thao tác bên dưới không thể hoàn tác. Hãy chắc chắn trước khi thực hiện.</p>
                    </div>
                    
                    <div class="d-flex gap-3 flex-wrap">
                        <a href="${pageContext.request.contextPath}/admin/users/toggle-status?id=${user.id}" 
                           class="btn btn-outline-warning"
                           onclick="return confirm('Bạn có chắc muốn ${user.verified ? 'vô hiệu hóa' : 'kích hoạt'} tài khoản này?')">
                            <i class="fas ${user.verified ? 'fa-lock' : 'fa-unlock'} me-2"></i>
                            ${user.verified ? 'Vô hiệu hóa' : 'Kích hoạt'} tài khoản
                        </a>
                        
                        <a href="${pageContext.request.contextPath}/admin/users/delete?id=${user.id}" 
                           class="btn btn-outline-danger"
                           onclick="return confirm('⚠️ CẢNH BÁO: Bạn sắp xóa người dùng này. Thao tác này KHÔNG THỂ hoàn tác!\\n\\nBạn có chắc chắn?')">
                            <i class="fas fa-trash me-2"></i>
                            Xóa người dùng
                        </a>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    // Form validation
    document.querySelector('form').addEventListener('submit', function(e) {
        const email = this.querySelector('input[name="email"]').value;
        const fullname = this.querySelector('input[name="fullname"]').value;
        
        if (!email || !fullname) {
            e.preventDefault();
            alert('Vui lòng điền đầy đủ thông tin bắt buộc!');
            return;
        }
        
        // Email validation
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            e.preventDefault();
            alert('Vui lòng nhập địa chỉ email hợp lệ!');
            return;
        }
    });
    
    // Xử lý checkbox verified status
    const checkbox = document.querySelector('input[type="checkbox"][name="isVerified"]');
    const hiddenInput = document.querySelector('input[type="hidden"][name="isVerified"]');
    
    if (checkbox) {
        checkbox.addEventListener('change', function() {
            // Khi checkbox thay đổi, cập nhật giá trị hidden input
            hiddenInput.value = this.checked ? 'true' : 'false';
        });
        
        // Khởi tạo giá trị ban đầu
        hiddenInput.value = checkbox.checked ? 'true' : 'false';
    }
    
    // Role change confirmation for admin
    const roleSelect = document.querySelector('select[name="role"]');
    if (roleSelect) {
        roleSelect.addEventListener('change', function() {
            if (this.value === 'admin') {
                if (!confirm('⚠️ Cảnh báo: Gán quyền admin cho người dùng này?\nNgười dùng sẽ có toàn quyền truy cập hệ thống.')) {
                    this.value = 'customer';
                }
            }
        });
    }
</script>
</body>
</html>