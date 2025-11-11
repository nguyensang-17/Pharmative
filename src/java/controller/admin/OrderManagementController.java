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
import models.OrderDetail;

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
                case "edit":
                    viewEditOrder(request, response);
                    break;
                case "delete":
                    deleteOrder(request, response);
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
        String paymentMethod = request.getParameter("payment_method");
        String dateFrom = request.getParameter("dateFrom");
        String dateTo = request.getParameter("dateTo");
        
        System.out.println("=== THAM SỐ TÌM KIẾM ===");
        System.out.println("Keyword: " + keyword);
        System.out.println("Status: " + status);
        System.out.println("Payment Method: " + paymentMethod);
        System.out.println("DateFrom: " + dateFrom);
        System.out.println("DateTo: " + dateTo);
        
        List<Order> orderList;
        
        // Nếu có tham số tìm kiếm, gọi phương thức tìm kiếm
        if (isSearchParamsPresent(keyword, status, paymentMethod, dateFrom, dateTo)) {
            System.out.println("=== THỰC HIỆN TÌM KIẾM ===");
            orderList = orderDAO.searchOrders(keyword, status, paymentMethod, dateFrom, dateTo);
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
                              ", Status: " + order.getStatus() +
                              ", Payment: " + order.getPaymentMethod());
        }
        
        // THỐNG KÊ
        int totalOrders = orderDAO.countAllOrders();
        int pendingOrders = orderDAO.countOrdersByStatus("pending");
        int processingOrders = orderDAO.countOrdersByStatus("processing");
        int deliveredOrders = orderDAO.countOrdersByStatus("delivered");
        int cancelledOrders = orderDAO.countOrdersByStatus("cancelled");
        
        // DEBUG: Kiểm tra thống kê
        System.out.println("=== THỐNG KÊ ===");
        System.out.println("Tổng: " + totalOrders);
        System.out.println("Chờ xử lý: " + pendingOrders);
        System.out.println("Đang xử lý: " + processingOrders);
        System.out.println("Đã giao: " + deliveredOrders);
        System.out.println("Đã hủy: " + cancelledOrders);
        
        // Set attributes
        request.setAttribute("orderList", orderList);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("pendingOrders", pendingOrders);
        request.setAttribute("processingOrders", processingOrders);
        request.setAttribute("deliveredOrders", deliveredOrders);
        request.setAttribute("cancelledOrders", cancelledOrders);
        
        request.getRequestDispatcher("/admin/orders/manage_orders.jsp").forward(request, response);
    }

    private boolean isSearchParamsPresent(String keyword, String status, String paymentMethod, String dateFrom, String dateTo) {
        return (keyword != null && !keyword.trim().isEmpty()) ||
               (status != null && !status.trim().isEmpty()) ||
               (paymentMethod != null && !paymentMethod.trim().isEmpty()) ||
               (dateFrom != null && !dateFrom.trim().isEmpty()) ||
               (dateTo != null && !dateTo.trim().isEmpty());
    }

    private void viewOrderDetail(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Order order = orderDAO.getOrderById(id);
        if (order != null) {
            List<OrderDetail> orderDetails = orderDAO.getOrderDetailsByOrderId(id);
            request.setAttribute("order", order);
            request.setAttribute("orderDetails", orderDetails);
            request.getRequestDispatcher("/admin/orders/order_detail.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Không tìm thấy đơn hàng");
            response.sendRedirect(request.getContextPath() + "/admin/orders");
        }
    }

    private void viewEditOrder(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Order order = orderDAO.getOrderById(id);
        if (order != null) {
            List<OrderDetail> orderDetails = orderDAO.getOrderDetailsByOrderId(id);
            request.setAttribute("order", order);
            request.setAttribute("orderDetails", orderDetails);
            request.getRequestDispatcher("/admin/orders/edit_order.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Không tìm thấy đơn hàng");
            response.sendRedirect(request.getContextPath() + "/admin/orders");
        }
    }

    private void deleteOrder(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        // Thực hiện xóa đơn hàng (cần implement logic xóa)
        // orderDAO.deleteOrder(id);
        
        request.getSession().setAttribute("message", "Đã xóa đơn hàng #" + id);
        response.sendRedirect(request.getContextPath() + "/admin/orders");
    }

    private void updateOrderStatus(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String status = request.getParameter("status");
        
        boolean success = orderDAO.updateOrderStatus(orderId, status);
        
        if (success) {
            request.getSession().setAttribute("message", "Đã cập nhật trạng thái đơn hàng #" + orderId);
        } else {
            request.getSession().setAttribute("error", "Cập nhật trạng thái thất bại");
        }

        response.sendRedirect(request.getContextPath() + "/admin/orders?action=detail&id=" + orderId);
    }
}