//package controler;
//
//import DAO.ProductDAO;
//import models.Product;
//import jakarta.servlet.ServletException;
// // dùng nếu bạn muốn map bằng annotation
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//
//import java.io.IOException;
//import java.sql.SQLException;
//import java.util.List;
//
////@WebServlet(name = "HomeController", urlPatterns = {"/home"})
//public class HomeController extends HttpServlet {
//
//    private static final long serialVersionUID = 1L;
//    private final ProductDAO productDAO = new ProductDAO();
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        try {
//            // Lấy 8 sản phẩm mới nhất để hiển thị trên trang chủ
//            List<Product> featuredProducts = productDAO.getFeaturedProducts(8);
//            request.setAttribute("featuredProducts", featuredProducts);
//            request.getRequestDispatcher("/home.jsp").forward(request, response);
//        } catch (SQLException e) {
//            // Có thể chuyển hướng đến một trang lỗi chung
//            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể tải dữ liệu trang chủ.");
//        }
//    }
//}
package controler;

import DAO.ProductDAO;
import models.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet; // dùng nếu bạn muốn map bằng annotation
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

// Nếu bạn muốn map bằng annotation, bỏ comment dòng dưới:
// @WebServlet(name = "HomeController", urlPatterns = {"/", "/index"})
public class HomeController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ProductDAO productDAO = new ProductDAO();
    private static final int PAGE_SIZE = 12; // số sp/trang

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // --- đọc query params ---
        String pageStr = request.getParameter("page");
        String catStr  = request.getParameter("cat"); // tùy chọn lọc theo category
        String q       = request.getParameter("q");   // tùy chọn tìm theo tên

        int page = 1;
        Integer cat = null;
        try { if (pageStr != null) page = Math.max(1, Integer.parseInt(pageStr)); } catch (Exception ignore) {}
        try { if (catStr  != null && !catStr.isEmpty()) cat = Integer.valueOf(catStr); } catch (Exception ignore) {}

        try {
            // --- tổng số & tính tổng trang ---
            int total = productDAO.countAllActive(cat, q);
            int totalPages = (int)Math.ceil(total / (double) PAGE_SIZE);
            if (totalPages == 0) totalPages = 1;
            if (page > totalPages) page = totalPages;

            // --- danh sách theo trang ---
            List<Product> products = productDAO.listPaged(page, PAGE_SIZE, cat, q);

            // --- block HOT: top bán 60 ngày (có thể rỗng nếu site mới) ---
            List<Product> hot = productDAO.getHot(8);
            if (hot == null || hot.isEmpty()) {
                // fallback để luôn có dữ liệu hiển thị
                hot = productDAO.getFeaturedProducts(8);
            }

            // --- set attributes cho JSP ---
            request.setAttribute("products", products);
            request.setAttribute("hot", hot);
            request.setAttribute("page", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("q", q);
            request.setAttribute("cat", cat);

            // forward về home.jsp
            request.getRequestDispatcher("/home.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(
                HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                "Không thể tải dữ liệu trang chủ."
            );
        }
    }
}

