<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="cpath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt lại mật khẩu - Pharmative</title>

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

        .reset-password-container {
            width: 100%;
            max-width: 480px;
            animation: fadeInUp 0.6s ease-out;
        }

        .reset-password-card {
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

        .reset-password-card:hover {
            box-shadow: 
                0 16px 50px rgba(24, 39, 75, 0.15),
                0 8px 30px rgba(117, 178, 57, 0.12),
                inset 0 1px 0 rgba(255, 255, 255, 0.8);
            border-color: rgba(117, 178, 57, 0.25);
            transform: translateY(-2px);
        }

        /* Viền xanh tinh tế với gradient */
        .reset-password-card::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(135deg, var(--brand-green), var(--brand-green-dark));
            border-radius: 20px 20px 0 0;
        }

        .reset-password-header {
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

        .reset-password-header h3 {
            font-weight: 600;
            color: #2b2e33;
            margin-bottom: 12px;
            font-size: 1.5rem;
        }

        .reset-password-header p {
            color: var(--muted);
            font-size: 0.95rem;
            line-height: 1.5;
            margin: 0;
        }

        .password-icon {
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

        .password-input {
            position: relative;
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

        .form-control.error {
            border-color: #dc3545;
            box-shadow: 0 0 0 3px rgba(220,53,69,0.1);
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

        .password-match {
            margin-top: 8px;
        }

        .password-match .text-success,
        .password-match .text-danger {
            font-size: 0.8rem;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .error-message {
            color: #dc3545;
            font-size: 0.8rem;
            margin-top: 6px;
            display: flex;
            align-items: center;
            gap: 4px;
            animation: slideDown 0.3s ease;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .btn-reset-password {
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

        .btn-reset-password::before {
            content: "";
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s ease;
        }

        .btn-reset-password:hover {
            transform: translateY(-3px);
            box-shadow: 
                0 8px 25px rgba(117,178,57,0.35),
                0 4px 8px rgba(117,178,57,0.15);
        }

        .btn-reset-password:hover::before {
            left: 100%;
        }

        .btn-reset-password:active {
            transform: translateY(-1px);
        }

        .btn-reset-password:disabled {
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

        .reset-password-links {
            text-align: center;
            margin-top: 30px;
            padding-top: 25px;
            border-top: 1px solid rgba(0,0,0,0.08);
            position: relative;
            z-index: 1;
        }

        .reset-password-links a {
            color: var(--brand-green);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.2s ease;
            position: relative;
        }

        .reset-password-links a:hover {
            color: var(--brand-green-dark);
            text-decoration: none;
        }

        .reset-password-links a::after {
            content: "";
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--brand-green);
            transition: width 0.3s ease;
        }

        .reset-password-links a:hover::after {
            width: 100%;
        }

        .reset-password-footer {
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

        /* Password requirements */
        .password-requirements {
            background: var(--brand-green-soft);
            border-radius: 10px;
            padding: 15px;
            margin-top: 15px;
            border-left: 3px solid var(--brand-green);
        }

        .password-requirements h6 {
            font-size: 0.85rem;
            font-weight: 600;
            color: var(--brand-green);
            margin-bottom: 8px;
        }

        .password-requirements ul {
            list-style: none;
            padding: 0;
            margin: 0;
            font-size: 0.8rem;
            color: var(--muted);
        }

        .password-requirements li {
            margin-bottom: 4px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .requirement-met {
            color: var(--brand-green);
        }

        .requirement-unmet {
            color: var(--muted);
        }

        /* Responsive */
        @media (max-width: 576px) {
            .reset-password-card {
                padding: 30px 25px;
                border-radius: 16px;
            }
            
            .brand-logo h2 {
                font-size: 1.6rem;
            }
            
            .brand-logo i {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
    <div class="reset-password-container">
        <div class="reset-password-card">
            <!-- Header -->
            <div class="reset-password-header">
                <div class="brand-logo">
                    <i class="fas fa-capsules"></i>
                    <h2>Pharmative</h2>
                </div>
                
                <div class="password-icon">
                    <i class="fas fa-lock"></i>
                </div>
                
                <h3>Tạo mật khẩu mới</h3>
                <p>Vui lòng tạo mật khẩu mới cho tài khoản của bạn</p>
            </div>

            <!-- Alert Messages -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle me-2"></i>${error}
                </div>
            </c:if>

            <c:if test="${not empty message}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle me-2"></i>${message}
                </div>
            </c:if>

            <!-- Reset Password Form -->
            <form action="${cpath}/reset-password" method="post" id="resetPasswordForm">
                <input type="hidden" name="token" value="${param.token}">

                <div class="form-group">
                    <label for="password" class="form-label">Mật khẩu mới</label>
                    <div class="password-input">
                        <input type="password" class="form-control" id="password" name="password" placeholder="Nhập mật khẩu mới" required>
                        <button type="button" class="toggle-password" data-target="password">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                    <div class="password-strength">
                        <div class="password-strength-bar" id="passwordStrengthBar"></div>
                    </div>
                    <div class="password-strength-text" id="passwordStrengthText"></div>
                    
                    <!-- Error message for password -->
                    <div class="error-message" id="passwordError" style="display: none;"></div>
                    
                    <!-- Password Requirements -->
                    <div class="password-requirements">
                        <h6>Yêu cầu mật khẩu:</h6>
                        <ul>
                            <li id="req-length" class="requirement-unmet">
                                <i class="fas fa-circle" style="font-size: 6px;"></i>
                                Ít nhất 8 ký tự
                            </li>
                            <li id="req-uppercase" class="requirement-unmet">
                                <i class="fas fa-circle" style="font-size: 6px;"></i>
                                Chứa chữ hoa và chữ thường
                            </li>
                            <li id="req-number" class="requirement-unmet">
                                <i class="fas fa-circle" style="font-size: 6px;"></i>
                                Chứa ít nhất 1 số
                            </li>
                            <li id="req-special" class="requirement-unmet">
                                <i class="fas fa-circle" style="font-size: 6px;"></i>
                                Chứa ít nhất 1 ký tự đặc biệt
                            </li>
                        </ul>
                    </div>
                </div>

                <div class="form-group">
                    <label for="confirm_password" class="form-label">Xác nhận mật khẩu mới</label>
                    <div class="password-input">
                        <input type="password" class="form-control" id="confirm_password" name="confirm_password" placeholder="Xác nhận mật khẩu mới" required>
                        <button type="button" class="toggle-password" data-target="confirm_password">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                    
                    <!-- Error message for confirm password -->
                    <div class="error-message" id="confirmPasswordError" style="display: none;"></div>
                    
                    <div class="password-match">
                        <div id="passwordMatch" style="display: none;">
                            <small class="text-success">
                                <i class="fas fa-check-circle"></i> Mật khẩu khớp
                            </small>
                        </div>
                        <div id="passwordMismatch" style="display: none;">
                            <small class="text-danger">
                                <i class="fas fa-times-circle"></i> Mật khẩu không khớp
                            </small>
                        </div>
                    </div>
                </div>

                <button type="submit" class="btn-reset-password" id="submitBtn">
                    <span class="loading-spinner" id="loadingSpinner"></span>
                    <i class="fas fa-redo me-2"></i>Đặt lại mật khẩu
                </button>
            </form>

            <!-- Links -->
            <div class="reset-password-links">
                <a href="${cpath}/login.jsp">
                    <i class="fas fa-arrow-left me-1"></i>Quay lại đăng nhập
                </a>
            </div>
        </div>

        <div class="reset-password-footer">
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

        // Real-time validation for password field
        document.getElementById('password').addEventListener('blur', validatePassword);
        document.getElementById('password').addEventListener('input', function() {
            validatePassword();
            updatePasswordStrength();
        });

        // Real-time validation for confirm password field
        document.getElementById('confirm_password').addEventListener('blur', validateConfirmPassword);
        document.getElementById('confirm_password').addEventListener('input', validateConfirmPassword);

        // Password validation function
        function validatePassword() {
            const password = document.getElementById('password').value;
            const errorElement = document.getElementById('passwordError');
            const passwordInput = document.getElementById('password');

            // Clear previous error
            hideError('passwordError');
            passwordInput.classList.remove('error');

            if (!password) {
                showError('passwordError', 'Vui lòng nhập mật khẩu mới');
                passwordInput.classList.add('error');
                return false;
            }

            if (password.length < 8) {
                showError('passwordError', 'Mật khẩu phải có ít nhất 8 ký tự');
                passwordInput.classList.add('error');
                return false;
            }

            const hasUpperCase = /[A-Z]/.test(password);
            const hasLowerCase = /[a-z]/.test(password);
            const hasNumber = /\d/.test(password);
            const hasSpecialChar = /[!@#$%^&*(),.?":{}|<>]/.test(password);

            if (!hasUpperCase || !hasLowerCase) {
                showError('passwordError', 'Mật khẩu phải chứa cả chữ hoa và chữ thường');
                passwordInput.classList.add('error');
                return false;
            }

            if (!hasNumber) {
                showError('passwordError', 'Mật khẩu phải chứa ít nhất 1 số');
                passwordInput.classList.add('error');
                return false;
            }

            if (!hasSpecialChar) {
                showError('passwordError', 'Mật khẩu phải chứa ít nhất 1 ký tự đặc biệt');
                passwordInput.classList.add('error');
                return false;
            }

            return true;
        }

        // Confirm password validation function
        function validateConfirmPassword() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirm_password').value;
            const errorElement = document.getElementById('confirmPasswordError');
            const confirmInput = document.getElementById('confirm_password');
            const matchDiv = document.getElementById('passwordMatch');
            const mismatchDiv = document.getElementById('passwordMismatch');

            // Clear previous error
            hideError('confirmPasswordError');
            confirmInput.classList.remove('error');
            matchDiv.style.display = 'none';
            mismatchDiv.style.display = 'none';

            if (!confirmPassword) {
                showError('confirmPasswordError', 'Vui lòng xác nhận mật khẩu');
                confirmInput.classList.add('error');
                return false;
            }

            if (password !== confirmPassword) {
                showError('confirmPasswordError', 'Mật khẩu xác nhận không khớp');
                confirmInput.classList.add('error');
                mismatchDiv.style.display = 'block';
                return false;
            }

            matchDiv.style.display = 'block';
            return true;
        }

        // Password strength checker
        function updatePasswordStrength() {
            const password = document.getElementById('password').value;
            const strengthBar = document.getElementById('passwordStrengthBar');
            const strengthText = document.getElementById('passwordStrengthText');
            
            // Check requirements
            const hasMinLength = password.length >= 8;
            const hasUpperCase = /[A-Z]/.test(password);
            const hasLowerCase = /[a-z]/.test(password);
            const hasNumber = /\d/.test(password);
            const hasSpecialChar = /[!@#$%^&*(),.?":{}|<>]/.test(password);
            
            // Update requirement indicators
            updateRequirement('req-length', hasMinLength);
            updateRequirement('req-uppercase', hasUpperCase && hasLowerCase);
            updateRequirement('req-number', hasNumber);
            updateRequirement('req-special', hasSpecialChar);
            
            // Calculate strength
            let strength = 0;
            let text = '';
            let className = '';
            
            if (hasMinLength) strength += 20;
            if (hasUpperCase && hasLowerCase) strength += 20;
            if (hasNumber) strength += 20;
            if (hasSpecialChar) strength += 20;
            if (password.length >= 12) strength += 20;
            
            if (strength === 0) {
                text = '';
                className = '';
            } else if (strength <= 20) {
                text = 'Mật khẩu yếu';
                className = 'strength-weak';
            } else if (strength <= 40) {
                text = 'Mật khẩu trung bình';
                className = 'strength-fair';
            } else if (strength <= 60) {
                text = 'Mật khẩu tốt';
                className = 'strength-good';
            } else {
                text = 'Mật khẩu mạnh';
                className = 'strength-strong';
            }
            
            strengthBar.className = 'password-strength-bar ' + className;
            strengthText.textContent = text;
        }

        // Update requirement indicator
        function updateRequirement(elementId, isMet) {
            const element = document.getElementById(elementId);
            if (isMet) {
                element.className = 'requirement-met';
                element.innerHTML = '<i class="fas fa-check-circle" style="font-size: 10px;"></i> ' + element.textContent;
            } else {
                element.className = 'requirement-unmet';
                element.innerHTML = '<i class="fas fa-circle" style="font-size: 6px;"></i> ' + element.textContent.replace(/<i class="fas fa-check-circle" style="font-size: 10px;"><\/i> /, '');
            }
        }

        // Show error message
        function showError(elementId, message) {
            const errorElement = document.getElementById(elementId);
            errorElement.innerHTML = `<i class="fas fa-exclamation-circle"></i> ${message}`;
            errorElement.style.display = 'flex';
        }

        // Hide error message
        function hideError(elementId) {
            const errorElement = document.getElementById(elementId);
            errorElement.style.display = 'none';
        }

        // Form validation on submit
        document.getElementById('resetPasswordForm').addEventListener('submit', function(e) {
            const isPasswordValid = validatePassword();
            const isConfirmPasswordValid = validateConfirmPassword();
            const submitBtn = document.getElementById('submitBtn');
            const loadingSpinner = document.getElementById('loadingSpinner');

            if (!isPasswordValid || !isConfirmPasswordValid) {
                e.preventDefault();
                // Focus on first invalid field
                if (!isPasswordValid) {
                    document.getElementById('password').focus();
                } else if (!isConfirmPasswordValid) {
                    document.getElementById('confirm_password').focus();
                }
                return;
            }

            // Show loading state
            submitBtn.disabled = true;
            loadingSpinner.style.display = 'inline-block';
            submitBtn.querySelector('i').style.display = 'none';
        });

        // Auto focus on password field
        document.getElementById('password').focus();

        // Add subtle hover effect to card
        const resetPasswordCard = document.querySelector('.reset-password-card');
        resetPasswordCard.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-2px)';
        });
        
        resetPasswordCard.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0)';
        });
    </script>
</body>
</html>