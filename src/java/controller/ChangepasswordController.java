package controller;

import DAO.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import models.User;
import util.PasswordUtil;

@WebServlet("change-password")
public class ChangepasswordController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User current = (session == null) ? null : (User) session.getAttribute("currentUser");

        if (current == null) {
            // nhớ trang để quay lại sau khi đăng nhập
            session = request.getSession(true);
            session.setAttribute("redirectAfterLogin", request.getRequestURI());
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        request.getRequestDispatcher("/change-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        User current = (session == null) ? null : (User) session.getAttribute("currentUser");

        if (current == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String oldPw = request.getParameter("oldPassword");
        String newPw = request.getParameter("newPassword");
        String cfPw  = request.getParameter("confirmPassword");

        // validate cơ bản
        if (oldPw == null || newPw == null || cfPw == null
                || oldPw.isBlank() || newPw.isBlank() || cfPw.isBlank()
                || !newPw.equals(cfPw)) {
            request.setAttribute("error", "Mật khẩu mới không hợp lệ hoặc không khớp.");
            request.getRequestDispatcher("/change-password.jsp").forward(request, response);
            return;
        }

        try {
            // lấy hash mới nhất từ DB để so khớp
            User fresh = userDAO.getUserById(current.getId());
            if (fresh == null) {
                request.setAttribute("error", "Không tìm thấy người dùng.");
                request.getRequestDispatcher("/change-password.jsp").forward(request, response);
                return;
            }

            // kiểm tra mật khẩu hiện tại
            boolean ok = PasswordUtil.checkPassword(oldPw, fresh.getPassword());
            if (!ok) {
                request.setAttribute("error", "Mật khẩu hiện tại không đúng.");
                request.getRequestDispatcher("/change-password.jsp").forward(request, response);
                return;
            }

            // cập nhật mật khẩu mới (DAO của bạn đã BCrypt + clear token)
            userDAO.updateUserPassword(fresh.getId(), newPw);

            // cập nhật lại user trong session (optional)
            User refreshed = userDAO.getUserById(fresh.getId());
            session.setAttribute("currentUser", refreshed);

            request.setAttribute("msg", "Đổi mật khẩu thành công.");
            request.getRequestDispatcher("/views/account/change-password.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống. Vui lòng thử lại.");
            request.getRequestDispatcher("/change-password.jsp").forward(request, response);
        }
    }
}
