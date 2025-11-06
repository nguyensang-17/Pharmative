package controller.admin;

import DAO.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import models.Order;

@WebServlet(urlPatterns = {"/admin/orders", "/admin/orders/"})
public class OrderManagementController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "detail":
                    viewOrderDetail(request, response);
                    break;
                default:
                    listOrders(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Lỗi truy vấn đơn hàng", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Chỉ có một hành động POST là cập nhật trạng thái
            updateOrderStatus(request, response);
        } catch (SQLException e) {
            throw new ServletException("Lỗi cập nhật trạng thái đơn hàng", e);
        }
    }

    private void listOrders(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
    List<Order> orderList = orderDAO.getAllOrders();
    
    // DEBUG: Kiểm tra dữ liệu
    System.out.println("=== DEBUG ORDER DATA ===");
    System.out.println("Total orders: " + orderList.size());
    for (Order order : orderList) {
        System.out.println("Order ID: " + order.getOrderId() + 
                          ", User ID: " + order.getUserId() + 
                          ", Status: " + order.getStatus() +
                          ", Total: " + order.getTotalAmount());
    }
    
    // Thống kê
    long pendingCount = orderList.stream().filter(o -> "PENDING".equals(o.getStatus())).count();
    long processingCount = orderList.stream().filter(o -> "PROCESSING".equals(o.getStatus())).count();
    long cancelledCount = orderList.stream().filter(o -> "CANCELLED".equals(o.getStatus())).count();
    
    // Set attributes với đúng tên
    request.setAttribute("orderList", orderList); // Đổi thành orderList
    request.setAttribute("totalOrders", orderList.size());
    request.setAttribute("pendingOrders", pendingCount);
    request.setAttribute("processingOrders", processingCount);
    request.setAttribute("cancelledOrders", cancelledCount);
    
    request.getRequestDispatcher("/admin/orders/manage_orders.jsp").forward(request, response);
}

    private void viewOrderDetail(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Order order = orderDAO.getOrderById(id); // DAO này đã lấy cả chi tiết đơn hàng
        request.setAttribute("order", order);
        request.getRequestDispatcher("/admin/orders/order_detail.jsp").forward(request, response);
    }

    private void updateOrderStatus(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String status = request.getParameter("status");
        orderDAO.updateOrderStatus(orderId, status);

        // Chuyển hướng lại trang chi tiết để xem thay đổi
        response.sendRedirect(request.getContextPath() + "/admin/orders?action=detail&id=" + orderId);
    }
}