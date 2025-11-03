package controller;

import DAO.ProductDAO;
import DAO.CategoryDAO;
import models.Product;
import models.Category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(urlPatterns = {"/shop", "/shop/"})
public class ShopController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final ProductDAO productDAO = new ProductDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();
    private static final int PAGE_SIZE = 9;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        System.out.println("=== SHOP CONTROLLER ACCESSED ===");
        System.out.println("Request URI: " + req.getRequestURI());
        System.out.println("Context Path: " + req.getContextPath());
        System.out.println("Servlet Path: " + req.getServletPath());

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String pageStr = req.getParameter("page");
        String catStr  = req.getParameter("cat");
        String q       = req.getParameter("q");

        System.out.println("Parameters - page: " + pageStr + ", cat: " + catStr + ", q: " + q);

        int page = 1;
        Integer cat = null;

        try { 
            if (pageStr != null) page = Math.max(1, Integer.parseInt(pageStr)); 
        } catch (Exception ignore) {}
        
        try { 
            if (catStr != null && !catStr.isEmpty()) cat = Integer.valueOf(catStr); 
        } catch (Exception ignore) {}
        
        if (q != null) {
            q = q.trim();
            if (q.isEmpty()) q = null;
        }

        try {
            // Lấy danh sách sản phẩm
            List<Product> products = productDAO.listPaged(page, PAGE_SIZE, cat, q);
            int total = productDAO.countAllActive(cat, q);
            int totalPages = (int) Math.ceil(total / (double) PAGE_SIZE);
            
            if (totalPages == 0) totalPages = 1;
            if (page > totalPages) page = totalPages;

            // Lấy danh mục active
            Category activeCat = (cat == null) ? null : categoryDAO.getById(cat);

            System.out.println("Products found: " + products.size());
            System.out.println("Forwarding to shop.jsp");

            // Set attributes
            req.setAttribute("products", products);
            req.setAttribute("page", page);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("q", q);
            req.setAttribute("cat", cat);
            req.setAttribute("activeCat", activeCat);

            // Forward đến JSP
            req.getRequestDispatcher("/shop.jsp").forward(req, resp);

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("SQL Error: " + e.getMessage());
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Không thể tải dữ liệu cửa hàng.");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("General Error: " + e.getMessage());
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Lỗi hệ thống: " + e.getMessage());
        }
    }
}