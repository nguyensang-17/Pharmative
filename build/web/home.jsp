<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
  // đảm bảo response UTF-8
  response.setCharacterEncoding("UTF-8");
%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <!-- ✅ DÒNG NÀY RẤT QUAN TRỌNG -->
  <base href="${cpath}/">

  <title>Pharmative</title>

  <!-- Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700&display=swap" rel="stylesheet">

  <!-- CSS (dùng đường dẫn tương đối, không cần ${cpath} nữa) -->
  <link rel="stylesheet" href="fonts/icomoon/style.css">
  <link rel="stylesheet" href="css/bootstrap.min.css">
  <link rel="stylesheet" href="css/magnific-popup.css">
  <link rel="stylesheet" href="css/jquery-ui.css">
  <link rel="stylesheet" href="css/owl.carousel.min.css">
  <link rel="stylesheet" href="css/owl.theme.default.min.css">
  <link rel="stylesheet" href="css/aos.css">
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
<jsp:include page="/common/headerChinh.jsp" />
<div class="site-wrap">


  <!-- Hero -->
  <div class="owl-carousel owl-single px-0">
    <div class="site-blocks-cover overlay" style="background-image: url('${cpath}/images/hero_bg.jpg');">
      <div class="container">
        <div class="row">
          <div class="col-lg-12 mx-auto align-self-center">
            <div class="site-block-cover-content text-center">
              <h1 class="mb-0"><strong class="text-primary">Thực phẩm chúc năng</strong> Mở cửa 24/7</h1>
              <div class="row justify-content-center mb-5">
                <div class="col-lg-6 text-center">
                  <p>Sức khỏe toàn diện – Phục vụ mọi lúc, mọi nơi.</p>
                  <p>  Sản phẩm chính hãng, tư vấn miễn phí 24/7.</p>
                </div>
              </div>
              <p><a href="${cpath}/shop.jsp" class="btn btn-primary px-5 py-3">🟢 ĐẶT HÀNG NGAY</a></p>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="site-blocks-cover overlay" style="background-image: url('${cpath}/images/hero_bg_2.jpg');">
      <div class="container">
        <div class="row">
          <div class="col-lg-12 mx-auto align-self-center">
            <div class="site-block-cover-content text-center">
              <h1 class="mb-0">Thực phẩm chức năng <strong class="text-primary">mới mỗi ngày</strong></h1>
              <div class="row justify-content-center mb-5">
                <div class="col-lg-6 text-center">
                  <p>Bảo vệ sức khỏe – Nâng cao chất lượng cuộc sống </p>
                  <p>    cùng sản phẩm chính hãng, an toàn.</p>
                </div>
              </div>
              <p><a href="${cpath}/shop.jsp" class="btn btn-primary px-5 py-3">🟢 ĐẶT HÀNG NGAY</a></p>
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
            <img src="${cpath}/images/freeship.jpg" alt="Image" class="img-fluid">
            <h3><a href="#">Miễn phí vẫn chuyển</a></h3>
            <p>Theo chính sách giao hàng.</p>
            <p><a href="#" class="d-flex align-items-center"><span class="mr-2">Tìm hiểu thêm</span> <span class="icon-keyboard_arrow_right"></span></a></p>
          </div>
        </div>
        <div class="col-lg-4">
          <div class="feature">
            <img src="${cpath}/images/uytin.jpg" alt="Image" class="img-fluid">
            <h3><a href="#">Cam kết 100%</a></h3>
            <p>Chất lượng sản phẩm.</p>
            <p><a href="#" class="d-flex align-items-center"><span class="mr-2">Tìm hiểu thêm</span> <span class="icon-keyboard_arrow_right"></span></a></p>
          </div>
        </div>
        <div class="col-lg-4">
          <div class="feature">
            <img src="${cpath}/images/thuocchinhhang.jpg" alt="Image" class="img-fluid">
            <h3><a href="#">Thuốc chính hãng</a></h3>
            <p>Đa dạng và chuyên sâu.</p>
            <p><a href="#" class="d-flex align-items-center"><span class="mr-2">Tìm hiểu thêm</span> <span class="icon-keyboard_arrow_right"></span></a></p>
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
          <h2><strong class="text-primary">Thực phẩm chức năng</strong></h2>
        </div>
      </div>

      <div class="row">
        <div class="col-md-12 block-3 products-wrap">
          <div class="nonloop-block-3 owl-carousel">

            <c:forEach var="p" items="${products}">
              <div class="text-center item mb-4 item-v2">
                <a href="${cpath}/product-detail?id=${p.productId}">
                  <img src="${cpath}/${p.imageUrl}" alt="${p.productName}">
                </a>
                <h3 class="text-dark">
                  <a href="${cpath}/product-detail?id=${p.productId}">${p.productName}</a>
                </h3>
                <p class="price">
                  <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫"/>
                </p>
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
            <a class="page-link" href="${cpath}/home?page=${page-1}">«</a>
          </li>
          <c:forEach var="i" begin="1" end="${totalPages}">
            <li class="page-item ${i==page?'active':''}">
              <a class="page-link" href="${cpath}/home?page=${i}">${i}</a>
            </li>
          </c:forEach>
          <li class="page-item ${page==totalPages?'disabled':''}">
            <a class="page-link" href="${cpath}/home?page=${page+1}">»</a>
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
                <a href="${cpath}/product-detail?id=${p.productId}">
                  <img src="${cpath}/${p.imageUrl}" alt="${p.productName}">
                </a>
                <h3 class="text-dark">
                  <a href="${cpath}/product-detail?id=${p.productId}">${p.productName}</a>
                </h3>
                <p class="price">
                  <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫"/>
                </p>
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
  <div class="site-section bg-image overlay" style="background-image: url('${cpath}/images/hero_bg_2.jpg');">
    <div class="container">
      <div class="row justify-content-center text-center">
        <div class="col-lg-7">
          <h3 class="text-white">🔥 Giảm ngay 38% cho đơn đầu tiên!</h3>
          <p class="text-white">Chỉ cần đăng ký tài khoản hôm nay – nhận ngay ưu đãi độc quyền.</p>
          <p class="mb-0"><a href="#" class="btn btn-outline-white">🟢 ĐĂNG KÝ NHẬN ƯU ĐÃI</a></p>
        </div>
      </div>
    </div>
  </div>

  <!-- Testimonials + Why us -->
<div class="site-section">
  <div class="container">
    <div class="row justify-content-between">
      
      <!-- Cột trái: Chăm sóc khách hàng -->
      <div class="col-lg-6">
        <div class="title-section">
          <h2><strong class="text-primary">Chuyên gia</strong></h2>
        </div>
        <div class="block-3 products-wrap">
          <div class="owl-single no-direction owl-carousel">
            <div class="testimony">
              <blockquote>
                <img src="${cpath}/images/person_1.jpg" alt="Image" class="img-fluid">
                <p>&ldquo;“Sử dụng thực phẩm chức năng đúng cách giúp tăng cường sức khỏe và phòng ngừa bệnh tật.”&rdquo;</p>
              </blockquote>
              <p class="author">&mdash; DS.Nguyễn Tiến Sơn</p>
            </div>
            <div class="testimony">
              <blockquote>
                <img src="${cpath}/images/person_2.jpg" alt="Image" class="img-fluid">
                <p>&ldquo;“Cung cấp sản phẩm chính hãng, đảm bảo an toàn và phù hợp với mọi lứa tuổi.”&rdquo;</p>
              </blockquote>
              <p class="author">&mdash; DS.Vũ Văn Nam</p>
            </div>
            <div class="testimony">
              <blockquote>
                <img src="${cpath}/images/person_3.jpg" alt="Image" class="img-fluid">
                <p>&ldquo;“Chế độ bổ sung dinh dưỡng hợp lý giúp cơ thể khỏe mạnh, tăng sức đề kháng tự nhiên.”&rdquo;</p>
              </blockquote>
              <p class="author">&mdash; DS.Giang Minh Quân</p>
            </div>
            <div class="testimony">
              <blockquote>
                <img src="${cpath}/images/person_4.jpg" alt="Image" class="img-fluid">
                <p>&ldquo;“Chúng tôi luôn tư vấn đúng sản phẩm – đúng nhu cầu – đúng sức khỏe cho khách hàng.”&rdquo;</p>
              </blockquote>
              <p class="author">&mdash; DS.Nguyễn Văn Sáng</p>
            </div>
          </div>
        </div>
      </div>

      <!-- Cột phải: Tại sao chọn chúng tôi -->
      <div class="col-lg-5">
  <div class="title-section">
    <h2 class="mb-5">🌿 Tại sao nên chọn <strong class="text-primary">Chúng tôi</strong>?</h2>
    <div class="step-number d-flex mb-4">
      <span>1</span><p>Tư vấn bởi đội ngũ dược sĩ chuyên nghiệp – phục vụ 24/7</p>
    </div>
    <div class="step-number d-flex mb-4">
      <span>2</span><p>Luôn bên bạn – vì sức khỏe cộng đồng.</p>
    </div>
    <div class="step-number d-flex mb-4">
      <span>3</span><p>Kiểm định chất lượng nghiêm ngặt</p>
    </div>
    <div class="step-number d-flex mb-4">
      <span>4</span><p>Ưu đãi hấp dẫn dành cho khách hàng mới</p>
    </div>
  </div>
</div>
<jsp:include page="/common/footerChinh.jsp" />
<!-- JS -->
<script src="${cpath}/js/jquery-3.3.1.min.js"></script>
<script src="${cpath}/js/jquery-ui.js"></script>
<script src="${cpath}/js/popper.min.js"></script>
<script src="${cpath}/js/bootstrap.min.js"></script>
<script src="${cpath}/js/owl.carousel.min.js"></script>
<script src="${cpath}/js/jquery.magnific-popup.min.js"></script>
<script src="${cpath}/js/aos.js"></script>
<script src="${cpath}/js/main.js"></script>
</body>
</html>
