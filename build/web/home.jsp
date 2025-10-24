<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Pharmative</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="fonts/icomoon/style.css">
  <link rel="stylesheet" href="css/bootstrap.min.css">
  <link rel="stylesheet" href="fonts/flaticon/font/flaticon.css">
  <link rel="stylesheet" href="css/magnific-popup.css">
  <link rel="stylesheet" href="css/jquery-ui.css">
  <link rel="stylesheet" href="css/owl.carousel.min.css">
  <link rel="stylesheet" href="css/owl.theme.default.min.css">
  <link rel="stylesheet" href="css/aos.css">
  <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="site-wrap">

  <div class="site-navbar py-2">
    <div class="search-wrap">
      <div class="container">
        <a href="#" class="search-close js-search-close"><span class="icon-close2"></span></a>
        <form action="index" method="get">
          <input name="q" type="text" class="form-control" placeholder="Tìm sản phẩm...">
        </form>
      </div>
    </div>

    <div class="container">
      <div class="d-flex align-items-center justify-content-between">
        <div class="logo">
          <div class="site-logo">
            <a href="index" class="js-logo-clone"><strong class="text-primary">Pharma</strong>tive</a>
          </div>
        </div>
        <div class="main-nav d-none d-lg-block">
          <nav class="site-navigation text-right text-md-center" role="navigation">
            <ul class="site-menu js-clone-nav d-none d-lg-block">
              <li class="active"><a href="index">Home</a></li>
              <li><a href="shop.jsp">Store</a></li>
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
              <li><a href="about.jsp">About</a></li>
              <li><a href="contact.jsp">Contact</a></li>
            </ul>
          </nav>
        </div>
        <div class="icons">
          <a href="#" class="icons-btn d-inline-block js-search-open"><span class="icon-search"></span></a>
          <a href="cart.jsp" class="icons-btn d-inline-block bag">
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

  <!-- Hero -->
  <div class="owl-carousel owl-single px-0">
    <div class="site-blocks-cover overlay" style="background-image: url('images/hero_bg.jpg');">
      <div class="container">
        <div class="row">
          <div class="col-lg-12 mx-auto align-self-center">
            <div class="site-block-cover-content text-center">
              <h1 class="mb-0"><strong class="text-primary">Pharmative</strong> Opens 24 Hours</h1>
              <div class="row justify-content-center mb-5">
                <div class="col-lg-6 text-center">
                  <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Facilis ex perspiciatis non quibusdam vel quidem.</p>
                </div>
              </div>
              <p><a href="shop.jsp" class="btn btn-primary px-5 py-3">Shop Now</a></p>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="site-blocks-cover overlay" style="background-image: url('images/hero_bg_2.jpg');">
      <div class="container">
        <div class="row">
          <div class="col-lg-12 mx-auto align-self-center">
            <div class="site-block-cover-content text-center">
              <h1 class="mb-0">New Medicine <strong class="text-primary">Everyday</strong></h1>
              <div class="row justify-content-center mb-5">
                <div class="col-lg-6 text-center">
                  <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Facilis ex perspiciatis non quibusdam vel quidem.</p>
                </div>
              </div>
              <p><a href="shop.jsp" class="btn btn-primary px-5 py-3">Shop Now</a></p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Features -->
  <div class="site-section py-5">
    <div class="container">
      <div class="row">
        <div class="col-lg-4">
          <div class="feature">
            <span class="wrap-icon flaticon-24-hours-drugs-delivery"></span>
            <h3><a href="#">Free Delivery</a></h3>
            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Culpa laborum voluptates excepturi neque labore.</p>
            <p><a href="#" class="d-flex align-items-center"><span class="mr-2">Learn more</span> <span class="icon-keyboard_arrow_right"></span></a></p>
          </div>
        </div>
        <div class="col-lg-4">
          <div class="feature">
            <span class="wrap-icon flaticon-medicine"></span>
            <h3><a href="#">New Medicine Everyday</a></h3>
            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Culpa laborum voluptates excepturi neque labore.</p>
            <p><a href="#" class="d-flex align-items-center"><span class="mr-2">Learn more</span> <span class="icon-keyboard_arrow_right"></span></a></p>
          </div>
        </div>
        <div class="col-lg-4">
          <div class="feature">
            <span class="wrap-icon flaticon-test-tubes"></span>
            <h3><a href="#">Medicines Guaranteed</a></h3>
            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Culpa laborum voluptates excepturi neque labore.</p>
            <p><a href="#" class="d-flex align-items-center"><span class="mr-2">Learn more</span> <span class="icon-keyboard_arrow_right"></span></a></p>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Products (dynamic) -->
  <div class="site-section bg-light">
    <div class="container">
      <div class="row">
        <div class="title-section text-center col-12">
          <h2>Pharmacy <strong class="text-primary">Products</strong></h2>
        </div>
      </div>

      <div class="row">
        <div class="col-md-12 block-3 products-wrap">
          <div class="nonloop-block-3 owl-carousel">
            <c:forEach var="p" items="${products}">
              <div class="text-center item mb-4 item-v2">
                <a href="product-detail?id=${p.id}">
                  <img src="${p.imageUrl}" alt="${p.name}">
                </a>
                <h3 class="text-dark"><a href="product-detail?id=${p.id}">${p.name}</a></h3>
                <p class="price">${p.price}</p>
              </div>
            </c:forEach>
            <c:if test="${empty products}">
              <div class="text-center item mb-4 item-v2">
                <h5>Chưa có sản phẩm</h5>
              </div>
            </c:if>
          </div>
        </div>
      </div>

      <!-- Pagination -->
      <nav aria-label="pagination" class="mt-3">
        <ul class="pagination justify-content-center">
          <li class="page-item ${page==1?'disabled':''}">
            <a class="page-link" href="index?page=${page-1}">«</a>
          </li>
          <c:forEach var="i" begin="1" end="${totalPages}">
            <li class="page-item ${i==page?'active':''}">
              <a class="page-link" href="index?page=${i}">${i}</a>
            </li>
          </c:forEach>
          <li class="page-item ${page==totalPages?'disabled':''}">
            <a class="page-link" href="index?page=${page+1}">»</a>
          </li>
        </ul>
      </nav>
    </div>
  </div>

  <!-- Hot products -->
  <div class="site-section">
    <div class="container">
      <div class="row">
        <div class="title-section text-center col-12">
          <h2>🔥 <strong class="text-primary">Sản phẩm hot</strong></h2>
        </div>
      </div>

      <div class="row">
        <div class="col-md-12 block-3 products-wrap">
          <div class="nonloop-block-3 owl-carousel">
            <c:forEach var="p" items="${hot}">
              <div class="text-center item mb-4 item-v2">
                <a href="product-detail?id=${p.id}">
                  <img src="${p.imageUrl}" alt="${p.name}">
                </a>
                <h3 class="text-dark"><a href="product-detail?id=${p.id}">${p.name}</a></h3>
                <p class="price">${p.price}</p>
              </div>
            </c:forEach>
            <c:if test="${empty hot}">
              <div class="text-center item mb-4 item-v2">
                <h5>Tạm thời chưa có dữ liệu hot</h5>
              </div>
            </c:if>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- CTA -->
  <div class="site-section bg-image overlay" style="background-image: url('images/hero_bg_2.jpg');">
    <div class="container">
      <div class="row justify-content-center text-center">
        <div class="col-lg-7">
          <h3 class="text-white">Sign up for discount up to 55% OFF</h3>
          <p class="text-white">Lorem ipsum dolor, sit amet consectetur adipisicing elit. Nemo omnis voluptatem consectetur quam.</p>
          <p class="mb-0"><a href="#" class="btn btn-outline-white">Sign up</a></p>
        </div>
      </div>
    </div>
  </div>

  <!-- Testimonials + Why us (giữ nguyên) -->
  <div class="site-section">
    <div class="container">
      <div class="row justify-content-between">
        <div class="col-lg-6">
          <div class="title-section">
            <h2>Happy <strong class="text-primary">Customers</strong></h2>
          </div>
          <div class="block-3 products-wrap">
            <div class="owl-single no-direction owl-carousel">
              <div class="testimony">
                <blockquote>
                  <img src="images/person_1.jpg" alt="Image" class="img-fluid">
                  <p>&ldquo;Lorem ipsum dolor, sit amet consectetur adipisicing elit...&rdquo;</p>
                </blockquote>
                <p class="author">&mdash; Kelly Holmes</p>
              </div>
              <div class="testimony">
                <blockquote>
                  <img src="images/person_2.jpg" alt="Image" class="img-fluid">
                  <p>&ldquo;Lorem ipsum dolor sit amet consectetur...&rdquo;</p>
                </blockquote>
                <p class="author">&mdash; Rebecca Morando</p>
              </div>
              <div class="testimony">
                <blockquote>
                  <img src="images/person_3.jpg" alt="Image" class="img-fluid">
                  <p>&ldquo;Lorem ipsum dolor sit amet consectetur...&rdquo;</p>
                </blockquote>
                <p class="author">&mdash; Lucas Gallone</p>
              </div>
              <div class="testimony">
                <blockquote>
                  <img src="images/person_4.jpg" alt="Image" class="img-fluid">
                  <p>&ldquo;Lorem ipsum dolor sit amet consectetur...&rdquo;</p>
                </blockquote>
                <p class="author">&mdash; Andrew Neel</p>
              </div>
            </div>
          </div>
        </div>

        <div class="col-lg-5">
          <div class="title-section">
            <h2 class="mb-5">Why <strong class="text-primary">Us</strong></h2>
            <div class="step-number d-flex mb-4">
              <span>1</span><p>Lorem ipsum dolor sit amet...</p>
            </div>
            <div class="step-number d-flex mb-4">
              <span>2</span><p>Lorem ipsum dolor sit amet...</p>
            </div>
            <div class="step-number d-flex mb-4">
              <span>3</span><p>Lorem ipsum dolor sit amet...</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Footer (giữ nguyên template của bạn) -->
  <footer class="site-footer bg-light">
    <div class="container">
      <div class="row">
        <div class="col-md-6 col-lg-4 mb-4 mb-lg-0">
          <div class="block-7">
            <h3 class="footer-heading mb-4">About <strong class="text-primary">Pharmative</strong></h3>
            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eius quae reiciendis distinctio voluptates sed dolorum excepturi iure eaque, aut unde.</p>
          </div>
        </div>
        <div class="col-lg-3 mx-auto mb-5 mb-lg-0">
          <h3 class="footer-heading mb-4">Navigation</h3>
          <ul class="list-unstyled">
            <li><a href="#">Supplements</a></li>
            <li><a href="#">Vitamins</a></li>
            <li><a href="#">Diet &amp; Nutrition</a></li>
            <li><a href="#">Tea &amp; Coffee</a></li>
          </ul>
        </div>
        <div class="col-md-6 col-lg-3">
          <div class="block-5 mb-5">
            <h3 class="footer-heading mb-4">Contact Info</h3>
            <ul class="list-unstyled">
              <li class="address">203 Fake St. Mountain View, San Francisco, California, USA</li>
              <li class="phone"><a href="tel://23923929210">+2 392 3929 210</a></li>
              <li class="email">emailaddress@domain.com</li>
            </ul>
          </div>
        </div>
      </div>
      <div class="row pt-5 mt-5 text-center">
        <div class="col-md-12">
          <p>
            Copyright &copy; <script>document.write(new Date().getFullYear());</script>
            All rights reserved | This template is made with
            <i class="icon-heart text-danger" aria-hidden="true"></i> by
            <a href="https://colorlib.com" target="_blank" class="text-primary">Colorlib</a>
          </p>
        </div>
      </div>
    </div>
  </footer>

</div>

<script src="js/jquery-3.3.1.min.js"></script>
<script src="js/jquery-ui.js"></script>
<script src="js/popper.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/owl.carousel.min.js"></script>
<script src="js/jquery.magnific-popup.min.js"></script>
<script src="js/aos.js"></script>
<script src="js/main.js"></script>
</body>
</html>
