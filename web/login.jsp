<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Pharmative</title>

    <!-- Bootstrap + FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico">
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

        .login-container {
            width: 100%;
            max-width: 420px;
            animation: fadeInUp 0.6s ease-out;
        }

        .login-card {
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

        .login-card:hover {
            box-shadow: 
                0 16px 50px rgba(24, 39, 75, 0.15),
                0 8px 30px rgba(117, 178, 57, 0.12),
                inset 0 1px 0 rgba(255, 255, 255, 0.8);
            border-color: rgba(117, 178, 57, 0.25);
            transform: translateY(-2px);
        }

        /* Viền xanh tinh tế với gradient */
        .login-card::before {
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
        .login-card::after {
            content: "";
            position: absolute;
            top: -50%;
            right: -50%;
            width: 100px;
            height: 100px;
            background: radial-gradient(circle, rgba(117,178,57,0.1) 0%, transparent 70%);
            border-radius: 50%;
            z-index: 0;
        }

        .login-header {
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
            margin-bottom: 15px;
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

        .login-header h3 {
            font-weight: 600;
            color: #2b2e33;
            margin-bottom: 8px;
        }

        .login-header p {
            color: var(--muted);
            font-size: 0.95rem;
            margin: 0;
        }

        .form-group {
            margin-bottom: 20px;
            position: relative;
            z-index: 1;
        }

        .form-label {
            font-weight: 600;
            color: #2b2e33;
            margin-bottom: 8px;
            font-size: 0.9rem;
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

        .password-input {
            position: relative;
        }

        .toggle-password {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: var(--muted);
            cursor: pointer;
            padding: 8px;
            border-radius: 6px;
            transition: all 0.2s ease;
        }

        .toggle-password:hover {
            color: var(--brand-green);
            background: rgba(117,178,57,0.08);
        }

        .btn-login {
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

        .btn-login::before {
            content: "";
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s ease;
        }

        .btn-login:hover {
            transform: translateY(-3px);
            box-shadow: 
                0 8px 25px rgba(117,178,57,0.35),
                0 4px 8px rgba(117,178,57,0.15);
        }

        .btn-login:hover::before {
            left: 100%;
        }

        .btn-login:active {
            transform: translateY(-1px);
        }

        .alert {
            border-radius: 12px;
            border: none;
            padding: 14px 16px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            position: relative;
            z-index: 1;
        }

        .alert-danger {
            background: rgba(220,53,69,0.08);
            color: #dc3545;
            border-left: 4px solid #dc3545;
        }

        .alert-success {
            background: rgba(117,178,57,0.08);
            color: var(--brand-green);
            border-left: 4px solid var(--brand-green);
        }

        .login-links {
            text-align: center;
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid rgba(0,0,0,0.08);
            position: relative;
            z-index: 1;
        }

        .login-links a {
            color: var(--brand-green);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.2s ease;
            position: relative;
        }

        .login-links a:hover {
            color: var(--brand-green-dark);
            text-decoration: none;
        }

        .login-links a::after {
            content: "";
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--brand-green);
            transition: width 0.3s ease;
        }

        .login-links a:hover::after {
            width: 100%;
        }

        .login-footer {
            text-align: center;
            margin-top: 30px;
            color: var(--muted);
            font-size: 0.85rem;
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

        /* Responsive */
        @media (max-width: 576px) {
            .login-card {
                padding: 30px 25px;
                border-radius: 16px;
            }
            
            .brand-logo h2 {
                font-size: 1.6rem;
            }
            
            .brand-logo i {
                font-size: 2rem;
            }
            
            .login-card::after {
                display: none;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-card">
            <!-- Header -->
            <div class="login-header">
                <div class="brand-logo">
                    <i class="fas fa-capsules"></i>
                    <h2>Pharmative</h2>
                </div>
                <h3>Đăng nhập tài khoản</h3>
                <p>Nhập thông tin đăng nhập của bạn</p>
            </div>

            <!-- Alert Messages -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle me-2"></i>${error}
                </div>
            </c:if>
            <c:if test="${param.success eq 'verified'}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle me-2"></i>Xác thực thành công. Vui lòng đăng nhập.
                </div>
            </c:if>
            <c:if test="${param.success eq 'reset'}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle me-2"></i>Đặt lại mật khẩu thành công. Vui lòng đăng nhập.
                </div>
            </c:if>

            <!-- Login Form -->
            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="form-group">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="Nhập email của bạn" required>
                </div>

                <div class="form-group">
                    <label for="password" class="form-label">Mật khẩu</label>
                    <div class="password-input">
                        <input type="password" class="form-control" id="password" name="password" placeholder="Nhập mật khẩu" required>
                        <button type="button" class="toggle-password" id="togglePassword">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                </div>

                <button type="submit" class="btn-login">
                    <i class="fas fa-sign-in-alt me-2"></i>Đăng nhập
                </button>
            </form>

            <!-- Links -->
            <div class="login-links">
                <p class="mb-2">Chưa có tài khoản? 
                    <a href="${pageContext.request.contextPath}/register.jsp">Đăng ký ngay</a>
                </p>
                <a href="${pageContext.request.contextPath}/forgot-password.jsp">Quên mật khẩu?</a>
            </div>
        </div>

        <div class="login-footer">
            &copy; 2023 Pharmative. Tất cả quyền được bảo lưu.
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Toggle password visibility
        document.getElementById('togglePassword').addEventListener('click', function() {
            const passwordInput = document.getElementById('password');
            const icon = this.querySelector('i');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        });

        // Auto focus on email field
        document.getElementById('email').focus();

        // Add subtle hover effect to login card
        const loginCard = document.querySelector('.login-card');
        loginCard.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-2px)';
        });
        
        loginCard.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0)';
        });
    </script>
</body>
</html>