package controler;

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

@WebServlet(name = "HomeController", urlPatterns = {"/home", ""})
public class HomeController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy 8 sản phẩm mới nhất để hiển thị trên trang chủ
            List<Product> featuredProducts = productDAO.getFeaturedProducts(8);
            request.setAttribute("featuredProducts", featuredProducts);
            request.getRequestDispatcher("home.jsp").forward(request, response);
        } catch (SQLException e) {
            // Có thể chuyển hướng đến một trang lỗi chung
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể tải dữ liệu trang chủ.");
        }
    }
}