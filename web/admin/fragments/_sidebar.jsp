<%-- WEB-INF/fragments/_sidebar.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- KHÔNG CÓ CSS Ở ĐÂY - CSS ĐÃ ĐƯỢC ĐƯA VÀO DASHBOARD -->

<div class="sidebar">
    <div class="sidebar-header">
        <h3><i class="fas fa-capsules"></i> Pharmative</h3>
    </div>
    
    <div class="user-info">
        <div class="user-avatar">
            <i class="fas fa-user"></i>
        </div>
        <div class="user-details">
            <div class="user-name">${sessionScope.currentUser != null ? sessionScope.currentUser.fullname : "Admin"}</div>
            <div class="user-role">Administrator</div>
        </div>
    </div>
    
    <div class="nav-menu">
        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link ${param.activePage == 'dashboard' ? 'active' : ''}">
                <i class="fas fa-tachometer-alt"></i>
                <span>Dashboard</span>
            </a>
        </div>
        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/users" class="nav-link ${param.activePage == 'users' ? 'active' : ''}">
                <i class="fas fa-users-cog"></i>
                <span>Quản lý Users</span>
            </a>
        </div>
        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/orders" class="nav-link ${param.activePage == 'orders' ? 'active' : ''}">
                <i class="fas fa-file-invoice"></i>
                <span>Quản lý Orders</span>
            </a>
        </div>
        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/products" class="nav-link ${param.activePage == 'products' ? 'active' : ''}">
                <i class="fas fa-box-open"></i>
                <span>Quản lý Products</span>
            </a>
        </div>
        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/categories" class="nav-link ${param.activePage == 'categories' ? 'active' : ''}">
                <i class="fas fa-tags"></i>
                <span>Quản lý Danh mục</span>
            </a>
        </div> 
    </div>
    
    <div class="sidebar-footer">
        <button class="logout-btn" onclick="location.href='${pageContext.request.contextPath}/logout'">
            <i class="fas fa-sign-out-alt"></i> Đăng xuất
        </button>
    </div>
</div>