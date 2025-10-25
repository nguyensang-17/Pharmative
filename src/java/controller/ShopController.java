package controller;

import DAO.ProductDAO;
import models.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "ShopController", urlPatterns = {"/shop"})
public class ShopController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final ProductDAO productDAO = new ProductDAO();
    private static final int PAGE_SIZE = 9; // 3 cột x 3 hàng

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // RẤT QUAN TRỌNG: đặt encoding trước khi đọc tham số
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String pageStr = req.getParameter("page");
        String catStr  = req.getParameter("cat");
        String q       = req.getParameter("q");

        int page = 1;
        Integer cat = null;

        try { if (pageStr != null) page = Math.max(1, Integer.parseInt(pageStr)); } catch (Exception ignore) {}
        try { if (catStr  != null && !catStr.isEmpty()) cat = Integer.valueOf(catStr); } catch (Exception ignore) {}
        if (q != null) {
            q = q.trim();
            if (q.isEmpty()) q = null;
        }

        try {
            int total = productDAO.countAllActive(cat, q);
            int totalPages = (int) Math.ceil(total / (double) PAGE_SIZE);
            if (totalPages == 0) totalPages = 1;
            if (page > totalPages) page = totalPages;

            List<Product> products = productDAO.listPaged(page, PAGE_SIZE, cat, q);

            // set attributes cho JSP
            req.setAttribute("products", products);
            req.setAttribute("page", page);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("q", q);
            req.setAttribute("cat", cat);

            req.getRequestDispatcher("/shop.jsp").forward(req, resp);
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể tải dữ liệu cửa hàng.");
        }
    }
}
