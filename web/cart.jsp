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
        <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="${cpath}/css/bootstrap.min.css">
        <link rel="stylesheet" href="${cpath}/css/style.css">

        <style>
            :root{
                --primary:#2e7d32;
                --primary-dark:#1b5e20;
                --bg:#f8f9fa;
                --radius:10px;
                --shadow:0 8px 24px rgba(0,0,0,.08)
            }
            body{
                font-family:'Nunito',sans-serif;
                background:var(--bg)
            }
            .cart-wrap{
                max-width:1200px;
                margin:36px auto;
                padding:0 16px
            }
            .card{
                background:#fff;
                border-radius:var(--radius);
                box-shadow:var(--shadow);
                overflow:hidden
            }
            .card-head{
                padding:22px 26px;
                border-bottom:1px solid #eee;
                background:#fafafa
            }
            .card-body{
                padding:26px
            }
            .cart-item{
                display:flex;
                align-items:center;
                gap:16px;
                padding:22px 0;
                border-bottom:1px solid #eee;
                transition:.2s
            }
            .cart-item:last-child{
                border-bottom:none
            }
            .thumb{
                width:96px;
                height:96px;
                border-radius:12px;
                overflow:hidden;
                flex:0 0 auto
            }
            .thumb img{
                width:100%;
                height:100%;
                object-fit:cover
            }
            .title{
                font-weight:800;
                margin:0 0 6px;
                font-size:1.05rem
            }
            .price{
                color:var(--primary);
                font-weight:700;
                font-size:0.95rem
            }
            .qty{
                display:flex;
                align-items:center;
                gap:10px;
                margin-top:10px
            }
            .qty .btn{
                width:36px;
                height:36px;
                border-radius:50%;
                display:flex;
                align-items:center;
                justify-content:center;
                padding:0;
                font-size:1.2rem;
                line-height:1
            }
            .qty input{
                width:64px;
                height:40px;
                text-align:center;
                border:1px solid #ddd;
                border-radius:10px;
                font-weight:700
            }
            .qty input:disabled{
                background:#f5f5f5;
                cursor:not-allowed
            }
            .line-total{
                margin-left:auto;
                min-width:140px;
                text-align:right;
                font-weight:800;
                color:var(--primary-dark);
                font-size:1.15rem
            }
            .btn-remove{
                border:none;
                background:transparent;
                color:#dc3545;
                margin-left:10px;
                cursor:pointer;
                padding:4px 8px;
                transition:.2s
            }
            .btn-remove:hover{
                opacity:.7;
                transform:scale(1.1)
            }
            .btn-remove:disabled{
                opacity:.4;
                cursor:not-allowed;
                transform:none
            }
            .summary{
                background:#fafafa;
                border-radius:12px;
                padding:20px;
                margin-top:18px
            }
            .row-sum{
                display:flex;
                justify-content:space-between;
                padding:10px 0;
                border-bottom:1px solid #eee;
                font-size:1rem
            }
            .row-sum:last-child{
                border-bottom:none;
                margin-top:8px;
                padding-top:16px
            }
            .sum-total{
                font-size:1.3rem;
                font-weight:900;
                color:var(--primary-dark)
            }
            .empty{
                padding:60px 20px;
                text-align:center
            }
            .loading{
                opacity:.55;
                pointer-events:none
            }
            .toast-container{
                position:fixed;
                top:20px;
                right:20px;
                z-index:9999
            }
            .toast{
                min-width:300px;
                box-shadow:0 4px 12px rgba(0,0,0,.15);
                margin-bottom:10px
            }
            .btn-checkout-group{
                display:flex;
                gap:10px;
                margin-top:16px;
                flex-wrap:wrap
            }
            .btn-checkout-group .btn{
                flex:1;
                min-width:180px;
                padding:12px 20px;
                font-weight:700;
                border-radius:8px
            }
            @media (max-width:768px){
                .cart-item{
                    flex-wrap:wrap
                }
                .line-total{
                    min-width:unset;
                    width:100%;
                    text-align:left;
                    margin-top:10px
                }
                .toast-container{
                    left:20px;
                    right:20px
                }
                .btn-checkout-group{
                    flex-direction:column
                }
                .btn-checkout-group .btn{
                    width:100%
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
                    <h2 class="m-0">Giỏ hàng của bạn</h2>
                    <small class="text-muted">Cập nhật số lượng / xóa sản phẩm</small>
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

                                            <div class="flex-fill">
                                                <p class="title">${item.product.productName}</p>
                                                <div class="price"><fmt:formatNumber value="${item.product.price}" pattern="#,###₫"/></div>

                                                <div class="qty">
                                                    <button class="btn btn-outline-secondary btn-sm btn-minus" type="button">−</button>
                                                    <input type="number" class="quantity" value="${item.quantity}" min="1" max="99"
                                                           data-original-value="${item.quantity}">
                                                    <button class="btn btn-outline-secondary btn-sm btn-plus" type="button">+</button>

                                                    <button class="btn-remove" type="button" title="Xóa sản phẩm">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 16 16">
                                                        <path d="M5.5 5.5a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-1 0v-7a.5.5 0 0 1 .5-.5m2.5.5a.5.5 0 0 1 1 0v7a.5.5 0 0 1-1 0zm3 .5a.5.5 0 0 1 .5-.5v7a.5.5 0 0 1-1 0z"/>
                                                        <path d="M14.5 3a1 1 0 0 1-1 1h-11a1 1 0 0 1-1-1H0v1a2 2 0 0 0 2 2v8a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V6a2 2 0 0 0 2-2V3zM4 6h8v8a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1zM6.5 1a1 1 0 0 1 1-1h1a1 1 0 0 1 1 1V2h-3z"/>
                                                        </svg>
                                                    </button>
                                                </div>
                                            </div>

                                            <div class="line-total">
                                                <fmt:formatNumber value="${lineTotal}" pattern="#,###₫"/>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>

                            <!-- Tóm tắt -->
                            <div class="summary">
                                <div class="row-sum">
                                    <span>Tạm tính</span>
                                    <span id="subtotal"><fmt:formatNumber value="${cartTotal}" pattern="#,###₫"/></span>
                                </div>
                                <div class="row-sum">
                                    <span>Phí vận chuyển</span>
                                    <span class="text-success fw-bold">MIỄN PHÍ</span>
                                </div>
                                <div class="row-sum sum-total">
                                    <span>Tổng thanh toán</span>
                                    <span id="grandtotal"><fmt:formatNumber value="${cartTotal}" pattern="#,###₫"/></span>
                                </div>

                                <div class="btn-checkout-group">
                                    <a href="${cpath}/checkout.jsp" class="btn btn-success">
                                        <i class="bi bi-credit-card"></i> Thanh toán
                                    </a>
                                    <a href="${cpath}/shop" class="btn btn-outline-secondary">
                                        <i class="bi bi-arrow-left"></i> Tiếp tục mua
                                    </a>
                                </div>
                            </div>
                        </c:when>

                        <c:otherwise>
                            <div class="empty">
                                <div style="font-size:60px">🛒</div>
                                <h4>Giỏ hàng của bạn đang trống</h4>
                                <p class="text-muted">Hãy thêm sản phẩm vào giỏ hàng để tiếp tục mua sắm</p>
                                <a href="${cpath}/shop" class="btn btn-success mt-3">
                                    <i class="bi bi-shop"></i> Mua sắm ngay
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
                        style: 'currency',
                        currency: 'VND',
                        maximumFractionDigits: 0
                    }).format(Math.round(value || 0));
                }

                // Hiển thị thông báo Bootstrap Toast
                function showToast(message, type = 'success') {
                    const bgClass = type === 'success' ? 'bg-success' : 'bg-danger';
                    const toastHtml = `
                        <div class="toast align-items-center text-white ${bgClass} border-0" role="alert">
                            <div class="d-flex">
                                <div class="toast-body">${message}</div>
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
                    if (lock) {
                        $item.addClass('loading');
                        $item.find('.btn-minus, .btn-plus, .btn-remove, .quantity').prop('disabled', true);
                    } else {
                        $item.removeClass('loading');
                        $item.find('.btn-minus, .btn-plus, .btn-remove, .quantity').prop('disabled', false);
                    }
                }

                // ========== CẬP NHẬT SỐ LƯỢNG ==========
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
                                    showToast('✓ Đã cập nhật số lượng', 'success');
                                } else {
                                    throw new Error('Server returned success: false');
                                }
                            })
                            .fail(function (xhr, status, error) {
                                console.error('Update failed:', status, error);
                                $inp.val(oldVal);
                                recalcTotals();
                                showToast('✗ Không thể cập nhật. Vui lòng thử lại!', 'danger');
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

                // ========== XÓA SẢN PHẨM ==========
                $(document).on('click', '.btn-remove', function (e) {
                    e.preventDefault();
                    const $item = $(this).closest('.cart-item');
                    const pid = $item.data('product-id');

                    if (!confirm('Bạn có chắc muốn xóa sản phẩm này khỏi giỏ hàng?')) {
                        return;
                    }

                    const backupHtml = $item.prop('outerHTML');
                    const $list = $('.cart-list');

                    // Xóa với animation
                    $item.slideUp(250, function () {
                        $(this).remove();
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
                                    showToast('✓ Đã xóa sản phẩm khỏi giỏ hàng', 'success');
                                }
                            })
                            .fail(function (xhr, status, error) {
                                console.error('Remove failed:', status, error);
                                // Khôi phục sản phẩm nếu xóa thất bại
                                const $restore = $(backupHtml).hide();
                                $list.append($restore);
                                $restore.slideDown(250);
                                recalcTotals();
                                showToast('✗ Không thể xóa sản phẩm. Vui lòng thử lại!', 'danger');
                            });
                });

                // Kiểm tra và hiển thị giỏ hàng trống
                function checkEmpty() {
                    if ($('.cart-item').length === 0) {
                        $('#cartBody').html(`
                            <div class="empty">
                                <div style="font-size:60px">🛒</div>
                                <h4>Giỏ hàng của bạn đang trống</h4>
                                <p class="text-muted">Hãy thêm sản phẩm vào giỏ hàng để tiếp tục mua sắm</p>
                                <a href="${ctx}/shop" class="btn btn-success mt-3">
                                    <i class="bi bi-shop"></i> Mua sắm ngay
                                </a>
                            </div>
                        `);
                    }
                }

                // Hiển thị thông báo từ URL params (nếu có)
                const urlParams = new URLSearchParams(window.location.search);
                if (urlParams.get('success') === 'added') {
                    showToast('✓ Đã thêm sản phẩm vào giỏ hàng', 'success');
                } else if (urlParams.get('error') === 'true') {
                    showToast('✗ Có lỗi xảy ra. Vui lòng thử lại!', 'danger');
                }
            });
        </script>
    </body>
</html>