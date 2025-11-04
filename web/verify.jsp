<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

  <title>Xác thực tài khoản - Pharmative</title>

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
      --border-radius: 12px;
      --box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
      --transition: all 0.3s ease;
    }
    
    body {
      font-family: 'Nunito', sans-serif;
      color: var(--text-dark);
      line-height: 1.6;
      background-color: #fefefe;
    }
    
    .text-primary {
      color: var(--primary-color) !important;
    }
    
    .btn-primary {
      background-color: var(--primary-color);
      border-color: var(--primary-color);
      border-radius: 30px;
      padding: 14px 35px;
      font-weight: 600;
      font-size: 1.1rem;
      transition: var(--transition);
      box-shadow: 0 4px 15px rgba(46, 125, 50, 0.3);
    }
    
    .btn-primary:hover {
      background-color: var(--primary-dark);
      border-color: var(--primary-dark);
      transform: translateY(-3px);
      box-shadow: 0 8px 20px rgba(46, 125, 50, 0.4);
    }
    
    /* Breadcrumb */
    .breadcrumb-section {
      background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
      padding: 30px 0;
      border-bottom: 1px solid #edf0f5;
    }
    
    .breadcrumb-section a {
      color: var(--primary-color);
      text-decoration: none;
      transition: var(--transition);
    }
    
    .breadcrumb-section a:hover {
      color: var(--primary-dark);
    }
    
    /* Verification Section */
    .verification-section {
      padding: 80px 0;
      background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
      min-height: 70vh;
      display: flex;
      align-items: center;
    }
    
    .verification-card {
      background: var(--white);
      border-radius: var(--border-radius);
      padding: 50px 40px;
      box-shadow: var(--box-shadow);
      border: 1px solid rgba(46, 125, 50, 0.1);
      text-align: center;
      max-width: 500px;
      margin: 0 auto;
      transition: var(--transition);
    }
    
    .verification-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
    }
    
    .verification-icon {
      width: 80px;
      height: 80px;
      background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0 auto 30px;
      color: white;
      font-size: 2rem;
    }
    
    .verification-title {
      font-size: 2.2rem;
      font-weight: 700;
      color: var(--primary-dark);
      margin-bottom: 15px;
    }
    
    .verification-subtitle {
      font-size: 1.1rem;
      color: var(--text-light);
      margin-bottom: 40px;
      line-height: 1.6;
    }
    
    .form-group {
      margin-bottom: 25px;
      text-align: left;
    }
    
    .form-label {
      font-weight: 600;
      color: var(--text-dark);
      margin-bottom: 10px;
      display: block;
    }
    
    .form-control {
      border: 2px solid #e9ecef;
      border-radius: 10px;
      padding: 15px 20px;
      font-size: 1rem;
      transition: var(--transition);
      width: 100%;
    }
    
    .form-control:focus {
      border-color: var(--primary-color);
      box-shadow: 0 0 0 3px rgba(46, 125, 50, 0.1);
    }
    
    .alert {
      border-radius: 10px;
      padding: 15px 20px;
      margin-bottom: 25px;
      border: none;
      font-weight: 500;
    }
    
    .alert-danger {
      background: rgba(220, 53, 69, 0.1);
      color: #dc3545;
      border-left: 4px solid #dc3545;
    }
    
    .btn-verify {
      width: 100%;
      padding: 18px;
      font-size: 1.1rem;
      font-weight: 600;
      border-radius: 15px;
      margin-top: 10px;
    }
    
    .verification-help {
      margin-top: 30px;
      padding-top: 20px;
      border-top: 1px solid #edf0f5;
      color: var(--text-light);
      font-size: 0.9rem;
    }
    
    .verification-help a {
      color: var(--primary-color);
      text-decoration: none;
      font-weight: 600;
    }
    
    .verification-help a:hover {
      color: var(--primary-dark);
    }
    
    /* Responsive */
    @media (max-width: 768px) {
      .verification-section {
        padding: 50px 0;
      }
      
      .verification-card {
        padding: 40px 25px;
        margin: 0 15px;
      }
      
      .verification-title {
        font-size: 1.8rem;
      }
      
      .verification-icon {
        width: 70px;
        height: 70px;
        font-size: 1.7rem;
      }
    }
    
    @media (max-width: 576px) {
      .verification-card {
        padding: 30px 20px;
      }
      
      .verification-title {
        font-size: 1.6rem;
      }
      
      .btn-verify {
        padding: 15px;
        font-size: 1rem;
      }
    }
  </style>
</head>

<body>
<jsp:include page="/common/headerChinh.jsp" />

<!-- Breadcrumb Section -->
<div class="breadcrumb-section">
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb mb-0">
            <li class="breadcrumb-item">
              <a href="${cpath}/home">Trang chủ</a>
            </li>
            <li class="breadcrumb-item active">Xác thực tài khoản</li>
          </ol>
        </nav>
      </div>
    </div>
  </div>
</div>

<!-- Verification Section -->
<div class="verification-section">
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-md-6 col-lg-5">
        <div class="verification-card">
          <div class="verification-icon">
            <i class="fas fa-shield-alt"></i>
          </div>
          
          <h1 class="verification-title">Xác thực tài khoản</h1>
          <p class="verification-subtitle">
            Vui lòng nhập mã xác thực đã được gửi đến email của bạn để hoàn tất đăng ký tài khoản.
          </p>
          
          <form action="${cpath}/verify" method="post">
            <c:if test="${not empty error}">
              <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle me-2"></i>
                ${error}
              </div>
            </c:if>
            
            <div class="form-group">
              <label for="code" class="form-label">Mã xác thực</label>
              <input type="text" 
                     class="form-control" 
                     id="code" 
                     name="code" 
                     placeholder="Nhập mã xác thực 6 chữ số" 
                     required
                     maxlength="6"
                     pattern="[0-9]{6}"
                     title="Vui lòng nhập mã xác thực gồm 6 chữ số">
            </div>
            
            <button type="submit" class="btn btn-primary btn-verify">
              <i class="fas fa-check-circle me-2"></i>
              XÁC THỰC TÀI KHOẢN
            </button>
          </form>
          
          <div class="verification-help">
            <p class="mb-2">Không nhận được mã? 
              <a href="${cpath}/resend-verification">Gửi lại mã xác thực</a>
            </p>
            <p class="mb-0">Mã xác thực có hiệu lực trong 15 phút</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<jsp:include page="/common/footerChinh.jsp" />

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<!-- JS -->
<script src="${cpath}/js/jquery-3.3.1.min.js"></script>
<script src="${cpath}/js/jquery-ui.js"></script>
<script src="${cpath}/js/popper.min.js"></script>
<script src="${cpath}/js/bootstrap.min.js"></script>
<script src="${cpath}/js/aos.js"></script>

<script>
  $(document).ready(function() {
    // Auto focus vào input code
    $('#code').focus();
    
    // Format input chỉ cho phép số
    $('#code').on('input', function() {
      this.value = this.value.replace(/[^0-9]/g, '');
    });
    
    // Hiệu ứng AOS
    AOS.init({
      duration: 1000,
      once: true
    });
  });
</script>
</body>
</html>