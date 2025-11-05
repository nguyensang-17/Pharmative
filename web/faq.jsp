<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    response.setCharacterEncoding("UTF-8");
%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Câu hỏi Thường gặp | Pharmative</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <base href="${cpath}/">
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico">
        <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="css/bootstrap.min.css">
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

            .faq-container {
                max-width: 1000px;
                margin: 40px auto;
                padding: 0 15px;
            }

            .faq-card {
                background: var(--white);
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                overflow: hidden;
                margin-bottom: 30px;
            }

            .faq-header {
                padding: 25px 30px;
                border-bottom: 1px solid #eee;
                background-color: #f8f9fa;
            }

            .faq-body {
                padding: 30px;
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

            .faq-category {
                margin-bottom: 40px;
            }

            .category-title {
                font-weight: 700;
                color: var(--primary-dark);
                margin-bottom: 25px;
                padding-bottom: 10px;
                border-bottom: 2px solid var(--primary-color);
            }

            .accordion-item {
                border: 1px solid #eee;
                border-radius: var(--border-radius);
                margin-bottom: 15px;
                overflow: hidden;
                background: var(--white);
            }

            .accordion-header {
                margin: 0;
            }

            .accordion-button {
                background-color: var(--white);
                color: var(--text-dark);
                font-weight: 600;
                padding: 20px 25px;
                border: none;
                width: 100%;
                text-align: left;
                cursor: pointer;
                transition: var(--transition);
                display: flex;
                justify-content: space-between;
                align-items: center;
                position: relative;
                font-size: 20px;
            }

            .accordion-button:hover {
                background-color: #f8f9fa;
            }

            .accordion-button:not(.collapsed) {
                background-color: rgba(46, 125, 50, 0.05);
                color: var(--primary-dark);
            }

            .accordion-button::after {
                content: '+';
                font-size: 1.5rem;
                font-weight: 300;
                transition: var(--transition);
                color: var(--primary-color);
            }

            .accordion-button:not(.collapsed)::after {
                content: '-';
                color: var(--primary-color);
            }

            .accordion-button.collapsed::after {
                content: '+';
            }

            .accordion-collapse {
                transition: var(--transition);
            }

            .accordion-body {
                padding: 20px 25px;
                background-color: var(--white);
                border-top: 1px solid #eee;
            }

            .contact-promo {
                background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
                color: white;
                border-radius: var(--border-radius);
                padding: 40px;
                text-align: center;
                margin-top: 50px;
            }

            .contact-promo h3 {
                margin-bottom: 15px;
            }

            .contact-promo p {
                margin-bottom: 25px;
                opacity: 0.9;
            }

            .btn-light {
                background-color: white;
                color: var(--primary-color);
                border-radius: 30px;
                padding: 12px 30px;
                font-weight: 600;
                transition: var(--transition);
            }

            .btn-light:hover {
                background-color: #f8f9fa;
                transform: translateY(-2px);
            }

            .search-box {
                position: relative;
                margin-bottom: 30px;
            }

            .search-input {
                width: 100%;
                padding: 15px 50px 15px 20px;
                border: 2px solid #eee;
                border-radius: 30px;
                font-size: 1rem;
                transition: var(--transition);
            }

            .search-input:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.2rem rgba(46, 125, 50, 0.25);
                outline: none;
            }

            .search-button {
                position: absolute;
                right: 5px;
                top: 50%;
                transform: translateY(-50%);
                background: var(--primary-color);
                border: none;
                color: white;
                width: 40px;
                height: 40px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: var(--transition);
            }

            .search-button:hover {
                background: var(--primary-dark);
            }

            .faq-icon {
                margin-right: 10px;
                color: var(--primary-color);
            }

            @media (max-width: 768px) {
                .faq-container {
                    margin: 20px auto;
                }

                .faq-body {
                    padding: 20px;
                }

                .accordion-button {
                    padding: 15px 20px;
                    font-size: 0.9rem;
                }

                .contact-promo {
                    padding: 30px 20px;
                }
            }
        </style>
    </head>

    <body>
        <jsp:include page="/common/headerChinh.jsp" />

        <div class="site-wrap">
            <!-- Breadcrumb -->
            <div class="bg-light py-3">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 mb-0">
                            <a href="${cpath}/home">Trang chủ</a> <span class="mx-2 mb-0">/</span>
                            <strong class="text-black">Câu hỏi Thường gặp</strong>
                        </div>
                    </div>
                </div>
            </div>

            <div class="faq-container">
                <div class="section-title">
                    <h2><strong class="text-primary">Câu hỏi Thường gặp</strong></h2>
                    <p class="text-muted">Tìm câu trả lời cho những thắc mắc phổ biến của bạn</p>
                </div>

                <div class="faq-card">
                    <div class="faq-header">
                        <h3 class="mb-0">Tìm kiếm câu hỏi</h3>
                    </div>
                    <div class="faq-body">
                        <div class="search-box">
                            <input type="text" class="search-input" placeholder="Nhập từ khóa tìm kiếm...">
                            <button class="search-button">
                                <i class="icon-search"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <div class="faq-card">
                    <div class="faq-body">
                        <!-- Sản phẩm & Đặt hàng -->
                        <div class="faq-category">
                            <h4 class="category-title"><i class="faq-icon">📦</i> Sản phẩm & Đặt hàng</h4>
                            <div class="accordion" id="accordionProducts">
                                <div class="accordion-item">
                                    <h2 class="accordion-header">
                                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#product1" aria-expanded="false" aria-controls="product1">
                                            Làm thế nào để đặt hàng trên Pharmative?
                                        </button>
                                    </h2>
                                    <div id="product1" class="accordion-collapse collapse" data-bs-parent="#accordionProducts">
                                        <div class="accordion-body">
                                            <p>Để đặt hàng trên Pharmative, bạn có thể:</p>
                                            <ol>
                                                <li>Tìm kiếm sản phẩm trong danh mục hoặc sử dụng thanh tìm kiếm</li>
                                                <li>Thêm sản phẩm vào giỏ hàng</li>
                                                <li>Kiểm tra giỏ hàng và tiến hành thanh toán</li>
                                                <li>Điền thông tin giao hàng và chọn phương thức thanh toán</li>
                                                <li>Xác nhận đơn hàng</li>
                                            </ol>
                                        </div>
                                    </div>
                                </div>

                                <div class="accordion-item">
                                    <h2 class="accordion-header">
                                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#product2" aria-expanded="false" aria-controls="product2">
                                            Sản phẩm của Pharmative có chính hãng không?
                                        </button>
                                    </h2>
                                    <div id="product2" class="accordion-collapse collapse" data-bs-parent="#accordionProducts">
                                        <div class="accordion-body">
                                            <p><strong>Tất cả sản phẩm trên Pharmative đều là hàng chính hãng 100%.</strong> Chúng tôi:</p>
                                            <ul>
                                                <li>Nhập khẩu trực tiếp từ các nhà sản xuất uy tín</li>
                                                <li>Cam kết chất lượng và nguồn gốc rõ ràng</li>
                                                <li>Có đầy đủ giấy tờ chứng nhận và kiểm định</li>
                                                <li>Bảo hành chính hãng theo quy định</li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>

                                <div class="accordion-item">
                                    <h2 class="accordion-header">
                                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#product3" aria-expanded="false" aria-controls="product3">
                                            Tôi có thể đổi trả sản phẩm không?
                                        </button>
                                    </h2>
                                    <div id="product3" class="accordion-collapse collapse" data-bs-parent="#accordionProducts">
                                        <div class="accordion-body">
                                            <p>Chúng tôi chấp nhận đổi trả trong các trường hợp:</p>
                                            <ul>
                                                <li>Sản phẩm bị lỗi do nhà sản xuất</li>
                                                <li>Nhận sai sản phẩm so với đơn đặt hàng</li>
                                                <li>Sản phẩm hết hạn sử dụng</li>
                                                <li>Bao bì bị hư hỏng trong quá trình vận chuyển</li>
                                            </ul>
                                            <p><strong>Thời gian đổi trả:</strong> Trong vòng 7 ngày kể từ khi nhận hàng.</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Thanh toán & Vận chuyển -->
                        <div class="faq-category">
                            <h4 class="category-title"><i class="faq-icon">💳</i> Thanh toán & Vận chuyển</h4>
                            <div class="accordion" id="accordionPayment">
                                <div class="accordion-item">
                                    <h2 class="accordion-header">
                                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#payment1" aria-expanded="false" aria-controls="payment1">
                                            Các phương thức thanh toán được chấp nhận?
                                        </button>
                                    </h2>
                                    <div id="payment1" class="accordion-collapse collapse" data-bs-parent="#accordionPayment">
                                        <div class="accordion-body">
                                            <p>Chúng tôi chấp nhận các phương thức thanh toán sau:</p>
                                            <ul>
                                                <li><strong>Thanh toán khi nhận hàng (COD)</strong></li>
                                                <li><strong>Chuyển khoản ngân hàng</strong></li>
                                                <li><strong>Ví điện tử</strong> (Momo, ZaloPay, ViettelPay)</li>
                                                <li><strong>Thẻ tín dụng/ghi nợ</strong> (Visa, MasterCard)</li>
                                                <li><strong>Thanh toán qua VNPAY</strong></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>

                                <div class="accordion-item">
                                    <h2 class="accordion-header">
                                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#payment2" aria-expanded="false" aria-controls="payment2">
                                            Thời gian giao hàng là bao lâu?
                                        </button>
                                    </h2>
                                    <div id="payment2" class="accordion-collapse collapse" data-bs-parent="#accordionPayment">
                                        <div class="accordion-body">
                                            <p>Thời gian giao hàng phụ thuộc vào khu vực của bạn:</p>
                                            <ul>
                                                <li><strong>Nội thành Hà Nội/HCM:</strong> 1-2 ngày làm việc</li>
                                                <li><strong>Các tỉnh thành khác:</strong> 2-5 ngày làm việc</li>
                                                <li><strong>Vùng sâu, vùng xa:</strong> 5-7 ngày làm việc</li>
                                            </ul>
                                            <p><em>Lưu ý: Thời gian có thể thay đổi trong các dịp lễ, Tết hoặc do ảnh hưởng của thời tiết.</em></p>
                                        </div>
                                    </div>
                                </div>

                                <div class="accordion-item">
                                    <h2 class="accordion-header">
                                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#payment3" aria-expanded="false" aria-controls="payment3">
                                            Phí vận chuyển được tính như thế nào?
                                        </button>
                                    </h2>
                                    <div id="payment3" class="accordion-collapse collapse" data-bs-parent="#accordionPayment">
                                        <div class="accordion-body">
                                            <p>Chính sách vận chuyển của chúng tôi:</p>
                                            <ul>
                                                <li><strong>Miễn phí vận chuyển</strong> cho đơn hàng từ 500,000đ trở lên</li>
                                                <li><strong>Phí 25,000đ</strong> cho đơn hàng dưới 500,000đ trong nội thành</li>
                                                <li><strong>Phí 35,000đ</strong> cho đơn hàng dưới 500,000đ ngoại thành</li>
                                                <li><strong>Liên hệ</strong> để biết phí vận chuyển đến vùng sâu, vùng xa</li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Sức khỏe & Tư vấn -->
                        <div class="faq-category">
                            <h4 class="category-title"><i class="faq-icon">🏥</i> Sức khỏe & Tư vấn</h4>
                            <div class="accordion" id="accordionHealth">
                                <div class="accordion-item">
                                    <h2 class="accordion-header">
                                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#health1" aria-expanded="false" aria-controls="health1">
                                            Làm thế nào để sử dụng thuốc đúng cách?
                                        </button>
                                    </h2>
                                    <div id="health1" class="accordion-collapse collapse" data-bs-parent="#accordionHealth">
                                        <div class="accordion-body">
                                            <p>Để sử dụng thuốc an toàn và hiệu quả:</p>
                                            <ul>
                                                <li><strong>Tuân thủ chỉ định của bác sĩ</strong> về liều lượng và thời gian sử dụng</li>
                                                <li><strong>Đọc kỹ hướng dẫn sử dụng</strong> trước khi dùng</li>
                                                <li><strong>Không tự ý thay đổi liều lượng</strong> hoặc ngừng thuốc đột ngột</li>
                                                <li><strong>Báo ngay cho bác sĩ</strong> nếu có tác dụng phụ bất thường</li>
                                                <li><strong>Bảo quản thuốc đúng cách</strong> theo hướng dẫn</li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>

                                <div class="accordion-item">
                                    <h2 class="accordion-header">
                                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#health2" aria-expanded="false" aria-controls="health2">
                                            Có được tư vấn sức khỏe miễn phí không?
                                        </button>
                                    </h2>
                                    <div id="health2" class="accordion-collapse collapse" data-bs-parent="#accordionHealth">
                                        <div class="accordion-body">
                                            <p><strong>Có, hoàn toàn miễn phí!</strong> Chúng tôi cung cấp dịch vụ tư vấn sức khỏe:</p>
                                            <ul>
                                                <li><strong>Đội ngũ dược sĩ chuyên môn</strong> sẵn sàng tư vấn 24/7</li>
                                                <li><strong>Hotline:</strong> 1800-1234 (Miễn phí)</li>
                                                <li><strong>Chat trực tuyến</strong> trên website và fanpage</li>
                                                <li><strong>Email:</strong> tuvansuckhoe@pharmative.com</li>
                                                <li><strong>Tư vấn trực tiếp</strong> tại các chi nhánh</li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>

                                <div class="accordion-item">
                                    <h2 class="accordion-header">
                                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#health3" aria-expanded="false" aria-controls="health3">
                                            Thực phẩm chức năng có thay thế được thuốc chữa bệnh?
                                        </button>
                                    </h2>
                                    <div id="health3" class="accordion-collapse collapse" data-bs-parent="#accordionHealth">
                                        <div class="accordion-body">
                                            <p><strong>KHÔNG, thực phẩm chức năng không thể thay thế thuốc chữa bệnh.</strong></p>
                                            <p>Thực phẩm chức năng có các đặc điểm:</p>
                                            <ul>
                                                <li>Hỗ trợ chức năng của cơ thể</li>
                                                <li>Tạo cho cơ thể tình trạng thoải mái</li>
                                                <li>Giảm nguy cơ mắc bệnh</li>
                                                <li>Bổ sung dinh dưỡng, tăng cường sức khỏe</li>
                                            </ul>
                                            <p><strong>Lưu ý quan trọng:</strong> Không được tự ý ngừng thuốc điều trị để thay thế bằng thực phẩm chức năng. Luôn tham khảo ý kiến bác sĩ trước khi sử dụng.</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Contact Promo -->
                <div class="contact-promo">
                    <h3>Vẫn chưa tìm thấy câu trả lời?</h3>
                    <p>Đội ngũ chăm sóc khách hàng của chúng tôi luôn sẵn sàng hỗ trợ bạn</p>
                    <a href="${cpath}/contact" class="btn btn-light">
                        <i class="icon-envelope"></i> Liên hệ ngay
                    </a>
                </div>
            </div>

            <jsp:include page="/common/footerChinh.jsp" />
        </div>

        <!-- Đảm bảo có Bootstrap JavaScript -->
        <script src="js/jquery-3.3.1.min.js"></script>
        <script src="js/bootstrap.bundle.min.js"></script>

        <!-- Fallback nếu không có Bootstrap JS -->
        <script>
            // Fallback accordion functionality nếu Bootstrap không hoạt động
            document.addEventListener('DOMContentLoaded', function () {
                const accordionButtons = document.querySelectorAll('.accordion-button');

                accordionButtons.forEach(button => {
                    button.addEventListener('click', function () {
                        const targetId = this.getAttribute('data-bs-target');
                        const target = document.querySelector(targetId);

                        // Toggle class collapsed
                        this.classList.toggle('collapsed');

                        // Toggle show/hide cho accordion body
                        if (target) {
                            target.classList.toggle('show');
                        }
                    });
                });

                // Search functionality
                const searchInput = document.querySelector('.search-input');
                if (searchInput) {
                    searchInput.addEventListener('keyup', function () {
                        const searchText = this.value.toLowerCase();
                        const accordionItems = document.querySelectorAll('.accordion-item');

                        accordionItems.forEach(item => {
                            const question = item.querySelector('.accordion-button').textContent.toLowerCase();
                            if (question.indexOf(searchText) === -1) {
                                item.style.display = 'none';
                            } else {
                                item.style.display = 'block';
                            }
                        });
                    });
                }

                // Clear search when input is empty
                if (searchInput) {
                    searchInput.addEventListener('input', function () {
                        if (this.value === '') {
                            const accordionItems = document.querySelectorAll('.accordion-item');
                            accordionItems.forEach(item => {
                                item.style.display = 'block';
                            });
                        }
                    });
                }
            });
        </script>
    </body>
</html>