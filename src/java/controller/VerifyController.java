package controller;

import DAO.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import models.User;

@WebServlet("/verify")
public class VerifyController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        if (code == null || code.isBlank()) {
            request.setAttribute("error", "Vui lòng nhập mã xác thực.");
            request.getRequestDispatcher("/verify.jsp").forward(request, response);
            return;
        }

        try {
            User user = userDAO.findUserByVerificationCode(code);
            if (user != null) {
                userDAO.activateUser(user.getId());
                request.getSession().removeAttribute("email_for_verification");
                response.sendRedirect(request.getContextPath() + "/login.jsp?success=verified");
            } else {
                request.setAttribute("error", "Mã xác thực không hợp lệ.");
                request.getRequestDispatcher("/verify.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}