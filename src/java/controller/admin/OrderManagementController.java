package controller.admin;

import DAO.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Order;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

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
            updateOrderStatus(request, response);
        } catch (SQLException e) {
            throw new ServletException("Lỗi cập nhật trạng thái đơn hàng", e);
        }
    }

    private void listOrders(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        // Lấy các tham số tìm kiếm từ request
        String keyword = request.getParameter("keyword");
        String status = request.getParameter("status");
        String dateFrom = request.getParameter("dateFrom");
        
        System.out.println("=== THAM SỐ TÌM KIẾM ===");
        System.out.println("Keyword: " + keyword);
        System.out.println("Status: " + status);
        System.out.println("DateFrom: " + dateFrom);
        
        List<Order> orderList;
        
        // Nếu có tham số tìm kiếm, gọi phương thức tìm kiếm
        if (isSearchParamsPresent(keyword, status, dateFrom)) {
            System.out.println("=== THỰC HIỆN TÌM KIẾM ===");
            orderList = orderDAO.searchOrders(keyword, status, dateFrom);
        } else {
            // Nếu không có tham số tìm kiếm, lấy tất cả orders
            System.out.println("=== LẤY TẤT CẢ ORDERS ===");
            orderList = orderDAO.getAllOrders();
        }
        
        // DEBUG: Kiểm tra dữ liệu
        System.out.println("Số lượng orders tìm thấy: " + orderList.size());
        for (Order order : orderList) {
            System.out.println("Order ID: " + order.getOrderId() + 
                              ", Customer: " + order.getCustomerName() + 
                              ", Status: " + order.getStatus());
        }
        
        // Thống kê
        long pendingCount = orderList.stream().filter(o -> "PENDING".equals(o.getStatus())).count();
        long processingCount = orderList.stream().filter(o -> "PROCESSING".equals(o.getStatus())).count();
        long cancelledCount = orderList.stream().filter(o -> "CANCELLED".equals(o.getStatus())).count();
        
        // Set attributes
        request.setAttribute("orderList", orderList);
        request.setAttribute("totalOrders", orderList.size());
        request.setAttribute("pendingOrders", pendingCount);
        request.setAttribute("processingOrders", processingCount);
        request.setAttribute("cancelledOrders", cancelledCount);
        
        request.getRequestDispatcher("/admin/orders/manage_orders.jsp").forward(request, response);
    }

    private boolean isSearchParamsPresent(String keyword, String status, String dateFrom) {
        return (keyword != null && !keyword.trim().isEmpty()) ||
               (status != null && !status.trim().isEmpty()) ||
               (dateFrom != null && !dateFrom.trim().isEmpty());
    }

    private void viewOrderDetail(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Order order = orderDAO.getOrderById(id);
        request.setAttribute("order", order);
        request.getRequestDispatcher("/admin/orders/order_detail.jsp").forward(request, response);
    }

    private void updateOrderStatus(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String status = request.getParameter("status");
        orderDAO.updateOrderStatus(orderId, status);

        response.sendRedirect(request.getContextPath() + "/admin/orders?action=detail&id=" + orderId);
    }
}