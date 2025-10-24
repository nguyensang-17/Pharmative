<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div>
    <h1 class="page-title"><c:out value="${product.productId != null ? 'Cập nhật sản phẩm' : 'Thêm sản phẩm'}"/></h1>
    <form action="${pageContext.request.contextPath}${product.productId != null ? '/admin/products/'+product.productId : '/admin/products'}" method="post" enctype="multipart/form-data" class="form-grid">
        <div class="form-group">
            <label>Tên sản phẩm</label>
            <input type="text" name="productName" value="${product.productName}" required>
        </div>
        <div class="form-group">
            <label>Giá (₫)</label>
            <input type="number" step="1000" min="0" name="price" value="${product.price}" required>
        </div>
        <div class="form-group">
            <label>Tồn kho</label>
            <input type="number" min="0" name="stockQuantity" value="${product.stockQuantity}" required>
        </div>
        <div class="form-group">
            <label>Danh mục</label>
            <select name="categoryId" required>
                <c:forEach var="c" items="${categories}">
                    <option value="${c.categoryId}" ${product.categoryId == c.categoryId ? 'selected' : ''}>${c.categoryName}</option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group">
            <label>Thương hiệu</label>
            <select name="brandId">
                <c:forEach var="b" items="${brands}">
                    <option value="${b.brandId}" ${product.brandId == b.brandId ? 'selected' : ''}>${b.brandName}</option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group">
            <label>Nhà cung cấp</label>
            <select name="supplierId">
                <c:forEach var="s" items="${suppliers}">
                    <option value="${s.supplierId}" ${product.supplierId == s.supplierId ? 'selected' : ''}>${s.supplierName}</option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group span-2">
            <label>Mô tả</label>
            <textarea name="description" rows="5">${product.description}</textarea>
        </div>
        <div class="form-group">
            <label>Ảnh</label>
            <input type="file" name="imageFile" accept="image/*">
            <c:if test="${not empty product.imageUrl}">
                <img src="${product.imageUrl}" alt="preview" class="preview"/>
            </c:if>
        </div>
        <div class="form-actions span-2">
            <a href="${pageContext.request.contextPath}/admin/products" class="btn-outline">Hủy</a>
            <button class="btn" type="submit">Lưu</button>
        </div>
    </form>
</div>