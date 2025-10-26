<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa User - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <jsp:include page="../fragments/sidebar.jsp" />
            
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Chỉnh sửa User</h1>
                    <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">
                        Quay lại
                    </a>
                </div>
                
                <div class="alert alert-info">
                    <h4>Trang chỉnh sửa user đang được phát triển</h4>
                    <p>Chức năng này sẽ sẵn sàng sớm!</p>
                </div>
            </main>
        </div>
    </div>
</body>
</html>