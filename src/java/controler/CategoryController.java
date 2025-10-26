package controller;

import DAO.CategoryDAO;
import models.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet(name = "CategoryController", urlPatterns = {"/viewCategory"})
public class CategoryController extends HttpServlet {
    private final CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            Map<Category, List<Category>> tree = categoryDAO.getTree2Levels();
            req.setAttribute("tree", tree);
            req.getRequestDispatcher("viewCategory.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException("Không thể tải danh mục sản phẩm", e);
        }
    }
}
