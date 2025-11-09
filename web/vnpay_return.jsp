<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page import="vnpay.Config" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    response.setCharacterEncoding("UTF-8");
%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <base href="${cpath}/">

        <title>Kết quả thanh toán - Pharmative</title>

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

            .payment-container {
                max-width: 900px;
                margin: 40px auto;
                padding: 0 15px;
            }

            .payment-card {
                background: var(--white);
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                overflow: hidden;
                margin-bottom: 30px;
            }

            .payment-header {
                padding: 25px 30px;
                border-bottom: 1px solid #eee;
                text-align: center;
            }

            .payment-body {
                padding: 30px;
            }

            .payment-status {
                display: flex;
                align-items: center;
                justify-content: center;
                margin-bottom: 20px;
            }

            .status-icon {
                width: 70px;
                height: 70px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-right: 20px;
                font-size: 30px;
            }

            .status-success {
                background-color: rgba(46, 125, 50, 0.1);
                color: var(--primary-color);
            }

            .status-fail {
                background-color: rgba(176, 0, 32, 0.1);
                color: #b00020;
            }

            .status-text {
                font-size: 1.5rem;
                font-weight: 700;
            }

            .status-success .status-text {
                color: var(--primary-color);
            }

            .status-fail .status-text {
                color: #b00020;
            }

            .payment-details {
                margin-top: 30px;
            }

            .detail-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 16px;
            }

            .detail-table th, .detail-table td {
                border: 1px solid #eee;
                padding: 12px 15px;
                text-align: left;
            }

            .detail-table th {
                background-color: #f8f9fa;
                font-weight: 600;
            }

            .hint {
                font-size: 13px;
                color: #777;
                margin-top: 5px;
            }

            .payment-actions {
                display: flex;
                justify-content: center;
                gap: 15px;
                margin-top: 30px;
            }

            .btn-outline-primary {
                color: var(--primary-color);
                border-color: var(--primary-color);
                border-radius: 30px;
                padding: 10px 25px;
                font-weight: 600;
                transition: var(--transition);
            }

            .btn-outline-primary:hover {
                background-color: var(--primary-color);
                color: white;
            }

            @media (max-width: 768px) {
                .payment-status {
                    flex-direction: column;
                    text-align: center;
                }

                .status-icon {
                    margin-right: 0;
                    margin-bottom: 15px;
                }

                .payment-actions {
                    flex-direction: column;
                    align-items: center;
                }

                .payment-actions a {
                    width: 100%;
                    max-width: 250px;
                    text-align: center;
                }
            }
        </style>
    </head>

    <body>
        <jsp:include page="/common/headerChinh.jsp" />

        <div class="site-wrap">
            <div class="payment-container">
                <%
                    // ===== 1) Thu thập tham số trả về từ VNPAY =====
                    Map<String, String> fields = new HashMap<>();
                    for (Map.Entry<String, String[]> e : request.getParameterMap().entrySet()) {
                        String name = e.getKey();
                        String value = (e.getValue() != null && e.getValue().length > 0) ? e.getValue()[0] : null;
                        if (value != null && !value.isEmpty()) {
                            fields.put(name, value);
                        }
                    }
                    String vnp_SecureHash = fields.get("vnp_SecureHash");
                    fields.remove("vnp_SecureHash");
                    fields.remove("vnp_SecureHashType");

                    // ===== 2) Tính chữ ký local để đối chiếu =====
                    // A) raw (thô)
                    String signRaw = Config.hashAllFields(new HashMap<>(fields));
                    // B) encoded (giống request)
                    List<String> names = new ArrayList<>(fields.keySet());
                    Collections.sort(names);
                    StringBuilder sbEnc = new StringBuilder();
                    for (Iterator<String> it = names.iterator(); it.hasNext();) {
                        String k = it.next();
                        String v = fields.get(k);
                        sbEnc.append(k).append("=").append(URLEncoder.encode(v, StandardCharsets.US_ASCII));
                        if (it.hasNext()) {
                            sbEnc.append("&");
                        }
                    }
                    String signEncoded = Config.hmacSHA512(Config.secretKey, sbEnc.toString());
                    boolean isValid = (vnp_SecureHash != null)
                              && (vnp_SecureHash.equalsIgnoreCase(signRaw) || vnp_SecureHash.equalsIgnoreCase(signEncoded));

                    // ===== 3) Lấy trường hiển thị =====
                    String respCode = request.getParameter("vnp_ResponseCode");
                    String txnStatus = request.getParameter("vnp_TransactionStatus");
                    String txnRef = request.getParameter("vnp_TxnRef");
                    String amount = request.getParameter("vnp_Amount");    // VND × 100
                    String bankCode = request.getParameter("vnp_BankCode");
                    String cardType = request.getParameter("vnp_CardType");
                    String payDate = request.getParameter("vnp_PayDate");
                    String txnNo = request.getParameter("vnp_TransactionNo");
                    String bankTranNo = request.getParameter("vnp_BankTranNo");
                    boolean okCode = "00".equals(respCode) || "00".equals(txnStatus);

                    // Format amount
                    String formattedAmount = "";
                    if (amount != null && !amount.isEmpty()) {
                        try {
                            long amountValue = Long.parseLong(amount);
                            formattedAmount = String.format("%,d", amountValue / 100) + " VND";
                        } catch (NumberFormatException e) {
                            formattedAmount = amount + " VND";
                        }
                    }

                    // Format payDate
                    String formattedPayDate = "";
                    if (payDate != null && payDate.length() >= 14) {
                        String year = payDate.substring(0, 4);
                        String month = payDate.substring(4, 6);
                        String day = payDate.substring(6, 8);
                        String hour = payDate.substring(8, 10);
                        String minute = payDate.substring(10, 12);
                        String second = payDate.substring(12, 14);
                        formattedPayDate = day + "/" + month + "/" + year + " " + hour + ":" + minute + ":" + second;
                    }
                %>

                <div class="payment-card">
                    <div class="payment-header">
                        <h2 class="mb-0">Kết quả thanh toán</h2>
                    </div>

                    <div class="payment-body">
                        <% if (isValid && okCode) { %>
                        <div class="payment-status status-success">
                            <div class="status-icon status-success">
                                <i class="icon-check"></i>
                            </div>
                            <div>
                                <div class="status-text">Thanh toán thành công</div>
                                <p>Cảm ơn bạn đã mua hàng tại Pharmative</p>
                            </div>
                        </div>
                        <% } else { %>
                        <div class="payment-status status-fail">
                            <div class="status-icon status-fail">
                                <i class="icon-close"></i>
                            </div>
                            <div>
                                <div class="status-text">Thanh toán thất bại</div>
                                <p>Giao dịch không thành công. Vui lòng thử lại</p>
                            </div>
                        </div>
                        <% } %>

                        <div class="payment-details">
                            <h4 class="mb-3">Thông tin giao dịch</h4>

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <strong>Trạng thái chữ ký:</strong>
                                    <% if (isValid) { %>
                                    <span class="text-primary">HỢP LỆ</span>
                                    <% } else { %>
                                    <span style="color: #b00020;">KHÔNG HỢP LỆ</span>
                                    <% }%>
                                </div>
                                <div class="col-md-6">
                                    <strong>Mã giao dịch:</strong> <%= txnRef != null ? txnRef : ""%>
                                </div>
                            </div>

                            <table class="detail-table">
                                <tr>
                                    <th>Trường</th>
                                    <th>Giá trị</th>
                                </tr>
                                <tr>
                                    <td>Mã website (vnp_TmnCode)</td>
                                    <td><%= request.getParameter("vnp_TmnCode") != null ? request.getParameter("vnp_TmnCode") : ""%></td>
                                </tr>
                                <tr>
                                    <td>Số tiền</td>
                                    <td>
                                        <%= formattedAmount%>
                                        <div class="hint">(đơn vị: VND × 100)</div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Mã phản hồi (vnp_ResponseCode)</td>
                                    <td><%= respCode != null ? respCode : ""%></td>
                                </tr>
                                <tr>
                                    <td>Trạng thái giao dịch (vnp_TransactionStatus)</td>
                                    <td><%= txnStatus != null ? txnStatus : "(không có)"%></td>
                                </tr>
                                <tr>
                                    <td>Mã giao dịch VNPAY (vnp_TransactionNo)</td>
                                    <td><%= txnNo != null ? txnNo : ""%></td>
                                </tr>
                                <tr>
                                    <td>Mã giao dịch Ngân hàng (vnp_BankTranNo)</td>
                                    <td><%= bankTranNo != null ? bankTranNo : ""%></td>
                                </tr>
                                <tr>
                                    <td>Ngân hàng (vnp_BankCode)</td>
                                    <td><%= bankCode != null ? bankCode : ""%></td>
                                </tr>
                                <tr>
                                    <td>Loại thẻ (vnp_CardType)</td>
                                    <td><%= cardType != null ? cardType : ""%></td>
                                </tr>
                                <tr>
                                    <td>Thời gian thanh toán</td>
                                    <td><%= formattedPayDate%></td>
                                </tr>
                            </table>

                            <% if (isValid && okCode) { %>
                            <div class="alert alert-success mt-4" role="alert">
                                <strong>Thanh toán hợp lệ!</strong> Đơn hàng của bạn đã được xác nhận và sẽ được xử lý trong thời gian sớm nhất.
                            </div>
                            <% } else { %>
                            <div class="alert alert-warning mt-4" role="alert">
                                <strong>Giao dịch không thành công.</strong> Vui lòng kiểm tra lại thông tin thanh toán hoặc thử lại sau.
                            </div>
                            <% }%>
                        </div>

                        <div class="payment-actions">
                            <a href="${cpath}/" class="btn btn-primary">Tiếp tục mua sắm</a>
                            <a href="${cpath}/order-history" class="btn btn-outline-primary">Xem đơn hàng</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="/common/footerChinh.jsp" />

        <script src="${cpath}/js/jquery-3.3.1.min.js"></script>
        <script src="${cpath}/js/bootstrap.min.js"></script>
    </body>
</html>