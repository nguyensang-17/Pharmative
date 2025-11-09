package controller.admin;

import DAO.CategoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import models.Category;

@WebServlet("/admin/categories")
public class CategoryManagementController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list"; // Mặc định là hiển thị danh sách
        }

        try {
            switch (action) {
                case "add":
                case "edit":
                    showCategoryForm(request, response);
                    break;
                case "delete":
                    deleteCategory(request, response);
                    break;
                default:
                    listCategories(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Lỗi truy vấn cơ sở dữ liệu", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("delete".equals(action)) {
                deleteCategory(request, response);
            } else {
                saveCategory(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Lỗi khi lưu danh mục", e);
        }
    }

    private void listCategories(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        // Lấy danh sách categories với đầy đủ thông tin
        request.setAttribute("categories", categoryDAO.getAllWithDetails());
        
        // Lấy thống kê
        request.setAttribute("totalCategories", categoryDAO.getTotalCategories());
        request.setAttribute("totalParentCategories", categoryDAO.getTotalParentCategories());
        request.setAttribute("totalChildCategories", categoryDAO.getTotalChildCategories());
        request.setAttribute("newCategoriesThisMonth", categoryDAO.getNewCategoriesThisMonth());
        
        request.getRequestDispatcher("/admin/categories/cat-list.jsp").forward(request, response);
    }

    private void showCategoryForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        String idStr = request.getParameter("id");
        
        // Lấy danh sách danh mục cha để hiển thị trong dropdown
        request.setAttribute("parentCategories", categoryDAO.getParents());
        
        if (idStr != null && !idStr.isEmpty()) {
            // Chế độ sửa
            int id = Integer.parseInt(idStr);
            Category category = categoryDAO.getCategoryById(id);
            request.setAttribute("category", category);
        }
        // Nếu không có id, đây là chế độ thêm mới
        request.getRequestDispatcher("/admin/categories/category-form.jsp").forward(request, response);
    }

    private void saveCategory(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        HttpSession session = request.getSession();
        
        String name = request.getParameter("name");
        String parentIdStr = request.getParameter("parentCategoryId");
        String idStr = request.getParameter("id");
        
        if (name == null || name.trim().isEmpty()) {
            session.setAttribute("error", "Tên danh mục không được để trống");
            response.sendRedirect(request.getContextPath() + "/admin/categories?action=" + (idStr != null ? "edit&id=" + idStr : "add"));
            return;
        }
        
        Category category = new Category();
        category.setCategoryName(name.trim());
        
        // Xử lý danh mục cha
        if (parentIdStr != null && !parentIdStr.isEmpty() && !parentIdStr.equals("0")) {
            category.setParentCategoryId(Integer.parseInt(parentIdStr));
        } else {
            category.setParentCategoryId(null);
        }

        try {
            if (idStr == null || idStr.isEmpty()) {
                // Thêm mới
                categoryDAO.addCategory(category);
                session.setAttribute("message", "Thêm danh mục thành công!");
            } else {
                // Cập nhật
                category.setCategoryId(Integer.parseInt(idStr));
                categoryDAO.updateCategory(category);
                session.setAttribute("message", "Cập nhật danh mục thành công!");
            }
            
            response.sendRedirect(request.getContextPath() + "/admin/categories");
            
        } catch (SQLException e) {
            session.setAttribute("error", "Lỗi khi lưu danh mục: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/categories?action=" + (idStr != null ? "edit&id=" + idStr : "add"));
        }
    }

    private void deleteCategory(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        HttpSession session = request.getSession();
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Category category = categoryDAO.getCategoryById(id);
            
            if (category == null) {
                session.setAttribute("error", "Danh mục không tồn tại!");
                response.sendRedirect(request.getContextPath() + "/admin/categories");
                return;
            }
            
            // Kiểm tra nếu danh mục có sản phẩm
            int productCount = categoryDAO.countProducts(id);
            if (productCount > 0) {
                session.setAttribute("error", "Không thể xóa danh mục '" + category.getCategoryName() + "' vì có " + productCount + " sản phẩm đang sử dụng.");
                response.sendRedirect(request.getContextPath() + "/admin/categories");
                return;
            }
            
            // Kiểm tra nếu danh mục có danh mục con
            int childCategoryCount = categoryDAO.countChildCategories(id);
            if (childCategoryCount > 0) {
                session.setAttribute("error", "Không thể xóa danh mục '" + category.getCategoryName() + "' vì có " + childCategoryCount + " danh mục con.");
                response.sendRedirect(request.getContextPath() + "/admin/categories");
                return;
            }
            
            // Thực hiện xoá
            boolean isDeleted = categoryDAO.deleteCategory(id);
            
            if (isDeleted) {
                session.setAttribute("message", "Xóa danh mục '" + category.getCategoryName() + "' thành công!");
            } else {
                session.setAttribute("error", "Xóa danh mục thất bại!");
            }
            
        } catch (NumberFormatException e) {
            session.setAttribute("error", "ID danh mục không hợp lệ");
        } catch (SQLException e) {
            // Xử lý lỗi constraint
            if (e.getMessage().contains("foreign key constraint")) {
                session.setAttribute("error", "Không thể xóa danh mục vì có dữ liệu liên quan trong hệ thống.");
            } else {
                session.setAttribute("error", "Lỗi khi xóa danh mục: " + e.getMessage());
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/categories");
    }
}