package controller.admin;

import DAO.BrandDAO;
import DAO.CategoryDAO;
import DAO.ProductDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import models.Product;

@WebServlet(name = "ProductManagementController", urlPatterns = {"/admin/products"})
public class ProductManagementController extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final BrandDAO brandDAO = new BrandDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
              throws ServletException, IOException {
        // TODO: check admin
        String action = req.getParameter("action");
        try {
            if ("edit".equals(action)) {
                Integer id = parseInt(req.getParameter("id"));
                req.setAttribute("product", id == null ? null : productDAO.getById(id));
                req.setAttribute("categories", categoryDAO.getAll());
                req.setAttribute("brands", brandDAO.getAll());
                req.getRequestDispatcher("/WEB-INF/views/admin/product-edit.jsp").forward(req, resp);
            } else {
                req.setAttribute("products", productDAO.getAll(1, 1000, null, null, null, "created"));
                req.getRequestDispatcher("/WEB-INF/views/admin/product-list.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
              throws ServletException, IOException {
        // TODO: check admin
        String action = req.getParameter("action");
        try {
            if ("save".equals(action)) {
                Integer id = parseInt(req.getParameter("product_id"));
                Product p = id == null ? new Product() : productDAO.getById(id);
                p.setProductName(req.getParameter("product_name"));
                p.setDescription(req.getParameter("description"));
                p.setPrice(new BigDecimal(req.getParameter("price")));
                p.setStockQuantity(Integer.parseInt(req.getParameter("stock_quantity")));
                p.setImageUrl(req.getParameter("image_url"));
                p.setCategoryId(parseInt(req.getParameter("category_id")));
                p.setBrandId(parseInt(req.getParameter("brand_id")));
                p.setSupplierId(parseInt(req.getParameter("supplier_id")));
                if (id == null) {
                    productDAO.create(p);
                } else {
                    productDAO.update(p);
                }
            } else if ("delete".equals(action)) {
                productDAO.delete(Integer.parseInt(req.getParameter("product_id")));
            }
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private Integer parseInt(String s) {
        try {
            return (s == null || s.isBlank()) ? null : Integer.valueOf(s);
        } catch (Exception e) {
            return null;
        }
    }
}
