<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Sản phẩm Mới - Admin</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root{
            --brand-green: #75b239;
            --brand-green-dark: #5fa127;
            --bg: #f6f8f7;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--bg);
            color: #333;
            display: flex;
            min-height: 100vh;
            margin: 0;
        }

        .sidebar {
            width: 260px;
            background: linear-gradient(180deg, var(--brand-green), var(--brand-green-dark));
            color: white;
            padding: 0;
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
        }

        .nav-menu {
            flex: 1;
            padding: 20px 0;
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
        }

        .nav-link:hover, .nav-link.active {
            background: rgba(255,255,255,0.1);
            color: white;
        }

        .nav-link i {
            width: 24px;
            margin-right: 12px;
        }

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
        }
        
        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 6px 18px rgba(24,39,75,0.06);
            margin-bottom: 24px;
        }
        
        .btn-success {
            background: var(--brand-green);
            border: none;
        }
        
        .btn-success:hover {
            background: var(--brand-green-dark);
        }

        .image-upload-container {
            border: 2px dashed #dee2e6;
            border-radius: 12px;
            padding: 30px;
            text-align: center;
            background: #fafafa;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .image-upload-container:hover {
            border-color: var(--brand-green);
            background: rgba(117,178,57,0.08);
        }

        .upload-icon {
            font-size: 3rem;
            color: var(--brand-green);
            margin-bottom: 15px;
        }

        .image-preview {
            max-width: 200px;
            max-height: 200px;
            border-radius: 8px;
            margin: 15px auto;
            display: none;
        }

        .btn-remove-image {
            display: none;
            margin-top: 10px;
        }

        .required::after {
            content: " *";
            color: #dc3545;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <h3><i class="fas fa-capsules"></i> Pharmative</h3>
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
                <a href="${pageContext.request.contextPath}/admin/products" class="nav-link active">
                    <i class="fas fa-box-open"></i>
                    <span>Quản lý Products</span>
                </a>
            </div>
        </div>
    </div>

    <!-- Main content -->
    <div class="main-content">
        <!-- Page Header -->
        <div class="page-header">
            <div>
                <h2><i class="fas fa-plus" style="margin-right:10px"></i> Thêm Sản phẩm Mới</h2>
                <p class="mb-0" style="opacity:0.9">Thêm sản phẩm mới vào hệ thống</p>
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

        <!-- Product Form -->
        <div class="card">
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/admin/products" method="post" enctype="multipart/form-data" id="productForm">
                    <input type="hidden" name="action" value="save">
                    
                    <div class="row">
                        <!-- Left Column - Basic Info -->
                        <div class="col-md-8">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label required">Tên sản phẩm</label>
                                    <input type="text" class="form-control" name="product_name" 
                                           placeholder="Nhập tên sản phẩm" required>
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label class="form-label required">Giá (₫)</label>
                                    <input type="number" class="form-control" name="price" 
                                           placeholder="Nhập giá sản phẩm" min="0" step="1000" required>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label required">Số lượng tồn kho</label>
                                    <input type="number" class="form-control" name="stock_quantity" 
                                           placeholder="Nhập số lượng" min="0" required>
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label class="form-label required">Danh mục</label>
                                    <select class="form-select" name="category_id" required>
                                        <option value="">-- Chọn danh mục --</option>
                                        <c:forEach var="category" items="${categories}">
                                            <option value="${category.categoryId}">${category.categoryName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <!-- THÊM BRAND VÀ SUPPLIER -->
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Thương hiệu</label>
                                    <select class="form-select" name="brand_id">
                                        <option value="">-- Chọn thương hiệu --</option>
                                        <c:forEach var="brand" items="${brands}">
                                            <option value="${brand.brandId}">${brand.brandName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Nhà cung cấp</label>
                                    <select class="form-select" name="supplier_id">
                                        <option value="">-- Chọn nhà cung cấp --</option>
                                        <c:forEach var="supplier" items="${suppliers}">
                                            <option value="${supplier.supplierId}">${supplier.supplierName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Mô tả sản phẩm</label>
                                <textarea class="form-control" name="description" rows="5" 
                                          placeholder="Nhập mô tả chi tiết về sản phẩm"></textarea>
                            </div>
                        </div>

                        <!-- Right Column - Image Upload -->
                        <div class="col-md-4">
                            <div class="mb-3">
                                <label class="form-label">Hình ảnh sản phẩm</label>
                                <div class="image-upload-container" id="uploadContainer">
                                    <div class="upload-icon">
                                        <i class="fas fa-cloud-upload-alt"></i>
                                    </div>
                                    <h5>Kéo thả ảnh vào đây</h5>
                                    <p class="text-muted">hoặc</p>
                                    <input type="file" class="form-control" id="imageInput" name="image" 
                                           accept="image/*" style="display: none;">
                                    <button type="button" class="btn btn-success" onclick="document.getElementById('imageInput').click()">
                                        <i class="fas fa-folder-open"></i> Chọn ảnh
                                    </button>
                                    <p class="text-muted mt-2 small">Hỗ trợ: JPG, PNG, GIF (Tối đa 5MB)</p>
                                </div>
                                
                                <!-- Image Preview -->
                                <img id="imagePreview" class="image-preview" alt="Preview">
                                
                                <button type="button" class="btn btn-outline-danger btn-remove-image w-100" id="removeImageBtn">
                                    <i class="fas fa-trash"></i> Xóa ảnh
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Form Actions -->
                    <div class="row mt-4">
                        <div class="col-12">
                            <div class="d-flex justify-content-between">
                                <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-outline-secondary">
                                    <i class="fas fa-arrow-left"></i> Quay lại danh sách
                                </a>
                                <button type="submit" class="btn btn-success">
                                    <i class="fas fa-save"></i> Thêm Sản phẩm
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const imageInput = document.getElementById('imageInput');
            const imagePreview = document.getElementById('imagePreview');
            const uploadContainer = document.getElementById('uploadContainer');
            const removeImageBtn = document.getElementById('removeImageBtn');

            // File input change event
            imageInput.addEventListener('change', function(e) {
                handleImageSelection(e.target.files[0]);
            });

            // Drag and drop functionality
            uploadContainer.addEventListener('dragover', function(e) {
                e.preventDefault();
                this.style.borderColor = '#75b239';
                this.style.background = 'rgba(117,178,57,0.1)';
            });

            uploadContainer.addEventListener('dragleave', function(e) {
                e.preventDefault();
                this.style.borderColor = '#dee2e6';
                this.style.background = '#fafafa';
            });

            uploadContainer.addEventListener('drop', function(e) {
                e.preventDefault();
                this.style.borderColor = '#dee2e6';
                this.style.background = '#fafafa';
                
                const files = e.dataTransfer.files;
                if (files.length > 0) {
                    handleImageSelection(files[0]);
                }
            });

            function handleImageSelection(file) {
                if (file) {
                    // Validate file size
                    if (file.size > 5 * 1024 * 1024) {
                        alert('Kích thước file không được vượt quá 5MB');
                        return;
                    }

                    // Validate file type
                    if (!file.type.match('image.*')) {
                        alert('Vui lòng chọn file ảnh (JPG, PNG, GIF)');
                        return;
                    }

                    const reader = new FileReader();
                    reader.onload = function(e) {
                        imagePreview.src = e.target.result;
                        imagePreview.style.display = 'block';
                        removeImageBtn.style.display = 'block';
                    }
                    reader.readAsDataURL(file);
                }
            }

            // Remove image
            removeImageBtn.addEventListener('click', function() {
                imageInput.value = '';
                imagePreview.style.display = 'none';
                this.style.display = 'none';
            });

            // Form validation
            document.getElementById('productForm').addEventListener('submit', function(e) {
                const productName = document.querySelector('input[name="product_name"]').value.trim();
                const price = document.querySelector('input[name="price"]').value;
                const stock = document.querySelector('input[name="stock_quantity"]').value;
                const category = document.querySelector('select[name="category_id"]').value;

                if (!productName) {
                    e.preventDefault();
                    alert('Vui lòng nhập tên sản phẩm');
                    return false;
                }

                if (!price || price < 0) {
                    e.preventDefault();
                    alert('Vui lòng nhập giá hợp lệ');
                    return false;
                }

                if (!stock || stock < 0) {
                    e.preventDefault();
                    alert('Vui lòng nhập số lượng hợp lệ');
                    return false;
                }

                if (!category) {
                    e.preventDefault();
                    alert('Vui lòng chọn danh mục');
                    return false;
                }
            });
        });
    </script>
</body>
</html>