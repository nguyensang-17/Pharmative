<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="sidebar-nav">
    <div class="brand">
        <a href="${pageContext.request.contextPath}/admin" class="brand-link">Pharmative<span>Admin</span></a>
    </div>
    <ul>
        <li class="${activeMenu == 'dashboard' ? 'active' : ''}"><a href="${pageContext.request.contextPath}/admin">? T?ng quan</a></li>
        <li class="menu-label">Qu?n lý bán hàng</li>
        <li class="${activeMenu == 'orders' ? 'active' : ''}"><a href="${pageContext.request.contextPath}/admin/orders">? ??n hàng</a></li>


        <li class="menu-label">S?n ph?m</li>
        <li class="${activeMenu == 'products' ? 'active' : ''}"><a href="${pageContext.request.contextPath}/admin/products">?? S?n ph?m</a></li>
        <li class="${activeMenu == 'categories' ? 'active' : ''}"><a href="${pageContext.request.contextPath}/admin/categories">?? Danh m?c</a></li>
        <li class="${activeMenu == 'brands' ? 'active' : ''}"><a href="${pageContext.request.contextPath}/admin/brands">?? Th??ng hi?u</a></li>
        <li class="${activeMenu == 'suppliers' ? 'active' : ''}"><a href="${pageContext.request.contextPath}/admin/suppliers">? Nhà cung c?p</a></li>


        <li class="menu-label">Khách hàng & ?ánh giá</li>
        <li class="${activeMenu == 'users' ? 'active' : ''}"><a href="${pageContext.request.contextPath}/admin/users">? Ng??i dùng</a></li>
        <li class="${activeMenu == 'reviews' ? 'active' : ''}"><a href="${pageContext.request.contextPath}/admin/reviews">? ?ánh giá</a></li>


        <li class="menu-label">Báo cáo</li>
        <li><a href="${pageContext.request.contextPath}/admin/reports">? Th?ng kê</a></li>


        <li class="menu-label">H? th?ng</li>
        <li><a href="${pageContext.request.contextPath}/admin/settings">?? C?u hình</a></li>
    </ul>
</nav>