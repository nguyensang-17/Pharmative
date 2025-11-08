<%-- 
    Document   : category_form
    Created on : Oct 23, 2025, 7:39:27 PM
    Author     : ADMINN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${category != null ? 'Chỉnh sửa' : 'Thêm mới'} Danh mục - Admin</title>
    
    <!-- Bootstrap + FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        /* Copy CSS từ cat-list.jsp ở đây */
        :root{
            --brand-green: #75b239;
            --brand-green-dark: #5fa127;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f6f8f7;
            color: #333;
        }
        
        .page-header {
            background: linear-gradient(135deg, var(--brand-green), var(--brand-green-dark));
            color: white;
            padding: 24px 28px;
            border-radius: 16px;
            margin-bottom: 26px;
        }
        
        .btn-success {
            background: var(--brand-green);
            border: none;
        }
        
        .btn-success:hover {
            background: var(--brand-green-dark);
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <jsp:include page="../WEB-INF/fragments/_sidebar.jsp">
                <jsp:param name="activePage" value="categories" />
            </jsp:include>

            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <!-- Page Header -->
                <div class="page-header mt-3">
                    <div>
                        <h2><i class="fas fa-tags" style="margin-right:10px"></i> 
                            ${category != null ? 'Chỉnh sửa Danh mục' : 'Thêm Danh mục Mới'}
                        </h2>
                        <p class="mb-0" style="opacity:0.9">
                            ${category != null ? 'Cập nhật thông tin danh mục' : 'Thêm danh mục sản phẩm mới vào hệ thống'}
                        </p>
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

                <!-- Form Card -->
                <div class="card">
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/admin/categories" method="post">
                            <input type="hidden" name="id" value="${category.categoryId}">
                            
                            <div class="row">
                                <div class="col-md-8">
                                    <div class="mb-3">
                                        <label for="name" class="form-label">Tên danh mục <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" id="name" name="name" 
                                               value="${category.categoryName}" required
                                               placeholder="Nhập tên danh mục">
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="parentCategoryId" class="form-label">Danh mục cha</label>
                                        <select class="form-select" id="parentCategoryId" name="parentCategoryId">
                                            <option value="0">-- Không có (Danh mục cha) --</option>
                                            <c:forEach var="parentCat" items="${parentCategories}">
                                                <option value="${parentCat.categoryId}" 
                                                        ${category.parentCategoryId == parentCat.categoryId ? 'selected' : ''}
                                                        ${category.categoryId == parentCat.categoryId ? 'disabled' : ''}>
                                                    ${parentCat.categoryName}
                                                </option>
                                            </c:forEach>
                                        </select>
                                        <div class="form-text">
                                            Chọn danh mục cha nếu đây là danh mục con. Để trống nếu đây là danh mục cha.
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="col-md-4">
                                    <div class="card bg-light">
                                        <div class="card-body">
                                            <h6 class="card-title"><i class="fas fa-info-circle"></i> Thông tin</h6>
                                            <c:if test="${category != null}">
                                                <p><strong>ID:</strong> ${category.categoryId}</p>
                                                <!-- Trong phần thông tin của category_form.jsp, sửa phần hiển thị ngày tạo: -->
<p><strong>Ngày tạo:</strong> 
    <c:if test="${category.createdAt != null}">
        ${category.createdAt}
    </c:if>
    <c:if test="${category.createdAt == null}">
        N/A
    </c:if>
</p>
                                            </c:if>
                                            <p class="text-muted small">
                                                Các trường đánh dấu <span class="text-danger">*</span> là bắt buộc.
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="d-flex gap-2">
                                <button type="submit" class="btn btn-success">
                                    <i class="fas fa-save"></i> ${category != null ? 'Cập nhật' : 'Thêm mới'}
                                </button>
                                <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left"></i> Quay lại
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>