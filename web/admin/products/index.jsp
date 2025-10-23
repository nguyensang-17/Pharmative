<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div>
    <div class="page-header">
        <h1 class="page-title">Sản phẩm</h1>
        <a class="btn" href="${pageContext.request.contextPath}/admin/products/new">+ Thêm</a>
    </div>
    <div class="card">
        <div class="table-wrap">
            <table id="productsTable" class="datatable">
                <thead>
                    <tr>
                        <th>ID</th><th>Ảnh</th><th>Tên</th><th>Danh mục</th><th>Giá</th><th>Tồn</th><th></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${products}">
                        <tr>
                            <td>${p.productId}</td>
                            <td><img src="${p.imageUrl}" class="thumb" alt="thumb"></td>
                            <td>${p.productName}</td>
                            <td>${p.categoryName}</td>
                            <td>${p.priceFmt}</td>
                            <td>${p.stockQuantity}</td>
                            <td class="text-right">
                                <a class="btn-sm" href="${pageContext.request.contextPath}/admin/products/${p.productId}/edit">Sửa</a>
                                <form action="${pageContext.request.contextPath}/admin/products/${p.productId}/delete" method="post" class="inline" onsubmit="return confirm('Xóa sản phẩm này?');">
                                    <button class="btn-sm danger" type="submit">Xóa</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <jsp:include page="/WEB-INF/views/admin/fragments/_pagination.jspf"/>
</div>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        if (window.$)
            $('#productsTable').DataTable();
    });
</script>