package controller;

import DAO.OrderDAO;
import controller.CartController.CartItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Order;
import models.OrderDetail;
import models.Product;
import models.User;
import util.EmailUtil;
import vnpay.Config;

import java.io.IOException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.*;

/**
 * Servlet xử lý kết quả trả về từ VNPay
 * Tạo đơn hàng nếu thanh toán thành công
 */
@WebServlet("/vnpay-return")
public class VNPayReturnController extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    private final OrderDAO orderDAO = new OrderDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        
        try {
            // Thu thập tham số từ VNPay
            Map<String, String> fields = new HashMap<>();
            for (Map.Entry<String, String[]> entry : request.getParameterMap().entrySet()) {
                String name = entry.getKey();
                String value = (entry.getValue() != null && entry.getValue().length > 0) 
                               ? entry.getValue()[0] : null;
                if (value != null && !value.isEmpty()) {
                    fields.put(name, value);
                }
            }
            
            // Lấy chữ ký
            String vnp_SecureHash = fields.get("vnp_SecureHash");
            if (vnp_SecureHash == null) {
                forwardToResultPage(request, response, false, "Thiếu chữ ký bảo mật");
                return;
            }
            
            fields.remove("vnp_SecureHash");
            fields.remove("vnp_SecureHashType");
            
            // Xác thực chữ ký
            boolean isValid = verifySignature(fields, vnp_SecureHash);
            String respCode = request.getParameter("vnp_ResponseCode");
            String txnStatus = request.getParameter("vnp_TransactionStatus");
            String txnRef = request.getParameter("vnp_TxnRef");
            String transactionNo = request.getParameter("vnp_TransactionNo");
            
            if (!isValid) {
                forwardToResultPage(request, response, false, "Chữ ký không hợp lệ");
                return;
            }
            
            if (!"00".equals(respCode)) {
                String errorMsg = getErrorMessage(respCode);
                forwardToResultPage(request, response, false, errorMsg);
                return;
            }
            
            // Thanh toán thành công - Tạo đơn hàng
            boolean orderCreated = createOrderFromVNPay(request, session, txnRef, transactionNo);
            
            if (orderCreated) {
                Integer orderId = (Integer) request.getAttribute("orderId");
                if (orderId != null) {
                    response.sendRedirect(request.getContextPath() + 
                        "/checkout-success.jsp?orderId=" + orderId + "&method=vnpay");
                    return;
                }
            } else {
                forwardToResultPage(request, response, false, 
                    "Thanh toán thành công nhưng không thể tạo đơn hàng. Vui lòng liên hệ hỗ trợ.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            forwardToResultPage(request, response, false, 
                "Có lỗi xảy ra khi xử lý giao dịch");
        }
    }
    
    private boolean verifySignature(Map<String, String> fields, String vnp_SecureHash) {
        try {
            List<String> fieldNames = new ArrayList<>(fields.keySet());
            Collections.sort(fieldNames);
            
            StringBuilder hashData = new StringBuilder();
            for (Iterator<String> itr = fieldNames.iterator(); itr.hasNext();) {
                String fieldName = itr.next();
                String fieldValue = fields.get(fieldName);
                if (fieldValue != null && !fieldValue.isEmpty()) {
                    hashData.append(fieldName)
                            .append('=')
                            .append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII));
                    if (itr.hasNext()) {
                        hashData.append('&');
                    }
                }
            }
            
            String signEncoded = Config.hmacSHA512(Config.secretKey, hashData.toString());
            return vnp_SecureHash.equalsIgnoreCase(signEncoded);
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    private boolean createOrderFromVNPay(HttpServletRequest request, HttpSession session,
                                         String txnRef, String transactionNo) {
        try {
            // Lấy user
            User user = (User) session.getAttribute("currentUser");
            if (user == null) {
                user = (User) session.getAttribute("user");
            }
            if (user == null) return false;
            
            // Lấy cart
            @SuppressWarnings("unchecked")
            Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
            if (cart == null || cart.isEmpty()) return false;
            
            // Lấy thông tin checkout
            String fullName = (String) session.getAttribute("checkout_fullName");
            String email = (String) session.getAttribute("checkout_email");
            String phone = (String) session.getAttribute("checkout_phone");
            String address = (String) session.getAttribute("checkout_address");
            String note = (String) session.getAttribute("checkout_note");
            
            if (fullName == null || email == null || phone == null || address == null) {
                return false;
            }
            
            // Tạo Order
            Order order = new Order();
            order.setUserId(user.getId());
            order.setShippingAddress(address);
            order.setCustomerName(fullName);
            order.setCustomerEmail(email);
            order.setCustomerPhone(phone);
            order.setPaymentMethod("vnpay");
            order.setNote(note != null ? note : "");
            order.setStatus("pending");
            
            List<OrderDetail> details = new ArrayList<>();
            List<EmailUtil.OrderLine> emailLines = new ArrayList<>();
            BigDecimal totalAmount = BigDecimal.ZERO;
            
            for (CartItem item : cart.values()) {
                Product product = item.getProduct();
                BigDecimal unitPrice = (product.getPrice() == null) 
                                       ? BigDecimal.ZERO : product.getPrice();
                int quantity = item.getQuantity();
                BigDecimal lineTotal = unitPrice.multiply(BigDecimal.valueOf(quantity));
                
                OrderDetail detail = new OrderDetail();
                detail.setProductId(product.getProductId());
                detail.setQuantity(quantity);
                detail.setPricePerUnit(unitPrice);
                details.add(detail);
                
                totalAmount = totalAmount.add(lineTotal);
                
                emailLines.add(new EmailUtil.OrderLine(
                    product.getProductName(),
                    quantity,
                    unitPrice,
                    lineTotal
                ));
            }
            
            order.setOrderDetails(details);
            order.setTotalAmount(totalAmount);
            
            // Lưu order
            boolean success = orderDAO.createOrder(order);
            if (!success) return false;
            
            // Gửi email
            try {
                EmailUtil.sendOrderConfirmationEmail(
                    email, fullName, order.getOrderId(),
                    emailLines, totalAmount, address
                );
            } catch (Exception e) {
                e.printStackTrace();
            }
            
            // Xóa session
            session.removeAttribute("cart");
            session.removeAttribute("checkout_fullName");
            session.removeAttribute("checkout_email");
            session.removeAttribute("checkout_phone");
            session.removeAttribute("checkout_address");
            session.removeAttribute("checkout_note");
            session.removeAttribute("checkout_paymentMethod");
            
            // Lưu orderId vào request
            request.setAttribute("orderId", order.getOrderId());
            
            return true;
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    private void forwardToResultPage(HttpServletRequest request, HttpServletResponse response,
                                     boolean success, String message) 
            throws ServletException, IOException {
        request.setAttribute("paymentSuccess", success);
        request.setAttribute("paymentMessage", message);
        request.getRequestDispatcher("/vnpay_return.jsp").forward(request, response);
    }
    
    private String getErrorMessage(String responseCode) {
        if (responseCode == null) return "Lỗi không xác định";
        
        switch (responseCode) {
            case "07": return "Trừ tiền thành công. Giao dịch bị nghi ngờ.";
            case "09": return "Thẻ/Tài khoản chưa đăng ký InternetBanking.";
            case "10": return "Xác thực thông tin sai quá 3 lần.";
            case "11": return "Đã hết hạn chờ thanh toán.";
            case "12": return "Thẻ/Tài khoản bị khóa.";
            case "13": return "Nhập sai OTP.";
            case "24": return "Khách hàng hủy giao dịch.";
            case "51": return "Tài khoản không đủ số dư.";
            case "65": return "Vượt quá hạn mức giao dịch trong ngày.";
            case "75": return "Ngân hàng đang bảo trì.";
            case "79": return "Nhập sai mật khẩu quá số lần quy định.";
            default: return "Giao dịch thất bại. Mã lỗi: " + responseCode;
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}