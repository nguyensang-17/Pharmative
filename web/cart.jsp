<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    response.setCharacterEncoding("UTF-8");
%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8">
        <title>Giỏ hàng | Pharmative</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Fonts + CSS -->
        <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800&display=swap" rel="stylesheet">
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico">
        <link rel="stylesheet" href="${cpath}/css/bootstrap.min.css">
        <link rel="stylesheet" href="${cpath}/css/style.css">

        <style>
            :root{
                --primary:#2e7d32;
                --primary-dark:#1b5e20;
                --primary-light:#4caf50;
                --bg:#f8f9fa;
                --radius:12px;
                --shadow:0 4px 16px rgba(0,0,0,.06)
            }
            body{
                font-family:'Nunito',sans-serif;
                background:var(--bg)
            }
            .cart-wrap{
                max-width:1200px;
                margin:30px auto;
                padding:0 16px
            }
            .card{
                background:#fff;
                border-radius:var(--radius);
                box-shadow:var(--shadow);
                overflow:hidden;
                border:none
            }
            .card-head{
                padding:24px 28px;
                border-bottom:2px solid #f0f0f0;
                background:linear-gradient(135deg, #fafafa 0%, #ffffff 100%)
            }
            .card-head h2{
                font-size:1.75rem;
                font-weight:800;
                color:#1a1a1a;
                margin:0 0 6px;
                display:flex;
                align-items:center;
                gap:12px
            }
            .cart-badge{
                display:inline-flex;
                align-items:center;
                justify-content:center;
                background:var(--primary);
                color:#fff;
                font-size:0.9rem;
                font-weight:700;
                padding:4px 12px;
                border-radius:20px;
                min-width:40px
            }
            .card-subtitle{
                color:#666;
                font-size:0.95rem;
                margin:0;
                font-weight:400
            }
            .card-body{
                padding:28px
            }
            .cart-item{
                display:flex;
                align-items:center;
                gap:20px;
                padding:24px 0;
                border-bottom:1px solid #f0f0f0;
                transition:all .3s ease
            }
            .cart-item:hover{
                background:#fafafa;
                margin:0 -12px;
                padding:24px 12px;
                border-radius:8px
            }
            .cart-item:last-child{
                border-bottom:none
            }
            .thumb{
                width:100px;
                height:100px;
                border-radius:12px;
                overflow:hidden;
                flex:0 0 auto;
                border:1px solid #f0f0f0;
                background:#fff
            }
            .thumb img{
                width:100%;
                height:100%;
                object-fit:cover;
                transition:transform .3s ease
            }
            .cart-item:hover .thumb img{
                transform:scale(1.05)
            }
            .product-info{
                flex:1;
                min-width:0
            }
            .title{
                font-weight:800;
                margin:0 0 8px;
                font-size:1.1rem;
                color:#1a1a1a;
                line-height:1.4
            }
            .price{
                color:var(--primary-dark);
                font-weight:700;
                font-size:1rem;
                display:inline-block;
                padding:4px 10px;
                background:#e8f5e9;
                border-radius:6px
            }
            .qty{
                display:flex;
                align-items:center;
                gap:8px;
                margin-top:12px
            }
            .qty .btn{
                width:36px;
                height:36px;
                border-radius:8px;
                display:flex;
                align-items:center;
                justify-content:center;
                padding:0;
                font-size:1.3rem;
                line-height:1;
                border:2px solid #e0e0e0;
                background:#fff;
                color:#555;
                transition:all .2s ease;
                font-weight:600
            }
            .qty .btn:hover:not(:disabled){
                background:var(--primary);
                border-color:var(--primary);
                color:#fff;
                transform:translateY(-2px);
                box-shadow:0 4px 8px rgba(46,125,50,.2)
            }
            .qty .btn:disabled{
                opacity:.4;
                cursor:not-allowed
            }
            .qty input{
                width:70px;
                height:40px;
                text-align:center;
                border:2px solid #e0e0e0;
                border-radius:8px;
                font-weight:700;
                font-size:1.05rem;
                transition:all .2s ease
            }
            .qty input:focus{
                outline:none;
                border-color:var(--primary);
                box-shadow:0 0 0 3px rgba(46,125,50,.1)
            }
            .qty input:disabled{
                background:#f5f5f5;
                cursor:not-allowed
            }
            .qty input.updating{
                border-color:var(--primary-light);
                animation:pulse .5s ease-in-out
            }
            @keyframes pulse{
                0%, 100%{
                    opacity:1
                }
                50%{
                    opacity:.7
                }
            }
            .line-total{
                min-width:150px;
                text-align:right;
                font-weight:800;
                color:var(--primary-dark);
                font-size:1.3rem;
                transition:all .3s ease
            }
            .line-total.updating{
                color:var(--primary-light);
                transform:scale(1.05)
            }
            .btn-remove{
                border:none;
                background:#fff;
                color:#dc3545;
                cursor:pointer;
                padding:8px;
                transition:all .2s ease;
                border-radius:8px;
                display:flex;
                align-items:center;
                justify-content:center;
                margin-left:8px
            }
            .btn-remove:hover:not(:disabled){
                background:#fee;
                transform:scale(1.1)
            }
            .btn-remove:disabled{
                opacity:.4;
                cursor:not-allowed;
                transform:none
            }
            .summary{
                background:linear-gradient(135deg, #f8f9fa 0%, #ffffff 100%);
                border-radius:12px;
                padding:24px;
                margin-top:24px;
                border:2px solid #f0f0f0
            }
            .row-sum{
                display:flex;
                justify-content:space-between;
                padding:12px 0;
                border-bottom:1px solid #e8e8e8;
                font-size:1.05rem
            }
            .row-sum:last-child{
                border-bottom:none;
                margin-top:12px;
                padding-top:20px;
                border-top:2px solid #e0e0e0
            }
            .sum-total{
                font-size:1.5rem;
                font-weight:900;
                color:var(--primary-dark)
            }
            .empty{
                padding:80px 20px;
                text-align:center
            }
            .empty-icon{
                font-size:80px;
                margin-bottom:20px;
                opacity:.8
            }
            .empty h4{
                font-weight:800;
                color:#333;
                margin-bottom:12px
            }
            .loading{
                opacity:.6;
                pointer-events:none
            }
            .toast-container{
                position:fixed;
                top:24px;
                right:24px;
                z-index:9999;
                max-width:400px
            }
            .toast{
                min-width:320px;
                box-shadow:0 8px 24px rgba(0,0,0,.15);
                margin-bottom:12px;
                border:none;
                border-radius:10px
            }
            .toast-body{
                font-weight:600;
                padding:14px 18px
            }
            .btn-checkout-group{
                display:flex;
                gap:12px;
                margin-top:20px;
                flex-wrap:wrap
            }
            .btn-checkout-group .btn{
                flex:1;
                min-width:200px;
                padding:14px 24px;
                font-weight:700;
                border-radius:10px;
                font-size:1.05rem;
                transition:all .3s ease;
                border:2px solid transparent
            }
            .btn-checkout-group .btn-success{
                background:var(--primary);
                border-color:var(--primary)
            }
            .btn-checkout-group .btn-success:hover{
                background:var(--primary-dark);
                border-color:var(--primary-dark);
                transform:translateY(-2px);
                box-shadow:0 8px 16px rgba(46,125,50,.3)
            }
            .btn-checkout-group .btn-outline-secondary{
                border-color:#ddd;
                color:#555
            }
            .btn-checkout-group .btn-outline-secondary:hover{
                background:#f5f5f5;
                border-color:#bbb;
                color:#333
            }
            @media (max-width:768px){
                .cart-item{
                    flex-wrap:wrap;
                    gap:16px
                }
                .product-info{
                    width:100%
                }
                .line-total{
                    width:100%;
                    text-align:left;
                    margin-top:12px;
                    min-width:unset
                }
                .toast-container{
                    left:16px;
                    right:16px;
                    max-width:unset
                }
                .toast{
                    min-width:unset
                }
                .btn-checkout-group{
                    flex-direction:column
                }
                .btn-checkout-group .btn{
                    width:100%;
                    min-width:unset
                }
                .card-head h2{
                    font-size:1.5rem
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="/common/headerChinh.jsp" />

        <!-- Toast container -->
        <div class="toast-container"></div>

        <div class="cart-wrap">
            <div class="card">
                <div class="card-head">
                    <h2>
                        Giỏ hàng của bạn
                        <c:if test="${not empty sessionScope.cart}">
                            <span class="cart-badge" id="cartItemCount">
                                ${sessionScope.cart.size()}
                            </span>
                        </c:if>
                    </h2>
                    <p class="card-subtitle">
                        <c:choose>
                            <c:when test="${not empty sessionScope.cart}">
                                Quản lý sản phẩm trong giỏ hàng của bạn
                            </c:when>
                            <c:otherwise>
                                Chưa có sản phẩm nào trong giỏ hàng
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>

                <div class="card-body" id="cartBody">
                    <c:choose>
                        <c:when test="${not empty sessionScope.cart}">
                            <c:set var="cartTotal" value="0" scope="page" />

                            <div class="cart-list">
                                <c:forEach var="item" items="${sessionScope.cart.values()}">
                                    <c:if test="${not empty item and not empty item.product}">
                                        <c:set var="lineTotal" value="${item.product.price * item.quantity}" />
                                        <c:set var="cartTotal" value="${cartTotal + lineTotal}" scope="page" />

                                        <!-- Mỗi sản phẩm -->
                                        <div class="cart-item"
                                             data-product-id="${item.product.productId}"
                                             data-unit-price="${item.product.price}">
                                            <div class="thumb">
                                                <img src="${cpath}/${item.product.imageUrl}"
                                                     alt="${item.product.productName}"
                                                     onerror="this.src='${cpath}/images/product-placeholder.jpg'">
                                            </div>

                                            <div class="product-info">
                                                <p class="title">${item.product.productName}</p>
                                                <div class="price">
                                                    <fmt:formatNumber value="${item.product.price}" pattern="#,###"/>₫
                                                </div>

                                                <div class="qty">
                                                    <button class="btn btn-minus" type="button">−</button>
                                                    <input type="number" class="quantity" value="${item.quantity}" min="1" max="99"
                                                           data-original-value="${item.quantity}">
                                                    <button class="btn btn-plus" type="button">+</button>

                                                    <button class="btn-remove" type="button" title="Xóa sản phẩm">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" fill="currentColor" viewBox="0 0 16 16">
                                                        <path d="M5.5 5.5a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-1 0v-7a.5.5 0 0 1 .5-.5m2.5.5a.5.5 0 0 1 1 0v7a.5.5 0 0 1-1 0zm3 .5a.5.5 0 0 1 .5-.5v7a.5.5 0 0 1-1 0z"/>
                                                        <path d="M14.5 3a1 1 0 0 1-1 1h-11a1 1 0 0 1-1-1H0v1a2 2 0 0 0 2 2v8a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V6a2 2 0 0 0 2-2V3zM4 6h8v8a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1zM6.5 1a1 1 0 0 1 1-1h1a1 1 0 0 1 1 1V2h-3z"/>
                                                        </svg>
                                                    </button>
                                                </div>
                                            </div>

                                            <div class="line-total">
                                                <fmt:formatNumber value="${lineTotal}" pattern="#,###"/>₫
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>

                            <!-- Tóm tắt -->
                            <div class="summary">
                                <div class="row-sum">
                                    <span>Tạm tính</span>
                                    <span id="subtotal"><fmt:formatNumber value="${cartTotal}" pattern="#,###"/>₫</span>
                                </div>
                                <div class="row-sum">
                                    <span>Phí vận chuyển</span>
                                    <span class="text-success fw-bold">MIỄN PHÍ</span>
                                </div>
                                <div class="row-sum sum-total">
                                    <span>Tổng thanh toán</span>
                                    <span id="grandtotal"><fmt:formatNumber value="${cartTotal}" pattern="#,###"/>₫</span>
                                </div>

                                <div class="btn-checkout-group">
                                    <a href="${cpath}/checkout.jsp" class="btn btn-success">
                                        💳 Thanh toán ngay
                                    </a>
                                    <a href="${cpath}/shop" class="btn btn-outline-secondary">
                                        ← Tiếp tục mua sắm
                                    </a>
                                </div>
                            </div>
                        </c:when>

                        <c:otherwise>
                            <div class="empty">
                                <div class="empty-icon">🛒</div>
                                <h4>Giỏ hàng của bạn đang trống</h4>
                                <p class="text-muted">Hãy thêm sản phẩm vào giỏ hàng để bắt đầu mua sắm</p>
                                <a href="${cpath}/shop" class="btn btn-success mt-3" style="padding:12px 32px">
                                    🛍️ Khám phá sản phẩm
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <jsp:include page="/common/footerChinh.jsp" />

        <script src="${cpath}/js/jquery-3.3.1.min.js"></script>
        <script src="${cpath}/js/bootstrap.min.js"></script>
        <script>
            $(function () {
                const ctx = "${cpath}";

                // Format tiền Việt Nam
                function formatMoney(value) {
                    return new Intl.NumberFormat('vi-VN', {
                        maximumFractionDigits: 0
                    }).format(Math.round(value || 0)) + '₫';
                }

                // Hiển thị thông báo Bootstrap Toast (chỉ dùng cho xóa sản phẩm)
                function showToast(message, type = 'success') {
                    const bgClass = type === 'success' ? 'bg-success' : 'bg-danger';
                    const icon = type === 'success' ? '✓' : '✗';
                    const toastHtml = `
                        <div class="toast align-items-center text-white ${bgClass} border-0" role="alert">
                            <div class="d-flex">
                                <div class="toast-body">${icon} ${message}</div>
                                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
                            </div>
                        </div>
                    `;

                    const $toast = $(toastHtml);
                    $('.toast-container').append($toast);

                    const toast = new bootstrap.Toast($toast[0], {delay: 3000});
                    toast.show();

                    $toast.on('hidden.bs.toast', function () {
                        $(this).remove();
                    });
                }

                // Tính lại tổng tiền toàn bộ giỏ hàng
                function recalcTotals() {
                    let sum = 0;
                    $('.cart-item').each(function () {
                        const unit = parseFloat($(this).data('unit-price')) || 0;
                        const qty = parseInt($(this).find('.quantity').val()) || 0;
                        const lineTotal = unit * qty;
                        sum += lineTotal;
                        $(this).find('.line-total').text(formatMoney(lineTotal));
                    });
                    $('#subtotal').text(formatMoney(sum));
                    $('#grandtotal').text(formatMoney(sum));
                }

                // Khóa/mở khóa item khi đang xử lý
                function lockItem($item, lock) {
                    const $lineTotal = $item.find('.line-total');
                    const $input = $item.find('.quantity');

                    if (lock) {
                        $item.addClass('loading');
                        $item.find('.btn-minus, .btn-plus, .btn-remove, .quantity').prop('disabled', true);
                        $lineTotal.addClass('updating');
                        $input.addClass('updating');
                    } else {
                        $item.removeClass('loading');
                        $item.find('.btn-minus, .btn-plus, .btn-remove, .quantity').prop('disabled', false);
                        $lineTotal.removeClass('updating');
                        $input.removeClass('updating');
                    }
                }

                // ========== CẬP NHẬT SỐ LƯỢNG (KHÔNG HIỆN THÔNG BÁO) ==========
                function updateQuantity($item, newQty) {
                    const pid = $item.data('product-id');
                    const $inp = $item.find('.quantity');
                    const oldVal = parseInt($inp.data('original-value')) || 1;

                    if (newQty === oldVal)
                        return;

                    lockItem($item, true);
                    $inp.val(newQty);
                    recalcTotals();

                    $.ajax({
                        url: ctx + '/cart',
                        type: 'POST',
                        data: {
                            action: 'update',
                            productId: pid,
                            quantity: newQty
                        },
                        dataType: 'json',
                        timeout: 10000
                    })
                            .done(function (data) {
                                if (data && data.success) {
                                    $inp.data('original-value', newQty);
                                    // KHÔNG hiển thị thông báo khi cập nhật số lượng
                                } else {
                                    throw new Error('Server returned success: false');
                                }
                            })
                            .fail(function (xhr, status, error) {
                                console.error('Update failed:', status, error);
                                $inp.val(oldVal);
                                recalcTotals();
                                showToast('Không thể cập nhật số lượng. Vui lòng thử lại!', 'danger');
                            })
                            .always(function () {
                                lockItem($item, false);
                            });
                }

                // Nút tăng số lượng
                $(document).on('click', '.btn-plus', function (e) {
                    e.preventDefault();
                    const $item = $(this).closest('.cart-item');
                    const $inp = $item.find('.quantity');
                    let newVal = Math.min(99, parseInt($inp.val()) + 1);
                    updateQuantity($item, newVal);
                });

                // Nút giảm số lượng
                $(document).on('click', '.btn-minus', function (e) {
                    e.preventDefault();
                    const $item = $(this).closest('.cart-item');
                    const $inp = $item.find('.quantity');
                    let newVal = Math.max(1, parseInt($inp.val()) - 1);
                    updateQuantity($item, newVal);
                });

                // Nhập trực tiếp số lượng
                $(document).on('change', '.quantity', function () {
                    const $item = $(this).closest('.cart-item');
                    let newVal = parseInt($(this).val());

                    if (isNaN(newVal) || newVal < 1)
                        newVal = 1;
                    if (newVal > 99)
                        newVal = 99;

                    updateQuantity($item, newVal);
                });

                // Ngăn submit form khi nhấn Enter
                $(document).on('keypress', '.quantity', function (e) {
                    if (e.which === 13) {
                        e.preventDefault();
                        $(this).blur();
                    }
                });

                // ========== XÓA SẢN PHẨM (VẪN HIỆN THÔNG BÁO) ==========
                $(document).on('click', '.btn-remove', function (e) {
                    e.preventDefault();
                    const $item = $(this).closest('.cart-item');
                    const pid = $item.data('product-id');
                    const productName = $item.find('.title').text();

                    if (!confirm('Bạn có chắc muốn xóa sản phẩm "' + productName + '" khỏi giỏ hàng?')) {
                        return;
                    }

                    const backupHtml = $item.prop('outerHTML');
                    const $list = $('.cart-list');

                    // Xóa với animation
                    $item.slideUp(300, function () {
                        $(this).remove();
                        updateCartCount();
                        recalcTotals();
                        checkEmpty();
                    });

                    $.ajax({
                        url: ctx + '/cart',
                        type: 'POST',
                        data: {
                            action: 'remove',
                            productId: pid
                        },
                        dataType: 'json',
                        timeout: 10000
                    })
                            .done(function (data) {
                                if (data && data.success) {
                                    showToast('Đã xóa sản phẩm khỏi giỏ hàng', 'success');
                                }
                            })
                            .fail(function (xhr, status, error) {
                                console.error('Remove failed:', status, error);
                                // Khôi phục sản phẩm nếu xóa thất bại
                                const $restore = $(backupHtml).hide();
                                $list.append($restore);
                                $restore.slideDown(300);
                                updateCartCount();
                                recalcTotals();
                                showToast('Không thể xóa sản phẩm. Vui lòng thử lại!', 'danger');
                            });
                });

                // Cập nhật số lượng sản phẩm trong badge
                function updateCartCount() {
                    const count = $('.cart-item').length;
                    $('#cartItemCount').text(count);
                }

                // Kiểm tra và hiển thị giỏ hàng trống
                function checkEmpty() {
                    if ($('.cart-item').length === 0) {
                        $('#cartBody').html(`
                            <div class="empty">
                                <div class="empty-icon">🛒</div>
                                <h4>Giỏ hàng của bạn đang trống</h4>
                                <p class="text-muted">Hãy thêm sản phẩm vào giỏ hàng để bắt đầu mua sắm</p>
                                <a href="${ctx}/shop" class="btn btn-success mt-3" style="padding:12px 32px">
                                    🛍️ Khám phá sản phẩm
                                </a>
                            </div>
                        `);
                    }
                }

                // Hiển thị thông báo từ URL params (nếu có)
                const urlParams = new URLSearchParams(window.location.search);
                if (urlParams.get('success') === 'added') {
                    showToast('Đã thêm sản phẩm vào giỏ hàng', 'success');
                } else if (urlParams.get('error') === 'true') {
                    showToast('Có lỗi xảy ra. Vui lòng thử lại!', 'danger');
                }
            });
        </script>
    </body>
</html>