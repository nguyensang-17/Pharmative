<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên mật khẩu - Pharmative</title>

    <!-- Bootstrap + FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        /* Theme màu xanh lá chính - giống với Dashboard */
        :root{
            --brand-green: #75b239;
            --brand-green-dark: #5fa127;
            --brand-green-light: #e8f4dc;
            --brand-green-soft: rgba(117,178,57,0.08);
            --brand-green-muted: #8bc34a;
            --muted: #6c6f76;
            --bg: #f6f8f7;
            --card-bg: #ffffff;
            --accent: rgba(117,178,57,0.06);
            --shadow: 0 6px 18px rgba(24,39,75,0.06);
            --shadow-green: 0 6px 18px rgba(117,178,57,0.12);
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--bg);
            color: #333;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            background-image: 
                radial-gradient(circle at 10% 20%, rgba(117,178,57,0.05) 0%, transparent 20%),
                radial-gradient(circle at 90% 80%, rgba(117,178,57,0.05) 0%, transparent 20%);
        }

        .forgot-password-container {
            width: 100%;
            max-width: 480px;
            animation: fadeInUp 0.6s ease-out;
        }

        .forgot-password-card {
            background: var(--card-bg);
            border-radius: 20px;
            padding: 40px 35px;
            box-shadow: 
                0 10px 40px rgba(24, 39, 75, 0.12),
                0 4px 20px rgba(117, 178, 57, 0.08),
                inset 0 1px 0 rgba(255, 255, 255, 0.8);
            border: 1px solid rgba(117, 178, 57, 0.15);
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .forgot-password-card:hover {
            box-shadow: 
                0 16px 50px rgba(24, 39, 75, 0.15),
                0 8px 30px rgba(117, 178, 57, 0.12),
                inset 0 1px 0 rgba(255, 255, 255, 0.8);
            border-color: rgba(117, 178, 57, 0.25);
            transform: translateY(-2px);
        }

        /* Viền xanh tinh tế với gradient */
        .forgot-password-card::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(135deg, var(--brand-green), var(--brand-green-dark));
            border-radius: 20px 20px 0 0;
        }

        /* Hiệu ứng ánh sáng góc */
        .forgot-password-card::after {
            content: "";
            position: absolute;
            top: -40%;
            right: -40%;
            width: 150px;
            height: 150px;
            background: radial-gradient(circle, rgba(117,178,57,0.08) 0%, transparent 70%);
            border-radius: 50%;
            z-index: 0;
        }

        .forgot-password-header {
            text-align: center;
            margin-bottom: 30px;
            position: relative;
            z-index: 1;
        }

        .brand-logo {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            margin-bottom: 20px;
            color: var(--brand-green);
        }

        .brand-logo i {
            font-size: 2.2rem;
            filter: drop-shadow(0 2px 4px rgba(117,178,57,0.2));
        }

        .brand-logo h2 {
            font-weight: 700;
            margin: 0;
            font-size: 1.8rem;
            background: linear-gradient(135deg, var(--brand-green), var(--brand-green-dark));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .forgot-password-header h3 {
            font-weight: 600;
            color: #2b2e33;
            margin-bottom: 12px;
            font-size: 1.5rem;
        }

        .forgot-password-header p {
            color: var(--muted);
            font-size: 0.95rem;
            line-height: 1.5;
            margin: 0;
        }

        .instruction-icon {
            width: 80px;
            height: 80px;
            background: var(--brand-green-soft);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            color: var(--brand-green);
            font-size: 2rem;
            border: 2px solid rgba(117,178,57,0.2);
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
            z-index: 1;
        }

        .form-label {
            font-weight: 600;
            color: #2b2e33;
            margin-bottom: 10px;
            font-size: 0.9rem;
            text-align: left;
            display: block;
        }

        .form-control {
            border: 2px solid #e9ecef;
            border-radius: 12px;
            padding: 14px 16px;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            background: #fff;
            box-shadow: 0 2px 6px rgba(0,0,0,0.04);
        }

        .form-control:focus {
            border-color: var(--brand-green);
            box-shadow: 
                0 0 0 3px rgba(117,178,57,0.15),
                0 4px 12px rgba(117,178,57,0.1);
            transform: translateY(-1px);
        }

        .btn-send-reset {
            background: linear-gradient(135deg, var(--brand-green), var(--brand-green-dark));
            color: white;
            border: none;
            border-radius: 12px;
            padding: 16px 20px;
            font-weight: 600;
            font-size: 1rem;
            width: 100%;
            transition: all 0.3s ease;
            margin-top: 10px;
            box-shadow: 
                0 4px 15px rgba(117,178,57,0.25),
                0 2px 4px rgba(117,178,57,0.1);
            position: relative;
            overflow: hidden;
        }

        .btn-send-reset::before {
            content: "";
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s ease;
        }

        .btn-send-reset:hover {
            transform: translateY(-3px);
            box-shadow: 
                0 8px 25px rgba(117,178,57,0.35),
                0 4px 8px rgba(117,178,57,0.15);
        }

        .btn-send-reset:hover::before {
            left: 100%;
        }

        .btn-send-reset:active {
            transform: translateY(-1px);
        }

        .btn-send-reset:disabled {
            opacity: 0.7;
            cursor: not-allowed;
            transform: none;
        }

        .alert {
            border-radius: 12px;
            border: none;
            padding: 14px 16px;
            margin-bottom: 25px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            position: relative;
            z-index: 1;
        }

        .alert-success {
            background: rgba(117,178,57,0.1);
            color: var(--brand-green);
            border-left: 4px solid var(--brand-green);
        }

        .alert-danger {
            background: rgba(220,53,69,0.08);
            color: #dc3545;
            border-left: 4px solid #dc3545;
        }

        .forgot-password-links {
            text-align: center;
            margin-top: 30px;
            padding-top: 25px;
            border-top: 1px solid rgba(0,0,0,0.08);
            position: relative;
            z-index: 1;
        }

        .forgot-password-links a {
            color: var(--brand-green);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.2s ease;
            position: relative;
            display: inline-block;
            margin: 0 10px;
        }

        .forgot-password-links a:hover {
            color: var(--brand-green-dark);
            text-decoration: none;
        }

        .forgot-password-links a::after {
            content: "";
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--brand-green);
            transition: width 0.3s ease;
        }

        .forgot-password-links a:hover::after {
            width: 100%;
        }

        .forgot-password-footer {
            text-align: center;
            margin-top: 30px;
            color: var(--muted);
            font-size: 0.85rem;
        }

        /* Loading animation */
        .loading-spinner {
            display: none;
            width: 20px;
            height: 20px;
            border: 2px solid rgba(255,255,255,0.3);
            border-radius: 50%;
            border-top: 2px solid white;
            animation: spin 1s linear infinite;
            margin-right: 8px;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Animation */
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

        /* Success state */
        .success-state {
            text-align: center;
            padding: 20px 0;
        }

        .success-icon {
            width: 80px;
            height: 80px;
            background: rgba(117,178,57,0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            color: var(--brand-green);
            font-size: 2rem;
            border: 2px solid rgba(117,178,57,0.3);
        }

        /* Responsive */
        @media (max-width: 576px) {
            .forgot-password-card {
                padding: 30px 25px;
                border-radius: 16px;
            }
            
            .brand-logo h2 {
                font-size: 1.6rem;
            }
            
            .brand-logo i {
                font-size: 2rem;
            }
            
            .forgot-password-card::after {
                display: none;
            }
            
            .forgot-password-links a {
                display: block;
                margin: 5px 0;
            }
        }
    </style>
</head>
<body>
    <div class="forgot-password-container">
        <div class="forgot-password-card">
            <!-- Header -->
            <div class="forgot-password-header">
                <div class="brand-logo">
                    <i class="fas fa-capsules"></i>
                    <h2>Pharmative</h2>
                </div>
                
                <div class="instruction-icon">
                    <i class="fas fa-key"></i>
                </div>
                
                <h3>Khôi phục mật khẩu</h3>
                <p>Nhập địa chỉ email của bạn và chúng tôi sẽ gửi cho bạn một liên kết để đặt lại mật khẩu.</p>
            </div>

            <!-- Alert Messages -->
            <c:if test="${not empty message}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle me-2"></i>${message}
                </div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle me-2"></i>${error}
                </div>
            </c:if>

            <!-- Forgot Password Form -->
            <form action="${pageContext.request.contextPath}/forgot-password" method="post" id="forgotPasswordForm">
                <div class="form-group">
                    <label for="email" class="form-label">Địa chỉ email</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="Nhập email của bạn" required>
                </div>

                <button type="submit" class="btn-send-reset" id="submitBtn">
                    <span class="loading-spinner" id="loadingSpinner"></span>
                    <i class="fas fa-paper-plane me-2"></i>Gửi liên kết khôi phục
                </button>
            </form>

            <!-- Success State (hidden by default) -->
            <div class="success-state" id="successState" style="display: none;">
                <div class="success-icon">
                    <i class="fas fa-check"></i>
                </div>
                <h4>Đã gửi liên kết!</h4>
                <p>Vui lòng kiểm tra email của bạn để đặt lại mật khẩu.</p>
            </div>

            <!-- Links -->
            <div class="forgot-password-links">
                <a href="${pageContext.request.contextPath}/login.jsp">
                    <i class="fas fa-arrow-left me-1"></i>Quay lại đăng nhập
                </a>
                <a href="${pageContext.request.contextPath}/register.jsp">
                    <i class="fas fa-user-plus me-1"></i>Tạo tài khoản mới
                </a>
            </div>
        </div>

        <div class="forgot-password-footer">
            &copy; 2023 Pharmative. Tất cả quyền được bảo lưu.
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Form submission handling
        document.getElementById('forgotPasswordForm').addEventListener('submit', function(e) {
            const submitBtn = document.getElementById('submitBtn');
            const loadingSpinner = document.getElementById('loadingSpinner');
            const email = document.getElementById('email').value;
            
            // Basic email validation
            if (!isValidEmail(email)) {
                e.preventDefault();
                showError('Vui lòng nhập địa chỉ email hợp lệ');
                return;
            }
            
            // Show loading state
            submitBtn.disabled = true;
            loadingSpinner.style.display = 'inline-block';
            submitBtn.querySelector('i').style.display = 'none';
            
            // Simulate form submission (in real scenario, this would be handled by the form action)
            setTimeout(() => {
                // If there's a success message from server, show success state
                <c:if test="${not empty message}">
                    showSuccessState();
                </c:if>
            }, 1000);
        });

        // Email validation function
        function isValidEmail(email) {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return emailRegex.test(email);
        }

        // Show error message
        function showError(message) {
            // Remove existing error alerts
            const existingAlert = document.querySelector('.alert-danger');
            if (existingAlert) {
                existingAlert.remove();
            }
            
            // Create new error alert
            const alertDiv = document.createElement('div');
            alertDiv.className = 'alert alert-danger';
            alertDiv.innerHTML = `<i class="fas fa-exclamation-circle me-2"></i>${message}`;
            
            // Insert after the header
            const header = document.querySelector('.forgot-password-header');
            header.parentNode.insertBefore(alertDiv, header.nextSibling);
            
            // Scroll to alert
            alertDiv.scrollIntoView({ behavior: 'smooth', block: 'center' });
        }

        // Show success state
        function showSuccessState() {
            const form = document.getElementById('forgotPasswordForm');
            const successState = document.getElementById('successState');
            
            form.style.display = 'none';
            successState.style.display = 'block';
        }

        // Auto focus on email field
        document.getElementById('email').focus();

        // Add subtle hover effect to card
        const forgotPasswordCard = document.querySelector('.forgot-password-card');
        forgotPasswordCard.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-2px)';
        });
        
        forgotPasswordCard.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0)';
        });

        // If there's a success message on page load, show success state
        <c:if test="${not empty message}">
            document.addEventListener('DOMContentLoaded', function() {
                showSuccessState();
            });
        </c:if>
    </script>
</body>
</html>