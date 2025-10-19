package controller;

import DAO.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import models.User;
import util.CodeGenerator;
import util.EmailUtil;

@WebServlet("/forgot-password")
public class ForgotPasswordController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        try {
            User user = userDAO.findUserByEmail(email);
            if (user != null) {
                String token = CodeGenerator.generateResetToken();
                userDAO.createPasswordResetToken(email, token);
                String serverUrl = request.getScheme() + "://" + request.getServerName()
                        + ((request.getServerPort() == 80 || request.getServerPort() == 443) ? "" : (":" + request.getServerPort()))
                        + request.getContextPath();
                EmailUtil.sendPasswordResetEmail(email, token, serverUrl);
            }
            // Luôn hiển thị thông báo chung để bảo mật
            request.setAttribute("message", "Nếu email tồn tại, liên kết đặt lại mật khẩu đã được gửi.");
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}