package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.EmailUtil;

@WebServlet(name = "ContactController", urlPatterns = {"/contact/send"})
public class ContactController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String first = req.getParameter("c_fname");
        String last  = req.getParameter("c_lname");
        String email = req.getParameter("c_email");
        String subject = req.getParameter("c_subject");
        String message = req.getParameter("c_message");

        String fullName = (first == null ? "" : first.trim()) + " " + (last == null ? "" : last.trim());
        fullName = fullName.trim();

        try {
            // Gửi email khuyến mãi + CSKH
            new EmailUtil().sendPromotionalEmail(email, fullName, subject, message);

            // báo thành công bằng query param
            resp.sendRedirect(req.getContextPath() + "/contact.jsp?sent=1");
        } catch (Exception e) {
            // log và báo lỗi
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/contact.jsp?sent=0");
        }
    }
}
