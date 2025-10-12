package controler;

import DAO.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import models.User;

@WebServlet("/register")
public class RegisterController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = new User();
        user.setFullname(request.getParameter("fullname"));
        user.setEmail(request.getParameter("email"));
        user.setPhoneNumber(request.getParameter("phone"));
        user.setAddress(request.getParameter("address"));
        user.setPassword(request.getParameter("password"));
        String confirmPassword = request.getParameter("confirm_password");

        // Validate
        if (!user.getPassword().equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        try {
            // Kiểm tra email đã tồn tại chưa
            if (userDAO.findUserByEmail(user.getEmail()) != null) {
                request.setAttribute("error", "Email đã được sử dụng.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }
            
            // Tạo user
            userDAO.createUser(user);
            response.sendRedirect(request.getContextPath() + "/login.jsp?success=true");

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi đăng ký. Vui lòng thử lại.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}