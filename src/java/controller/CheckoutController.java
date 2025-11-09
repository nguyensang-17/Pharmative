package controller;

import DAO.OrderDAO;
import controller.CartController.CartItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import models.Order;
import models.OrderDetail;
import models.User;
import models.Product;
import util.EmailUtil;

@WebServlet("/checkout")
public class CheckoutController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Kiểm tra user đã đăng nhập
        User user = (User) session.getAttribute("currentUser");
        if (user == null) {
            user = (User) session.getAttribute("user");
        }
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        // Kiểm tra giỏ hàng
        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart.jsp");
            return;
        }
        
        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        
        // Kiểm tra user
        User user = (User) session.getAttribute("currentUser");
        if (user == null) {
            user = (User) session.getAttribute("user");
        }
        
        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");

        // Validate
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart.jsp");
            return;
        }

        try {
            // Lấy thông tin từ form
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String note = request.getParameter("note");
            String paymentMethod = request.getParameter("paymentMethod");

            // Validate input
            if (fullName == null || fullName.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                phone == null || phone.trim().isEmpty() ||
                address == null || address.trim().isEmpty()) {
                
                request.setAttribute("error", "Vui lòng điền đầy đủ thông tin bắt buộc");
                request.getRequestDispatcher("checkout.jsp").forward(request, response);
                return;
            }

            // Chỉ xử lý COD ở đây, VNPay sẽ được xử lý bởi VNPayReturnServlet
            if (!"cod".equals(paymentMethod)) {
                response.sendRedirect(request.getContextPath() + "/checkout.jsp");
                return;
            }

            // === XỬ LÝ THANH TOÁN COD ===
            
            // Tạo đối tượng Order
            Order order = new Order();
            order.setUserId(user.getId());
            order.setShippingAddress(address);
            order.setCustomerName(fullName);
            order.setCustomerEmail(email);
            order.setCustomerPhone(phone);
            order.setPaymentMethod("cod");
            order.setNote(note != null ? note : "");
            order.setStatus("pending");
            
            // Tạo danh sách chi tiết đơn hàng
            List<OrderDetail> details = new ArrayList<>();
            List<EmailUtil.OrderLine> emailLines = new ArrayList<>();
            BigDecimal totalAmount = BigDecimal.ZERO;

            for (CartItem item : cart.values()) {
                Product product = item.getProduct();
                BigDecimal unitPrice = (product.getPrice() == null) 
                                       ? BigDecimal.ZERO : product.getPrice();
                BigDecimal lineTotal = unitPrice.multiply(BigDecimal.valueOf(item.getQuantity()));

                OrderDetail detail = new OrderDetail();
                detail.setProductId(product.getProductId());
                detail.setQuantity(item.getQuantity());
                detail.setPricePerUnit(unitPrice);
                details.add(detail);
                
                totalAmount = totalAmount.add(lineTotal);

                emailLines.add(new EmailUtil.OrderLine(
                    product.getProductName(),
                    item.getQuantity(),
                    unitPrice,
                    lineTotal
                ));
            }

            order.setOrderDetails(details);
            order.setTotalAmount(totalAmount);

            // Lưu đơn hàng vào database
            boolean success = orderDAO.createOrder(order);

            if (success) {
                // Gửi email xác nhận COD
                try {
                    EmailUtil.sendCODOrderConfirmationEmail(
                        email, fullName, order.getOrderId(),
                        emailLines, totalAmount, address
                    );
                } catch (Exception e) {
                    // Log lỗi nhưng vẫn tiếp tục
                    e.printStackTrace();
                }
                
                // Xóa giỏ hàng
                session.removeAttribute("cart");
                
                // Chuyển hướng đến trang thành công
                response.sendRedirect(request.getContextPath() + 
                    "/checkout-success.jsp?orderId=" + order.getOrderId() + "&method=cod");
                
            } else {
                request.setAttribute("error", 
                    "Đặt hàng thất bại. Có thể do số lượng tồn kho không đủ.");
                request.getRequestDispatcher("checkout.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi: " + e.getMessage());
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
        }
    }
}