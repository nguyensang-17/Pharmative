package util;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.math.BigDecimal;
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;
import java.util.Properties;

public class EmailUtil {

    private static final String FROM_EMAIL = "nvs17062004@gmail.com";
    private static final String APP_PASSWORD = "keehhdlymqenjfmh";

    // --- Tùy chọn: dùng TLS: true (587) hoặc SSL: true (465)
    private static final boolean USE_TLS = true;
    private static final boolean USE_SSL = false;

    public void sendNewsletterWelcome(String toEmail) {
        String subject = "[Pharmative] Đăng ký nhận khuyến mãi thành công";
        String html = """
        <div style="font-family:Arial, sans-serif; line-height:1.6">
          <h2 style="margin:0 0 12px">Chào mừng bạn đến với Pharmative!</h2>
          <p>Cảm ơn bạn đã đăng ký nhận thông tin khuyến mãi từ <strong>Pharmative</strong>.</p>
          <ul>
            <li>🎁 Mã <strong>WELCOME10</strong>: Giảm 10%% cho đơn đầu tiên.</li>
            <li>🚚 Miễn phí vận chuyển cho đơn từ <strong>499.000đ</strong>.</li>
            <li>🕒 Áp dụng đến hết <strong>tháng này</strong>.</li>
          </ul>
          <p>Hãy theo dõi email để không bỏ lỡ các ưu đãi mới!</p>
          <hr style="border:none;border-top:1px solid #ddd;margin:16px 0"/>
          <p style="margin:0 0 8px"><strong>Hỗ trợ khách hàng</strong></p>
          <p style="margin:0">Hotline: 1900 1234 (8:00–22:00, T2–CN)<br/>Email: support@pharmative.com</p>
          <p style="margin-top:16px">Trân trọng,<br/>Đội ngũ Pharmative</p>
        </div>
        """;
        sendHtml(toEmail, subject, html);
    }

    public void sendPromotionalEmail(String toEmail, String fullName, String subject, String userMessage) {
        String safeName = (fullName == null || fullName.isBlank()) ? "bạn" : fullName.trim();

        String html = """
        <div style="font-family:Arial, sans-serif; line-height:1.6">
          <h2 style="margin:0 0 12px">Pharmative – Ưu đãi & Chăm sóc khách hàng</h2>
          <p>Xin chào %s,</p>
          <p>Cảm ơn bạn đã liên hệ với <strong>Pharmative</strong>. Dưới đây là thông tin ưu đãi hiện có:</p>
          <ul>
            <li>🎁 Mã <strong>WELCOME10</strong>: Giảm 10%% cho đơn hàng đầu tiên.</li>
            <li>🚚 Miễn phí vận chuyển cho đơn từ <strong>499.000đ</strong>.</li>
            <li>🕒 Chương trình áp dụng đến hết <strong>tháng này</strong>.</li>
          </ul>

          %s

          <hr style="border:none;border-top:1px solid #ddd;margin:16px 0"/>
          <p style="margin:0 0 8px"><strong>Hỗ trợ khách hàng</strong></p>
          <p style="margin:0">Hotline: 1900 1234 (8:00–21:00, T2–CN)<br/>
             Email: support@pharmative.example</p>
          <p style="margin-top:16px">Trân trọng,<br/>Đội ngũ Pharmative</p>
        </div>
        """.formatted(
                  safeName,
                  (userMessage != null && !userMessage.isBlank())
                  ? "<p><strong>Nội dung bạn gửi:</strong><br/>" + userMessage.replaceAll("\n", "<br/>") + "</p>"
                  : ""
        );

        sendHtml(toEmail, (subject == null || subject.isBlank()) ? "[Pharmative] Ưu đãi & CSKH" : subject.trim(), html);
    }

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

    public static void sendCODOrderConfirmationEmail(String toEmail,
              String customerName,
              int orderId,
              List<OrderLine> items,
              BigDecimal totalAmount,
              String shippingAddress) {
        if (toEmail == null || toEmail.isBlank()) {
            throw new IllegalArgumentException("Email người nhận không được để trống");
        }

        String safeName = (customerName == null || customerName.isBlank()) ? "bạn" : customerName.trim();
        NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));

        StringBuilder itemsTable = new StringBuilder();
        itemsTable.append("<table style=\"width:100%;border-collapse:collapse;margin-top:16px\">");
        itemsTable.append("<thead><tr>")
                  .append("<th align=\"left\" style=\"padding:8px;border-bottom:1px solid #e5e5e5\">Sản phẩm</th>")
                  .append("<th align=\"center\" style=\"padding:8px;border-bottom:1px solid #e5e5e5\">SL</th>")
                  .append("<th align=\"right\" style=\"padding:8px;border-bottom:1px solid #e5e5e5\">Đơn giá</th>")
                  .append("<th align=\"right\" style=\"padding:8px;border-bottom:1px solid #e5e5e5\">Thành tiền</th>")
                  .append("</tr></thead><tbody>");

        for (OrderLine item : items) {
            String unitPrice = currencyFormat.format(item.unitPrice());
            String lineTotal = currencyFormat.format(item.lineTotal());
            itemsTable.append("<tr>")
                      .append("<td style=\"padding:8px;border-bottom:1px solid #f5f5f5\">")
                      .append(item.productName()).append("</td>")
                      .append("<td align=\"center\" style=\"padding:8px;border-bottom:1px solid #f5f5f5\">")
                      .append(item.quantity()).append("</td>")
                      .append("<td align=\"right\" style=\"padding:8px;border-bottom:1px solid #f5f5f5\">")
                      .append(unitPrice).append("</td>")
                      .append("<td align=\"right\" style=\"padding:8px;border-bottom:1px solid #f5f5f5\">")
                      .append(lineTotal).append("</td>")
                      .append("</tr>");
        }

        itemsTable.append("</tbody></table>");

        String subject = "[Pharmative] Xác nhận đơn hàng COD #" + orderId;

        StringBuilder body = new StringBuilder();
        body.append("<div style=\"font-family:Arial,sans-serif;line-height:1.6;color:#333\">")
                  .append("<h2 style=\"margin:0 0 12px\">Xin chào ").append(safeName).append(",</h2>")
                  .append("<p>Cảm ơn bạn đã mua sắm tại <strong>Pharmative</strong>. Đơn hàng COD của bạn đã được xác nhận.</p>")
                  .append("<p><strong>Mã đơn hàng:</strong> #").append(orderId).append("</p>")
                  .append("<p><strong>Phương thức thanh toán:</strong> Thanh toán khi nhận hàng (COD)</p>");

        if (shippingAddress != null && !shippingAddress.isBlank()) {
            body.append("<p><strong>Địa chỉ giao hàng:</strong><br/>")
                      .append(shippingAddress.replaceAll("\n", "<br/>")).append("</p>");
        }

        body.append(itemsTable);

        body.append("<p style=\"text-align:right;font-size:16px;margin-top:12px\"><strong>Tổng thanh toán: ")
                  .append(currencyFormat.format(totalAmount != null ? totalAmount : BigDecimal.ZERO))
                  .append("</strong></p>");

        body.append("<div style=\"background:#f8f9fa;padding:15px;border-radius:8px;margin:20px 0;\">")
                  .append("<h4 style=\"margin-top:0;color:#d35400;\">📦 Thông tin giao hàng COD</h4>")
                  .append("<p>• Vui lòng chuẩn bị số tiền <strong>")
                  .append(currencyFormat.format(totalAmount))
                  .append("</strong> để thanh toán khi nhận hàng</p>")
                  .append("<p>• Nhân viên giao hàng sẽ liên hệ với bạn trước khi giao</p>")
                  .append("<p>• Thời gian giao hàng dự kiến: 2-3 ngày làm việc</p>")
                  .append("</div>");

        body.append("<p>Chúng tôi sẽ liên hệ và giao hàng trong thời gian sớm nhất. Bạn có thể xem lại đơn hàng trong mục <em>Tài khoản &gt; Lịch sử đơn hàng</em>.</p>")
                  .append("<p>Nếu cần hỗ trợ, hãy liên hệ với chúng tôi qua hotline 1900 1234 hoặc email support@pharmative.com.</p>")
                  .append("<p style=\"margin-top:16px\">Trân trọng,<br/>Đội ngũ Pharmative</p>")
                  .append("</div>");

        sendHtml(toEmail, subject, body.toString());
    }

    public static void sendOrderConfirmationEmail(String toEmail,
              String customerName,
              int orderId,
              List<OrderLine> items,
              BigDecimal totalAmount,
              String shippingAddress) {
        if (toEmail == null || toEmail.isBlank()) {
            throw new IllegalArgumentException("Email người nhận không được để trống");
        }

        String safeName = (customerName == null || customerName.isBlank()) ? "bạn" : customerName.trim();
        NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));

        StringBuilder itemsTable = new StringBuilder();
        itemsTable.append("<table style=\"width:100%;border-collapse:collapse;margin-top:16px\">");
        itemsTable.append("<thead><tr>")
                  .append("<th align=\"left\" style=\"padding:8px;border-bottom:1px solid #e5e5e5\">Sản phẩm</th>")
                  .append("<th align=\"center\" style=\"padding:8px;border-bottom:1px solid #e5e5e5\">SL</th>")
                  .append("<th align=\"right\" style=\"padding:8px;border-bottom:1px solid #e5e5e5\">Đơn giá</th>")
                  .append("<th align=\"right\" style=\"padding:8px;border-bottom:1px solid #e5e5e5\">Thành tiền</th>")
                  .append("</tr></thead><tbody>");

        for (OrderLine item : items) {
            String unitPrice = currencyFormat.format(item.unitPrice());
            String lineTotal = currencyFormat.format(item.lineTotal());
            itemsTable.append("<tr>")
                      .append("<td style=\"padding:8px;border-bottom:1px solid #f5f5f5\">")
                      .append(item.productName()).append("</td>")
                      .append("<td align=\"center\" style=\"padding:8px;border-bottom:1px solid #f5f5f5\">")
                      .append(item.quantity()).append("</td>")
                      .append("<td align=\"right\" style=\"padding:8px;border-bottom:1px solid #f5f5f5\">")
                      .append(unitPrice).append("</td>")
                      .append("<td align=\"right\" style=\"padding:8px;border-bottom:1px solid #f5f5f5\">")
                      .append(lineTotal).append("</td>")
                      .append("</tr>");
        }

        itemsTable.append("</tbody></table>");

        String subjectPrefix = (orderId > 0) ? "#" + orderId + " " : "";
        String subject = "[Pharmative] Xác nhận đơn hàng " + subjectPrefix + "thành công";

        StringBuilder body = new StringBuilder();
        body.append("<div style=\"font-family:Arial,sans-serif;line-height:1.6;color:#333\">")
                  .append("<h2 style=\"margin:0 0 12px\">Xin chào ").append(safeName).append(",</h2>")
                  .append("<p>Cảm ơn bạn đã mua sắm tại <strong>Pharmative</strong>. Đơn hàng của bạn đã được ghi nhận thành công.</p>");

        if (orderId > 0) {
            body.append("<p><strong>Mã đơn hàng:</strong> #").append(orderId).append("</p>");
        }

        if (shippingAddress != null && !shippingAddress.isBlank()) {
            body.append("<p><strong>Địa chỉ giao hàng:</strong><br/>")
                      .append(shippingAddress.replaceAll("\n", "<br/>")).append("</p>");
        }

        body.append(itemsTable);

        body.append("<p style=\"text-align:right;font-size:16px;margin-top:12px\"><strong>Tổng thanh toán: ")
                  .append(currencyFormat.format(totalAmount != null ? totalAmount : BigDecimal.ZERO))
                  .append("</strong></p>");

        body.append("<p>Chúng tôi sẽ liên hệ và giao hàng trong thời gian sớm nhất. Bạn có thể xem lại đơn hàng trong mục <em>Tài khoản &gt; Lịch sử đơn hàng</em>.</p>")
                  .append("<p>Nếu cần hỗ trợ, hãy liên hệ với chúng tôi qua hotline 1900 1234 hoặc email support@pharmative.com.</p>")
                  .append("<p style=\"margin-top:16px\">Trân trọng,<br/>Đội ngũ Pharmative</p>")
                  .append("</div>");

        sendHtml(toEmail, subject, body.toString());
    }

    public static class OrderLine {

        private final String productName;
        private final int quantity;
        private final BigDecimal unitPrice;
        private final BigDecimal lineTotal;

        public OrderLine(String productName, int quantity, BigDecimal unitPrice, BigDecimal lineTotal) {
            this.productName = (productName == null) ? "Sản phẩm" : productName;
            this.quantity = quantity;
            BigDecimal safeUnitPrice = (unitPrice == null) ? BigDecimal.ZERO : unitPrice;
            this.unitPrice = safeUnitPrice;
            this.lineTotal = (lineTotal == null) ? safeUnitPrice.multiply(BigDecimal.valueOf(quantity)) : lineTotal;
        }

        public String productName() {
            return productName;
        }

        public int quantity() {
            return quantity;
        }

        public BigDecimal unitPrice() {
            return unitPrice;
        }

        public BigDecimal lineTotal() {
            return lineTotal;
        }
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
