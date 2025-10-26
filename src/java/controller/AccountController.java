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
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        // Lấy lịch sử đơn hàng của người dùng
        List<Order> orderHistory = orderDAO.getById(user.getId());
        request.setAttribute("orderHistory", orderHistory);
        request.getRequestDispatcher("/customer/account.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User currentUser = (User) session.getAttribute("user");
        
        // Cập nhật thông tin người dùng
        currentUser.setFullname(request.getParameter("fullname"));
        currentUser.setPhoneNumber(request.getParameter("phone_number"));
        currentUser.setAddress(request.getParameter("address"));
        
        try {
            boolean success = userDAO.updateUser(currentUser);
            if(success) {
                // Cập nhật lại thông tin trong session
                session.setAttribute("user", currentUser);
                request.setAttribute("successMessage", "Cập nhật thông tin thành công!");
            } else {
                request.setAttribute("errorMessage", "Cập nhật thông tin thất bại.");
            }
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Lỗi cơ sở dữ liệu khi cập nhật.");
            e.printStackTrace();
        }

        // Tải lại lịch sử đơn hàng và chuyển tiếp lại trang account
        doGet(request, response);
    }
}