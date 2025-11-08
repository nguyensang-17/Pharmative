<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="cpath" value="${pageContext.request.contextPath}" />

<style>
    /* Reset và cấu hình chung */
    .site-navbar {
        width: 100%;
        background: #fff;
        box-shadow: 0 2px 20px rgba(0, 0, 0, 0.08);
        position: relative;
        z-index: 1000;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .site-navbar .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 20px;
    }

    /* Header chính */
    .main-header {
        padding: 15px 0;
    }

    .header-content {
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    /* Logo */
    .logo {
        flex: 0 0 auto;
    }

    .site-logo a {
        font-size: 28px;
        font-weight: 800;
        text-decoration: none;
        display: flex;
        align-items: center;
        letter-spacing: -0.5px;
    }

    .pharma-text {
        color: #27ae60;
    }

    .tive-text {
        color: #2ecc71;
        font-weight: 700;
    }

    /* Navigation */
    .main-nav {
        flex: 1;
        margin: 0 30px;
    }

    .site-menu {
        display: flex;
        list-style: none;
        margin: 0;
        padding: 0;
        justify-content: center;
        gap: 5px;
    }

    .site-menu > li {
        position: relative;
    }

    .site-menu > li > a {
        color: #2c3e50;
        text-decoration: none;
        font-weight: 600;
        font-size: 16px;
        padding: 12px 18px;
        display: block;
        transition: all 0.3s ease;
        border-radius: 8px;
        position: relative;
    }

    .site-menu > li > a:hover {
        color: #27ae60;
        background: #f8fff9;
    }

    .site-menu > li > a.active {
        color: #27ae60;
        background: #f0f9f1;
    }

    /* Dropdown menu */
    .has-children .dropdown {
        position: absolute;
        top: 100%;
        left: 0;
        background: #fff;
        min-width: 240px;
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
        opacity: 0;
        visibility: hidden;
        transform: translateY(10px);
        transition: all 0.3s ease;
        z-index: 1000;
        padding: 10px 0;
        border-top: 3px solid #27ae60;
    }

    .has-children:hover .dropdown {
        opacity: 1;
        visibility: visible;
        transform: translateY(0);
    }

    .dropdown li {
        position: relative;
    }

    .dropdown li a {
        display: block;
        padding: 12px 20px;
        color: #495057;
        text-decoration: none;
        font-size: 14px;
        transition: all 0.2s ease;
        border-left: 3px solid transparent;
    }

    .dropdown li a:hover {
        background: #f0f9f1;
        color: #27ae60;
        border-left-color: #27ae60;
    }

    /* Nested dropdown */
    .has-children .dropdown .has-children .dropdown {
        left: 100%;
        top: -10px;
    }

    /* Icons container */
    .icons-container {
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .icons-btn {
        position: relative;
        color: #2c3e50;
        text-decoration: none;
        padding: 10px;
        border-radius: 50%;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
        width: 44px;
        height: 44px;
        background: #f8f9fa;
    }

    .icons-btn.account-btn {
        min-width: auto;
        width: auto;
        padding: 10px 16px;
        border-radius: 25px;
        justify-content: flex-start;
        gap: 8px;
        background: #f0f9f1;
        color: #27ae60;
        font-weight: 600;
    }

    .account-name {
        font-size: 14px;
        max-width: 100%;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        text-align: left;
        font-weight: 600;
    }

    .icons-btn:hover {
        background: #27ae60;
        color: white;
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(39, 174, 96, 0.3);
    }

    .bag {
        position: relative;
    }

    .number {
        position: absolute;
        top: -5px;
        right: -5px;
        background: #e74c3c;
        color: white;
        border-radius: 50%;
        width: 20px;
        height: 20px;
        font-size: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: bold;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
    }

    /* Mobile menu toggle */
    .mobile-toggle {
        display: none;
        font-size: 24px;
        cursor: pointer;
    }

    /* Responsive */
    @media (max-width: 991px) {
        .main-nav {
            display: none;
        }

        .mobile-toggle {
            display: block;
        }

        .header-content {
            position: relative;
        }

        .logo {
            flex: 1;
            text-align: center;
        }

        .icons-container {
            gap: 8px;
        }

        .account-name {
            display: none;
        }

        .icons-btn.account-btn {
            padding: 10px;
        }
    }
</style>

<div class="site-navbar">
    <!-- Header chính -->
    <div class="main-header">
        <div class="container">
            <div class="header-content">
                <!-- Logo -->
                <div class="logo">
                    <div class="site-logo">
                        <a href="${cpath}/home" class="js-logo-clone">
                            <span class="pharma-text">PHARMA</span><span class="tive-text">TIVE</span>
                        </a>
                    </div>
                </div>

                <!-- Main Navigation -->
                <div class="main-nav d-none d-lg-block">
                    <nav class="site-navigation text-right text-md-center" role="navigation">
                        <ul class="site-menu js-clone-nav d-none d-lg-block">
                            <li><a href="${cpath}/home" class="active">Trang chủ</a></li>
                            <li><a href="${cpath}/shop">Sản phẩm</a></li>
                            <li class="has-children">
                                <a href="#">Danh mục sản phẩm</a>
                                <ul class="dropdown">
                                    <!-- Nhóm 1 -->
                                    <li class="has-children">
                                        <a href="${cpath}/shop?cat=1">Vitamin &amp; khoáng chất</a>
                                        <ul class="dropdown">
                                            <li><a href="${cpath}/shop?cat=6">Vitamin tổng hợp</a></li>
                                            <li><a href="${cpath}/shop?cat=7">Vitamin C</a></li>
                                            <li><a href="${cpath}/shop?cat=8">Canxi &amp; Vitamin D</a></li>
                                        </ul>
                                    </li>

                                    <!-- Nhóm 2 -->
                                    <li class="has-children">
                                        <a href="${cpath}/shop?cat=2">Thảo dược &amp; Bổ sung</a>
                                        <ul class="dropdown">
                                            <li><a href="${cpath}/shop?cat=10">Hỗ trợ tiêu hóa</a></li>
                                        </ul>
                                    </li>

                                    <!-- Nhóm 3 -->
                                    <li class="has-children">
                                        <a href="${cpath}/shop?cat=3">Dinh dưỡng thể thao</a>
                                        <ul class="dropdown">
                                            <li><a href="${cpath}/shop?cat=11">Whey Protein</a></li>
                                            <li><a href="${cpath}/shop?cat=12">BCAA &amp; Amino</a></li>
                                        </ul>
                                    </li>

                                    <!-- Các nhóm đơn -->
                                    <li><a href="${cpath}/shop?cat=4">Kiểm soát cân nặng</a></li>
                                    <li><a href="${cpath}/shop?cat=5">Hỗ trợ sắc đẹp</a></li>
                                </ul>
                            </li>

                            <li><a href="${cpath}/about.jsp">Giới thiệu</a></li>
                            <li><a href="${cpath}/contact.jsp">Chăm sóc khách hàng</a></li>
                        </ul>
                    </nav>
                </div>

                <!-- Icons góc phải -->
                <div class="icons-container">
                    <!-- 🛒 Giỏ hàng -->
                    <a href="${cpath}/cart.jsp" class="icons-btn bag" title="Giỏ hàng">
                        <span class="icon-shopping-bag"></span>
                        <c:if test="${not empty sessionScope.cart}">
                            <span class="number">${sessionScope.cart.size()}</span>
                        </c:if>
                    </a>

                    <!-- 👤 Người dùng -->
                    <c:choose>
                        <c:when test="${not empty sessionScope.currentUser}">
                            <a href="${cpath}/account" class="icons-btn account-btn" title="Tài khoản">
                                <span class="icon-user"></span>
                                <span class="account-name">${sessionScope.currentUser.fullname}</span>
                            </a>
                            <a href="${cpath}/logout" class="icons-btn" title="Đăng xuất">
                                <span class="icon-sign-out"></span>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="${cpath}/login.jsp" class="icons-btn" title="Đăng nhập">
                                <span class="icon-user"></span>
                            </a>
                        </c:otherwise>
                    </c:choose>

                    <!-- Menu mobile -->
                    <a href="#" class="icons-btn mobile-toggle d-lg-none js-menu-toggle" title="Menu">
                        <span class="icon-menu"></span>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>