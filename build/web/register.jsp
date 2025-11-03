<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - Pharmative</title>

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
            padding: 20px;
            background-image: 
                radial-gradient(circle at 10% 20%, rgba(117,178,57,0.05) 0%, transparent 20%),
                radial-gradient(circle at 90% 80%, rgba(117,178,57,0.05) 0%, transparent 20%);
        }

        .register-container {
            width: 100%;
            max-width: 800px;
            margin: 0 auto;
            animation: fadeInUp 0.6s ease-out;
        }

        .breadcrumb-section {
            background: transparent;
            padding: 15px 0;
            margin-bottom: 30px;
        }

        .breadcrumb-section a {
            color: var(--brand-green);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.2s ease;
        }

        .breadcrumb-section a:hover {
            color: var(--brand-green-dark);
            text-decoration: underline;
        }

        .breadcrumb-section .text-black {
            color: #2b2e33 !important;
            font-weight: 600;
        }

        .register-card {
            background: var(--card-bg);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 
                0 10px 40px rgba(24, 39, 75, 0.12),
                0 4px 20px rgba(117, 178, 57, 0.08),
                inset 0 1px 0 rgba(255, 255, 255, 0.8);
            border: 1px solid rgba(117, 178, 57, 0.15);
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .register-card:hover {
            box-shadow: 
                0 16px 50px rgba(24, 39, 75, 0.15),
                0 8px 30px rgba(117, 178, 57, 0.12),
                inset 0 1px 0 rgba(255, 255, 255, 0.8);
            border-color: rgba(117, 178, 57, 0.25);
            transform: translateY(-2px);
        }

        /* Viền xanh tinh tế với gradient */
        .register-card::before {
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
        .register-card::after {
            content: "";
            position: absolute;
            top: -30%;
            right: -30%;
            width: 200px;
            height: 200px;
            background: radial-gradient(circle, rgba(117,178,57,0.08) 0%, transparent 70%);
            border-radius: 50%;
            z-index: 0;
        }

        .register-header {
            text-align: center;
            margin-bottom: 35px;
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

        .register-header h3 {
            font-weight: 600;
            color: #2b2e33;
            margin-bottom: 8px;
            font-size: 1.5rem;
        }

        .register-header p {
            color: var(--muted);
            font-size: 0.95rem;
            margin: 0;
        }

        .form-group {
            margin-bottom: 24px;
            position: relative;
            z-index: 1;
        }

        .form-label {
            font-weight: 600;
            color: #2b2e33;
            margin-bottom: 10px;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .form-label .text-danger {
            color: #dc3545 !important;
            font-size: 1.1rem;
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

        .password-strength {
            margin-top: 8px;
            height: 4px;
            background: #e9ecef;
            border-radius: 2px;
            overflow: hidden;
            position: relative;
        }

        .password-strength-bar {
            height: 100%;
            width: 0%;
            border-radius: 2px;
            transition: all 0.3s ease;
        }

        .strength-weak { background: #dc3545; width: 25%; }
        .strength-fair { background: #fd7e14; width: 50%; }
        .strength-good { background: #ffc107; width: 75%; }
        .strength-strong { background: var(--brand-green); width: 100%; }

        .password-strength-text {
            font-size: 0.8rem;
            margin-top: 4px;
            color: var(--muted);
        }

        .btn-register {
            background: linear-gradient(135deg, var(--brand-green), var(--brand-green-dark));
            color: white;
            border: none;
            border-radius: 12px;
            padding: 16px 20px;
            font-weight: 600;
            font-size: 1rem;
            width: 100%;
            transition: all 0.3s ease;
            margin-top: 20px;
            box-shadow: 
                0 4px 15px rgba(117,178,57,0.25),
                0 2px 4px rgba(117,178,57,0.1);
            position: relative;
            overflow: hidden;
        }

        .btn-register::before {
            content: "";
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s ease;
        }

        .btn-register:hover {
            transform: translateY(-3px);
            box-shadow: 
                0 8px 25px rgba(117,178,57,0.35),
                0 4px 8px rgba(117,178,57,0.15);
        }

        .btn-register:hover::before {
            left: 100%;
        }

        .btn-register:active {
            transform: translateY(-1px);
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

        .alert-danger {
            background: rgba(220,53,69,0.08);
            color: #dc3545;
            border-left: 4px solid #dc3545;
        }

        .register-links {
            text-align: center;
            margin-top: 30px;
            padding-top: 25px;
            border-top: 1px solid rgba(0,0,0,0.08);
            position: relative;
            z-index: 1;
        }

        .register-links a {
            color: var(--brand-green);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.2s ease;
            position: relative;
        }

        .register-links a:hover {
            color: var(--brand-green-dark);
            text-decoration: none;
        }

        .register-links a::after {
            content: "";
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--brand-green);
            transition: width 0.3s ease;
        }

        .register-links a:hover::after {
            width: 100%;
        }

        .register-footer {
            text-align: center;
            margin-top: 40px;
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
        @media (max-width: 768px) {
            .register-card {
                padding: 30px 25px;
                border-radius: 16px;
            }
            
            .brand-logo h2 {
                font-size: 1.6rem;
            }
            
            .brand-logo i {
                font-size: 2rem;
            }
            
            .register-card::after {
                display: none;
            }
        }

        @media (max-width: 576px) {
            body {
                padding: 15px;
            }
            
            .register-container {
                max-width: 100%;
            }
            
            .form-group.row > div {
                margin-bottom: 15px;
            }
        }
    </style>
</head>
<body>
    <div class="register-container">
        <!-- Breadcrumb -->
        <div class="breadcrumb-section">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 mb-0">
                        <a href="${pageContext.request.contextPath}/home">Home</a>
                        <span class="mx-2 mb-0">/</span>
                        <strong class="text-black">Đăng ký</strong>
                    </div>
                </div>
            </div>
        </div>

        <!-- Register Card -->
        <div class="register-card">
            <!-- Header -->
            <div class="register-header">
                <div class="brand-logo">
                    <i class="fas fa-capsules"></i>
                    <h2>Pharmative</h2>
                </div>
                <h3>Tạo tài khoản mới</h3>
                <p>Điền thông tin để đăng ký tài khoản</p>
            </div>

            <!-- Alert Messages -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle me-2"></i>${error}
                </div>
            </c:if>

            <!-- Register Form -->
            <form action="${pageContext.request.contextPath}/register" method="post">
                <div class="form-group row">
                    <div class="col-md-12">
                        <label for="fullname" class="form-label">
                            Họ và tên <span class="text-danger">*</span>
                        </label>
                        <input type="text" class="form-control" id="fullname" name="fullname" placeholder="Nhập họ và tên đầy đủ" required>
                    </div>
                </div>

                <div class="form-group row">
                    <div class="col-md-12">
                        <label for="email" class="form-label">
                            Email <span class="text-danger">*</span>
                        </label>
                        <input type="email" class="form-control" id="email" name="email" placeholder="Nhập địa chỉ email" required>
                    </div>
                </div>

                <div class="form-group row">
                    <div class="col-md-12">
                        <label for="phone" class="form-label">Số điện thoại</label>
                        <input type="text" class="form-control" id="phone" name="phone" placeholder="Nhập số điện thoại">
                    </div>
                </div>

                <div class="form-group row">
                    <div class="col-md-6">
                        <label for="password" class="form-label">
                            Mật khẩu <span class="text-danger">*</span>
                        </label>
                        <div class="password-input">
                            <input type="password" class="form-control" id="password" name="password" placeholder="Tạo mật khẩu" required>
                            <button type="button" class="toggle-password" data-target="password">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                        <div class="password-strength">
                            <div class="password-strength-bar" id="passwordStrengthBar"></div>
                        </div>
                        <div class="password-strength-text" id="passwordStrengthText"></div>
                    </div>
                    <div class="col-md-6">
                        <label for="confirm_password" class="form-label">
                            Xác nhận mật khẩu <span class="text-danger">*</span>
                        </label>
                        <div class="password-input">
                            <input type="password" class="form-control" id="confirm_password" name="confirm_password" placeholder="Xác nhận mật khẩu" required>
                            <button type="button" class="toggle-password" data-target="confirm_password">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                        <div class="password-match" id="passwordMatch" style="display: none;">
                            <small class="text-success"><i class="fas fa-check-circle"></i> Mật khẩu khớp</small>
                        </div>
                        <div class="password-mismatch" id="passwordMismatch" style="display: none;">
                            <small class="text-danger"><i class="fas fa-times-circle"></i> Mật khẩu không khớp</small>
                        </div>
                    </div>
                </div>

                <button type="submit" class="btn-register" id="submitBtn">
                    <i class="fas fa-user-plus me-2"></i>Đăng ký tài khoản
                </button>
            </form>

            <!-- Links -->
            <div class="register-links">
                <p class="mb-0">Đã có tài khoản? 
                    <a href="${pageContext.request.contextPath}/login.jsp">Đăng nhập ngay</a>
                </p>
            </div>
        </div>

        <div class="register-footer">
            &copy; 2023 Pharmative. Tất cả quyền được bảo lưu.
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Toggle password visibility
        document.querySelectorAll('.toggle-password').forEach(button => {
            button.addEventListener('click', function() {
                const target = this.getAttribute('data-target');
                const passwordInput = document.getElementById(target);
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
        });

        // Password strength checker
        document.getElementById('password').addEventListener('input', function() {
            const password = this.value;
            const strengthBar = document.getElementById('passwordStrengthBar');
            const strengthText = document.getElementById('passwordStrengthText');
            
            let strength = 0;
            let text = '';
            let className = '';
            
            if (password.length >= 8) strength += 25;
            if (password.match(/[a-z]/) && password.match(/[A-Z]/)) strength += 25;
            if (password.match(/\d/)) strength += 25;
            if (password.match(/[^a-zA-Z\d]/)) strength += 25;
            
            if (strength === 0) {
                text = '';
                className = '';
            } else if (strength <= 25) {
                text = 'Mật khẩu yếu';
                className = 'strength-weak';
            } else if (strength <= 50) {
                text = 'Mật khẩu trung bình';
                className = 'strength-fair';
            } else if (strength <= 75) {
                text = 'Mật khẩu tốt';
                className = 'strength-good';
            } else {
                text = 'Mật khẩu mạnh';
                className = 'strength-strong';
            }
            
            strengthBar.className = 'password-strength-bar ' + className;
            strengthText.textContent = text;
        });

        // Password confirmation check
        document.getElementById('confirm_password').addEventListener('input', function() {
            const password = document.getElementById('password').value;
            const confirmPassword = this.value;
            const matchDiv = document.getElementById('passwordMatch');
            const mismatchDiv = document.getElementById('passwordMismatch');
            
            if (confirmPassword === '') {
                matchDiv.style.display = 'none';
                mismatchDiv.style.display = 'none';
            } else if (password === confirmPassword) {
                matchDiv.style.display = 'block';
                mismatchDiv.style.display = 'none';
            } else {
                matchDiv.style.display = 'none';
                mismatchDiv.style.display = 'block';
            }
        });

        // Form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirm_password').value;
            
            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Mật khẩu xác nhận không khớp!');
            }
        });

        // Auto focus on first field
        document.getElementById('fullname').focus();

        // Add subtle hover effect to register card
        const registerCard = document.querySelector('.register-card');
        registerCard.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-2px)';
        });
        
        registerCard.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0)';
        });
    </script>
</body>
</html>