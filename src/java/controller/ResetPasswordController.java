package controller;

import DAO.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import models.User;

@WebServlet("/reset-password")
public class ResetPasswordController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String token = request.getParameter("token");
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirm_password");

        if (token == null || token.isBlank()) {
            request.setAttribute("error", "Thiếu token.");
            request.getRequestDispatcher("/reset-password.jsp?token=").forward(request, response);
            return;
        }
        if (password == null || !password.equals(confirm)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp.");
            request.getRequestDispatcher("/reset-password.jsp?token=" + token).forward(request, response);
            return;
        }

        try {
            User user = userDAO.findUserByResetToken(token);
            if (user != null) {
                userDAO.updateUserPassword(user.getId(), password);
                response.sendRedirect(request.getContextPath() + "/login.jsp?success=reset");
            } else {
                request.setAttribute("error", "Token không hợp lệ hoặc đã hết hạn.");
                request.getRequestDispatcher("/reset-password.jsp?token=" + token).forward(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}