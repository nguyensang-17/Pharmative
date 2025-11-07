package controller;

import DAO.OrderDAO;
import DAO.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import models.Order;
import models.User;

@WebServlet("/account")
public class AccountController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final OrderDAO orderDAO = new OrderDAO();
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Yêu cầu đăng nhập để truy cập trang này
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("currentUser");

        // Lấy lịch sử đơn hàng của người dùng
        List<Order> orderHistory = orderDAO.getOrdersByUserId(user.getId());
        request.setAttribute("orderHistory", orderHistory);
        request.setAttribute("user", user);
        request.getRequestDispatcher("/account.jsp").forward(request, response);
    }
    

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null || action.isBlank()) {
            action = "updateProfile";
        }

        switch (action) {
            case "changePassword" -> handleChangePassword(request, response, session);
            case "updateProfile" -> handleUpdateProfile(request, response, session);
            default -> {
                request.setAttribute("errorMessage", "Hành động không hợp lệ.");
                doGet(request, response);
            }
        }
    }

    private void handleUpdateProfile(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        User currentUser = (User) session.getAttribute("currentUser");

        String fullname = request.getParameter("fullname");
        String phone = request.getParameter("phone_number");
        String address = request.getParameter("address");

        currentUser.setFullname(fullname != null ? fullname.trim() : null);
        currentUser.setPhoneNumber(phone != null ? phone.trim() : null);
        currentUser.setAddress(address != null ? address.trim() : null);

        try {
            boolean success = userDAO.updateUser(currentUser);
            if (success) {
                // Refresh thông tin user từ DB để đảm bảo dữ liệu nhất quán
                User freshUser = userDAO.getUserById(currentUser.getId());
                if (freshUser != null) {
                    session.setAttribute("currentUser", freshUser);
                }
                request.setAttribute("successMessage", "Cập nhật thông tin thành công!");
            } else {
                request.setAttribute("errorMessage", "Cập nhật thông tin thất bại.");
            }
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Lỗi cơ sở dữ liệu khi cập nhật.");
            e.printStackTrace();
        }

        doGet(request, response);
    }

    private void handleChangePassword(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        User currentUser = (User) session.getAttribute("currentUser");

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (currentPassword == null || newPassword == null || confirmPassword == null
                || currentPassword.isBlank() || newPassword.isBlank() || confirmPassword.isBlank()) {
            request.setAttribute("errorMessage", "Vui lòng nhập đầy đủ thông tin mật khẩu.");
            doGet(request, response);
            return;
        }

        if (!util.PasswordUtil.checkPassword(currentPassword, currentUser.getPassword())) {
            request.setAttribute("errorMessage", "Mật khẩu hiện tại không đúng.");
            doGet(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Mật khẩu mới và xác nhận không khớp.");
            doGet(request, response);
            return;
        }

        if (newPassword.length() < 6) {
            request.setAttribute("errorMessage", "Mật khẩu mới phải có ít nhất 6 ký tự.");
            doGet(request, response);
            return;
        }

        try {
            userDAO.updateUserPassword(currentUser.getId(), newPassword);
            User freshUser = userDAO.getUserById(currentUser.getId());
            if (freshUser != null) {
                session.setAttribute("currentUser", freshUser);
            }
            request.setAttribute("successMessage", "Đổi mật khẩu thành công!");
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Lỗi cơ sở dữ liệu khi đổi mật khẩu.");
            e.printStackTrace();
        }

        doGet(request, response);
    }
}