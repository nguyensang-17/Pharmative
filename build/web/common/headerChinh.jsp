<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <c:set var="cpath" value="${pageContext.request.contextPath}" />

        <style>
            /* Reset và cấu hình chung */
            .site-navbar {
                width: 100%;
                background: rgba(255, 255, 255, 0.98);
                box-shadow: 0 4px 30px rgba(0, 0, 0, 0.05);
                position: sticky;
                top: 0;
                z-index: 1000;
                font-family: 'Nunito', sans-serif;
                backdrop-filter: blur(10px);
                transition: all 0.3s ease;
            }

            .site-navbar .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 20px;
            }

            /* Header chính */
            .main-header {
                padding: 12px 0;
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
                /* Reverted to 28px */
                font-weight: 800;
                text-decoration: none;
                display: flex;
                align-items: center;
                letter-spacing: -0.5px;
                transition: transform 0.3s ease;
            }

            .site-logo a:hover {
                transform: scale(1.05);
            }

            .pharma-text {
                color: #27ae60;
                /* Reverted to original green */
            }

            .tive-text {
                color: #2ecc71;
                /* Reverted to original light green */
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
                gap: 8px;
            }

            .site-menu>li {
                position: relative;
            }

            .site-menu>li>a {
                color: #4a4a4a;
                text-decoration: none;
                font-weight: 700;
                font-size: 15px;
                padding: 10px 16px;
                display: block;
                transition: all 0.3s ease;
                border-radius: 50px;
                position: relative;
            }

            .site-menu>li>a:hover,
            .site-menu>li>a.active {
                color: #27ae60;
                background: rgba(39, 174, 96, 0.08);
                /* Adjusted to match logo */
            }

            /* Dropdown menu */
            .has-children .dropdown {
                position: absolute;
                top: 120%;
                left: 0;
                background: #fff;
                min-width: 240px;
                box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
                border-radius: 12px;
                opacity: 0;
                visibility: hidden;
                transform: translateY(15px);
                transition: all 0.3s cubic-bezier(0.165, 0.84, 0.44, 1);
                z-index: 1000;
                padding: 10px;
                border: 1px solid rgba(0, 0, 0, 0.05);
            }

            .has-children .dropdown::before {
                content: '';
                position: absolute;
                top: -6px;
                left: 20px;
                width: 12px;
                height: 12px;
                background: #fff;
                transform: rotate(45deg);
                border-top: 1px solid rgba(0, 0, 0, 0.05);
                border-left: 1px solid rgba(0, 0, 0, 0.05);
            }

            .has-children:hover .dropdown {
                opacity: 1;
                visibility: visible;
                transform: translateY(0);
                top: 100%;
            }

            .dropdown li {
                position: relative;
            }

            .dropdown li a {
                display: block;
                padding: 10px 15px;
                color: #555;
                text-decoration: none;
                font-size: 14px;
                font-weight: 600;
                transition: all 0.2s ease;
                border-radius: 8px;
            }

            .dropdown li a:hover {
                background: #f1f8e9;
                color: #2e7d32;
                transform: translateX(5px);
            }

            /* Nested dropdown */
            .has-children .dropdown .has-children .dropdown {
                left: 100%;
                top: 0;
                margin-left: 10px;
            }

            /* Icons container */
            .icons-container {
                display: flex;
                align-items: center;
                gap: 12px;
            }

            .icons-btn {
                position: relative;
                color: #4a4a4a;
                text-decoration: none;
                padding: 0;
                border-radius: 50%;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                justify-content: center;
                width: 42px;
                height: 42px;
                background: transparent;
                border: 1px solid transparent;
            }

            .icons-btn:hover {
                background: #f1f8e9;
                color: #2e7d32;
                border-color: rgba(46, 125, 50, 0.1);
                transform: translateY(-2px);
            }

            .icons-btn.account-btn {
                min-width: auto;
                width: auto;
                padding: 6px 16px 6px 12px;
                border-radius: 50px;
                justify-content: flex-start;
                gap: 10px;
                background: #f1f8e9;
                color: #2e7d32;
                font-weight: 700;
                border: 1px solid rgba(46, 125, 50, 0.1);
            }

            .icons-btn.account-btn:hover {
                background: #2e7d32;
                color: #fff;
                box-shadow: 0 4px 12px rgba(46, 125, 50, 0.2);
            }

            .account-name {
                font-size: 14px;
                max-width: 100px;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
                text-align: left;
            }

            .bag {
                position: relative;
            }

            .number {
                position: absolute;
                top: -2px;
                right: -2px;
                background: #d32f2f;
                color: white;
                border-radius: 50%;
                width: 18px;
                height: 18px;
                font-size: 11px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: bold;
                box-shadow: 0 2px 4px rgba(211, 47, 47, 0.3);
                border: 2px solid #fff;
            }

            /* Mobile menu toggle */
            .mobile-toggle {
                display: none;
                font-size: 22px;
                cursor: pointer;
            }

            /* Responsive */
            @media (max-width: 991px) {
                .main-nav {
                    display: none;
                }

                .mobile-toggle {
                    display: flex;
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
                    padding: 0;
                    width: 42px;
                    height: 42px;
                    justify-content: center;
                    border-radius: 50%;
                }

                .icons-btn.account-btn span:first-child {
                    margin: 0;
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
                                <c:set var="uri" value="${pageContext.request.requestURI}" />
                                <ul class="site-menu js-clone-nav d-none d-lg-block">
                                    <li><a href="${cpath}/home"
                                            class="${uri.endsWith('/home') || uri.endsWith('/home.jsp') ? 'active' : ''}">Trang
                                            chủ</a></li>
                                    <li><a href="${cpath}/shop" class="${uri.contains('/shop') ? 'active' : ''}">Sản
                                            phẩm</a></li>
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

                                    <li><a href="${cpath}/about.jsp"
                                            class="${uri.endsWith('/about.jsp') ? 'active' : ''}">Giới thiệu</a></li>
                                    <li><a href="${cpath}/contact.jsp"
                                            class="${uri.endsWith('/contact.jsp') ? 'active' : ''}">Chăm sóc khách
                                            hàng</a></li>
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