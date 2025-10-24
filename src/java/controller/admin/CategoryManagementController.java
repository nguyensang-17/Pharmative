package controller.admin;

import DAO.CategoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

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
        try {
            saveCategory(request, response);
        } catch (SQLException e) {
            throw new ServletException("Lỗi khi lưu danh mục", e);
        }
    }

    private void listCategories(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        request.setAttribute("categoryList", categoryDAO.getAllCategories());
        request.getRequestDispatcher("/admin/manage_categories.jsp").forward(request, response);
    }

    private void showCategoryForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            // Chế độ sửa
            int id = Integer.parseInt(idStr);
            Category category = categoryDAO.getCategoryById(id);
            request.setAttribute("category", category);
        }
        // Nếu không có id, đây là chế độ thêm mới (không cần làm gì thêm)
        request.getRequestDispatcher("/admin/category_form.jsp").forward(request, response);
    }

    private void saveCategory(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        String name = request.getParameter("name");
        String idStr = request.getParameter("id");
        
        Category category = new Category();
        category.setName(name);

        if (idStr == null || idStr.isEmpty()) {
            // Thêm mới
            categoryDAO.addCategory(category);
        } else {
            // Cập nhật
            category.setId(Integer.parseInt(idStr));
            categoryDAO.updateCategory(category);
        }
        response.sendRedirect(request.getContextPath() + "/admin/categories");
    }

    private void deleteCategory(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        categoryDAO.deleteCategory(id);
        response.sendRedirect(request.getContextPath() + "/admin/categories?action=list&deleteSuccess=true");
    }
}