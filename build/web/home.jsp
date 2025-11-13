<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    response.setCharacterEncoding("UTF-8");
%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <base href="${cpath}/">

        <title>Pharmative - Dược phẩm chính hãng</title>

        <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="fonts/icomoon/style.css">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/magnific-popup.css">
        <link rel="stylesheet" href="css/jquery-ui.css">
        <link rel="stylesheet" href="css/owl.carousel.min.css">
        <link rel="stylesheet" href="css/owl.theme.default.min.css">
        <link rel="stylesheet" href="css/aos.css">
        <link rel="stylesheet" href="css/style.css">

        <style>
            :root {
                --primary-color: #2e7d32;
                --primary-light: #4caf50;
                --primary-dark: #1b5e20;
                --accent-color: #8bc34a;
                --text-dark: #1a1a1a;
                --text-light: #666;
                --bg-light: #f8f9fa;
                --white: #ffffff;
                --border-radius: 8px;
                --box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
                --transition: all 0.3s ease;
            }

            body {
                font-family: 'Nunito', sans-serif;
                color: var(--text-dark);
                line-height: 1.6;
            }

            .text-primary {
                color: var(--primary-color) !important;
            }

            .btn-primary {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
                border-radius: 30px;
                padding: 12px 30px;
                font-weight: 600;
                transition: var(--transition);
            }

            .btn-primary:hover {
                background-color: var(--primary-dark);
                border-color: var(--primary-dark);
                transform: translateY(-2px);
                box-shadow: 0 6px 15px rgba(46, 125, 50, 0.3);
            }

            /* Hero Section */
            .site-blocks-cover {
                padding: 100px 0;
                position: relative;
                overflow: hidden;
            }

            .site-blocks-cover::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: rgba(0, 0, 0, 0.4);
                z-index: 1;
            }

            .site-blocks-cover .container {
                position: relative;
                z-index: 2;
            }

            .site-block-cover-content h1 {
                font-size: 3rem;
                font-weight: 700;
                margin-bottom: 20px;
                text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.3);
            }

            .site-block-cover-content p {
                font-size: 1.2rem;
                margin-bottom: 30px;
                max-width: 600px;
                margin-left: auto;
                margin-right: auto;
            }

            /* Features Section */
            .features-section {
                padding: 0px 0;
                background-color: var(--bg-light);
            }

            .feature-card {
                background: var(--white);
                border-radius: var(--border-radius);
                padding: 30px 20px;
                text-align: center;
                box-shadow: var(--box-shadow);
                transition: var(--transition);
                height: 100%;
            }

            .feature-card:hover {
                transform: translateY(-10px);
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            }

            .feature-card img {
                width: 80px;
                height: 80px;
                object-fit: contain;
                margin-bottom: 20px;
            }

            .feature-card h4 {
                font-weight: 700;
                margin-bottom: 15px;
                color: var(--primary-dark);
            }

            /* Product Section */
            .product-section {
                padding: 80px 0;
            }

            .section-title {
                position: relative;
                margin-bottom: 50px;
                text-align: center;
            }

            .section-title h2 {
                font-weight: 700;
                display: inline-block;
                position: relative;
            }

            .section-title h2::after {
                content: '';
                position: absolute;
                width: 70px;
                height: 3px;
                background: var(--primary-color);
                bottom: -10px;
                left: 50%;
                transform: translateX(-50%);
            }

            .product-card {
                background: var(--white);
                border-radius: var(--border-radius);
                overflow: hidden;
                box-shadow: var(--box-shadow);
                transition: var(--transition);
                margin-bottom: 30px;
                height: 100%;
            }

            .product-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            }

            .product-image {
                height: 250px;
                overflow: hidden;
            }

            .product-image img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                transition: var(--transition);
            }

            .product-card:hover .product-image img {
                transform: scale(1.05);
            }

            .product-info {
                padding: 20px;
                text-align: center;
            }

            .product-info h3 {
                font-size: 1.2rem;
                font-weight: 600;
                margin-bottom: 10px;
            }

            .product-info h3 a {
                color: var(--text-dark);
                text-decoration: none;
                transition: var(--transition);
            }

            .product-info h3 a:hover {
                color: var(--primary-color);
            }

            .price {
                font-weight: 700;
                color: var(--primary-color);
                font-size: 1.2rem;
            }

            /* Testimonials */
            .testimonials-section {
                padding: 0px 0;
                background-color: var(--bg-light);
            }

            .testimonial-card {
                background: var(--white);
                border-radius: var(--border-radius);
                padding: 30px;
                box-shadow: var(--box-shadow);
                margin: 15px;
                position: relative;
            }

            .testimonial-card::before {
                content: '"';
                position: absolute;
                top: 10px;
                left: 20px;
                font-size: 60px;
                color: var(--primary-light);
                opacity: 0.2;
                font-family: Georgia, serif;
            }

            .testimonial-card blockquote {
                border: none;
                padding: 0;
                margin-bottom: 20px;
            }

            .testimonial-card img {
                width: 150px !important;
                height: 300px;
                border-radius: 50%;
                object-fit: cover;
                object-position: center top;
                margin-right: 20px;
                float: left;
                border: 3px solid var(--primary-light);
            }

            .testimonial-card p {
                margin-bottom: 0;
            }

            .testimonial-card .author {
                clear: both;
                padding-top: 15px;
                font-weight: 600;
                color: var(--primary-dark);
            }

            /* Why Us Section */
            .why-us-section {
                padding: 0px 0;
            }

            .step-number {
                margin-bottom: 30px;
                align-items: flex-start;
            }

            .step-number span {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                width: 40px;
                height: 60px;
                background: var(--primary-color);
                color: white;
                border-radius: 50%;
                font-weight: 700;
                margin-right: 15px;
                flex-shrink: 0;
            }

            .step-number p {
                margin: 0;
                padding-top: 8px;
            }

            /* Pagination */
            .pagination .page-link {
                color: var(--primary-color);
                border: 1px solid #dee2e6;
            }

            .pagination .page-item.active .page-link {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
            }

            /* Responsive */
            @media (max-width: 768px) {
                .site-block-cover-content h1 {
                    font-size: 2rem;
                }

                .site-block-cover-content p {
                    font-size: 1rem;
                }

                .feature-card, .product-card {
                    margin-bottom: 20px;
                }
            }
        </style>
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico">
    </head>

    <body>
        <jsp:include page="/common/headerChinh.jsp" />
        <div class="site-wrap">

            <!-- Hero Section -->
            <div class="owl-carousel owl-single px-0">
                <div class="site-blocks-cover overlay" style="background-image: url('${cpath}/images/hero_bg.jpg');">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-12 mx-auto align-self-center text-center">
                                <div class="site-block-cover-content">
                                    <h1 class="mb-3"><strong class="text-primary">Dược Phẩm Pharmative</strong> Mở cửa 24/7</h1>
                                    <p>Sức khỏe toàn diện – Sản phẩm chính hãng, tư vấn miễn phí bởi dược sĩ chuyên môn.</p>
                                    <p><a href="${cpath}/shop" class="btn btn-primary px-5 py-3">🟢 ĐẶT HÀNG NGAY</a></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="site-blocks-cover overlay" style="background-image: url('${cpath}/images/hero_bg_2.jpg');">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-12 mx-auto align-self-center text-center">
                                <div class="site-block-cover-content">
                                    <h1 class="mb-3">Dược phẩm chất lượng <strong class="text-primary">cho mọi nhà</strong></h1>
                                    <p>Bảo vệ sức khỏe – Nâng cao chất lượng cuộc sống cùng sản phẩm chính hãng, an toàn.</p>
                                    <p><a href="${cpath}/shop" class="btn btn-primary px-5 py-3">🟢 ĐẶT HÀNG NGAY</a></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>



            <!-- Sản phẩm hot -->
            <div class="product-section bg-light">
                <div class="container">
                    <div class="section-title">
                        <h2>🔥 <strong class="text-primary">Sản phẩm hot</strong></h2>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <div class="nonloop-block-3 owl-carousel">
                                <c:forEach var="p" items="${hot}">
                                    <div class="product-card">
                                        <div class="product-image">
                                            <a href="${cpath}/product-detail?id=${p.productId}">
                                                <img src="${cpath}/${p.imageUrl}" alt="${p.productName}">
                                            </a>
                                        </div>
                                        <div class="product-info">
                                            <h3 class="text-dark">
                                                <a href="${cpath}/product-detail?id=${p.productId}">${p.productName}</a>
                                            </h3>
                                            <p class="price"><fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫"/></p>
                                        </div>
                                    </div>
                                </c:forEach>

                                <c:if test="${empty hot}">
                                    <div class="text-center">
                                        <h5>Tạm thời chưa có sản phẩm hot</h5>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Thực phẩm chức năng -->
            <div class="product-section">
                <div class="container">
                    <div class="section-title">
                        <h2><strong class="text-primary">Thực phẩm chức năng</strong></h2>
                    </div>

                    <div class="row">
                        <c:forEach var="p" items="${products}">
                            <div class="col-12 col-md-6 col-lg-4">
                                <div class="product-card">
                                    <div class="product-image">
                                        <a href="${cpath}/product-detail?id=${p.productId}">
                                            <img src="${cpath}/${p.imageUrl}" alt="${p.productName}">
                                        </a>
                                    </div>
                                    <div class="product-info">
                                        <h3 class="text-dark">
                                            <a href="${cpath}/product-detail?id=${p.productId}">${p.productName}</a>
                                        </h3>
                                        <p class="price"><fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫"/></p>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>

                        <c:if test="${empty products}">
                            <div class="col-12 text-center">
                                <div class="alert alert-info">Chưa có sản phẩm.</div>
                            </div>
                        </c:if>
                    </div>

                    <!-- Phân trang -->
                    <nav aria-label="pagination" class="mt-5">
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

            <!-- Features Section -->
            <div class="features-section">
                <div class="container">
                    <div class="row">
                        <div class="col-md-4 mb-4">
                            <div class="feature-card">
                                <img src="${cpath}/images/freeship.jpg" alt="Miễn phí vận chuyển">
                                <h4>Miễn phí vận chuyển</h4>
                                <p>Theo chính sách giao hàng cho đơn hàng từ 500.000đ trở lên.</p>
                            </div>
                        </div>
                        <div class="col-md-4 mb-4">
                            <div class="feature-card">
                                <img src="${cpath}/images/uytin.jpg" alt="Cam kết chất lượng">
                                <h4>Cam kết 100%</h4>
                                <p>Chất lượng sản phẩm chính hãng, có nguồn gốc rõ ràng.</p>
                            </div>
                        </div>
                        <div class="col-md-4 mb-4">
                            <div class="feature-card">
                                <img src="${cpath}/images/thuocchinhhang.jpg" alt="Đa dạng sản phẩm">
                                <h4>Đa dạng sản phẩm</h4>
                                <p>Chuyên sâu và an toàn cho sức khỏe với hơn 1000 sản phẩm.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Testimonials + Why us -->
            <div class="container">
                <div class="row justify-content-between mt-5 mb-5">

                    <!-- Cột trái: Chuyên gia -->
                    <div class="col-lg-6">
                        <div class="section-title">
                            <h2><strong class="text-primary">Chuyên gia tư vấn</strong></h2>
                        </div>
                        <div class="testimonials-section">
                            <div class="owl-single no-direction owl-carousel">
                                <div class="testimonial-card">
                                    <blockquote>
                                        <img src="${cpath}/images/person_1.jpg" alt="Dược sĩ Nguyễn Tiến Sơn">
                                        <p>"Sử dụng thực phẩm chức năng đúng cách giúp tăng cường sức khỏe và phòng ngừa bệnh tật. Luôn tham khảo ý kiến dược sĩ trước khi sử dụng."</p>
                                    </blockquote>
                                    <p class="author">— DS. Nguyễn Tiến Sơn</p>
                                </div>
                                <div class="testimonial-card">
                                    <blockquote>
                                        <img src="${cpath}/images/person_2.jpg" alt="Dược sĩ Vũ Văn Nam">
                                        <p>"Cung cấp sản phẩm chính hãng, đảm bảo an toàn và phù hợp với mọi lứa tuổi. Chúng tôi cam kết chất lượng từng sản phẩm."</p>
                                    </blockquote>
                                    <p class="author">— DS. Vũ Văn Nam</p>
                                </div>
                                <div class="testimonial-card">
                                    <blockquote>
                                        <img src="${cpath}/images/anhThe.png" alt="Dược sĩ Giang Minh Quân">
                                        <p>"Chế độ bổ sung dinh dưỡng hợp lý giúp cơ thể khỏe mạnh, tăng sức đề kháng tự nhiên. Tư vấn miễn phí 24/7."</p>
                                    </blockquote>
                                    <p class="author">— DS. Giang Minh Quân</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Cột phải: Tại sao chọn chúng tôi -->
                    <div class="col-lg-5">
                        <div class="why-us-section">
                            <div class="section-title">
                                <h2 class="mb-4">🌿 Tại sao nên chọn <strong class="text-primary">Chúng tôi</strong>?</h2>
                            </div>
                            <div class="step-number d-flex mb-4">
                                <span>1</span>
                                <p>Tư vấn bởi đội ngũ dược sĩ chuyên nghiệp – phục vụ 24/7</p>
                            </div>
                            <div class="step-number d-flex mb-4">
                                <span>2</span>
                                <p>Luôn bên bạn – vì sức khỏe cộng đồng</p>
                            </div>
                            <div class="step-number d-flex mb-4">
                                <span>3</span>
                                <p>Kiểm định chất lượng nghiêm ngặt, nguồn gốc rõ ràng</p>
                            </div>
                            <div class="step-number d-flex mb-4">
                                <span>4</span>
                                <p>Ưu đãi hấp dẫn dành cho khách hàng thân thiết</p>
                            </div>
                            <div class="step-number d-flex mb-4">
                                <span>5</span>
                                <p>Giao hàng nhanh chóng, đóng gói cẩn thận</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <jsp:include page="/common/footerChinh.jsp" />
        </div>

        <!-- JS -->
        <script src="${cpath}/js/jquery-3.3.1.min.js"></script>
        <script src="${cpath}/js/jquery-ui.js"></script>
        <script src="${cpath}/js/popper.min.js"></script>
        <script src="${cpath}/js/bootstrap.min.js"></script>
        <script src="${cpath}/js/owl.carousel.min.js"></script>
        <script src="${cpath}/js/jquery.magnific-popup.min.js"></script>
        <script src="${cpath}/js/aos.js"></script>
        <script src="${cpath}/js/main.js"></script>

        <script>
            $(document).ready(function () {
                // Khởi tạo carousel
                $('.owl-carousel').owlCarousel({
                    loop: true,
                    margin: 30,
                    nav: true,
                    dots: false,
                    responsive: {
                        0: {
                            items: 1
                        },
                        600: {
                            items: 2
                        },
                        1000: {
                            items: 3
                        }
                    }
                });

                // Hero carousel
                $('.owl-single').owlCarousel({
                    loop: true,
                    autoplay: true,
                    autoplayTimeout: 5000,
                    autoplayHoverPause: true,
                    items: 1,
                    nav: true,
                    dots: true
                });

                // Testimonial carousel
                $('.no-direction').owlCarousel({
                    loop: true,
                    autoplay: true,
                    autoplayTimeout: 4000,
                    items: 1,
                    nav: false,
                    dots: true
                });
            });
        </script>
    </body>
</html>