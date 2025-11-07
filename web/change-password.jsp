<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    response.setCharacterEncoding("UTF-8");
%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Đổi mật khẩu | Pharmative</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <base href="${cpath}/">

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

            .account-container {
                max-width: 800px;
                margin: 40px auto;
                padding: 0 15px;
            }

            .account-card {
                background: var(--white);
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                overflow: hidden;
                margin-bottom: 30px;
            }

            .account-header {
                padding: 25px 30px;
                border-bottom: 1px solid #eee;
                background-color: #f8f9fa;
            }

            .account-body {
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

            .password-strength {
                height: 4px;
                background-color: #e9ecef;
                border-radius: 2px;
                margin-top: 5px;
                overflow: hidden;
            }

            .password-strength-bar {
                height: 100%;
                width: 0%;
                transition: var(--transition);
            }

            .strength-weak {
                background-color: #dc3545;
                width: 25%;
            }

            .strength-fair {
                background-color: #fd7e14;
                width: 50%;
            }

            .strength-good {
                background-color: #ffc107;
                width: 75%;
            }

            .strength-strong {
                background-color: #28a745;
                width: 100%;
            }

            .alert {
                border-radius: var(--border-radius);
                padding: 15px;
                margin-bottom: 25px;
            }

            .alert-success {
                background-color: rgba(46, 125, 50, 0.1);
                border: 1px solid var(--primary-color);
                color: var(--primary-dark);
            }

            .alert-danger {
                background-color: rgba(220, 53, 69, 0.1);
                border: 1px solid #dc3545;
                color: #dc3545;
            }

            .password-requirements {
                background-color: #f8f9fa;
                border-radius: var(--border-radius);
                padding: 20px;
                margin-top: 20px;
            }

            .requirement-item {
                display: flex;
                align-items: center;
                margin-bottom: 8px;
                font-size: 0.9rem;
            }

            .requirement-item.valid {
                color: var(--primary-color);
            }

            .requirement-item.invalid {
                color: var(--text-light);
            }

            .requirement-icon {
                margin-right: 8px;
                font-size: 0.8rem;
            }

            @media (max-width: 768px) {
                .account-container {
                    margin: 20px auto;
                }

                .account-body {
                    padding: 20px;
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
                            <a href="${cpath}/home">Trang chủ</a> 
                            <span class="mx-2 mb-0">/</span>
                            <a href="${cpath}/account">Tài khoản</a>
                            <span class="mx-2 mb-0">/</span>
                            <strong class="text-black">Đổi mật khẩu</strong>
                        </div>
                    </div>
                </div>
            </div>

            <div class="account-container">
                <div class="account-card">
                    <div class="account-header">
                        <h2 class="mb-0">Đổi mật khẩu</h2>
                        <p class="mb-0 text-muted">Bảo vệ tài khoản của bạn với mật khẩu mạnh</p>
                    </div>

                    <div class="account-body">
                        <!-- Thông báo -->
                        <c:if test="${not empty msg}">
                            <div class="alert alert-success">
                                <i class="icon-check"></i> ${msg}
                            </div>
                        </c:if>

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger">
                                <i class="icon-warning"></i> ${error}
                            </div>
                        </c:if>

                        <form action="${cpath}/change-password" method="post" id="changePasswordForm">
                            <div class="form-group">
                                <label for="oldPassword" class="form-label">Mật khẩu hiện tại <span class="text-danger">*</span></label>
                                <input type="password" class="form-control" id="oldPassword" name="oldPassword" required>
                            </div>

                            <div class="form-group">
                                <label for="newPassword" class="form-label">Mật khẩu mới <span class="text-danger">*</span></label>
                                <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                                <div class="password-strength">
                                    <div class="password-strength-bar" id="passwordStrengthBar"></div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="confirmPassword" class="form-label">Xác nhận mật khẩu mới <span class="text-danger">*</span></label>
                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                                <div class="text-danger mt-1" id="confirmMessage" style="font-size: 0.9rem;"></div>
                            </div>

                            <!-- Password Requirements -->
                            <div class="password-requirements">
                                <h6 class="mb-3">Yêu cầu mật khẩu:</h6>
                                <div class="requirement-item invalid" id="reqLength">
                                    <i class="requirement-icon">○</i>
                                    Ít nhất 8 ký tự
                                </div>
                                <div class="requirement-item invalid" id="reqUppercase">
                                    <i class="requirement-icon">○</i>
                                    Có ít nhất 1 chữ hoa
                                </div>
                                <div class="requirement-item invalid" id="reqLowercase">
                                    <i class="requirement-icon">○</i>
                                    Có ít nhất 1 chữ thường
                                </div>
                                <div class="requirement-item invalid" id="reqNumber">
                                    <i class="requirement-icon">○</i>
                                    Có ít nhất 1 số
                                </div>
                                <div class="requirement-item invalid" id="reqSpecial">
                                    <i class="requirement-icon">○</i>
                                    Có ít nhất 1 ký tự đặc biệt
                                </div>
                            </div>

                            <div class="form-group mt-4">
                                <button type="submit" class="btn btn-primary btn-lg w-100" id="submitBtn" disabled>
                                    <i class="icon-lock"></i> Đổi mật khẩu
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <jsp:include page="/common/footerChinh.jsp" />
        </div>

        <script src="js/jquery-3.3.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>

        <script>
            $(document).ready(function () {
                const $newPassword = $('#newPassword');
                const $confirmPassword = $('#confirmPassword');
                const $confirmMessage = $('#confirmMessage');
                const $passwordStrengthBar = $('#passwordStrengthBar');
                const $submitBtn = $('#submitBtn');

                let isPasswordValid = false;
                let isPasswordMatch = false;

                // Kiểm tra độ mạnh mật khẩu
                $newPassword.on('input', function () {
                    const password = $(this).val();
                    checkPasswordStrength(password);
                    checkPasswordMatch();
                    updateSubmitButton();
                });

                // Kiểm tra xác nhận mật khẩu
                $confirmPassword.on('input', function () {
                    checkPasswordMatch();
                    updateSubmitButton();
                });

                function checkPasswordStrength(password) {
                    let strength = 0;
                    const requirements = {
                        length: password.length >= 8,
                        uppercase: /[A-Z]/.test(password),
                        lowercase: /[a-z]/.test(password),
                        number: /[0-9]/.test(password),
                        special: /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(password)
                    };

                    // Cập nhật hiển thị requirements
                    $('#reqLength').toggleClass('valid', requirements.length).toggleClass('invalid', !requirements.length);
                    $('#reqUppercase').toggleClass('valid', requirements.uppercase).toggleClass('invalid', !requirements.uppercase);
                    $('#reqLowercase').toggleClass('valid', requirements.lowercase).toggleClass('invalid', !requirements.lowercase);
                    $('#reqNumber').toggleClass('valid', requirements.number).toggleClass('invalid', !requirements.number);
                    $('#reqSpecial').toggleClass('valid', requirements.special).toggleClass('invalid', !requirements.special);

                    // Tính điểm độ mạnh
                    if (requirements.length)
                        strength += 25;
                    if (requirements.uppercase)
                        strength += 25;
                    if (requirements.lowercase)
                        strength += 25;
                    if (requirements.number || requirements.special)
                        strength += 25;

                    // Cập nhật thanh độ mạnh
                    $passwordStrengthBar.removeClass('strength-weak strength-fair strength-good strength-strong');

                    if (strength <= 25) {
                        $passwordStrengthBar.addClass('strength-weak');
                    } else if (strength <= 50) {
                        $passwordStrengthBar.addClass('strength-fair');
                    } else if (strength <= 75) {
                        $passwordStrengthBar.addClass('strength-good');
                    } else {
                        $passwordStrengthBar.addClass('strength-strong');
                    }

                    // Kiểm tra tất cả requirements
                    isPasswordValid = Object.values(requirements).every(req => req);
                }

                function checkPasswordMatch() {
                    const password = $newPassword.val();
                    const confirm = $confirmPassword.val();

                    if (confirm === '') {
                        $confirmMessage.text('');
                        isPasswordMatch = false;
                    } else if (password === confirm) {
                        $confirmMessage.text('✓ Mật khẩu khớp').removeClass('text-danger').addClass('text-success');
                        isPasswordMatch = true;
                    } else {
                        $confirmMessage.text('✗ Mật khẩu không khớp').removeClass('text-success').addClass('text-danger');
                        isPasswordMatch = false;
                    }
                }

                function updateSubmitButton() {
                    const oldPassword = $('#oldPassword').val();
                    if (oldPassword && isPasswordValid && isPasswordMatch) {
                        $submitBtn.prop('disabled', false);
                    } else {
                        $submitBtn.prop('disabled', true);
                    }
                }

                // Kiểm tra mật khẩu hiện tại
                $('#oldPassword').on('input', updateSubmitButton);

                // Xác nhận trước khi submit
                $('#changePasswordForm').on('submit', function (e) {
                    if (!isPasswordValid) {
                        e.preventDefault();
                        alert('Vui lòng đảm bảo mật khẩu mới đáp ứng tất cả yêu cầu.');
                        return false;
                    }

                    if (!isPasswordMatch) {
                        e.preventDefault();
                        alert('Mật khẩu xác nhận không khớp.');
                        return false;
                    }

                    return true;
                });
            });
        </script>
    </body>
</html>