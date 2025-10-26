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
            --bg: #f6f8f7;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--bg);
        }
        
        .page-header {
            background: linear-gradient(135deg, var(--brand-green), var(--brand-green-dark));
            color: white;
            padding: 24px;
            border-radius: 12px;
            margin-bottom: 24px;
        }
        
        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            margin-bottom: 24px;
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
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <jsp:include page="../fragments/sidebar.jsp" />

            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <!-- Page Header -->
                <div class="page-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h2><i class="fas fa-users"></i> Quản lý Users</h2>
                            <p class="mb-0">Quản lý thông tin người dùng hệ thống</p>
                        </div>
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
                <div class="row">
                    <div class="col-md-3">
                        <div class="card text-center">
                            <div class="card-body">
                                <h3 class="text-primary">${totalUsers}</h3>
                                <p class="text-muted mb-0">Tổng Users</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-center">
                            <div class="card-body">
                                <h3 class="text-success">${totalCustomers}</h3>
                                <p class="text-muted mb-0">Khách hàng</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-center">
                            <div class="card-body">
                                <h3 class="text-warning">${totalAdmins}</h3>
                                <p class="text-muted mb-0">Quản trị viên</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-center">
                            <div class="card-body">
                                <h3 class="text-info">${newUsersThisMonth}</h3>
                                <p class="text-muted mb-0">User mới (tháng)</p>
                            </div>
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
                                                    <a href="${pageContext.request.contextPath}/admin/users/view?id=${user.id}" 
                                                       class="btn btn-sm btn-outline-primary" title="Xem chi tiết">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/admin/users/edit?id=${user.id}" 
                                                       class="btn btn-sm btn-outline-warning" title="Chỉnh sửa">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/admin/users/toggle-status?id=${user.id}" 
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
                                                                <a href="${pageContext.request.contextPath}/admin/users/delete?id=${user.id}" 
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
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>