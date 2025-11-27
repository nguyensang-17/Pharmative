<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <c:set var="cpath" value="${pageContext.request.contextPath}" />

        <style>
            .site-footer {
                background: #1a1a1a !important;
                color: #b0b0b0 !important;
                padding: 80px 0 30px !important;
                margin-top: 80px;
                width: 100% !important;
                max-width: 100% !important;
                font-family: 'Nunito', sans-serif;
                position: relative;
                overflow: hidden;
            }

            /* Decorative top border */
            .site-footer::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 4px;
                background: linear-gradient(90deg, #2e7d32, #4caf50, #81c784, #2e7d32);
            }

            .site-footer .footer-heading {
                color: #fff !important;
                font-weight: 800;
                margin-bottom: 25px;
                font-size: 1.1rem;
                letter-spacing: 0.5px;
                position: relative;
                display: inline-block;
            }

            .site-footer .footer-heading::after {
                content: '';
                display: block;
                width: 40px;
                height: 3px;
                background: #4caf50;
                margin-top: 10px;
                border-radius: 2px;
            }

            .site-footer .member-card {
                background: rgba(255, 255, 255, 0.03);
                border-radius: 12px;
                padding: 20px;
                margin-bottom: 20px;
                border: 1px solid rgba(255, 255, 255, 0.05);
                transition: all 0.3s ease;
            }

            .site-footer .member-card:hover {
                background: rgba(255, 255, 255, 0.06);
                transform: translateY(-5px);
                border-color: #4caf50;
            }

            .site-footer .member-name {
                color: #fff;
                font-weight: 700;
                margin-bottom: 8px;
                font-size: 1rem;
            }

            .site-footer .member-info {
                font-size: 0.85rem;
                line-height: 1.6;
                color: #a0a0a0 !important;
            }

            .site-footer .footer-links {
                list-style: none;
                padding: 0;
                margin: 0;
            }

            .site-footer .footer-links li {
                margin-bottom: 12px;
            }

            .site-footer .footer-links a {
                color: #b0b0b0 !important;
                text-decoration: none;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                font-size: 0.95rem;
            }

            .site-footer .footer-links a::before {
                content: '\f054';
                font-family: 'Font Awesome 5 Free';
                font-weight: 900;
                font-size: 10px;
                margin-right: 10px;
                color: #4caf50;
                transition: transform 0.3s ease;
            }

            .site-footer .footer-links a:hover {
                color: #fff !important;
                padding-left: 5px;
            }

            .site-footer .footer-links a:hover::before {
                transform: translateX(3px);
            }

            .site-footer .contact-info p {
                color: #b0b0b0 !important;
                margin-bottom: 18px;
                display: flex;
                align-items: flex-start;
                font-size: 0.95rem;
            }

            .site-footer .contact-info i {
                color: #4caf50;
                margin-right: 15px;
                width: 20px;
                margin-top: 4px;
                font-size: 1.1rem;
            }

            .site-footer .social-links {
                display: flex;
                gap: 12px;
                margin-top: 25px;
            }

            .site-footer .social-links a {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                width: 42px;
                height: 42px;
                background: rgba(255, 255, 255, 0.05);
                border-radius: 50%;
                color: #fff;
                text-decoration: none;
                transition: all 0.3s ease;
                border: 1px solid rgba(255, 255, 255, 0.05);
            }

            .site-footer .social-links a:hover {
                background: #4caf50;
                transform: translateY(-3px);
                border-color: #4caf50;
                box-shadow: 0 5px 15px rgba(76, 175, 80, 0.3);
            }

            .site-footer .newsletter-form {
                display: flex;
                margin-top: 20px;
                position: relative;
            }

            .site-footer .newsletter-input {
                flex: 1;
                padding: 14px 20px;
                border: 1px solid rgba(255, 255, 255, 0.1);
                border-radius: 50px;
                background: rgba(255, 255, 255, 0.05);
                color: white;
                font-family: inherit;
                outline: none;
                transition: all 0.3s ease;
            }

            .site-footer .newsletter-input:focus {
                border-color: #4caf50;
                background: rgba(255, 255, 255, 0.1);
            }

            .site-footer .newsletter-input::placeholder {
                color: #777;
            }

            .site-footer .newsletter-btn {
                position: absolute;
                right: 5px;
                top: 5px;
                bottom: 5px;
                background: #4caf50;
                color: white;
                border: none;
                padding: 0 25px;
                border-radius: 50px;
                cursor: pointer;
                transition: all 0.3s ease;
                font-family: inherit;
                font-weight: 700;
                font-size: 0.9rem;
            }

            .site-footer .newsletter-btn:hover {
                background: #43a047;
                transform: scale(1.05);
            }

            .site-footer .certification {
                background: rgba(255, 255, 255, 0.02);
                border-radius: 16px;
                padding: 25px;
                margin-top: 40px;
                text-align: center;
                border: 1px solid rgba(255, 255, 255, 0.05);
            }

            .site-footer .certification-badge {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                background: rgba(76, 175, 80, 0.15);
                color: #4caf50;
                padding: 8px 18px;
                border-radius: 50px;
                margin: 5px;
                font-size: 0.85rem;
                font-weight: 600;
                border: 1px solid rgba(76, 175, 80, 0.2);
            }

            .site-footer .certification-badge.blue {
                background: rgba(33, 150, 243, 0.15);
                color: #2196f3;
                border-color: rgba(33, 150, 243, 0.2);
            }

            .site-footer .certification-badge.orange {
                background: rgba(255, 152, 0, 0.15);
                color: #ff9800;
                border-color: rgba(255, 152, 0, 0.2);
            }

            .site-footer .footer-bottom {
                border-top: 1px solid rgba(255, 255, 255, 0.05) !important;
                padding-top: 30px;
                margin-top: 40px;
                text-align: center;
                font-size: 0.85rem;
                color: #777 !important;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .site-footer {
                    padding: 50px 0 20px !important;
                }

                .site-footer .newsletter-form {
                    flex-direction: column;
                }

                .site-footer .newsletter-btn {
                    position: static;
                    width: 100%;
                    margin-top: 10px;
                    padding: 12px;
                }

                .site-footer .newsletter-input {
                    border-radius: 12px;
                }

                .site-footer .newsletter-btn {
                    border-radius: 12px;
                }
            }
        </style>

        <footer class="site-footer">
            <div class="container">
                <div class="row">

                    <!-- Thông tin thành viên nhóm -->
                    <div class="col-lg-6 col-md-12 mb-5">
                        <h3 class="footer-heading">THÀNH VIÊN NHÓM</h3>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="member-card">
                                    <div class="member-name">NGUYỄN TIẾN SƠN</div>
                                    <div class="member-info">
                                        <div><strong>MSV:</strong> 22103100146</div>
                                        <div><strong>Email:</strong> ntson.dhti16a1cl@sv.uneti.edu.vn</div>
                                        <div><strong>SDT:</strong> 0849200604</div>
                                        <div><strong>Lớp:</strong> DHTI16A1CL</div>
                                    </div>
                                </div>

                                <div class="member-card">
                                    <div class="member-name">NGUYỄN VĂN SÁNG</div>
                                    <div class="member-info">
                                        <div><strong>MSV:</strong> 22103100095</div>
                                        <div><strong>Email:</strong> nvsang.dhti16a1cl@sv.uneti.edu.vn</div>
                                        <div><strong>SDT:</strong> 0356718540</div>
                                        <div><strong>Lớp:</strong> DHTI16A1CL</div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-sm-6">
                                <div class="member-card">
                                    <div class="member-name">VŨ VĂN NAM</div>
                                    <div class="member-info">
                                        <div><strong>MSV:</strong> 22103100023</div>
                                        <div><strong>Email:</strong> vvnam.dhti16a1hn@sv.uneti.edu.vn</div>
                                        <div><strong>SDT:</strong> 0849200604</div>
                                        <div><strong>Lớp:</strong> DHTI16A1CL</div>
                                    </div>
                                </div>

                                <div class="member-card">
                                    <div class="member-name">GIANG MINH QUÂN</div>
                                    <div class="member-info">
                                        <div><strong>MSV:</strong> 22103100084</div>
                                        <div><strong>Email:</strong> gmq.dhti16a1cl@sv.uneti.edu.vn</div>
                                        <div><strong>SDT:</strong> 0369471004</div>
                                        <div><strong>Lớp:</strong> DHTI16A1CL</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Thông tin liên hệ & Mạng xã hội -->
                    <div class="col-lg-3 col-md-6 mb-5">
                        <h3 class="footer-heading">LIÊN HỆ</h3>
                        <div class="contact-info">
                            <p><i class="fas fa-map-marker-alt"></i> 218 Lĩnh Nam, Hà Nội</p>
                            <p><i class="fas fa-phone"></i> Hotline: 1900 1234</p>
                            <p><i class="fas fa-envelope"></i> Email: info@pharmative.com</p>
                            <p><i class="fas fa-clock"></i> Giờ làm việc: 7:00 - 22:00</p>
                        </div>

                        <h3 class="footer-heading mt-4">KẾT NỐI</h3>
                        <div class="social-links">
                            <a href="#"><i class="fab fa-facebook-f"></i></a>
                            <a href="#"><i class="fab fa-twitter"></i></a>
                            <a href="#"><i class="fab fa-instagram"></i></a>
                            <a href="#"><i class="fab fa-youtube"></i></a>
                        </div>
                    </div>

                    <!-- Liên kết nhanh & Đăng ký nhận tin -->
                    <div class="col-lg-3 col-md-6 mb-5">
                        <h3 class="footer-heading">LIÊN KẾT NHANH</h3>
                        <ul class="footer-links">
                            <li><a href="${cpath}/home">Trang chủ</a></li>
                            <li><a href="${cpath}/shop">Sản phẩm</a></li>
                            <li><a href="${cpath}/about.jsp">Về chúng tôi</a></li>
                            <li><a href="${cpath}/contact.jsp">Liên hệ</a></li>
                            <li><a href="${cpath}/blog.jsp">Tin tức y tế</a></li>
                            <li><a href="${cpath}/faq.jsp">Câu hỏi thường gặp</a></li>
                        </ul>

                        <c:set var="returnUrl"
                            value="${pageContext.request.requestURI}${not empty pageContext.request.queryString ? '?' : ''}${pageContext.request.queryString}" />

                        <h3 class="footer-heading mt-4">ĐĂNG KÝ NHẬN TIN</h3>
                        <p style="color: #a0a0a0; font-size: 0.9rem; margin-bottom: 15px;">Nhận thông tin khuyến mãi mới
                            nhất</p>

                        <form action="${cpath}/newsletter/subscribe" method="post" class="newsletter-form">
                            <input type="email" name="email" class="newsletter-input" placeholder="Email của bạn"
                                required>
                            <input type="hidden" name="return" value="${returnUrl}">
                            <button type="submit" class="newsletter-btn">Gửi</button>
                        </form>

                        <c:choose>
                            <c:when test="${param.subscribed == '1'}">
                                <div class="alert alert-success mt-3" style="font-size: 0.85rem;">Đăng ký thành công!
                                </div>
                            </c:when>
                            <c:when test="${param.subscribed == '0'}">
                                <div class="alert alert-danger mt-3" style="font-size: 0.85rem;">Đăng ký thất bại.</div>
                            </c:when>
                        </c:choose>

                    </div>
                </div>

                <!-- Chứng nhận & Phương thức thanh toán -->
                <div class="row">
                    <div class="col-12">
                        <div class="certification">
                            <h5 class="text-center mb-4" style="color: #fff; font-size: 1rem; opacity: 0.8;">CHỨNG NHẬN
                                & BẢO MẬT</h5>
                            <div class="text-center">
                                <span class="certification-badge">
                                    <i class="fas fa-shield-alt"></i> Bộ Y Tế cấp phép
                                </span>
                                <span class="certification-badge blue">
                                    <i class="fas fa-lock"></i> Bảo mật SSL
                                </span>
                                <span class="certification-badge orange">
                                    <i class="fas fa-check-circle"></i> Chính hãng 100%
                                </span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Footer bottom -->
                <div class="row">
                    <div class="col-12">
                        <div class="footer-bottom">
                            <p>&copy; 2024 PHARMATIVE - DƯỢC PHẨM CHÍNH HÃNG. Tất cả quyền được bảo lưu.</p>
                            <p>Website được phát triển bởi Nhóm Sinh viên UNETI - DHTI16A1CL</p>
                        </div>
                    </div>
                </div>
            </div>
        </footer>

        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">