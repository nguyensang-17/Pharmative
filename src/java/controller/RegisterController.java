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

@WebServlet("/register")
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String fullname = request.getParameter("fullname");
        String email    = request.getParameter("email");
        String phone    = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirm  = request.getParameter("confirm_password");

        if (fullname == null || email == null || password == null || confirm == null
                || fullname.isBlank() || email.isBlank() || password.isBlank()) {
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin bắt buộc.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        if (!password.equals(confirm)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        try {
            if (userDAO.findUserByEmail(email) != null) {
                request.setAttribute("error", "Email này đã được sử dụng để đăng ký.");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
                return;
            }

            User user = new User();
            user.setFullname(fullname);
            user.setEmail(email);
            user.setPhoneNumber(phone);
            user.setPassword(password);
            user.setRole("customer");
            user.setVerified(false);

            String verificationCode = CodeGenerator.generateVerificationCode();
            user.setVerificationCode(verificationCode);

            userDAO.createUser(user);
            EmailUtil.sendVerificationEmail(email, verificationCode);

            HttpSession session = request.getSession();
            session.setAttribute("email_for_verification", email);
            response.sendRedirect(request.getContextPath() + "/verify.jsp");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}