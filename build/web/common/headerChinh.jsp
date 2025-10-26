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
                <li><a href="#">Dinh dưỡng</a></li>
                <li class="has-children">
                  <a href="#">Vitamin &amp; khoáng chất</a>
                  <ul class="dropdown">
                    <li><a href="#">Vitamin C</a></li>
                    <li><a href="#">Vitamin D3</a></li>
                    <li><a href="#">Vitamin B</a></li>
                  </ul>
                </li>
                <li><a href="#">Diet &amp; Hỗ trợ sắc đẹp</a></li>
                <li><a href="#">Bổ não &amp; trí nhớ</a></li>
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