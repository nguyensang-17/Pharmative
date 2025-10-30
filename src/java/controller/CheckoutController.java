package controller;

import DAO.OrderDAO;
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
import models.CartItem;
import models.Order;
import models.OrderDetail;
import models.User;

@WebServlet("/checkout")
public class CheckoutController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");
        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");

        if (user == null || cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        // Tạo đối tượng Order
        Order order = new Order();
        order.setUserId(user.getId());
        order.setShippingAddress(request.getParameter("shippingAddress"));
        
        List<OrderDetail> details = new ArrayList<>();
        BigDecimal totalAmount = BigDecimal.ZERO;

        for (CartItem item : cart.values()) {
            OrderDetail detail = new OrderDetail();
            detail.setProductId(item.getProduct().getId());
            detail.setQuantity(item.getQuantity());
            detail.setPricePerUnit(item.getProduct().getPrice());
            details.add(detail);
            totalAmount = totalAmount.add(item.getSubtotal());
        }

        order.setOrderDetails(details);
        order.setTotalAmount(totalAmount);

        // Gọi DAO để lưu đơn hàng (với transaction)
        boolean success = orderDAO.createOrder(order);

        if (success) {
            session.removeAttribute("cart"); // Xóa giỏ hàng
            response.sendRedirect(request.getContextPath() + "/order-success.jsp");
        } else {
            request.setAttribute("error", "Đặt hàng thất bại. Có thể do số lượng tồn kho không đủ.");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
        }
    }
}