package controller.admin;

import DAO.CategoryDAO;
import DAO.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Product;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;

@WebServlet(urlPatterns = {"/admin/products", "/admin/products/*"})
public class ProductManagementController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // View constants
    private static final String LAYOUT = "/WEB-INF/admin/layout.jsp";
    private static final String PRODUCT_INDEX = "/WEB-INF/admin/products/index.jsp";
    private static final String PRODUCT_FORM  = "/WEB-INF/admin/products/form.jsp";

    private final ProductDAO productDAO = new ProductDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        // route by REST-like path first, then fallback to ?action=
        String pathInfo = req.getPathInfo(); // e.g. "/new", "/123/edit", "/123/delete"
        String action = req.getParameter("action");

        try {
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
            }

            if (action == null) action = "list";
            switch (action) {
                case "add":
                    showProductForm(req, resp, null);
                    break;
                case "edit":
                    showProductForm(req, resp, parseIntSafe(req.getParameter("id")));
                    break;
                case "delete":
                    deleteProduct(req, resp, parseIntSafe(req.getParameter("id")));
                    break;
                default:
                    listProducts(req, resp);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        try {
            // also accept REST-like save via POST to /admin/products (create) or /admin/products/{id} (update)
            String pathInfo = req.getPathInfo(); // may be null
            if (pathInfo != null && pathInfo.matches("^/\\d+$")) {
                // update
                Integer id = parseIntSafe(pathInfo.substring(1));
                saveProduct(req, resp, id);
                return;
            }

            if ("save".equals(action)) {
                Integer id = parseIntSafe(req.getParameter("id"));
                saveProduct(req, resp, id);
            } else {
                listProducts(req, resp);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    /* -------------------- handlers -------------------- */

    private void listProducts(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, ServletException, IOException {
        // TODO: nếu DAO của bạn hỗ trợ phân trang, đọc page/size từ query string
        // int page = parseIntSafe(req.getParameter("page"), 1);
        // int size = parseIntSafe(req.getParameter("size"), 20);
        // req.setAttribute("page", productDAO.getAllProductsPaged(page, size));

        req.setAttribute("products", productDAO.getAllProducts(1, 1000)); // giữ nguyên API hiện có
        setLayoutAttrs(req, "products", "Sản phẩm", PRODUCT_INDEX);
        req.getRequestDispatcher(LAYOUT).forward(req, resp);
    }

    private void showProductForm(HttpServletRequest req, HttpServletResponse resp, Integer id)
            throws SQLException, ServletException, IOException {
        if (id != null) {
            Product p = productDAO.getProductById(id);
            if (p == null) { resp.sendError(404, "Product not found"); return; }
            req.setAttribute("product", p);
            req.setAttribute("pageTitle", "Cập nhật sản phẩm");
        } else {
            req.setAttribute("pageTitle", "Thêm sản phẩm");
        }
        req.setAttribute("categoryList", categoryDAO.getAllCategories());
        setLayoutAttrs(req, "products", (String) req.getAttribute("pageTitle"), PRODUCT_FORM);
        req.getRequestDispatcher(LAYOUT).forward(req, resp);
    }

    private void saveProduct(HttpServletRequest req, HttpServletResponse resp, Integer id)
            throws SQLException, IOException {
        // đọc dữ liệu form
        String name = nvl(req.getParameter("name"));
        Integer categoryId = parseIntSafe(req.getParameter("categoryId"));
        BigDecimal price = parseBigDecimalSafe(req.getParameter("price"));
        Integer stock = parseIntSafe(req.getParameter("stockQuantity"));
        String description = nvl(req.getParameter("description"));
        String imageUrl = nvl(req.getParameter("imageUrl"));

        // validate cơ bản
        if (name.isBlank() || categoryId == null || price == null || stock == null) {
            // có thể set flash error vào session rồi redirect về form
            resp.sendRedirect(req.getContextPath() + "/admin/products?action=" + (id == null ? "add" : "edit&id="+id));
            return;
        }

        Product p = new Product();
        p.setName(name);
        p.setCategoryId(categoryId);
        p.setPrice(price.max(BigDecimal.ZERO));
        p.setStockQuantity(Math.max(0, stock));
        p.setDescription(description);
        p.setImageUrl(imageUrl);

        if (id == null) {
            productDAO.addProduct(p);
        } else {
            p.setId(id);
            productDAO.updateProduct(p);
        }

        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }

    private void deleteProduct(HttpServletRequest req, HttpServletResponse resp, Integer id)
            throws SQLException, IOException {
        if (id != null) {
            productDAO.deleteProduct(id);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }

    /* -------------------- helpers -------------------- */

    private void setLayoutAttrs(HttpServletRequest req, String activeMenu, String pageTitle, String contentPage) {
        req.setAttribute("activeMenu", activeMenu);
        req.setAttribute("pageTitle", pageTitle);
        req.setAttribute("contentPage", contentPage);
    }

    private static Integer parseIntSafe(String s) {
        try { return (s == null || s.isBlank()) ? null : Integer.parseInt(s.trim()); }
        catch (NumberFormatException e) { return null; }
    }

    private static BigDecimal parseBigDecimalSafe(String s) {
        try { return (s == null || s.isBlank()) ? null : new BigDecimal(s.trim()); }
        catch (NumberFormatException e) { return null; }
    }

    private static String nvl(String s) { return s == null ? "" : s.trim(); }
}
