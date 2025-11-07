package controller.admin;

import DAO.BrandDAO;
import DAO.CategoryDAO;
import DAO.ProductDAO;
import DAO.SupplierDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import models.Product;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Paths;

@WebServlet(name = "ProductManagementController", urlPatterns = {"/admin/products", "/admin/products/"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 1024 * 1024 * 5, // 5MB
        maxRequestSize = 1024 * 1024 * 10 // 10MB
)
public class ProductManagementController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final ProductDAO productDAO = new ProductDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final BrandDAO brandDAO = new BrandDAO();
    private final SupplierDAO supplierDAO = new SupplierDAO();

    // Thư mục lưu ảnh
    private static final String UPLOAD_DIRECTORY = "images/products";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        System.out.println("=== PRODUCT MANAGEMENT CONTROLLER CALLED ===");

        // Check admin authentication
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            System.out.println("User not authenticated, redirecting to login");
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String action = req.getParameter("action");
        System.out.println("Action parameter: " + action);

        try {
            if (action == null || action.isEmpty()) {
                System.out.println("Listing products...");
                listProducts(req, resp);
            } else if ("edit".equals(action)) {
                System.out.println("Showing edit form for ID: " + req.getParameter("id"));
                showEditForm(req, resp);
            } else if ("new".equals(action)) {
                System.out.println("Showing new product form");
                showNewForm(req, resp);
            } else if ("delete".equals(action)) {
                System.out.println("Deleting product ID: " + req.getParameter("id"));
                deleteProduct(req, resp);
            } else {
                System.out.println("Unknown action, listing products");
                listProducts(req, resp);
            }
        } catch (Exception e) {
            System.err.println("ERROR in ProductManagementController:");
            e.printStackTrace();
            throw new ServletException("Lỗi: " + e.getMessage(), e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        System.out.println("=== PRODUCT MANAGEMENT POST CALLED ===");
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");
        System.out.println("POST Action: " + action);

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

        System.out.println("=== LISTING PRODUCTS IN CONTROLLER ===");

        try {
            // Get all products for admin
            var products = productDAO.getAllProductsForAdmin();
            System.out.println("Products retrieved: " + products.size());

            req.setAttribute("products", products);

            String jspPath = "/admin/products/product-list.jsp";
            System.out.println("Forwarding to: " + jspPath);

            req.getRequestDispatcher(jspPath).forward(req, resp);

        } catch (Exception e) {
            System.err.println("ERROR in listProducts:");
            e.printStackTrace();
            throw e;
        }
    }

    // 2. SHOW EDIT FORM
    private void showEditForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, Exception {

        String idParam = req.getParameter("id");
        System.out.println("Edit form for ID: " + idParam);

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

            // Get categories, brands và suppliers for dropdowns
            var categories = categoryDAO.getAll();
            var brands = brandDAO.getAll();
            var suppliers = supplierDAO.getAll();

            req.setAttribute("product", product);
            req.setAttribute("categories", categories);
            req.setAttribute("brands", brands);
            req.setAttribute("suppliers", suppliers);

            String jspPath = "/admin/products/product-edits.jsp";
            System.out.println("Forwarding to edit form: " + jspPath);

            req.getRequestDispatcher(jspPath).forward(req, resp);

        } catch (NumberFormatException e) {
            setSessionError(req, "ID sản phẩm không hợp lệ!");
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }

    // 3. SHOW NEW FORM
    private void showNewForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, Exception {

        System.out.println("Showing new product form");

        // Get categories, brands và suppliers for dropdowns
        var categories = categoryDAO.getAll();
        var brands = brandDAO.getAll();
        var suppliers = supplierDAO.getAll();

        req.setAttribute("categories", categories);
        req.setAttribute("brands", brands);
        req.setAttribute("suppliers", suppliers);

        String jspPath = "/admin/products/product-add.jsp";
        System.out.println("Forwarding to new form: " + jspPath);

        req.getRequestDispatcher(jspPath).forward(req, resp);
    }

    // 4. SAVE PRODUCT (Create or Update) - ĐÃ SỬA ĐỂ XỬ LÝ UPLOAD ẢNH
    // 4. SAVE PRODUCT (Create or Update)
    private void saveProduct(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, Exception {

        System.out.println("=== SAVING PRODUCT ===");

        try {
            String idParam = req.getParameter("product_id");
            Integer productId = parseInt(idParam);

            Product product;
            boolean isNew = (productId == null);

            if (isNew) {
                product = new Product();
                System.out.println("Creating new product");
            } else {
                product = productDAO.getProductById(productId);
                System.out.println("Updating product ID: " + productId);
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
                } else {
                    setSessionError(req, "Giá sản phẩm không được để trống!");
                    redirectBackToForm(req, resp, productId);
                    return;
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
                } else {
                    setSessionError(req, "Số lượng tồn kho không được để trống!");
                    redirectBackToForm(req, resp, productId);
                    return;
                }
            } catch (NumberFormatException e) {
                setSessionError(req, "Số lượng tồn kho không hợp lệ!");
                redirectBackToForm(req, resp, productId);
                return;
            }

            // Xử lý upload ảnh
            String imageUrl = handleImageUpload(req, product);
            if (imageUrl != null) {
                product.setImageUrl(imageUrl);
            } else if (isNew) {
                // Nếu là thêm mới và không có ảnh upload, để null
                product.setImageUrl(null);
            }
            // Nếu là update và không upload ảnh mới, giữ ảnh cũ

            // Xử lý category_id (bắt buộc)
            Integer categoryId = parseInt(req.getParameter("category_id"));
            if (categoryId == null) {
                setSessionError(req, "Vui lòng chọn danh mục!");
                redirectBackToForm(req, resp, productId);
                return;
            }
            product.setCategoryId(categoryId);

            // Xử lý brand_id (không bắt buộc)
            Integer brandId = parseInt(req.getParameter("brand_id"));
            product.setBrandId(brandId); // Có thể là null

            // Xử lý supplier_id (không bắt buộc)
            Integer supplierId = parseInt(req.getParameter("supplier_id"));
            product.setSupplierId(supplierId); // Có thể là null

            // Debug thông tin
            System.out.println("=== PRODUCT DATA TO SAVE ===");
            System.out.println("Name: " + product.getProductName());
            System.out.println("Price: " + product.getPrice());
            System.out.println("Stock: " + product.getStockQuantity());
            System.out.println("Category: " + product.getCategoryId());
            System.out.println("Brand: " + product.getBrandId());
            System.out.println("Supplier: " + product.getSupplierId());
            System.out.println("Image: " + product.getImageUrl());

            // Save product
            boolean success;
            if (isNew) {
                productDAO.addProduct(product);
                success = true;
                setSessionMessage(req, "✅ Thêm sản phẩm thành công!");
                System.out.println("Product added successfully");
            } else {
                success = productDAO.updateProduct(product);
                if (success) {
                    setSessionMessage(req, "✅ Cập nhật sản phẩm thành công!");
                    System.out.println("Product updated successfully");
                } else {
                    setSessionError(req, "❌ Không thể cập nhật sản phẩm!");
                    System.out.println("Product update failed");
                }
            }

            if (success) {
                resp.sendRedirect(req.getContextPath() + "/admin/products");
            } else {
                redirectBackToForm(req, resp, productId);
            }

        } catch (Exception e) {
            System.err.println("ERROR in saveProduct:");
            e.printStackTrace();
            setSessionError(req, "Lỗi hệ thống: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }

    // 5. DELETE PRODUCT
    private void deleteProduct(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, Exception {

        String idParam = req.getParameter("id");
        System.out.println("Deleting product ID: " + idParam);

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
                System.out.println("Product deleted successfully");
            } else {
                setSessionError(req, "❌ Không thể xóa sản phẩm!");
                System.out.println("Product deletion failed");
            }

        } catch (NumberFormatException e) {
            setSessionError(req, "ID sản phẩm không hợp lệ!");
        }

        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }

    // Helper method để xử lý upload ảnh
    // Helper method để xử lý upload ảnh
// Helper method để xử lý upload ảnh - Phiên bản đơn giản
// Helper method để xử lý upload ảnh - Phiên bản tối ưu
// Helper method để xử lý upload ảnh - Phiên bản fix lỗi đường dẫn
    private String handleImageUpload(HttpServletRequest request, Product product)
            throws IOException, ServletException {

        Part filePart = request.getPart("image");

        // Kiểm tra xem có file được upload không
        if (filePart == null || filePart.getSize() == 0) {
            System.out.println("No image uploaded");
            return null;
        }

        // Lấy tên file gốc
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        if (fileName == null || fileName.isEmpty()) {
            System.out.println("No file name");
            return null;
        }

        // Lấy phần mở rộng file
        String fileExtension = "";
        int dotIndex = fileName.lastIndexOf(".");
        if (dotIndex > 0) {
            fileExtension = fileName.substring(dotIndex);
        }

        // Tạo tên file duy nhất
        String uniqueFileName = System.currentTimeMillis() + fileExtension;

        // Đường dẫn lưu file - sửa lại cho đúng
        String uploadPath = getServletContext().getRealPath("/") + UPLOAD_DIRECTORY;

        System.out.println("Upload path: " + uploadPath);

        // Tạo thư mục nếu chưa tồn tại
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            boolean created = uploadDir.mkdirs();
            System.out.println("Directory created: " + created + " - " + uploadPath);
        }

        // Lưu file
        String filePath = uploadPath + File.separator + uniqueFileName;
        System.out.println("Saving image to: " + filePath);

        try {
            // Copy file input stream đến file output stream
            try ( InputStream input = filePart.getInputStream();  OutputStream output = new FileOutputStream(filePath)) {
                byte[] buffer = new byte[1024];
                int length;
                while ((length = input.read(buffer)) > 0) {
                    output.write(buffer, 0, length);
                }
            }

            System.out.println("✅ Image saved successfully: " + uniqueFileName);

            // Trả về đường dẫn tương đối để lưu vào database
            return UPLOAD_DIRECTORY + "/" + uniqueFileName;
        } catch (Exception e) {
            System.err.println("❌ Error saving image: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
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
