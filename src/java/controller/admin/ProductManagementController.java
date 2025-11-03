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

    private static final long serialVersionUID = 1L;

    private final ProductDAO productDAO = new ProductDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final BrandDAO brandDAO = new BrandDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        // Check admin authentication
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        
        String action = req.getParameter("action");
        
        try {
            if (action == null || action.isEmpty()) {
                // Default: show product list
                listProducts(req, resp);
            } 
            else if ("edit".equals(action)) {
                showEditForm(req, resp);
            } 
            else if ("new".equals(action)) {
                showNewForm(req, resp);
            } 
            else if ("delete".equals(action)) {
                deleteProduct(req, resp);
            } 
            else {
                listProducts(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Lỗi: " + e.getMessage(), e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        
        String action = req.getParameter("action");
        
        try {
            if ("save".equals(action)) {
                saveProduct(req, resp);
            } else {
                resp.sendRedirect(req.getContextPath() + "/admin/products");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Lỗi: " + e.getMessage(), e);
        }
    }

    // 1. LIST PRODUCTS
    private void listProducts(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, Exception {
        
        // Get all products for admin
        var products = productDAO.getAllProducts();
        req.setAttribute("products", products);
        
        // Forward to product list page
        req.getRequestDispatcher("/WEB-INF/views/admin/product-list.jsp").forward(req, resp);
    }

    // 2. SHOW EDIT FORM
    private void showEditForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, Exception {
        
        String idParam = req.getParameter("id");
        
        if (idParam == null || idParam.isEmpty()) {
            setSessionError(req, "Thiếu ID sản phẩm!");
            resp.sendRedirect(req.getContextPath() + "/admin/products");
            return;
        }
        
        try {
            int productId = Integer.parseInt(idParam);
            Product product = productDAO.getProductById(productId);
            
            if (product == null) {
                setSessionError(req, "Không tìm thấy sản phẩm!");
                resp.sendRedirect(req.getContextPath() + "/admin/products");
                return;
            }
            
            // Get categories and brands for dropdowns
            var categories = categoryDAO.getAll();
            var brands = brandDAO.getAll();
            
            req.setAttribute("product", product);
            req.setAttribute("categories", categories);
            req.setAttribute("brands", brands);
            
            req.getRequestDispatcher("/WEB-INF/views/admin/product-edit.jsp").forward(req, resp);
            
        } catch (NumberFormatException e) {
            setSessionError(req, "ID sản phẩm không hợp lệ!");
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }

    // 3. SHOW NEW FORM
    private void showNewForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, Exception {
        
        // Get categories and brands for dropdowns
        var categories = categoryDAO.getAll();
        var brands = brandDAO.getAll();
        
        req.setAttribute("categories", categories);
        req.setAttribute("brands", brands);
        
        req.getRequestDispatcher("/WEB-INF/views/admin/product-edit.jsp").forward(req, resp);
    }

    // 4. SAVE PRODUCT (Create or Update)
    private void saveProduct(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, Exception {
        
        try {
            String idParam = req.getParameter("product_id");
            Integer productId = parseInt(idParam);
            
            Product product;
            boolean isNew = (productId == null);
            
            if (isNew) {
                product = new Product();
            } else {
                product = productDAO.getProductById(productId);
                if (product == null) {
                    setSessionError(req, "Không tìm thấy sản phẩm để cập nhật!");
                    resp.sendRedirect(req.getContextPath() + "/admin/products");
                    return;
                }
            }
            
            // Set product properties from form data
            product.setProductName(req.getParameter("product_name"));
            product.setDescription(req.getParameter("description"));
            
            // Handle price
            try {
                String priceStr = req.getParameter("price");
                if (priceStr != null && !priceStr.trim().isEmpty()) {
                    product.setPrice(new BigDecimal(priceStr));
                }
            } catch (NumberFormatException e) {
                setSessionError(req, "Giá sản phẩm không hợp lệ!");
                redirectBackToForm(req, resp, productId);
                return;
            }
            
            // Handle stock quantity
            try {
                String stockStr = req.getParameter("stock_quantity");
                if (stockStr != null && !stockStr.trim().isEmpty()) {
                    product.setStockQuantity(Integer.parseInt(stockStr));
                }
            } catch (NumberFormatException e) {
                setSessionError(req, "Số lượng tồn kho không hợp lệ!");
                redirectBackToForm(req, resp, productId);
                return;
            }
            
            product.setImageUrl(req.getParameter("image_url"));
            product.setCategoryId(parseInt(req.getParameter("category_id")));
            product.setBrandId(parseInt(req.getParameter("brand_id")));
            product.setSupplierId(parseInt(req.getParameter("supplier_id")));
            
            // Save product
            boolean success;
            if (isNew) {
                productDAO.addProduct(product);
                success = true;
                setSessionMessage(req, "✅ Thêm sản phẩm thành công!");
            } else {
                success = productDAO.updateProduct(product);
                if (success) {
                    setSessionMessage(req, "✅ Cập nhật sản phẩm thành công!");
                } else {
                    setSessionError(req, "❌ Không thể cập nhật sản phẩm!");
                }
            }
            
            if (success) {
                resp.sendRedirect(req.getContextPath() + "/admin/products");
            } else {
                redirectBackToForm(req, resp, productId);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            setSessionError(req, "Lỗi hệ thống: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }

    // 5. DELETE PRODUCT
    private void deleteProduct(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, Exception {
        
        String idParam = req.getParameter("id");
        
        if (idParam == null || idParam.isEmpty()) {
            setSessionError(req, "Thiếu ID sản phẩm!");
            resp.sendRedirect(req.getContextPath() + "/admin/products");
            return;
        }
        
        try {
            int productId = Integer.parseInt(idParam);
            
            boolean success = productDAO.deleteProduct(productId);
            
            if (success) {
                setSessionMessage(req, "✅ Đã xóa sản phẩm thành công!");
            } else {
                setSessionError(req, "❌ Không thể xóa sản phẩm!");
            }
            
        } catch (NumberFormatException e) {
            setSessionError(req, "ID sản phẩm không hợp lệ!");
        }
        
        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }

    // Helper methods
    private Integer parseInt(String s) {
        try {
            return (s == null || s.isBlank()) ? null : Integer.valueOf(s);
        } catch (Exception e) {
            return null;
        }
    }
    
    private void setSessionError(HttpServletRequest req, String message) {
        req.getSession().setAttribute("error", message);
    }
    
    private void setSessionMessage(HttpServletRequest req, String message) {
        req.getSession().setAttribute("message", message);
    }
    
    private void redirectBackToForm(HttpServletRequest req, HttpServletResponse resp, Integer productId) 
            throws IOException {
        if (productId == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/products?action=new");
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/products?action=edit&id=" + productId);
        }
    }
}