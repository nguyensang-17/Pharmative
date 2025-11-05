<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    response.setCharacterEncoding("UTF-8");
%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="vi">

    <head>
        <title>Liên hệ | Pharmative</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico">

        <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="fonts/icomoon/style.css">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="fonts/flaticon/font/flaticon.css">
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
                background-color: var(--bg-light);
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

            .contact-container {
                max-width: 1200px;
                margin: 40px auto;
                padding: 0 15px;
            }

            .contact-card {
                background: var(--white);
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                overflow: hidden;
                margin-bottom: 30px;
            }

            .contact-header {
                padding: 25px 30px;
                border-bottom: 1px solid #eee;
                background-color: #f8f9fa;
            }

            .contact-body {
                padding: 30px;
            }

            .form-group {
                margin-bottom: 25px;
            }

            .form-label {
                font-weight: 600;
                margin-bottom: 8px;
                color: var(--text-dark);
            }

            .form-control {
                border-radius: var(--border-radius);
                padding: 12px 15px;
                border: 1px solid #ddd;
                transition: var(--transition);
            }

            .form-control:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.2rem rgba(46, 125, 50, 0.25);
            }

            .contact-info-card {
                background: var(--white);
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                padding: 30px;
                height: 100%;
                transition: var(--transition);
            }

            .contact-info-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            }

            .contact-icon {
                width: 60px;
                height: 60px;
                border-radius: 50%;
                background-color: rgba(46, 125, 50, 0.1);
                display: flex;
                align-items: center;
                justify-content: center;
                margin-bottom: 20px;
                color: var(--primary-color);
                font-size: 24px;
            }

            .office-card {
                background: var(--white);
                border-radius: var(--border-radius);
                padding: 25px;
                box-shadow: var(--box-shadow);
                transition: var(--transition);
                height: 100%;
            }

            .office-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            }

            .alert-success {
                background-color: rgba(46, 125, 50, 0.1);
                border: 1px solid var(--primary-color);
                color: var(--primary-dark);
                border-radius: var(--border-radius);
                padding: 15px;
                margin-bottom: 25px;
            }

            .alert-danger {
                background-color: rgba(220, 53, 69, 0.1);
                border: 1px solid #dc3545;
                color: #dc3545;
                border-radius: var(--border-radius);
                padding: 15px;
                margin-bottom: 25px;
            }

            .section-title {
                position: relative;
                margin-bottom: 40px;
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

            @media (max-width: 768px) {
                .contact-container {
                    margin: 20px auto;
                }

                .contact-body {
                    padding: 20px;
                }

                .contact-info-card, .office-card {
                    margin-bottom: 20px;
                }
            }
        </style>
    </head>

    <body>
        <% String sent = request.getParameter("sent"); %>

        <jsp:include page="/common/headerChinh.jsp" />

        <div class="site-wrap">
            <!-- Breadcrumb -->
            <div class="bg-light py-3">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 mb-0">
                            <a href="${cpath}/home">Trang chủ</a> <span class="mx-2 mb-0">/</span>
                            <strong class="text-black">Liên hệ</strong>
                        </div>
                    </div>
                </div>
            </div>

            <div class="contact-container">
                <!-- Thông báo -->
                <% if ("1".equals(sent)) { %>
                <div class="alert-success">
                    <i class="icon-check"></i> Đã gửi email ưu đãi & CSKH thành công! Vui lòng kiểm tra hộp thư.
                </div>
                <% } else if ("0".equals(sent)) { %>
                <div class="alert-danger">
                    <i class="icon-warning"></i> Gửi email thất bại. Vui lòng thử lại sau.
                </div>
                <% }%>

                <!-- Thông tin liên hệ -->
                <div class="row mb-5">
                    <div class="col-md-4 mb-4">
                        <div class="contact-info-card">
                            <div class="contact-icon">
                                <i class="icon-phone"></i>
                            </div>
                            <h4>Điện thoại</h4>
                            <p class="text-muted mb-2">Hỗ trợ 24/7</p>
                            <h5 class="text-primary">+84 123 456 789</h5>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="contact-info-card">
                            <div class="contact-icon">
                                <i class="icon-envelope"></i>
                            </div>
                            <h4>Email</h4>
                            <p class="text-muted mb-2">Phản hồi trong 24h</p>
                            <h5 class="text-primary">cskh@pharmative.com</h5>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="contact-info-card">
                            <div class="contact-icon">
                                <i class="icon-map-marker"></i>
                            </div>
                            <h4>Địa chỉ</h4>
                            <p class="text-muted mb-2">Làm việc: 8:00 - 22:00</p>
                            <h5 class="text-primary">Hà Nội, Việt Nam</h5>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-8 mb-5">
                        <div class="contact-card">
                            <div class="contact-header">
                                <h2 class="mb-0">Gửi tin nhắn cho chúng tôi</h2>
                                <p class="mb-0 text-muted">Chúng tôi luôn sẵn sàng hỗ trợ bạn</p>
                            </div>
                            <div class="contact-body">
                                <form action="${cpath}/contact/send" method="post">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="c_fname" class="form-label">Họ <span class="text-danger">*</span></label>
                                                <input type="text" class="form-control" id="c_fname" name="c_fname" required>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="c_lname" class="form-label">Tên <span class="text-danger">*</span></label>
                                                <input type="text" class="form-control" id="c_lname" name="c_lname" required>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="c_email" class="form-label">Email <span class="text-danger">*</span></label>
                                        <input type="email" class="form-control" id="c_email" name="c_email" required>
                                    </div>

                                    <div class="form-group">
                                        <label for="c_subject" class="form-label">Tiêu đề</label>
                                        <input type="text" class="form-control" id="c_subject" name="c_subject" placeholder="Tiêu đề tin nhắn của bạn">
                                    </div>

                                    <div class="form-group">
                                        <label for="c_message" class="form-label">Nội dung tin nhắn</label>
                                        <textarea name="c_message" id="c_message" cols="30" rows="7" class="form-control" placeholder="Xin vui lòng mô tả chi tiết yêu cầu của bạn..."></textarea>
                                    </div>

                                    <div class="form-group">
                                        <button type="submit" class="btn btn-primary btn-lg w-100">
                                            <i class="icon-paper-plane"></i> Gửi tin nhắn
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-4">
                        <div class="contact-card">
                            <div class="contact-header">
                                <h2 class="mb-0">Thông tin liên hệ</h2>
                                <p class="mb-0 text-muted">Kết nối với chúng tôi</p>
                            </div>
                            <div class="contact-body">
                                <div class="mb-4">
                                    <h5 class="text-primary mb-3">Pharmative Company</h5>
                                    <p class="text-muted mb-2">
                                        <i class="icon-map-marker text-primary mr-2"></i>
                                        218 Lĩnh Nam, Vĩnh Hưng<br>
                                        Hà Nội, Việt Nam
                                    </p>
                                    <p class="text-muted mb-2">
                                        <i class="icon-phone text-primary mr-2"></i>
                                        +84 123 456 789
                                    </p>
                                    <p class="text-muted mb-0">
                                        <i class="icon-envelope text-primary mr-2"></i>
                                        info@pharmative.com
                                    </p>
                                </div>

                                <div class="mb-4">
                                    <h5 class="text-primary mb-3">Giờ làm việc</h5>
                                    <p class="text-muted mb-1">Thứ 2 - Thứ 6: 8:00 - 22:00</p>
                                    <p class="text-muted mb-1">Thứ 7: 8:00 - 18:00</p>
                                    <p class="text-muted mb-0">Chủ nhật: 8:00 - 12:00</p>
                                </div>

                                <div>
                                    <h5 class="text-primary mb-3">Theo dõi chúng tôi</h5>
                                    <div class="d-flex gap-3">
                                        <a href="#" class="text-primary" style="font-size: 1.5rem;">
                                            <i class="icon-facebook">  </i>
                                        </a> 
                                        <a href="#" class="text-primary" style="font-size: 1.5rem;">
                                            <i class="icon-twitter">  </i>
                                        </a> 
                                        <a href="#" class="text-primary" style="font-size: 1.5rem;">
                                            <i class="icon-instagram">  </i>
                                        </a> 
                                        <a href="#" class="text-primary" style="font-size: 1.5rem;">
                                            <i class="icon-youtube-play">  </i>
                                        </a> 
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Văn phòng -->
                <div class="row mt-5">
                    <div class="col-12">
                        <div class="section-title">
                            <h2><strong class="text-primary">Hệ thống văn phòng</strong></h2>
                        </div>
                    </div>
                    <div class="col-lg-4 mb-4">
                        <div class="office-card">
                            <div class="contact-icon">
                                <i class="icon-map-marker"></i>
                            </div>
                            <h4 class="text-primary mb-3">Hà Nội</h4>
                            <p class="text-muted mb-0">
                                Tòa nhà Pharmative<br>
                                218 Lĩnh Nam, Vĩnh Hưng<br>
                                Hà Nội, Việt Nam<br>
                                ĐT: +84 123 456 789
                            </p>
                        </div>
                    </div>
                    <div class="col-lg-4 mb-4">
                        <div class="office-card">
                            <div class="contact-icon">
                                <i class="icon-map-marker"></i>
                            </div>
                            <h4 class="text-primary mb-3">TP. Hồ Chí Minh</h4>
                            <p class="text-muted mb-0">
                                Tòa nhà Pharmative<br>
                                218 Lĩnh Nam, Vĩnh Hưng<br>
                                TP. Hồ Chí Minh, Việt Nam<br>
                                ĐT: +84 987 654 321
                            </p>
                        </div>
                    </div>
                    <div class="col-lg-4 mb-4">
                        <div class="office-card">
                            <div class="contact-icon">
                                <i class="icon-map-marker"></i>
                            </div>
                            <h4 class="text-primary mb-3">Đà Nẵng</h4>
                            <p class="text-muted mb-0">
                                Tòa nhà Pharmative<br>
                                218 Lĩnh Nam, Vĩnh Hưng<br>
                                Đà Nẵng, Việt Nam<br>
                                ĐT: +84 456 123 789
                            </p>
                        </div>
                    </div>
                </div>
            </div>

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