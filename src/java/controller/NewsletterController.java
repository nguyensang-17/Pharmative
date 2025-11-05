package controller;

import java.io.IOException;
import java.util.regex.Pattern;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import util.EmailUtil;

@WebServlet(name = "NewsletterController", urlPatterns = {"/newsletter/subscribe"})
public class NewsletterController extends HttpServlet {
    private static final Pattern EMAIL_RX = Pattern.compile("^[\\w.!#$%&’*+/=?`{|}~^-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String email = req.getParameter("email");
        String ret   = req.getParameter("return");
        String referer = req.getHeader("Referer");

        String back = (ret != null && !ret.isBlank()) ? ret
                     : (referer != null ? referer : req.getContextPath() + "/home");
        String join = back.contains("?") ? "&" : "?";

        if (email == null || !EMAIL_RX.matcher(email.trim()).matches()) {
            resp.sendRedirect(back + join + "subscribed=0");
            return;
        }

        try {
            // TODO (tùy chọn): lưu DB bảng newsletter_subscribers(email, created_at, status)
            new EmailUtil().sendNewsletterWelcome(email.trim());
            resp.sendRedirect(back + join + "subscribed=1");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(back + join + "subscribed=0");
        }
    }
}
