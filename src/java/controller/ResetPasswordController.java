package controller;

import DAO.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import models.User;
import org.mindrot.jbcrypt.BCrypt; // nếu PasswordUtil đã lo thì có thể bỏ

@WebServlet("/reset-password")
public class ResetPasswordController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy token từ query ?token=...
        String token = request.getParameter("token");
        if (token == null || token.isBlank()) {
            request.setAttribute("error", "Thiếu token đặt lại mật khẩu.");
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
            return;
        }

        try {
            // findUserByResetToken đã kiểm tra hạn với NOW() trong SQL
            User u = userDAO.findUserByResetToken(token);
            if (u == null) {
                request.setAttribute("error", "Token không hợp lệ hoặc đã hết hạn.");
                request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
                return;
            }

            // Hợp lệ → mở form đặt lại (form của bạn đã có <input hidden name="token" value="${param.token}">)
            request.setAttribute("token", token);
            request.getRequestDispatcher("/reset-password.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String token    = request.getParameter("token");
        String password = request.getParameter("password");
        String confirm  = request.getParameter("confirm_password");

        if (token == null || token.isBlank()) {
            request.setAttribute("error", "Thiếu token đặt lại mật khẩu.");
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
            return;
        }

        if (password == null || confirm == null || password.isBlank() || !password.equals(confirm)) {
            request.setAttribute("error", "Mật khẩu không hợp lệ hoặc không khớp.");
            request.setAttribute("token", token); // để form giữ lại token
            request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
            return;
        }

        try {
            // Kiểm tra token/hạn (hàm này đã require reset_token_expiry > NOW())
            User u = userDAO.findUserByResetToken(token);
            if (u == null) {
                request.setAttribute("error", "Token không hợp lệ hoặc đã hết hạn.");
                request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
                return;
            }

            // Cập nhật mật khẩu mới (DAO của bạn đã tự hash và xoá token)
            userDAO.updateUserPassword(u.getId(), password);

            request.setAttribute("msg", "Đặt lại mật khẩu thành công. Vui lòng đăng nhập.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
