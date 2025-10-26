<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Users - Pharmative Admin</title>
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
            max-width: 1400px;
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
        
        /* Statistics Cards */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .stat-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 25px;
            border-radius: 10px;
            color: white;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }
        .stat-card:hover {
            transform: translateY(-5px);
        }
        .stat-card h3 {
            font-size: 14px;
            opacity: 0.9;
            margin-bottom: 10px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .stat-card .number {
            font-size: 36px;
            font-weight: bold;
        }
        .stat-card:nth-child(2) {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        }
        .stat-card:nth-child(3) {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        }
        .stat-card:nth-child(4) {
            background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
        }
        
        /* Filter Section */
        .filter-section {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 25px;
        }
        .filter-form {
            display: flex;
            gap: 15px;
            align-items: center;
            flex-wrap: wrap;
        }
        .filter-form input[type="text"],
        .filter-form select {
            padding: 10px 15px;
            border: 2px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            transition: border-color 0.3s;
        }
        .filter-form input[type="text"] {
            flex: 1;
            min-width: 250px;
        }
        .filter-form input[type="text"]:focus,
        .filter-form select:focus {
            outline: none;
            border-color: #007bff;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
        }
        .btn-primary {
            background: #007bff;
            color: white;
        }
        .btn-primary:hover {
            background: #0056b3;
        }
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        .btn-secondary:hover {
            background: #545b62;
        }
        
        /* Table */
        .table-wrapper {
            overflow-x: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        table thead {
            background: #f8f9fa;
        }
        table th {
            padding: 15px 12px;
            text-align: left;
            font-weight: 600;
            color: #333;
            border-bottom: 2px solid #dee2e6;
            white-space: nowrap;
        }
        table td {
            padding: 12px;
            border-bottom: 1px solid #dee2e6;
            vertical-align: middle;
        }
        table tbody tr:hover {
            background: #f8f9fa;
        }
        
        /* Badges */
        .badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
            white-space: nowrap;
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
        
        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }
        .btn-sm {
            padding: 6px 12px;
            font-size: 13px;
            border-radius: 4px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            transition: all 0.3s;
        }
        .btn-view {
            background: #17a2b8;
            color: white;
        }
        .btn-view:hover {
            background: #138496;
        }
        .btn-edit {
            background: #ffc107;
            color: #000;
        }
        .btn-edit:hover {
            background: #e0a800;
        }
        .btn-toggle {
            background: #6c757d;
            color: white;
        }
        .btn-toggle:hover {
            background: #545b62;
        }
        .btn-delete {
            background: #dc3545;
            color: white;
        }
        .btn-delete:hover {
            background: #c82333;
        }
        
        /* Pagination */
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 5px;
            margin-top: 25px;
            flex-wrap: wrap;
        }
        .pagination a,
        .pagination span {
            padding: 8px 14px;
            border: 1px solid #dee2e6;
            text-decoration: none;
            color: #333;
            border-radius: 5px;
            transition: all 0.3s;
        }
        .pagination a:hover {
            background: #007bff;
            color: white;
            border-color: #007bff;
        }
        .pagination .active {
            background: #007bff;
            color: white;
            border-color: #007bff;
            font-weight: bold;
        }
        .pagination .disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }
        
        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }
        .empty-state svg {
            width: 120px;
            height: 120px;
            margin-bottom: 20px;
            opacity: 0.3;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }
            .stats-container {
                grid-template-columns: 1fr;
            }
            .filter-form {
                flex-direction: column;
                align-items: stretch;
            }
            .filter-form input[type="text"],
            .filter-form select,
            .filter-form button {
                width: 100%;
            }
            table {
                font-size: 13px;
            }
            table th,
            table td {
                padding: 8px 6px;
            }
            .action-buttons {
                flex-direction: column;
            }
            .btn-sm {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>👥 Quản Lý Người Dùng</h1>
        
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
        
        <!-- Statistics Cards -->
        <div class="stats-container">
            <div class="stat-card">
                <h3>Tổng Users</h3>
                <div class="number">${totalUsers}</div>
            </div>
            <div class="stat-card">
                <h3>Customers</h3>
                <div class="number">${totalCustomers}</div>
            </div>
            <div class="stat-card">
                <h3>Admins</h3>
                <div class="number">${totalAdmins}</div>
            </div>
            <div class="stat-card">
                <h3>Mới Tháng Này</h3>
                <div class="number">${newUsersThisMonth}</div>
            </div>
        </div>
        
        <!-- Filter & Search -->
        <div class="filter-section">
            <form action="${pageContext.request.contextPath}/admin/users/list" 
                  method="get" class="filter-form">
                <input type="text" 
                       name="keyword" 
                       placeholder="🔍 Tìm kiếm theo tên, email, số điện thoại..." 
                       value="${keyword}">
                
                <select name="role">
                    <option value="">-- Tất cả roles --</option>
                    <option value="customer" ${roleFilter == 'customer' ? 'selected' : ''}>
                        👤 Customer
                    </option>
                    <option value="admin" ${roleFilter == 'admin' ? 'selected' : ''}>
                        👑 Admin
                    </option>
                </select>
                
                <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                <a href="${pageContext.request.contextPath}/admin/users/list" 
                   class="btn btn-secondary">Reset</a>
            </form>
        </div>
        
        <!-- Users Table -->
        <div class="table-wrapper">
            <c:choose>
                <c:when test="${not empty users}">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Họ Tên</th>
                                <th>Email</th>
                                <th>Số Điện Thoại</th>
                                <th>Role</th>
                                <th>Trạng Thái</th>
                                <th>Ngày Tạo</th>
                                <th style="text-align: center;">Hành Động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" items="${users}">
                                <tr>
                                    <td><strong>#${user.id}</strong></td>
                                    <td>${user.fullname}</td>
                                    <td>${user.email}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty user.phoneNumber}">
                                                ${user.phoneNumber}
                                            </c:when>
                                            <c:otherwise>
                                                <span style="color: #999;">Chưa có</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <span class="badge ${user.role == 'admin' ? 'badge-admin' : 'badge-customer'}">
                                            ${user.role == 'admin' ? '👑 Admin' : '👤 Customer'}
                                        </span>
                                    </td>
                                    <td>
                                        <span class="badge ${user.verified ? 'badge-verified' : 'badge-unverified'}">
                                            ${user.verified ? '✓ Đã xác thực' : '✗ Chưa xác thực'}
                                        </span>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${user.createdAt}" 
                                                        pattern="dd/MM/yyyy HH:mm"/>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <a href="${pageContext.request.contextPath}/admin/users/view?id=${user.id}" 
                                               class="btn-sm btn-view" title="Xem chi tiết">
                                                👁️ Xem
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/users/edit?id=${user.id}" 
                                               class="btn-sm btn-edit" title="Chỉnh sửa">
                                                ✏️ Sửa
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/users/toggle-status?id=${user.id}" 
                                               class="btn-sm btn-toggle" 
                                               title="Khóa/Mở khóa"
                                               onclick="return confirm('Bạn có chắc muốn thay đổi trạng thái user này?')">
                                                🔒 Toggle
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/users/delete?id=${user.id}" 
                                               class="btn-sm btn-delete" 
                                               title="Xóa"
                                               onclick="return confirm('⚠️ CẢNH BÁO: Bạn có chắc muốn xóa user này?\n\nHành động này không thể hoàn tác!')">
                                                🗑️ Xóa
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    
                    <!-- Pagination -->
                    <c:if test="${totalPages > 1}">
                        <div class="pagination">
                            <!-- Previous Button -->
                            <c:choose>
                                <c:when test="${currentPage > 1}">
                                    <a href="?page=${currentPage - 1}<c:if test='${not empty keyword}'>&keyword=${keyword}</c:if><c:if test='${not empty roleFilter}'>&role=${roleFilter}</c:if>">
                                        ‹ Trước
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <span class="disabled">‹ Trước</span>
                                </c:otherwise>
                            </c:choose>
                            
                            <!-- Page Numbers -->
                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <c:choose>
                                    <c:when test="${i == currentPage}">
                                        <span class="active">${i}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="?page=${i}<c:if test='${not empty keyword}'>&keyword=${keyword}</c:if><c:if test='${not empty roleFilter}'>&role=${roleFilter}</c:if>">
                                            ${i}
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            
                            <!-- Next Button -->
                            <c:choose>
                                <c:when test="${currentPage < totalPages}">
                                    <a href="?page=${currentPage + 1}<c:if test='${not empty keyword}'>&keyword=${keyword}</c:if><c:if test='${not empty roleFilter}'>&role=${roleFilter}</c:if>">
                                        Sau ›
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <span class="disabled">Sau ›</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
                        </svg>
                        <h3>Không tìm thấy người dùng nào</h3>
                        <p>Thử thay đổi bộ lọc hoặc tìm kiếm của bạn</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        
        <!-- Back Button -->
        <div style="margin-top: 30px;">
            <a href="${pageContext.request.contextPath}/admin/dashboard" 
               class="btn btn-secondary">
                ← Quay lại Dashboard
            </a>
        </div>
    </div>
</body>
</html>