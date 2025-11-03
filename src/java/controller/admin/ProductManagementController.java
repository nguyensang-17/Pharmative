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

<<<<<<< HEAD
=======
    private static final long serialVersionUID = 1L;

<<<<<<< Updated upstream
    // View constants
    private static final String LAYOUT = "/WEB-INF/admin/layout.jsp";
    private static final String PRODUCT_INDEX = "/WEB-INF/admin/products/index.jsp";
    private static final String PRODUCT_FORM  = "/WEB-INF/admin/products/form.jsp";

=======
>>>>>>> Stashed changes
>>>>>>> sang
    private final ProductDAO productDAO = new ProductDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final BrandDAO brandDAO = new BrandDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
              throws ServletException, IOException {
        // TODO: check admin
        String action = req.getParameter("action");
        try {
<<<<<<< HEAD
            if ("edit".equals(action)) {
                Integer id = parseInt(req.getParameter("id"));
                req.setAttribute("product", id == null ? null : productDAO.getById(id));
=======
<<<<<<< Updated upstream
            if (pathInfo != null && !pathInfo.equals("/")) {
                String[] parts = pathInfo.split("/");
                // parts[0] = "" (leading slash)
                if (parts.length == 2 && "new".equals(parts[1])) {
                    showProductForm(req, resp, null);
                    return;
                }
                if (parts.length == 3) {
                    Integer id = parseIntSafe(parts[1]);
                    if (id == null) { resp.sendError(400, "Invalid product id"); return; }
                    switch (parts[2]) {
                        case "edit":
                            showProductForm(req, resp, id);
                            return;
                        case "delete":
                            deleteProduct(req, resp, id);
                            return;
                    }
                }
=======
            if ("edit".equals(action)) {
                Integer id = parseInt(req.getParameter("id"));
                req.setAttribute("product", id == null ? null : productDAO.getProductById(id));
>>>>>>> sang
                req.setAttribute("categories", categoryDAO.getAll());
                req.setAttribute("brands", brandDAO.getAll());
                req.getRequestDispatcher("/WEB-INF/views/admin/product-edit.jsp").forward(req, resp);
            } else {
<<<<<<< HEAD
                req.setAttribute("products", productDAO.getAll(1, 1000, null, null, null, "created"));
                req.getRequestDispatcher("/WEB-INF/views/admin/product-list.jsp").forward(req, resp);
=======
                //req.setAttribute("products", productDAO.getAllProducts(1, 1000, null, null, null, "created"));
                req.getRequestDispatcher("/WEB-INF/views/admin/product-list.jsp").forward(req, resp);
>>>>>>> Stashed changes
>>>>>>> sang
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
<<<<<<< HEAD
=======
<<<<<<< Updated upstream
            // also accept REST-like save via POST to /admin/products (create) or /admin/products/{id} (update)
            String pathInfo = req.getPathInfo(); // may be null
            if (pathInfo != null && pathInfo.matches("^/\\d+$")) {
                // update
                Integer id = parseIntSafe(pathInfo.substring(1));
                saveProduct(req, resp, id);
                return;
=======
            if ("save".equals(action)) {
                Integer id = parseInt(req.getParameter("product_id"));
                Product p = id == null ? new Product() : productDAO.getProductById(id);
                p.setProductName(req.getParameter("product_name"));
                p.setDescription(req.getParameter("description"));
                p.setPrice(new BigDecimal(req.getParameter("price")));
                p.setStockQuantity(Integer.parseInt(req.getParameter("stock_quantity")));
                p.setImageUrl(req.getParameter("image_url"));
                p.setCategoryId(parseInt(req.getParameter("category_id")));
                p.setBrandId(parseInt(req.getParameter("brand_id")));
                p.setSupplierId(parseInt(req.getParameter("supplier_id")));
                if (id == null) {
                    productDAO.addProduct(p);
                } else {
                    productDAO.updateProduct(p);
                }
            } else if ("delete".equals(action)) {
                productDAO.deleteProduct(Integer.parseInt(req.getParameter("product_id")));
>>>>>>> Stashed changes
            }

>>>>>>> sang
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
