<%-- WEB-INF/fragments/sidebar.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    /* Đảm bảo CSS cho sidebar được copy từ dashboard.jsp */
    :root{
        --brand-green: #75b239;
        --brand-green-dark: #5fa127;
        --brand-green-light: #e8f4dc;
        --brand-green-soft: rgba(117,178,57,0.08);
        --brand-green-muted: #8bc34a;
        --muted: #6c6f76;
        --bg: #f6f8f7;
        --card-bg: #ffffff;
        --accent: rgba(117,178,57,0.06);
        --shadow: 0 6px 18px rgba(24,39,75,0.06);
        --shadow-green: 0 6px 18px rgba(117,178,57,0.12);
    }

    .sidebar {
        width: 260px;
        background: linear-gradient(180deg, var(--brand-green), var(--brand-green-dark));
        color: white;
        padding: 0;
        box-shadow: 4px 0 20px rgba(0,0,0,0.08);
        z-index: 100;
        display: flex;
        flex-direction: column;
        transition: all 0.3s ease;
        position: fixed;
        height: 100vh;
        overflow-y: auto;
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
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
    }

    .sidebar-header h3 i {
        font-size: 1.6rem;
    }

    .user-info {
        padding: 16px 20px;
        border-bottom: 1px solid rgba(255,255,255,0.1);
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .user-avatar {
        width: 42px;
        height: 42px;
        border-radius: 50%;
        background: rgba(255,255,255,0.2);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.2rem;
    }

    .user-details {
        flex: 1;
    }

    .user-name {
        font-weight: 600;
        font-size: 0.95rem;
        margin-bottom: 4px;
    }

    .user-role {
        font-size: 0.8rem;
        opacity: 0.8;
        background: rgba(255,255,255,0.15);
        padding: 2px 8px;
        border-radius: 12px;
        display: inline-block;
    }

    .nav-menu {
        flex: 1;
        padding: 20px 0;
        overflow-y: auto;
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
        font-weight: 500;
        border-left: 3px solid transparent;
    }

    .nav-link:hover, .nav-link.active {
        background: rgba(255,255,255,0.1);
        color: white;
        border-left-color: white;
    }

    .nav-link i {
        width: 24px;
        margin-right: 12px;
        font-size: 1.1rem;
    }

    .sidebar-footer {
        padding: 16px 20px;
        border-top: 1px solid rgba(255,255,255,0.1);
    }

    .logout-btn {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        width: 100%;
        padding: 12px;
        background: rgba(255,255,255,0.15);
        color: white;
        border: none;
        border-radius: 8px;
        font-weight: 600;
        transition: all 0.2s ease;
    }

    .logout-btn:hover {
        background: rgba(255,255,255,0.25);
        transform: translateY(-2px);
    }

    @media (max-width: 992px) {
        .sidebar {
            width: 100%;
            height: auto;
            position: relative;
        }
        
        .nav-menu {
            display: flex;
            overflow-x: auto;
            padding: 10px 0;
        }
        
        .nav-item {
            margin-bottom: 0;
            margin-right: 10px;
            flex-shrink: 0;
        }
        
        .nav-link {
            border-left: none;
            border-bottom: 3px solid transparent;
            padding: 10px 15px;
            white-space: nowrap;
        }
        
        .nav-link:hover, .nav-link.active {
            border-left-color: transparent;
            border-bottom-color: white;
        }
        
        .user-info, .sidebar-footer {
            display: none;
        }
    }
</style>

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
        <div class="nav-item">
            <a href="#" class="nav-link">
                <i class="fas fa-chart-bar"></i>
                <span>Báo cáo & Thống kê</span>
            </a>
        </div>
        <div class="nav-item">
            <a href="#" class="nav-link">
                <i class="fas fa-cog"></i>
                <span>Cài đặt hệ thống</span>
            </a>
        </div>
    </div>
    
    <div class="sidebar-footer">
        <button class="logout-btn" onclick="location.href='${pageContext.request.contextPath}/logout'">
            <i class="fas fa-sign-out-alt"></i> Đăng xuất
        </button>
    </div>
</div>