package util;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.util.Properties;

public class EmailUtil {

    private static final String FROM_EMAIL = "nvs17062004@gmail.com";
    private static final String APP_PASSWORD = "keehhdlymqenjfmh";

    // --- Tùy chọn: dùng TLS: true (587) hoặc SSL: true (465)
    private static final boolean USE_TLS = true;
    private static final boolean USE_SSL = false;

    public static void sendNewPasswordEmail(String toEmail, String newPassword) {
        String subject = "Pharmative - Mật khẩu mới của bạn";
        String body = "<h2>Mật khẩu mới đã được tạo</h2>"
                  + "<p>Mật khẩu đăng nhập mới của bạn là: "
                  + "<strong style=\"font-size:16px;\">" + newPassword + "</strong></p>"
                  + "<p>Vì lý do an toàn, hãy đăng nhập và <b>đổi mật khẩu</b> ngay trong phần Tài khoản.</p>"
                  + "<p>Nếu bạn không yêu cầu, hãy bỏ qua email này và liên hệ hỗ trợ.</p>";
        sendHtml(toEmail, subject, body);
    }

    public static void sendVerificationEmail(String toEmail, String code) {
        String subject = "Pharmative - Mã xác thực tài khoản";
        String body = "<h1>Chào mừng đến Pharmative!</h1>"
                  + "<p>Mã xác thực của bạn: <strong>" + code + "</strong></p>"
                  + "<p>Mã có hiệu lực trong thời gian ngắn. Nếu không phải bạn đăng ký, vui lòng bỏ qua email này.</p>";
        sendHtml(toEmail, subject, body);
    }

    public static void sendPasswordResetEmail(String toEmail, String token, String serverUrl) {
        String resetUrl = serverUrl + "/reset-password.jsp?token=" + token;
        String subject = "Pharmative - Đặt lại mật khẩu";
        String body = "<h2>Yêu cầu đặt lại mật khẩu</h2>"
                  + "<p>Nhấn vào liên kết sau để đặt lại mật khẩu của bạn:</p>"
                  + "<p><a href=\"" + resetUrl + "\">" + resetUrl + "</a></p>"
                  + "<p>Nếu bạn không yêu cầu thao tác này, hãy bỏ qua email.</p>";
        sendHtml(toEmail, subject, body);
    }

    private static void sendHtml(String toEmail, String subject, String html) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.starttls.required", "true");  // bắt buộc TLS
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

// Ép version TLS vì Google đã tắt TLS 1.0/1.1
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");   // hoặc "TLSv1.3,TLSv1.2"

// Timeout để tránh treo/ngắt bất chợt
        props.put("mail.smtp.connectiontimeout", "15000");
        props.put("mail.smtp.timeout", "15000");
        props.put("mail.smtp.writetimeout", "15000");

// Một số môi trường cần khai báo rõ cơ chế
        props.put("mail.smtp.auth.mechanisms", "LOGIN PLAIN");

        if (USE_TLS) {
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.auth.mechanisms", "LOGIN PLAIN");
        } else if (USE_SSL) {
            props.put("mail.smtp.port", "465");
            props.put("mail.smtp.ssl.enable", "true");
            // Không bật starttls khi dùng SSL port 465
        } else {
            // fallback – nhưng Gmail đòi TLS/SSL nên không khuyến nghị
            props.put("mail.smtp.port", "25");
        }

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
            }
        });

        // Bật debug khi cần xem log SMTP trong server.log của GlassFish
        session.setDebug(true);

        try {
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(FROM_EMAIL));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail, false));
            msg.setSubject(subject);
            msg.setContent(html, "text/html; charset=UTF-8");
            Transport.send(msg);
        } catch (MessagingException e) {
            // Log đầy đủ nguyên nhân thật thay vì nuốt lỗi chung chung
            e.printStackTrace();
            throw new RuntimeException("Failed to send email: " + e.getMessage(), e);
        }
    }
}
