package controller.admin;

import DAO.UserDAO;
import DAO.OrderDAO;
import DAO.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;
import java.util.List;

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
            // 1. Thống kê tổng quan
            int totalUsers = userDAO.countCustomers();
            int totalOrders = orderDAO.countAllOrders();
            double totalRevenue = orderDAO.getTotalRevenue();
            int totalProducts = productDAO.countProducts();
            
            // 2. Dữ liệu cho biểu đồ
            Map<String, Double> monthlyRevenue = orderDAO.getMonthlyRevenue(6);
            Map<String, Integer> orderStatusStats = orderDAO.getOrderStatusStatistics();
            Map<String, Integer> topProducts = productDAO.getTopSellingProducts(5);
            List<Map<String, Object>> recentActivities = orderDAO.getRecentActivities(5);
            
            // Set attributes
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("monthlyRevenue", monthlyRevenue);
            request.setAttribute("orderStatusStats", orderStatusStats);
            request.setAttribute("topProducts", topProducts);
            request.setAttribute("recentActivities", recentActivities);
            
            // Debug log
            System.out.println("=== DASHBOARD DATA ===");
            System.out.println("Basic Stats:");
            System.out.println("  - Users: " + totalUsers);
            System.out.println("  - Orders: " + totalOrders);
            System.out.println("  - Revenue: " + totalRevenue);
            System.out.println("  - Products: " + totalProducts);
            System.out.println("Chart Data:");
            System.out.println("  - Monthly Revenue: " + monthlyRevenue);
            System.out.println("  - Order Status: " + orderStatusStats);
            System.out.println("  - Top Products: " + topProducts);
            System.out.println("  - Recent Activities: " + (recentActivities != null ? recentActivities.size() : 0));
            
            // Forward to JSP
            request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
            
        } catch (SQLException e) {
            System.err.println("ERROR loading dashboard:");
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                             "Không thể tải dữ liệu dashboard: " + e.getMessage());
        }
    }
}