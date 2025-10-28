package controller;

import DAO.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.security.SecureRandom;
import java.sql.SQLException;
import models.User;
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
                // 1) Tạo mật khẩu ngẫu nhiên mới
                String newPassword = generateTempPassword(10); // ví dụ 10 ký tự

                // 2) Cập nhật vào DB (đã băm bằng BCrypt trong UserDAO.updateUserPassword)
                userDAO.updateUserPassword(user.getId(), newPassword);

                // 3) Gửi email thông báo mật khẩu mới
                try {
                    EmailUtil.sendNewPasswordEmail(email, newPassword);
                } catch (RuntimeException mailErr) {
                    // Không làm hỏng flow; vẫn báo thành công nhưng gợi ý kiểm tra lại email
                    mailErr.printStackTrace();
                }
            }

            // 4) Vì lý do bảo mật, luôn trả về thông báo chung
            request.setAttribute("message", "Nếu email tồn tại, mật khẩu mới đã được gửi đến hộp thư của bạn.");
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    // Tạo mật khẩu ngẫu nhiên: chữ hoa + chữ thường + số
    private String generateTempPassword(int length) {
        final String UPPER = "ABCDEFGHJKLMNPQRSTUVWXYZ";
        final String LOWER = "abcdefghijkmnopqrstuvwxyz";
        final String DIGIT = "23456789";
        final String ALL = UPPER + LOWER + DIGIT;

        SecureRandom rnd = new SecureRandom();
        StringBuilder sb = new StringBuilder(length);

        // Đảm bảo có đủ loại
        sb.append(UPPER.charAt(rnd.nextInt(UPPER.length())));
        sb.append(LOWER.charAt(rnd.nextInt(LOWER.length())));
        sb.append(DIGIT.charAt(rnd.nextInt(DIGIT.length())));

        for (int i = sb.length(); i < length; i++) {
            sb.append(ALL.charAt(rnd.nextInt(ALL.length())));
        }
        // Xáo lại
        char[] arr = sb.toString().toCharArray();
        for (int i = 0; i < arr.length; i++) {
            int j = rnd.nextInt(arr.length);
            char t = arr[i]; arr[i] = arr[j]; arr[j] = t;
        }
        return new String(arr);
    }
}