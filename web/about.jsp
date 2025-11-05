<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="cpath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Về Pharmative</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico">
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

            <!-- Header -->
            <jsp:include page="/common/headerChinh.jsp" />

            <div class="site-blocks-cover overlay" style="background-image: url('images/hero_bg_2.jpg');">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12 mx-auto align-self-center">
                            <div class="site-block-cover-content text-center">
                                <h1 class="mb-0">Về <strong class="text-primary">Pharmative</strong></h1>
                                <div class="row justify-content-center mb-5"> 
                                    <div class="col-lg-6 text-center">
                                        <p>Pharmative là thương hiệu cung cấp các sản phẩm chăm sóc sức khỏe, vitamin và thực phẩm bổ sung đáng tin cậy, giúp bạn và gia đình luôn khỏe mạnh, tràn đầy năng lượng mỗi ngày.</p>
                                    </div>
                                </div>
                                <p>
                                    <a href="${cpath}/shop" class="btn btn-primary px-5 py-3">Mua sắm ngay</a>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Why Us / History / Awards -->
            <div class="site-section py-5" data-aos="fade">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-4">
                            <h3 class="text-black h4">Tại sao chọn chúng tôi</h3>
                            <p>Chúng tôi cam kết mang đến sản phẩm chính hãng, an toàn và được kiểm định chất lượng kỹ lưỡng. Pharmative đồng hành cùng sức khỏe của bạn trên mọi chặng đường.</p>
                        </div>
                        <div class="col-lg-4">
                            <h3 class="text-black h4">Lịch sử hình thành</h3>
                            <p>Pharmative được thành lập với sứ mệnh nâng cao chất lượng cuộc sống thông qua các sản phẩm chăm sóc sức khỏe tự nhiên. Chúng tôi luôn nỗ lực không ngừng để phục vụ tốt hơn mỗi ngày.</p>
                        </div>
                        <div class="col-lg-4">
                            <h3 class="text-black h4">Thành tựu đạt được</h3>
                            <p>Pharmative tự hào được hàng nghìn khách hàng tin tưởng lựa chọn và nhận nhiều chứng nhận về an toàn, chất lượng từ các tổ chức uy tín trong và ngoài nước.</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Leadership -->
            <div class="site-section bg-light custom-border-bottom" data-aos="fade">
                <div class="container">
                    <div class="row justify-content-center mb-5">
                        <div class="title-section text-center col-md-7">
                            <h2>Đội ngũ <strong class="text-primary">Lãnh đạo</strong></h2>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 col-lg-4 mb-5">
                            <div class="block-38 text-center">
                                <div class="block-38-header">
                                    <img src="images/person_1.jpg" alt="Ảnh CEO" class="mb-4">
                                    <h3 class="block-38-heading h4">Elizabeth Graham</h3>
                                    <p class="block-38-subheading">Giám đốc điều hành / Nhà sáng lập</p>
                                </div>
                                <div class="block-38-body">
                                    <p>Với hơn 15 năm kinh nghiệm trong lĩnh vực dược phẩm, bà Elizabeth luôn đặt chất lượng và sức khỏe người tiêu dùng lên hàng đầu trong mọi chiến lược phát triển của Pharmative.</p>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6 col-lg-4 mb-5">
                            <div class="block-38 text-center">
                                <div class="block-38-header">
                                    <img src="images/person_2.jpg" alt="Ảnh Co-founder" class="mb-4">
                                    <h3 class="block-38-heading h4">Jennifer Greive</h3>
                                    <p class="block-38-subheading">Đồng sáng lập</p>
                                </div>
                                <div class="block-38-body">
                                    <p>Bà Jennifer là người định hướng chiến lược phát triển bền vững, cam kết mang lại các sản phẩm thân thiện với môi trường và tốt cho sức khỏe cộng đồng.</p>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6 col-lg-4 mb-5">
                            <div class="block-38 text-center">
                                <div class="block-38-header">
                                    <img src="images/person_3.jpg" alt="Ảnh Marketing" class="mb-4">
                                    <h3 class="block-38-heading h4">Patrick Marx</h3>
                                    <p class="block-38-subheading">Giám đốc Marketing</p>
                                </div>
                                <div class="block-38-body">
                                    <p>Anh Patrick là người đứng sau những chiến dịch truyền thông sáng tạo, giúp đưa hình ảnh Pharmative đến gần hơn với khách hàng Việt Nam.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Sign up -->
            <div class="site-section bg-image overlay" style="background-image: url('images/hero_bg_2.jpg');">
                <div class="container">
                    <div class="row justify-content-center text-center">
                        <div class="col-lg-7">
                            <h3 class="text-white">Đăng ký nhận ưu đãi hấp dẫn</h3>
                            <p class="text-white">Hãy để lại email của bạn để nhận thông tin sản phẩm mới và các lời khuyên hữu ích về chăm sóc sức khỏe từ Pharmative.</p>
                            <p class="mb-0"><a href="#" class="btn btn-outline-white">Đăng ký ngay</a></p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Footer -->
            <jsp:include page="/common/footerChinh.jsp" />
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
