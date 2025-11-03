package controller.admin;

import DAO.UserDAO;
import DAO.OrderDAO;
import DAO.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/admin/dashboard")
public class DashboardController extends HttpServlet {
    
    private UserDAO userDAO = new UserDAO();
    private OrderDAO orderDAO = new OrderDAO();
    private ProductDAO productDAO = new ProductDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("=== DASHBOARD CONTROLLER ===");
        System.out.println("Loading dashboard data...");
        
        try {
            // Lấy thống kê tổng quan
            int totalUsers = userDAO.countCustomers();
            int totalOrders = orderDAO.countAllOrders();
            double totalRevenue = orderDAO.getTotalRevenue();
            int totalProducts = productDAO.countProducts();
            
            // Set attributes
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("totalProducts", totalProducts);
            
            System.out.println("Stats loaded:");
            System.out.println("  - Users: " + totalUsers);
            System.out.println("  - Orders: " + totalOrders);
            System.out.println("  - Revenue: " + totalRevenue);
            System.out.println("  - Products: " + totalProducts);
            
            // Forward to JSP
            request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
            
        } catch (SQLException e) {
            System.err.println("ERROR loading dashboard:");
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                             "Không thể tải dữ liệu dashboard");
        }
    }
}