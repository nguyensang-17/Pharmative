package controler.admin;

import DAO.CategoryDAO;
import DAO.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import models.Product;

@WebServlet("/admin/products")
public class ProductManagementController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final ProductDAO productDAO = new ProductDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "add":
                case "edit":
                    showProductForm(request, response);
                    break;
                case "delete":
                    deleteProduct(request, response);
                    break;
                default:
                    listProducts(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("save".equals(action)) {
                saveProduct(request, response);
            } else {
                listProducts(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        request.setAttribute("productList", productDAO.getAllProducts(1, 1000)); // Lấy tất cả
        request.getRequestDispatcher("/admin/manage_products.jsp").forward(request, response);
    }

    private void showProductForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            Product product = productDAO.getProductById(Integer.parseInt(idStr));
            request.setAttribute("product", product);
        }
        request.setAttribute("categoryList", categoryDAO.getAllCategories());
        request.getRequestDispatcher("/admin/product_form.jsp").forward(request, response);
    }

    private void saveProduct(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        Product product = new Product();
        product.setName(request.getParameter("name"));
        product.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
        product.setPrice(new BigDecimal(request.getParameter("price")));
        product.setStockQuantity(Integer.parseInt(request.getParameter("stockQuantity")));
        product.setDescription(request.getParameter("description"));
        product.setImageUrl(request.getParameter("imageUrl"));

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            productDAO.addProduct(product);
        } else {
            product.setId(Integer.parseInt(idStr));
            productDAO.updateProduct(product);
        }
        response.sendRedirect(request.getContextPath() + "/admin/products");
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        productDAO.deleteProduct(id);
        response.sendRedirect(request.getContextPath() + "/admin/products");
    }
}