package controller;

import DAO.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import models.User;

@WebServlet("/login")
public class LoginController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
              throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            User user = userDAO.checkLogin(email, password);

            if (user != null) {
                // Kiểm tra xác thực email
                if (!user.isVerified()) {
                    request.setAttribute("error", "Tài khoản chưa xác thực email. Vui lòng kiểm tra hộp thư.");
                    request.getRequestDispatcher("/login.jsp").forward(request, response);
                    return;
                }

                // ✅ Lưu thông tin vào session
                HttpSession session = request.getSession();
                session.setAttribute("currentUser", user);
                session.setAttribute("userId", user.getId());
                session.setAttribute("userEmail", user.getEmail());
                session.setAttribute("userRole", user.getRole()); // ✅ THÊM DÒNG NÀY
                session.setAttribute("userName", user.getFullname()); // Optional: tên hiển thị

                // ✅ DEBUG: In ra console để kiểm tra
                System.out.println("=== LOGIN SUCCESS ===");
                System.out.println("User ID: " + user.getId());
                System.out.println("User Email: " + user.getEmail());
                System.out.println("User Role: " + user.getRole());
                System.out.println("Session ID: " + session.getId());

                // ✅ REDIRECT THEO ROLE
                if ("admin".equalsIgnoreCase(user.getRole())) {
                    System.out.println("Redirecting admin to: /admin/dashboard");
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                } else {
                    System.out.println("Redirecting customer to: /home.jsp");
                    response.sendRedirect(request.getContextPath() + "/home.jsp");
                }

            } else {
                request.setAttribute("error", "Email hoặc mật khẩu không chính xác.");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi cơ sở dữ liệu. Vui lòng thử lại sau.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
