<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <% response.setCharacterEncoding("UTF-8"); %>
                <c:set var="cpath" value="${pageContext.request.contextPath}" />

                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="utf-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
                    <base href="${cpath}/">

                    <title>Pharmative - Dược phẩm chính hãng</title>

                    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800&display=swap"
                        rel="stylesheet">
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
                            --text-dark: #2c3e50;
                            --text-light: #6c757d;
                            --bg-light: #f4f7f6;
                            --white: #ffffff;
                            --border-radius: 16px;
                            --box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
                            --transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
                        }

                        body {
                            font-family: 'Nunito', sans-serif;
                            color: var(--text-dark);
                            line-height: 1.7;
                            background-color: #fff;
                        }

                        h1,
                        h2,
                        h3,
                        h4,
                        h5,
                        h6 {
                            color: var(--text-dark);
                            font-weight: 700;
                        }

                        .text-primary {
                            color: var(--primary-color) !important;
                        }

                        .btn-primary {
                            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
                            border: none;
                            border-radius: 50px;
                            padding: 14px 36px;
                            font-weight: 700;
                            letter-spacing: 0.5px;
                            transition: var(--transition);
                            box-shadow: 0 4px 15px rgba(46, 125, 50, 0.3);
                        }

                        .btn-primary:hover {
                            background: linear-gradient(135deg, var(--primary-dark), var(--primary-color));
                            transform: translateY(-3px);
                            box-shadow: 0 8px 25px rgba(46, 125, 50, 0.4);
                        }

                        /* Hero Section */
                        .site-blocks-cover {
                            padding: 140px 0;
                            position: relative;
                            overflow: hidden;
                            background-size: cover;
                            background-position: center;
                            background-attachment: fixed;
                        }

                        .site-blocks-cover::before {
                            content: '';
                            position: absolute;
                            top: 0;
                            left: 0;
                            right: 0;
                            bottom: 0;
                            background: linear-gradient(to right, rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.3));
                            z-index: 1;
                        }

                        .site-blocks-cover .container {
                            position: relative;
                            z-index: 2;
                        }

                        .site-block-cover-content h1 {
                            font-size: 3.5rem;
                            font-weight: 800;
                            margin-bottom: 24px;
                            color: white;
                            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
                            animation: fadeInUp 1s ease-out;
                        }

                        .site-block-cover-content p {
                            font-size: 1.3rem;
                            margin-bottom: 36px;
                            color: rgba(255, 255, 255, 0.9);
                            max-width: 700px;
                            margin-left: auto;
                            margin-right: auto;
                            animation: fadeInUp 1s ease-out 0.2s backwards;
                        }

                        .site-block-cover-content .btn {
                            animation: fadeInUp 1s ease-out 0.4s backwards;
                        }

                        @keyframes fadeInUp {
                            from {
                                opacity: 0;
                                transform: translateY(30px);
                            }

                            to {
                                opacity: 1;
                                transform: translateY(0);
                            }
                        }

                        /* Features Section */
                        .features-section {
                            padding: 60px 0;
                            background-color: var(--white);
                            margin-top: -60px;
                            position: relative;
                            z-index: 10;
                        }

                        .feature-card {
                            background: var(--white);
                            border-radius: var(--border-radius);
                            padding: 40px 30px;
                            text-align: center;
                            box-shadow: var(--box-shadow);
                            transition: var(--transition);
                            height: 100%;
                            border: 1px solid rgba(0, 0, 0, 0.03);
                        }

                        .feature-card:hover {
                            transform: translateY(-15px);
                            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
                            border-color: var(--primary-light);
                        }

                        .feature-card h4 {
                            font-weight: 700;
                            margin-bottom: 16px;
                            color: var(--text-dark);
                        }

                        /* Product Section */
                        .product-section {
                            padding: 100px 0;
                        }

                        .bg-light {
                            background-color: var(--bg-light) !important;
                        }

                        .section-title {
                            margin-bottom: 60px;
                            text-align: center;
                        }

                        .section-title h2 {
                            font-size: 2.5rem;
                            font-weight: 800;
                            position: relative;
                            display: inline-block;
                            padding-bottom: 15px;
                        }

                        .section-title h2::after {
                            content: '';
                            position: absolute;
                            width: 80px;
                            height: 4px;
                            background: var(--primary-color);
                            bottom: 0;
                            left: 50%;
                            transform: translateX(-50%);
                            border-radius: 2px;
                        }

                        .product-card {
                            background: var(--white);
                            border-radius: var(--border-radius);
                            overflow: hidden;
                            box-shadow: var(--box-shadow);
                            transition: var(--transition);
                            margin-bottom: 30px;
                            height: 100%;
                            border: 1px solid rgba(0, 0, 0, 0.03);
                            position: relative;
                        }

                        .product-card:hover {
                            transform: translateY(-10px);
                            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.12);
                        }

                        .product-image {
                            height: 280px;
                            overflow: hidden;
                            position: relative;
                            background: #fff;
                            padding: 20px;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                        }

                        .product-image img {
                            max-width: 100%;
                            max-height: 100%;
                            object-fit: contain;
                            transition: var(--transition);
                        }

                        .product-card:hover .product-image img {
                            transform: scale(1.08);
                        }

                        .product-info {
                            padding: 25px;
                            text-align: center;
                            background: #fff;
                        }

                        .product-info h3 {
                            font-size: 1.1rem;
                            font-weight: 700;
                            margin-bottom: 12px;
                            line-height: 1.4;
                            height: 3.2em;
                            overflow: hidden;
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
                            font-weight: 800;
                            color: var(--primary-color);
                            font-size: 1.3rem;
                            margin-bottom: 0;
                        }

                        /* Testimonials */
                        .testimonials-section {
                            padding: 0;
                        }

                        .testimonial-card {
                            background: var(--white);
                            border-radius: var(--border-radius);
                            padding: 40px;
                            box-shadow: var(--box-shadow);
                            margin: 20px 10px;
                            position: relative;
                            border: 1px solid rgba(0, 0, 0, 0.03);
                        }

                        .testimonial-card:hover {
                            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.08);
                        }

                        .testimonial-card::before {
                            content: '"';
                            position: absolute;
                            top: 20px;
                            left: 30px;
                            font-size: 80px;
                            color: var(--primary-light);
                            opacity: 0.15;
                            font-family: Georgia, serif;
                            line-height: 1;
                        }

                        .testimonial-card blockquote {
                            border: none;
                            padding: 0;
                            margin-bottom: 24px;
                            position: relative;
                            z-index: 2;
                        }

                        .testimonial-card blockquote p {
                            font-style: italic;
                            font-size: 1.05rem;
                            color: var(--text-light);
                        }

                        .testimonial-user {
                            display: flex;
                            align-items: center;
                        }

                        .testimonial-user img {
                            width: 60px !important;
                            height: 60px;
                            border-radius: 50%;
                            object-fit: cover;
                            margin-right: 16px;
                            border: 2px solid var(--primary-light);
                        }

                        .testimonial-info h5 {
                            margin: 0;
                            font-size: 1rem;
                            font-weight: 700;
                            color: var(--text-dark);
                        }

                        .testimonial-info span {
                            font-size: 0.85rem;
                            color: var(--primary-color);
                            font-weight: 600;
                        }

                        /* Why Us Section */
                        .why-us-section {
                            padding: 20px;
                            background: var(--white);
                            border-radius: var(--border-radius);
                            box-shadow: var(--box-shadow);
                        }

                        .step-number {
                            margin-bottom: 24px;
                            align-items: center;
                            padding: 15px;
                            border-radius: 12px;
                            transition: var(--transition);
                        }

                        .step-number:hover {
                            background: var(--bg-light);
                            transform: translateX(10px);
                        }

                        .step-number span {
                            display: inline-flex;
                            align-items: center;
                            justify-content: center;
                            width: 44px;
                            height: 44px;
                            background: var(--primary-color);
                            color: white;
                            border-radius: 50%;
                            font-weight: 700;
                            margin-right: 20px;
                            flex-shrink: 0;
                            box-shadow: 0 4px 10px rgba(46, 125, 50, 0.3);
                        }

                        .step-number p {
                            margin: 0;
                            font-weight: 600;
                            color: var(--text-dark);
                            font-size: 1.05rem;
                        }

                        /* Pagination */
                        .pagination .page-link {
                            color: var(--text-dark);
                            border: none;
                            width: 40px;
                            height: 40px;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            border-radius: 50%;
                            margin: 0 5px;
                            font-weight: 700;
                            transition: var(--transition);
                        }

                        .pagination .page-item.active .page-link {
                            background-color: var(--primary-color);
                            color: white;
                            box-shadow: 0 4px 10px rgba(46, 125, 50, 0.3);
                        }

                        .pagination .page-link:hover:not(.active) {
                            background-color: var(--bg-light);
                            color: var(--primary-color);
                        }

                        /* Responsive */
                        @media (max-width: 768px) {
                            .site-blocks-cover {
                                padding: 100px 0;
                            }

                            .site-block-cover-content h1 {
                                font-size: 2.2rem;
                            }

                            .features-section {
                                margin-top: 0;
                                padding: 40px 0;
                            }

                            .feature-card,
                            .product-card {
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
                            <div class="site-blocks-cover overlay"
                                style="background-image: url('${cpath}/images/hero_bg.jpg');">
                                <div class="container">
                                    <div class="row">
                                        <div class="col-lg-12 mx-auto align-self-center text-center">
                                            <div class="site-block-cover-content">
                                                <h1 class="mb-3">Dược Phẩm <strong
                                                        class="text-primary">Pharmative</strong></h1>
                                                <p>Chăm sóc sức khỏe toàn diện với sản phẩm chính hãng và sự tư vấn tận
                                                    tâm từ đội ngũ dược sĩ chuyên môn.</p>
                                                <p>
                                                    <a href="${cpath}/shop" class="btn btn-primary">
                                                        <i class="fas fa-shopping-cart me-2"></i> MUA NGAY
                                                    </a>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="site-blocks-cover overlay"
                                style="background-image: url('${cpath}/images/hero_bg_2.jpg');">
                                <div class="container">
                                    <div class="row">
                                        <div class="col-lg-12 mx-auto align-self-center text-center">
                                            <div class="site-block-cover-content">
                                                <h1 class="mb-3">Chất Lượng <strong class="text-primary">Cho Mọi
                                                        Nhà</strong></h1>
                                                <p>Cam kết 100% thuốc và thực phẩm chức năng chính hãng, an toàn và hiệu
                                                    quả cho gia đình bạn.</p>
                                                <p>
                                                    <a href="${cpath}/shop" class="btn btn-primary">
                                                        <i class="fas fa-shopping-bag me-2"></i> KHÁM PHÁ NGAY
                                                    </a>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Features Section -->
                        <div class="features-section">
                            <div class="container">
                                <div class="row">
                                    <div class="col-md-4 mb-4">
                                        <div class="feature-card">
                                            <div class="text-primary mb-3">
                                                <i class="fas fa-shipping-fast fa-3x"></i>
                                            </div>
                                            <h4>Giao Hàng Nhanh</h4>
                                            <p>Miễn phí vận chuyển cho đơn hàng từ 500k. Giao hàng hỏa tốc trong nội
                                                thành.</p>
                                        </div>
                                    </div>
                                    <div class="col-md-4 mb-4">
                                        <div class="feature-card">
                                            <div class="text-primary mb-3">
                                                <i class="fas fa-shield-alt fa-3x"></i>
                                            </div>
                                            <h4>Cam Kết Chính Hãng</h4>
                                            <p>Sản phẩm 100% chính hãng, có hóa đơn và nguồn gốc xuất xứ rõ ràng.</p>
                                        </div>
                                    </div>
                                    <div class="col-md-4 mb-4">
                                        <div class="feature-card">
                                            <div class="text-primary mb-3">
                                                <i class="fas fa-user-md fa-3x"></i>
                                            </div>
                                            <h4>Dược Sĩ Tư Vấn</h4>
                                            <p>Đội ngũ dược sĩ chuyên môn cao sẵn sàng tư vấn sức khỏe miễn phí 24/7.
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Sản phẩm hot -->
                        <div class="product-section bg-light">
                            <div class="container">
                                <div class="section-title">
                                    <h2>Sản Phẩm <strong class="text-primary">Nổi Bật</strong></h2>
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
                                                        <h3>
                                                            <a
                                                                href="${cpath}/product-detail?id=${p.productId}">${p.productName}</a>
                                                        </h3>
                                                        <p class="price">
                                                            <fmt:formatNumber value="${p.price}" type="currency"
                                                                currencySymbol="₫" />
                                                        </p>
                                                    </div>
                                                </div>
                                            </c:forEach>

                                            <c:if test="${empty hot}">
                                                <div class="text-center w-100">
                                                    <h5 class="text-muted">Đang cập nhật sản phẩm nổi bật...</h5>
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
                                    <h2>Thực Phẩm <strong class="text-primary">Chức Năng</strong></h2>
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
                                                    <h3>
                                                        <a
                                                            href="${cpath}/product-detail?id=${p.productId}">${p.productName}</a>
                                                    </h3>
                                                    <p class="price">
                                                        <fmt:formatNumber value="${p.price}" type="currency"
                                                            currencySymbol="₫" />
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>

                                    <c:if test="${empty products}">
                                        <div class="col-12 text-center">
                                            <div class="alert alert-info">Chưa có sản phẩm nào.</div>
                                        </div>
                                    </c:if>
                                </div>

                                <!-- Phân trang -->
                                <nav aria-label="pagination" class="mt-5">
                                    <ul class="pagination justify-content-center">
                                        <li class="page-item ${page==1?'disabled':''}">
                                            <a class="page-link" href="${cpath}/home?page=${page-1}"><i
                                                    class="fas fa-chevron-left"></i></a>
                                        </li>
                                        <c:forEach var="i" begin="1" end="${totalPages}">
                                            <li class="page-item ${i==page?'active':''}">
                                                <a class="page-link" href="${cpath}/home?page=${i}">${i}</a>
                                            </li>
                                        </c:forEach>
                                        <li class="page-item ${page==totalPages?'disabled':''}">
                                            <a class="page-link" href="${cpath}/home?page=${page+1}"><i
                                                    class="fas fa-chevron-right"></i></a>
                                        </li>
                                    </ul>
                                </nav>
                            </div>
                        </div>

                        <!-- Testimonials + Why us -->
                        <div class="container">
                            <div class="row justify-content-between mt-5 mb-5">

                                <!-- Cột trái: Chuyên gia -->
                                <div class="col-lg-6">
                                    <div class="section-title text-start">
                                        <h2>Chuyên Gia <strong class="text-primary">Tư Vấn</strong></h2>
                                    </div>
                                    <div class="testimonials-section">
                                        <div class="owl-single no-direction owl-carousel">
                                            <div class="testimonial-card">
                                                <blockquote>
                                                    <p>"Sử dụng thực phẩm chức năng đúng cách giúp tăng cường sức khỏe
                                                        và phòng ngừa bệnh tật. Luôn tham khảo ý kiến dược sĩ trước khi
                                                        sử dụng."</p>
                                                </blockquote>
                                                <div class="testimonial-user">
                                                    <img src="${cpath}/images/person_1.jpg"
                                                        alt="Dược sĩ Nguyễn Tiến Sơn">
                                                    <div class="testimonial-info">
                                                        <h5>Nguyễn Tiến Sơn</h5>
                                                        <span>Dược sĩ Chuyên khoa I</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="testimonial-card">
                                                <blockquote>
                                                    <p>"Cung cấp sản phẩm chính hãng, đảm bảo an toàn và phù hợp với mọi
                                                        lứa tuổi. Chúng tôi cam kết chất lượng từng sản phẩm."</p>
                                                </blockquote>
                                                <div class="testimonial-user">
                                                    <img src="${cpath}/images/person_2.jpg" alt="Dược sĩ Vũ Văn Nam">
                                                    <div class="testimonial-info">
                                                        <h5>Vũ Văn Nam</h5>
                                                        <span>Dược sĩ Lâm sàng</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="testimonial-card">
                                                <blockquote>
                                                    <p>"Chế độ bổ sung dinh dưỡng hợp lý giúp cơ thể khỏe mạnh, tăng sức
                                                        đề kháng tự nhiên. Tư vấn miễn phí 24/7."</p>
                                                </blockquote>
                                                <div class="testimonial-user">
                                                    <img src="${cpath}/images/anhThe.png" alt="Dược sĩ Giang Minh Quân">
                                                    <div class="testimonial-info">
                                                        <h5>Giang Minh Quân</h5>
                                                        <span>Dược sĩ Trưởng</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Cột phải: Tại sao chọn chúng tôi -->
                                <div class="col-lg-5">
                                    <div class="why-us-section">
                                        <div class="section-title text-start">
                                            <h2 class="mb-4">Tại Sao Chọn <strong class="text-primary">Chúng
                                                    Tôi</strong>?</h2>
                                        </div>
                                        <div class="step-number d-flex mb-4">
                                            <span><i class="fas fa-user-md"></i></span>
                                            <p>Tư vấn bởi đội ngũ dược sĩ chuyên nghiệp – phục vụ 24/7</p>
                                        </div>
                                        <div class="step-number d-flex mb-4">
                                            <span><i class="fas fa-heart"></i></span>
                                            <p>Luôn bên bạn – vì sức khỏe cộng đồng</p>
                                        </div>
                                        <div class="step-number d-flex mb-4">
                                            <span><i class="fas fa-check-circle"></i></span>
                                            <p>Kiểm định chất lượng nghiêm ngặt, nguồn gốc rõ ràng</p>
                                        </div>
                                        <div class="step-number d-flex mb-4">
                                            <span><i class="fas fa-gift"></i></span>
                                            <p>Ưu đãi hấp dẫn dành cho khách hàng thân thiết</p>
                                        </div>
                                        <div class="step-number d-flex mb-4">
                                            <span><i class="fas fa-shipping-fast"></i></span>
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