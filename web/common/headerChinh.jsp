<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="cpath" value="${pageContext.request.contextPath}" />

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
      <div class="logo">
        <div class="site-logo">
          <a href="${cpath}/home" class="js-logo-clone">
            <strong class="text-primary">Thực phẩm</strong> Chức năng
          </a>
        </div>
      </div>

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
                    <li><a href="${cpath}/shop?cat=9">Bổ não &amp; Trí nhớ</a></li>
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
      <div class="icons">
<<<<<<< HEAD
        <!-- 🧑 Icon user dẫn đến login.jsp -->
        <a href="${cpath}/login.jsp" class="icons-btn d-inline-block">
          <span class="icon-user"></span>
        </a>

        <!-- 🛒 Giỏ hàng -->
=======
          
        <a href="#" class="icons-btn d-inline-block js-search-open"><span class="icon-search"></span></a>
>>>>>>> quan-Admin/user
        <a href="${cpath}/cart" class="icons-btn d-inline-block bag">
          <span class="icon-shopping-bag"></span>
          <span class="number">2</span>
        </a>
<<<<<<< HEAD

        <!-- Icon menu (mobile) -->
=======
        
>>>>>>> quan-Admin/user
        <a href="#" class="site-menu-toggle js-menu-toggle ml-3 d-inline-block d-lg-none">
          <span class="icon-menu"></span>
        </a>
        
      </div>
    </div>
  </div>
</div>
