package controller.admin;

import DAO.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import models.Order;

@WebServlet("/admin/orders")
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
        request.setAttribute("orderList", orderDAO.getAllOrders());
<<<<<<< HEAD
        request.getRequestDispatcher("/admin/manage_orders.jsp").forward(request, response);
=======
        request.getRequestDispatcher("/admin/orders/manage_orders.jsp").forward(request, response);
>>>>>>> parent of 92e24ee (Merge branch 'main' of https://github.com/nguyensang-17/Pharmative)
    }

    private void viewOrderDetail(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Order order = orderDAO.getOrderById(id); // DAO này đã lấy cả chi tiết đơn hàng
        request.setAttribute("order", order);
        request.getRequestDispatcher("/admin/order_detail.jsp").forward(request, response);
    }

    private void updateOrderStatus(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String status = request.getParameter("status");
        orderDAO.updateOrderStatus(orderId, status);

        // Chuyển hướng lại trang chi tiết để xem thay đổi
        response.sendRedirect(request.getContextPath() + "/admin/orders?action=detail&id=" + orderId);
    }
}