<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Quản lý sản phẩm</title>
    <style>
        .container { max-width: 1000px; margin: 0 auto; padding: 20px; }
        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .form-group { margin-bottom: 20px; }
        .span-2 { grid-column: span 2; }
        .preview { max-width: 200px; margin-top: 10px; border-radius: 4px; border: 1px solid #ddd; }
        .btn { padding: 10px 20px; background: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; display: inline-block; }
        .btn-outline { background: white; color: #007bff; border: 1px solid #007bff; }
        .btn-success { background: #28a745; }
        .form-actions { text-align: right; margin-top: 30px; padding-top: 20px; border-top: 1px solid #eee; }
        label { display: block; margin-bottom: 8px; font-weight: bold; color: #333; }
        input, select, textarea { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; font-size: 14px; }
        input:focus, select:focus, textarea:focus { border-color: #007bff; outline: none; box-shadow: 0 0 0 2px rgba(0,123,255,0.25); }
        .required::after { content: " *"; color: red; }
        .alert { padding: 12px; margin: 10px 0; border-radius: 4px; }
        .alert-success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .alert-error { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="page-title">
            <c:out value="${product.productId != null ? '✏️ Cập nhật sản phẩm' : '➕ Thêm sản phẩm mới'}"/>
        </h1>
        
        <!-- Hiển thị thông báo -->
        <c:if test="${not empty sessionScope.message}">
            <div class="alert alert-success">${sessionScope.message}</div>
            <c:remove var="message" scope="session"/>
        </c:if>
        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-error">${sessionScope.error}</div>
            <c:remove var="error" scope="session"/>
        </c:if>

        <form action="${pageContext.request.contextPath}/admin/products" method="post" class="form-grid">
            <input type="hidden" name="action" value="save">
            <input type="hidden" name="product_id" value="${product.productId}">
            
            <div class="form-group">
                <label class="required">Tên sản phẩm</label>
                <input type="text" name="product_name" value="${product.productName}" 
                       placeholder="Nhập tên sản phẩm" required>
            </div>
            
            <div class="form-group">
                <label class="required">Giá (₫)</label>
                <input type="number" step="1000" min="0" name="price" value="${product.price}" 
                       placeholder="Nhập giá sản phẩm" required>
            </div>
            
            <div class="form-group">
                <label class="required">Tồn kho</label>
                <input type="number" min="0" name="stock_quantity" value="${product.stockQuantity}" 
                       placeholder="Nhập số lượng tồn kho" required>
            </div>
            
            <div class="form-group">
                <label class="required">Danh mục</label>
                <select name="category_id" required>
                    <option value="">-- Chọn danh mục --</option>
                    <c:forEach var="c" items="${categories}">
                        <option value="${c.categoryId}" ${product.categoryId == c.categoryId ? 'selected' : ''}>
                            ${c.categoryName}
                        </option>
                    </c:forEach>
                </select>
            </div>
            
            <div class="form-group">
                <label>Thương hiệu</label>
                <select name="brand_id">
                    <option value="">-- Chọn thương hiệu --</option>
                    <c:forEach var="b" items="${brands}">
                        <option value="${b.brandId}" ${product.brandId == b.brandId ? 'selected' : ''}>
                            ${b.brandName}
                        </option>
                    </c:forEach>
                </select>
            </div>
            
            <div class="form-group">
                <label>Nhà cung cấp</label>
                <select name="supplier_id">
                    <option value="">-- Chọn nhà cung cấp --</option>
                    <c:forEach var="s" items="${suppliers}">
                        <option value="${s.supplierId}" ${product.supplierId == s.supplierId ? 'selected' : ''}>
                            ${s.supplierName}
                        </option>
                    </c:forEach>
                </select>
            </div>
            
            <div class="form-group span-2">
                <label>Mô tả sản phẩm</label>
                <textarea name="description" rows="5" placeholder="Nhập mô tả chi tiết về sản phẩm">${product.description}</textarea>
            </div>
            
            <div class="form-group span-2">
                <label>URL Ảnh sản phẩm</label>
                <input type="text" name="image_url" value="${product.imageUrl}" 
                       placeholder="Nhập URL ảnh (ví dụ: images/product.jpg)">
                <c:if test="${not empty product.imageUrl}">
                    <div style="margin-top: 10px;">
                        <strong>Preview:</strong><br>
                        <img src="${pageContext.request.contextPath}/${product.imageUrl}" 
                             alt="Preview" class="preview" 
                             onerror="this.style.display='none'">
                    </div>
                </c:if>
            </div>
            
            <div class="form-actions span-2">
                <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-outline">← Quay lại</a>
                <button class="btn btn-success" type="submit">
                    <c:out value="${product.productId != null ? '💾 Cập nhật' : '💾 Thêm mới'}"/>
                </button>
            </div>
        </form>
    </div>

    <script>
        // Auto-preview image when URL changes
        document.querySelector('input[name="image_url"]').addEventListener('input', function(e) {
            const preview = document.querySelector('.preview');
            if (preview) {
                preview.src = '${pageContext.request.contextPath}/' + e.target.value;
                preview.style.display = 'block';
            }
        });
    </script>
</body>
</html>