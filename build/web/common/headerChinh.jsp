<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="cpath" value="${pageContext.request.contextPath}" />

<div class="site-navbar py-2">
<<<<<<< Updated upstream
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
          <a href="${cpath}/home" class="js-logo-clone"><strong class="text-primary">Pharma</strong>tive</a>
        </div>
      </div>
      <div class="main-nav d-none d-lg-block">
        <nav class="site-navigation text-right text-md-center" role="navigation">
          <ul class="site-menu js-clone-nav d-none d-lg-block">
            <li><a href="${cpath}/home">Home</a></li>
            <li><a href="${cpath}/shop">Store</a></li>
            <li class="has-children">
              <a href="#">Products</a>
              <ul class="dropdown">
                <li><a href="#">Supplements</a></li>
                <li class="has-children">
                  <a href="#">Vitamins</a>
                  <ul class="dropdown">
                    <li><a href="#">Supplements</a></li>
                    <li><a href="#">Vitamins</a></li>
                    <li><a href="#">Diet &amp; Nutrition</a></li>
                    <li><a href="#">Tea &amp; Coffee</a></li>
                  </ul>
                </li>
                <li><a href="#">Diet &amp; Nutrition</a></li>
                <li><a href="#">Tea &amp; Coffee</a></li>
              </ul>
            </li>
            <li><a href="${cpath}/about.jsp">About</a></li>
            <li><a href="${cpath}/contact.jsp">Contact</a></li>
          </ul>
        </nav>
      </div>
      <div class="icons">
        <a href="#" class="icons-btn d-inline-block js-search-open"><span class="icon-search"></span></a>
        <a href="${cpath}/cart" class="icons-btn d-inline-block bag">
          <span class="icon-shopping-bag"></span>
          <span class="number">2</span>
        </a>
        <a href="#" class="site-menu-toggle js-menu-toggle ml-3 d-inline-block d-lg-none">
          <span class="icon-menu"></span>
        </a>
      </div>
    </div>
  </div>
</div>
=======
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
                    <a href="${cpath}/home" class="js-logo-clone"><strong class="text-primary">Thực phẩm</strong> Chức năng</a>
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
                                <li class="has-children">
                                    <a href="#">Vitamin &amp; khoáng chất</a>
                                    <ul class="dropdown">
                                        <li><a href="#">Vitamin tổng hợp</a></li>
                                        <li><a href="#">Vitamin C</a></li>
                                        <li><a href="#">Canxi & Vitamin D</a></li>
                                    </ul>
                                </li>
                                <li class="has-children">
                                    <a href="#">>Thảo dược &amp; Bổ sung</a>
                                    <ul class="dropdown">
                                        <li><a href="#">Bổ não & Trí nhớ</a></li>
                                        <li><a href="#">Hỗ trợ tiêu hóa</a></li>         
                                    </ul>
                                </li>
                                <li>
                                    <a href="#">Dinh dưỡng thể thao</a>
                                    <ul class="dropdown">
                                        <li><a href="#">Whey Protein</a></li>
                                        <li><a href="#">BCAA & Amino</a></li>         
                                    </ul>
                                </li>
                                <li><a href="#">Kiểm soát cân nặng</a></li>
                                <li><a href="#">Hỗ trợ sắc đẹp</a></li>
                            </ul>
                        </li>
                        <li><a href="${cpath}/about.jsp">Giới thiệu</a></li>
                        <li><a href="${cpath}/contact.jsp">Chăm sóc khách hàng</a></li>
                    </ul>
                </nav>
            </div>
            <div class="icons">
                <a href="#" class="icons-btn d-inline-block js-search-open"><span class="icon-search"></span></a>
                <a href="${cpath}/cart" class="icons-btn d-inline-block bag">
                    <span class="icon-shopping-bag"></span>
                    <span class="number">2</span>
                </a>
                <a href="#" class="site-menu-toggle js-menu-toggle ml-3 d-inline-block d-lg-none">
                    <span class="icon-menu"></span>
                </a>
            </div>
        </div>
    </div>
</div>
>>>>>>> Stashed changes
