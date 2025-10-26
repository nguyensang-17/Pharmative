<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết User - Pharmative Admin</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f5f5;
            padding: 20px;
        }
        .container {
            max-width: 900px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            margin-bottom: 30px;
            font-size: 28px;
            border-bottom: 3px solid #007bff;
            padding-bottom: 10px;
        }
        
        /* User Header Section */
        .user-header {
            display: flex;
            align-items: center;
            gap: 30px;
            margin-bottom: 30px;
            padding: 25px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 10px;
            color: white;
        }
        .user-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 48px;
            color: #667eea;
            font-weight: bold;
            flex-shrink: 0;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }
        .user-header-info {
            flex: 1;
        }
        .user-header-info h2 {
            margin-bottom: 10px;
            font-size: 24px;
            font-weight: 600;
        }
        .user-header-info p {
            opacity: 0.9;
            margin: 5px 0;
            font-size: 15px;
        }
        .user-header-info .badges {
            margin-top: 12px;
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }
        
        /* Info Grid */
        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .info-card {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            border-left: 4px solid #007bff;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .info-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .info-card h3 {
            font-size: 13px;
            color: #666;
            margin-bottom: 10px;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-weight: 600;
        }
        .info-card p {
            font-size: 18px;
            color: #333;
            font-weight: 500;
            word-break: break-word;
        }
        .info-card.empty p {
            color: #999;
            font-style: italic;
        }
        
        /* Badges */
        .badge {
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
            display: inline-block;
        }
        .badge-admin {
            background: #ffc107;
            color: #000;
        }
        .badge-customer {
            background: #28a745;
            color: white;
        }
        .badge-verified {
            background: #17a2b8;
            color: white;
        }
        .badge-unverified {
            background: #dc3545;
            color: white;
        }
        
        /* Statistics Section */
        .stats-section {
            margin-top: 30px;
            padding: 25px;
            background: #f8f9fa;
            border-radius: 8px;
            border: 2px solid #e9ecef;
        }
        .stats-section h3 {
            margin-bottom: 20px;
            color: #333;
            font-size: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
        }
        .stat-item {
            text-align: center;
            padding: 20px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.08);
            transition: transform 0.3s;
        }
        .stat-item:hover {
            transform: translateY(-5px);
        }
        .stat-item .label {
            font-size: 13px;
            color: #666;
            margin-bottom: 10px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .stat-item .value {
            font-size: 28px;
            font-weight: bold;
            color: #007bff;
        }
        
        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 30px;
            padding-top: 30px;
            border-top: 2px solid #dee2e6;
            flex-wrap: wrap;
        }
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 500;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
        }
        .btn-primary {
            background: #007bff;
            color: white;
        }
        .btn-primary:hover {
            background: #0056b3;
        }
        .btn-warning {
            background: #ffc107;
            color: #000;
        }
        .btn-warning:hover {
            background: #e0a800;
        }
        .btn-danger {
            background: #dc3545;
            color: white;
        }
        .btn-danger:hover {
            background: #c82333;
        }
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        .btn-secondary:hover {
            background: #545b62;
        }
        
        /* Alert Messages */
        .alert {
            padding: 15px 20px;
            margin-bottom: 20px;
            border-radius: 5px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        /* Empty State */
        .no-stats {
            text-align: center;
            padding: 30px;
            color: #999;
        }
        .no-stats svg {
            width: 80px;
            height: 80px;
            margin-bottom: 15px;
            opacity: 0.3;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }
            .user-header {
                flex-direction: column;
                text-align: center;
                padding: 20px;
            }
            .user-avatar {
                width: 80px;
                height: 80px;
                font-size: 36px;
            }
            .user-header-info .badges {
                justify-content: center;
            }
            .info-grid,
            .stats-grid {
                grid-template-columns: 1fr;
            }
            .action-buttons {
                flex-direction: column;
            }
            .btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>👤 Chi Tiết Người Dùng</h1>
        
        <!-- Alert Messages -->
        <c:if test="${not empty sessionScope.message}">
            <div class="alert alert-success">
                ✅ ${sessionScope.message}
            </div>
            <c:remove var="message" scope="session"/>
        </c:if>
        
        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-error">
                ❌ ${sessionScope.error}
            </div>
            <c:remove var="error" scope="session"/>
        </c:if>
        
        <!-- User Header -->
        <div class="user-header">
            <div class="user-avatar">
                ${user.fullname.substring(0,1).toUpperCase()}
            </div>
            <div class="user-header-info">
                <h2>${user.fullname}</h2>
                <p>📧 ${user.email}</p>
                <c:if test="${not empty user.phoneNumber}">
                    <p>📱 ${user.phoneNumber}</p>
                </c:if>
                <div class="badges">
                    <span class="badge ${user.role == 'admin' ? 'badge-admin' : 'badge-customer'}">
                        ${user.role == 'admin' ? '👑 Admin' : '👤 Customer'}
                    </span>
                    <span class="badge ${user.verified ? 'badge-verified' : 'badge-unverified'}">
                        ${user.verified ? '✓ Đã xác thực' : '✗ Chưa xác thực'}
                    </span>
                </div>
            </div>
        </div>
        
        <!-- User Information Grid -->
        <div class="info-grid">
            <div class="info-card">
                <h3>🆔 ID Người Dùng</h3>
                <p>#${user.id}</p>
            </div>
            
            <div class="info-card ${empty user.phoneNumber ? 'empty' : ''}">
                <h3>📱 Số Điện Thoại</h3>
                <p>
                    <c:choose>
                        <c:when test="${not empty user.phoneNumber}">
                            ${user.phoneNumber}
                        </c:when>
                        <c:otherwise>
                            Chưa cập nhật
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>
            
            <div class="info-card ${empty user.address ? 'empty' : ''}">
                <h3>📍 Địa Chỉ</h3>
                <p>
                    <c:choose>
                        <c:when test="${not empty user.address}">
                            ${user.address}
                        </c:when>
                        <c:otherwise>
                            Chưa cập nhật
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>
            
            <div class="info-card">
                <h3>📅 Ngày Đăng Ký</h3>
                <p>
                    <fmt:formatDate value="${user.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                </p>
            </div>
        </div>
        
        <!-- User Statistics (if available) -->
        <c:choose>
            <c:when test="${not empty stats}">
                <div class="stats-section">
                    <h3>📊 Thống Kê Hoạt Động</h3>
                    <div class="stats-grid">
                        <div class="stat-item">
                            <div class="label">Tổng Đơn Hàng</div>
                            <div class="value">${stats.totalOrders}</div>
                        </div>
                        <div class="stat-item">
                            <div class="label">Tổng Chi Tiêu</div>
                            <div class="value">
                                <fmt:formatNumber value="${stats.totalSpent}" 
                                                 type="number" 
                                                 maxFractionDigits="0"/>₫
                            </div>
                        </div>
                        <div class="stat-item">
                            <div class="label">Đơn Hàng Cuối</div>
                            <div class="value" style="font-size: 16px;">
                                <c:choose>
                                    <c:when test="${not empty stats.lastOrderDate}">
                                        <fmt:formatDate value="${stats.lastOrderDate}" 
                                                       pattern="dd/MM/yyyy"/>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color: #999;">Chưa có</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="stats-section">
                    <h3>📊 Thống Kê Hoạt Động</h3>
                    <div class="no-stats">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" />
                        </svg>
                        <p>Chưa có dữ liệu thống kê</p>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
        
        <!-- Action Buttons -->
        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/admin/users/edit?id=${user.id}" 
               class="btn btn-primary">
                ✏️ Chỉnh Sửa Thông Tin
            </a>
            
            <a href="${pageContext.request.contextPath}/admin/users/toggle-status?id=${user.id}" 
               class="btn btn-warning"
               onclick="return confirm('Bạn có chắc muốn ${user.verified ? 'hủy xác thực' : 'xác thực'} user này?')">
                🔒 ${user.verified ? 'Hủy Xác Thực' : 'Xác Thực User'}
            </a>
            
            <a href="${pageContext.request.contextPath}/admin/users/delete?id=${user.id}" 
               class="btn btn-danger"
               onclick="return confirm('⚠️ CẢNH BÁO:\n\nBạn có chắc muốn xóa user này?\n\nThông tin:\n- ID: #${user.id}\n- Tên: ${user.fullname}\n- Email: ${user.email}\n\nHành động này KHÔNG THỂ HOÀN TÁC!\nTất cả dữ liệu liên quan (đơn hàng, đánh giá...) sẽ bị ảnh hưởng.')">
                🗑️ Xóa User
            </a>
            
            <a href="${pageContext.request.contextPath}/admin/users/list" 
               class="btn btn-secondary">
                ← Quay Lại Danh Sách
            </a>
        </div>
    </div>
</body>
</html>