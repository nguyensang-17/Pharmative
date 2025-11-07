<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="cpath" value="${pageContext.request.contextPath}" />

<style>
    /* OVERRIDE CSS - Fix chiều rộng header */
    .site-navbar {
        max-width: 100% !important;
        width: 100% !important;
    }
    
    .site-navbar .container {
        max-width: 100% !important;
        width: 100% !important;
    }
    
    /* Đảm bảo header chiếm toàn bộ chiều rộng */
    .site-navbar > .container {
        max-width: 100% !important;
        padding-left: 15px;
        padding-right: 15px;
    }
    
    /* Fix cho các phần tử bên trong */
    .d-flex.align-items-center.justify-content-between {
        width: 100% !important;
    }
    
    /* Custom styles cho header */
    .icons-container {
        display: flex;
        align-items: center;
        gap: 15px;
    }
    
    .icons-btn {
        position: relative;
        color: #333;
        text-decoration: none;
        padding: 8px;
        border-radius: 8px;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
        width: 40px;
        height: 40px;
    }

    .icons-btn.account-btn {
        min-width: 120px;
        width: auto;
        padding: 8px 14px;
        justify-content: flex-start;
        gap: 6px;
    }

    .account-name {
        font-size: 14px;
        max-width: 160px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        text-align: left;
    }
    
    .icons-btn:hover {
        background: #f8f9fa;
        color: #007bff;
        transform: translateY(-2px);
    }
    
    .bag {
        position: relative;
    }
    
    .number {
        position: absolute;
        top: -5px;
        right: -5px;
        background: #dc3545;
        color: white;
        border-radius: 50%;
        width: 20px;
        height: 20px;
        font-size: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: bold;
    }
</style>

<div class="site-navbar py-2">
  <div class="search-wrap">
    <div class="container">
      <a href="#" class="search-close js-search-close"><span class="icon-close2"></span></a>
      <form action="${cpath}/home" method="get">
        <input name="q" type="text" class="form-control" placeholder="Tìm sản phẩm...">
      </form>
    </div>
  </div>

  <div class="container">
    <div class="d-flex align-items-center justify-content-between">
      <!-- Logo -->
      <div class="logo">
        <div class="site-logo">
          <a href="${cpath}/home" class="js-logo-clone">
            Pharma<strong class="text-primary">tive</strong>
          </a>
        </div>
      </div>

      <!-- Main Navigation -->
      <div class="main-nav d-none d-lg-block">
        <nav class="site-navigation text-right text-md-center" role="navigation">
          <ul class="site-menu js-clone-nav d-none d-lg-block">
            <li><a href="${cpath}/home">Trang chủ</a></li>
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

      <!-- Icons góc phải - Sắp xếp lại theo hàng ngang -->
      <div class="icons-container">
        <!-- 🔍 Tìm kiếm -->
        <a href="#" class="icons-btn js-search-open" title="Tìm kiếm">
          <span class="icon-search"></span>
        </a>

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
              <span class="account-name">Xin chào, ${sessionScope.currentUser.fullname}</span>
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
        <a href="#" class="icons-btn d-lg-none js-menu-toggle" title="Menu">
          <span class="icon-menu"></span>
        </a>
      </div>
    </div>
  </div>
</div>

<script>
    // Search functionality
    document.addEventListener('DOMContentLoaded', function() {
        const searchOpen = document.querySelector('.js-search-open');
        const searchClose = document.querySelector('.js-search-close');
        const searchWrap = document.querySelector('.search-wrap');
        
        if (searchOpen && searchWrap) {
            searchOpen.addEventListener('click', function(e) {
                e.preventDefault();
                searchWrap.classList.add('active');
                // Focus on search input
                const searchInput = searchWrap.querySelector('input');
                if (searchInput) {
                    searchInput.focus();
                }
            });
        }
        
        if (searchClose && searchWrap) {
            searchClose.addEventListener('click', function(e) {
                e.preventDefault();
                searchWrap.classList.remove('active');
            });
        }
        
        // Close search when clicking outside
        if (searchWrap) {
            searchWrap.addEventListener('click', function(e) {
                if (e.target === searchWrap) {
                    searchWrap.classList.remove('active');
                }
            });
        }
        
        // Close search with ESC key
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape' && searchWrap.classList.contains('active')) {
                searchWrap.classList.remove('active');
            }
        });
    });
</script>