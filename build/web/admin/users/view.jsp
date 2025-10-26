<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết User - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <jsp:include page="../fragments/sidebar.jsp" />
            
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Chi tiết User</h1>
                    <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">
                        Quay lại
                    </a>
                </div>
                
                <div class="alert alert-info">
                    <h4>Trang chi tiết user đang được phát triển</h4>
                    <p>Chức năng này sẽ sẵn sàng sớm!</p>
                </div>
                
                <c:if test="${not empty user}">
                    <div class="card">
                        <div class="card-body">
                            <h5>Thông tin cơ bản</h5>
                            <p><strong>ID:</strong> ${user.id}</p>
                            <p><strong>Họ tên:</strong> ${user.fullname}</p>
                            <p><strong>Email:</strong> ${user.email}</p>
                            <p><strong>Vai trò:</strong> ${user.role}</p>
                        </div>
                    </div>
                </c:if>
            </main>
        </div>
    </div>
</body>
</html>