<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    response.setCharacterEncoding("UTF-8");
%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Tin tức Y tế | Pharmative</title>
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

            .news-container {
                max-width: 1200px;
                margin: 40px auto;
                padding: 0 15px;
            }

            .news-card {
                background: var(--white);
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                overflow: hidden;
                margin-bottom: 30px;
                transition: var(--transition);
            }

            .news-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
            }

            .news-header {
                padding: 25px 30px;
                border-bottom: 1px solid #eee;
                background-color: #f8f9fa;
            }

            .news-image {
                width: 100%;
                height: 250px;
                object-fit: cover;
            }

            .news-body {
                padding: 25px;
            }

            .news-category {
                display: inline-block;
                background-color: var(--primary-color);
                color: white;
                padding: 4px 12px;
                border-radius: 20px;
                font-size: 0.8rem;
                font-weight: 600;
                margin-bottom: 15px;
            }

            .news-title {
                font-weight: 700;
                margin-bottom: 15px;
                color: var(--text-dark);
            }

            .news-excerpt {
                color: var(--text-light);
                margin-bottom: 20px;
            }

            .news-meta {
                display: flex;
                align-items: center;
                justify-content: space-between;
                color: var(--text-light);
                font-size: 0.9rem;
            }

            .news-date {
                display: flex;
                align-items: center;
            }

            .news-date i {
                margin-right: 5px;
            }

            .read-more {
                color: var(--primary-color);
                font-weight: 600;
                text-decoration: none;
                transition: var(--transition);
            }

            .read-more:hover {
                color: var(--primary-dark);
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

            .sidebar-card {
                background: var(--white);
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                padding: 25px;
                margin-bottom: 30px;
            }

            .sidebar-title {
                font-weight: 700;
                margin-bottom: 20px;
                color: var(--primary-dark);
                border-bottom: 2px solid var(--primary-color);
                padding-bottom: 10px;
            }

            .category-list {
                list-style: none;
                padding: 0;
                margin: 0;
            }

            .category-list li {
                margin-bottom: 10px;
            }

            .category-list a {
                color: var(--text-dark);
                text-decoration: none;
                transition: var(--transition);
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .category-list a:hover {
                color: var(--primary-color);
            }

            .category-count {
                background-color: var(--bg-light);
                color: var(--text-light);
                padding: 2px 8px;
                border-radius: 12px;
                font-size: 0.8rem;
            }

            .recent-news-item {
                display: flex;
                margin-bottom: 15px;
                padding-bottom: 15px;
                border-bottom: 1px solid #eee;
            }

            .recent-news-item:last-child {
                margin-bottom: 0;
                padding-bottom: 0;
                border-bottom: none;
            }

            .recent-news-image {
                width: 80px;
                height: 60px;
                object-fit: cover;
                border-radius: var(--border-radius);
                margin-right: 15px;
            }

            .recent-news-title {
                font-weight: 600;
                font-size: 0.9rem;
                margin-bottom: 5px;
            }

            .recent-news-date {
                color: var(--text-light);
                font-size: 0.8rem;
            }

            .news-tags {
                display: flex;
                flex-wrap: wrap;
                gap: 8px;
            }

            .news-tag {
                background-color: var(--bg-light);
                color: var(--text-dark);
                padding: 4px 12px;
                border-radius: 20px;
                font-size: 0.8rem;
                text-decoration: none;
                transition: var(--transition);
            }

            .news-tag:hover {
                background-color: var(--primary-color);
                color: white;
            }

            @media (max-width: 768px) {
                .news-container {
                    margin: 20px auto;
                }

                .news-body {
                    padding: 20px;
                }

                .news-meta {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 10px;
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
                            <strong class="text-black">Tin tức Y tế</strong>
                        </div>
                    </div>
                </div>
            </div>

            <div class="news-container">
                <div class="section-title">
                    <h2><strong class="text-primary">Tin tức Y tế & Sức khỏe</strong></h2>
                    <p class="text-muted">Cập nhật thông tin y tế mới nhất và lời khuyên từ chuyên gia</p>
                </div>

                <div class="row">
                    <!-- Main Content -->
                    <div class="col-lg-8">
                        <!-- Featured News -->
                        <div class="news-card">
                            <img src="${cpath}/images/news/featured-news.jpg" alt="Tin tức nổi bật" class="news-image">
                            <div class="news-body">
                                <span class="news-category">SỨC KHỎE</span>
                                <h3 class="news-title">5 Loại Vitamin Thiết Yếu Cho Hệ Miễn Dịch Khỏe Mạnh</h3>
                                <p class="news-excerpt">Khám phá những vitamin quan trọng giúp tăng cường hệ miễn dịch và bảo vệ cơ thể khỏi bệnh tật trong mùa dịch...</p>
                                <div class="news-meta">
                                    <div class="news-date">
                                        <i class="icon-calendar"></i> 15/12/2024
                                    </div>
                                    <a href="#" class="read-more">Đọc tiếp →</a>
                                </div>
                            </div>
                        </div>

                        <!-- News Grid -->
                        <div class="row">
                            <div class="col-md-6 mb-4">
                                <div class="news-card">
                                    <img src="${cpath}/images/news/news-1.jpg" alt="Tin tức 1" class="news-image">
                                    <div class="news-body">
                                        <span class="news-category">DINH DƯỠNG</span>
                                        <h4 class="news-title">Chế Độ Ăn Cho Người Cao Huyết Áp</h4>
                                        <p class="news-excerpt">Những thực phẩm nên và không nên ăn để kiểm soát huyết áp hiệu quả...</p>
                                        <div class="news-meta">
                                            <div class="news-date">12/12/2024</div>
                                            <a href="#" class="read-more">Đọc tiếp →</a>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6 mb-4">
                                <div class="news-card">
                                    <img src="${cpath}/images/news/news-2.jpg" alt="Tin tức 2" class="news-image">
                                    <div class="news-body">
                                        <span class="news-category">THỂ DỤC</span>
                                        <h4 class="news-title">Bài Tập Thể Dục Tại Nhà Cho Người Bận Rộn</h4>
                                        <p class="news-excerpt">15 phút mỗi ngày với các bài tập đơn giản giúp duy trì sức khỏe...</p>
                                        <div class="news-meta">
                                            <div class="news-date">10/12/2024</div>
                                            <a href="#" class="read-more">Đọc tiếp →</a>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6 mb-4">
                                <div class="news-card">
                                    <img src="${cpath}/images/news/news-3.jpg" alt="Tin tức 3" class="news-image">
                                    <div class="news-body">
                                        <span class="news-category">SỨC KHỎE TÂM THẦN</span>
                                        <h4 class="news-title">Cách Giảm Căng Thẳng Trong Cuộc Sống Hiện Đại</h4>
                                        <p class="news-excerpt">Phương pháp đơn giản để quản lý stress và cải thiện sức khỏe tinh thần...</p>
                                        <div class="news-meta">
                                            <div class="news-date">08/12/2024</div>
                                            <a href="#" class="read-more">Đọc tiếp →</a>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6 mb-4">
                                <div class="news-card">
                                    <img src="${cpath}/images/news/news-4.jpg" alt="Tin tức 4" class="news-image">
                                    <div class="news-body">
                                        <span class="news-category">PHÒNG BỆNH</span>
                                        <h4 class="news-title">Dấu Hiệu Nhận Biết Sớm Bệnh Tim Mạch</h4>
                                        <p class="news-excerpt">Những triệu chứng cảnh báo sớm giúp phát hiện kịp thời các vấn đề tim mạch...</p>
                                        <div class="news-meta">
                                            <div class="news-date">05/12/2024</div>
                                            <a href="#" class="read-more">Đọc tiếp →</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Pagination -->
                        <nav aria-label="Page navigation">
                            <ul class="pagination justify-content-center">
                                <li class="page-item disabled">
                                    <a class="page-link" href="#" tabindex="-1">Trước</a>
                                </li>
                                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                <li class="page-item"><a class="page-link" href="#">2</a></li>
                                <li class="page-item"><a class="page-link" href="#">3</a></li>
                                <li class="page-item">
                                    <a class="page-link" href="#">Tiếp</a>
                                </li>
                            </ul>
                        </nav>
                    </div>

                    <!-- Sidebar -->
                    <div class="col-lg-4">
                        <!-- Categories -->
                        <div class="sidebar-card">
                            <h4 class="sidebar-title">Danh mục</h4>
                            <ul class="category-list">
                                <li><a href="#">Sức khỏe tổng quát <span class="category-count">12</span></a></li>
                                <li><a href="#">Dinh dưỡng <span class="category-count">8</span></a></li>
                                <li><a href="#">Thể dục <span class="category-count">6</span></a></li>
                                <li><a href="#">Sức khỏe tâm thần <span class="category-count">5</span></a></li>
                                <li><a href="#">Phòng bệnh <span class="category-count">7</span></a></li>
                                <li><a href="#">Thuốc & Điều trị <span class="category-count">9</span></a></li>
                                <li><a href="#">Chăm sóc gia đình <span class="category-count">4</span></a></li>
                            </ul>
                        </div>

                        <!-- Recent News -->
                        <div class="sidebar-card">
                            <h4 class="sidebar-title">Tin mới nhất</h4>
                            <div class="recent-news-item">
                                <img src="${cpath}/images/news/recent-1.jpg" alt="Tin gần đây 1" class="recent-news-image">
                                <div>
                                    <h5 class="recent-news-title">Cách Phòng Ngừa Cảm Cúm Mùa Đông</h5>
                                    <div class="recent-news-date">14/12/2024</div>
                                </div>
                            </div>
                            <div class="recent-news-item">
                                <img src="${cpath}/images/news/recent-2.jpg" alt="Tin gần đây 2" class="recent-news-image">
                                <div>
                                    <h5 class="recent-news-title">Lợi Ích Của Việc Uống Đủ Nước</h5>
                                    <div class="recent-news-date">13/12/2024</div>
                                </div>
                            </div>
                            <div class="recent-news-item">
                                <img src="${cpath}/images/news/recent-3.jpg" alt="Tin gần đây 3" class="recent-news-image">
                                <div>
                                    <h5 class="recent-news-title">Thực Phẩm Tốt Cho Xương Khớp</h5>
                                    <div class="recent-news-date">11/12/2024</div>
                                </div>
                            </div>
                        </div>

                        <!-- Tags -->
                        <div class="sidebar-card">
                            <h4 class="sidebar-title">Thẻ phổ biến</h4>
                            <div class="news-tags">
                                <a href="#" class="news-tag">#sứckhỏe</a>
                                <a href="#" class="news-tag">#dinhdưỡng</a>
                                <a href="#" class="news-tag">#thểdục</a>
                                <a href="#" class="news-tag">#phòngbệnh</a>
                                <a href="#" class="news-tag">#vitamin</a>
                                <a href="#" class="news-tag">#timmạch</a>
                                <a href="#" class="news-tag">#miễndịch</a>
                                <a href="#" class="news-tag">#sứckhỏetâmthần</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <jsp:include page="/common/footerChinh.jsp" />
        </div>

        <script src="js/jquery-3.3.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
    </body>
</html>