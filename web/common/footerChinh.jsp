<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="cpath" value="${pageContext.request.contextPath}" />

<style>
.site-footer {
    background: linear-gradient(135deg, #1b5e20 0%, #2e7d32 100%) !important;
    color: white !important;
    padding: 50px 0 20px !important;
    margin-top: 50px;
    width: 100% !important;
    max-width: 100% !important;
}

.site-footer .footer-section {
    margin-bottom: 30px;
}

.site-footer .footer-heading {
    color: #8bc34a !important;
    font-weight: 700;
    margin-bottom: 20px;
    font-size: 1.2rem;
    border-bottom: 2px solid #4caf50;
    padding-bottom: 10px;
}

.site-footer .member-card {
    background: rgba(255, 255, 255, 0.1);
    border-radius: 10px;
    padding: 20px;
    margin-bottom: 20px;
    border-left: 4px solid #4caf50;
    transition: all 0.3s ease;
}

.site-footer .member-card:hover {
    background: rgba(255, 255, 255, 0.15);
    transform: translateY(-5px);
}

.site-footer .member-name {
    color: #8bc34a;
    font-weight: 700;
    margin-bottom: 10px;
    font-size: 1.1rem;
}

.site-footer .member-info {
    font-size: 0.9rem;
    line-height: 1.6;
    color: #e0e0e0 !important;
}

.site-footer .member-info div {
    margin-bottom: 5px;
}

.site-footer .footer-links {
    list-style: none;
    padding: 0;
    margin: 0;
}

.site-footer .footer-links li {
    margin-bottom: 8px;
}

.site-footer .footer-links a {
    color: #e0e0e0 !important;
    text-decoration: none;
    transition: all 0.3s ease;
}

.site-footer .footer-links a:hover {
    color: #8bc34a !important;
    padding-left: 5px;
}

.site-footer .contact-info {
    font-size: 0.95rem;
    line-height: 1.8;
}

.site-footer .contact-info p {
    color: #e0e0e0 !important;
    margin-bottom: 15px;
    display: flex;
    align-items: flex-start;
}

.site-footer .contact-info i {
    color: #8bc34a;
    margin-right: 10px;
    width: 20px;
    margin-top: 3px;
}

.site-footer .social-links {
    display: flex;
    gap: 15px;
    margin-top: 20px;
}

.site-footer .social-links a {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 40px;
    height: 40px;
    background: rgba(255, 255, 255, 0.1);
    border-radius: 50%;
    color: white;
    text-decoration: none;
    transition: all 0.3s ease;
}

.site-footer .social-links a:hover {
    background: #4caf50;
    transform: translateY(-3px);
}

.site-footer .payment-methods {
    margin-top: 20px;
}

.site-footer .payment-methods img {
    height: 30px;
    margin-right: 10px;
    margin-bottom: 10px;
}

.site-footer .certification {
    background: rgba(255, 255, 255, 0.05);
    border-radius: 8px;
    padding: 15px;
    margin-top: 20px;
    text-align: center;
}

.site-footer .certification img {
    max-height: 50px;
    margin: 5px 10px;
}

.site-footer .footer-bottom {
    border-top: 1px solid rgba(255, 255, 255, 0.1) !important;
    padding-top: 20px;
    margin-top: 30px;
    text-align: center;
    font-size: 0.9rem;
    color: #bdbdbd !important;
}

.site-footer .footer-bottom p {
    color: #bdbdbd !important;
    margin-bottom: 5px;
}

.site-footer .newsletter-form {
    display: flex;
    margin-top: 15px;
}

.site-footer .newsletter-input {
    flex: 1;
    padding: 10px 15px;
    border: none;
    border-radius: 25px 0 0 25px;
    background: rgba(255, 255, 255, 0.1);
    color: white;
    font-family: inherit;
}

.site-footer .newsletter-input::placeholder {
    color: #bdbdbd;
}

.site-footer .newsletter-btn {
    background: #4caf50;
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 0 25px 25px 0;
    cursor: pointer;
    transition: all 0.3s ease;
    font-family: inherit;
    font-weight: 600;
}

.site-footer .newsletter-btn:hover {
    background: #388e3c;
}

.site-footer .certification-badge {
    display: inline-block;
    background: #4caf50;
    color: white;
    padding: 5px 15px;
    border-radius: 15px;
    margin: 5px;
    font-size: 0.8rem;
}

.site-footer .certification-badge.blue {
    background: #2196f3;
}

.site-footer .certification-badge.orange {
    background: #ff9800;
}

/* Responsive */
@media (max-width: 768px) {
    .site-footer {
        padding: 30px 0 15px !important;
    }
    
    .site-footer .member-card {
        margin-bottom: 15px;
    }
    
    .site-footer .social-links {
        justify-content: center;
    }
    
    .site-footer .newsletter-form {
        flex-direction: column;
    }
    
    .site-footer .newsletter-input,
    .site-footer .newsletter-btn {
        border-radius: 25px;
        margin-bottom: 10px;
        width: 100%;
    }
    
    .site-footer .certification-badge {
        display: block;
        margin: 5px auto;
        width: fit-content;
    }
}

/* Đảm bảo override các style cũ */
.site-footer ul li a {
    color: #e0e0e0 !important;
}

.site-footer ul li a:hover {
    color: #8bc34a !important;
}

.site-footer .block-7 {
    background: transparent !important;
    border: none !important;
    padding: 0 !important;
    margin-bottom: 0 !important;
}
</style>

<footer class="site-footer">
  <div class="container">
    <div class="row">
      
      <!-- Thông tin thành viên nhóm -->
      <div class="col-lg-6 col-md-12 mb-4">
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
      <div class="col-lg-3 col-md-6 mb-4">
        <h3 class="footer-heading">LIÊN HỆ</h3>
        <div class="contact-info">
          <p><i class="fas fa-map-marker-alt"></i> 123 Đường ABC, Quận 1, TP.HCM</p>
          <p><i class="fas fa-phone"></i> Hotline: 1900 1234</p>
          <p><i class="fas fa-envelope"></i> Email: info@pharmative.com</p>
          <p><i class="fas fa-clock"></i> Giờ làm việc: 7:00 - 22:00</p>
        </div>
        
        <h3 class="footer-heading mt-4">KẾT NỐI VỚI CHÚNG TÔI</h3>
        <div class="social-links">
          <a href="#"><i class="fab fa-facebook-f"></i></a>
          <a href="#"><i class="fab fa-twitter"></i></a>
          <a href="#"><i class="fab fa-instagram"></i></a>
          <a href="#"><i class="fab fa-youtube"></i></a>
          <a href="#"><i class="fab fa-tiktok"></i></a>
        </div>
      </div>

      <!-- Liên kết nhanh & Đăng ký nhận tin -->
      <div class="col-lg-3 col-md-6 mb-4">
        <h3 class="footer-heading">LIÊN KẾT NHANH</h3>
        <ul class="footer-links">
          <li><a href="${cpath}/">Trang chủ</a></li>
          <li><a href="${cpath}/shop">Sản phẩm</a></li>
          <li><a href="${cpath}/about">Về chúng tôi</a></li>
          <li><a href="${cpath}/contact">Liên hệ</a></li>
          <li><a href="${cpath}/blog">Tin tức y tế</a></li>
          <li><a href="${cpath}/faq">Câu hỏi thường gặp</a></li>
        </ul>
        
        <h3 class="footer-heading mt-4">ĐĂNG KÝ NHẬN TIN</h3>
        <p style="color: #e0e0e0; font-size: 0.9rem; margin-bottom: 15px;">Nhận thông tin khuyến mãi và tư vấn sức khỏe</p>
        <form class="newsletter-form">
          <input type="email" class="newsletter-input" placeholder="Email của bạn" required>
          <button type="submit" class="newsletter-btn">Đăng ký</button>
        </form>
      </div>
    </div>

    <!-- Chứng nhận & Phương thức thanh toán -->
    <div class="row">
      <div class="col-12">
        <div class="certification">
          <h5 class="text-center mb-3" style="color: #8bc34a;">CHỨNG NHẬN & BẢO MẬT</h5>
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