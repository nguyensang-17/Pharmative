package controler;

import DAO.CategoryDAO;
import DAO.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import models.Category;
import models.Product;

@WebServlet("/products")
public class ProductController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final ProductDAO productDAO = new ProductDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();
    private static final int PAGE_SIZE = 9; // 9 sản phẩm mỗi trang

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String categoryIdStr = request.getParameter("categoryId");
            String searchQuery = request.getParameter("search");
            String pageStr = request.getParameter("page");
            int page = (pageStr == null) ? 1 : Integer.parseInt(pageStr);

            List<Product> productList;
            int totalProducts;

            if (searchQuery != null && !searchQuery.isEmpty()) {
                productList = productDAO.searchProductsByName(searchQuery);
                totalProducts = productList.size(); // Không phân trang khi tìm kiếm cho đơn giản
            } else if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
                int categoryId = Integer.parseInt(categoryIdStr);
                productList = productDAO.getProductsByCategory(categoryId);
                totalProducts = productList.size(); // Không phân trang khi lọc
            } else {
                productList = productDAO.getAllProducts(page, PAGE_SIZE);
                totalProducts = productDAO.getTotalProductCount();
            }

            List<Category> categoryList = categoryDAO.getAllCategories();
            int totalPages = (int) Math.ceil((double) totalProducts / PAGE_SIZE);

            request.setAttribute("products", productList);
            request.setAttribute("categories", categoryList);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", page);
            request.setAttribute("selectedCategoryId", categoryIdStr);

            request.getRequestDispatcher("products.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể tải danh sách sản phẩm.");
        }
    }
}