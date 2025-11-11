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
                    // CHỈ gọi delete từ GET khi có confirm trước đó
                    // Trong hầu hết trường hợp, nên dùng POST để xoá
                    response.sendRedirect(request.getContextPath() + "/admin/categories");
                    break;
                default:
                    listCategories(request, response);
                    break;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi truy vấn cơ sở dữ liệu: " + e.getMessage());
            try {
                listCategories(request, response);
            } catch (SQLException ex) {
                throw new ServletException("Lỗi nghiêm trọng khi tải danh sách", ex);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Lỗi xử lý yêu cầu", e);
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
            e.printStackTrace();
            HttpSession session = request.getSession();
            session.setAttribute("error", "Lỗi cơ sở dữ liệu: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/categories");
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Lỗi xử lý yêu cầu", e);
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
            try {
                int id = Integer.parseInt(idStr);
                Category category = categoryDAO.getCategoryById(id);
                if (category == null) {
                    request.setAttribute("error", "Danh mục không tồn tại");
                } else {
                    request.setAttribute("category", category);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "ID danh mục không hợp lệ");
            }
        }
        // Nếu không có id, đây là chế độ thêm mới
        request.getRequestDispatcher("/admin/categories/category-form.jsp").forward(request, response);
    }

    private void saveCategory(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        HttpSession session = request.getSession();
        
        String name = request.getParameter("name");
        String parentIdStr = request.getParameter("parentCategoryId");
        String idStr = request.getParameter("id");
        
        // Validation
        if (name == null || name.trim().isEmpty()) {
            session.setAttribute("error", "Tên danh mục không được để trống");
            response.sendRedirect(request.getContextPath() + "/admin/categories?action=" + (idStr != null ? "edit&id=" + idStr : "add"));
            return;
        }
        
        if (name.trim().length() < 2 || name.trim().length() > 100) {
            session.setAttribute("error", "Tên danh mục phải từ 2 đến 100 ký tự");
            response.sendRedirect(request.getContextPath() + "/admin/categories?action=" + (idStr != null ? "edit&id=" + idStr : "add"));
            return;
        }
        
        Category category = new Category();
        category.setCategoryName(name.trim());
        
        // Xử lý danh mục cha
        if (parentIdStr != null && !parentIdStr.isEmpty() && !parentIdStr.equals("0")) {
            try {
                int parentId = Integer.parseInt(parentIdStr);
                // Kiểm tra danh mục cha có tồn tại không
                Category parent = categoryDAO.getCategoryById(parentId);
                if (parent != null) {
                    category.setParentCategoryId(parentId);
                } else {
                    session.setAttribute("error", "Danh mục cha không tồn tại");
                    response.sendRedirect(request.getContextPath() + "/admin/categories?action=" + (idStr != null ? "edit&id=" + idStr : "add"));
                    return;
                }
            } catch (NumberFormatException e) {
                session.setAttribute("error", "ID danh mục cha không hợp lệ");
                response.sendRedirect(request.getContextPath() + "/admin/categories?action=" + (idStr != null ? "edit&id=" + idStr : "add"));
                return;
            }
        } else {
            category.setParentCategoryId(null);
        }

        try {
            boolean success;
            if (idStr == null || idStr.isEmpty()) {
                // Thêm mới
                success = categoryDAO.addCategory(category);
                if (success) {
                    session.setAttribute("message", "Thêm danh mục thành công!");
                } else {
                    session.setAttribute("error", "Thêm danh mục thất bại!");
                }
            } else {
                // Cập nhật
                try {
                    category.setCategoryId(Integer.parseInt(idStr));
                    success = categoryDAO.updateCategory(category);
                    if (success) {
                        session.setAttribute("message", "Cập nhật danh mục thành công!");
                    } else {
                        session.setAttribute("error", "Cập nhật danh mục thất bại! Danh mục không tồn tại.");
                    }
                } catch (NumberFormatException e) {
                    session.setAttribute("error", "ID danh mục không hợp lệ");
                    response.sendRedirect(request.getContextPath() + "/admin/categories?action=edit&id=" + idStr);
                    return;
                }
            }
            
            response.sendRedirect(request.getContextPath() + "/admin/categories");
            
        } catch (SQLException e) {
            e.printStackTrace();
            // Kiểm tra lỗi trùng lặp tên
            if (e.getMessage().toLowerCase().contains("duplicate") || e.getMessage().toLowerCase().contains("unique")) {
                session.setAttribute("error", "Tên danh mục đã tồn tại");
            } else {
                session.setAttribute("error", "Lỗi khi lưu danh mục: " + e.getMessage());
            }
            response.sendRedirect(request.getContextPath() + "/admin/categories?action=" + (idStr != null ? "edit&id=" + idStr : "add"));
        }
    }

    private void deleteCategory(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        HttpSession session = request.getSession();
        
        String idStr = request.getParameter("id");
        
        // Kiểm tra id có tồn tại và hợp lệ không
        if (idStr == null || idStr.trim().isEmpty()) {
            session.setAttribute("error", "ID danh mục không được để trống");
            response.sendRedirect(request.getContextPath() + "/admin/categories");
            return;
        }
        
        try {
            int id = Integer.parseInt(idStr);
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
                session.setAttribute("error", "Xóa danh mục thất bại! Danh mục không tồn tại hoặc đã bị xóa trước đó.");
            }
            
        } catch (NumberFormatException e) {
            session.setAttribute("error", "ID danh mục không hợp lệ: " + idStr);
        } catch (SQLException e) {
            e.printStackTrace();
            // Xử lý lỗi constraint
            String errorMessage = e.getMessage().toLowerCase();
            if (errorMessage.contains("foreign key constraint") || errorMessage.contains("constraint")) {
                session.setAttribute("error", "Không thể xóa danh mục vì có dữ liệu liên quan trong hệ thống.");
            } else {
                session.setAttribute("error", "Lỗi khi xóa danh mục: " + e.getMessage());
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/categories");
    }
}