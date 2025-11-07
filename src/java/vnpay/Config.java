package vnpay;

import jakarta.servlet.http.HttpServletRequest;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.nio.charset.StandardCharsets;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.util.*;

public class Config {

    // === CẤU HÌNH SANDBOX (đổi theo merchant của bạn) ===
    public static String vnp_PayUrl   = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
    public static String vnp_ReturnUrl= "http://localhost:8080/Pharmative/vnpay_return.jsp"; 
    public static String vnp_TmnCode  = "8S14KTHI";   
    public static String secretKey    = "P157NR8XKX5ZVIJNJVCX8ITJ98LCTZNT".trim();

    // === UTIL ===
    public static String getRandomNumber(int len) {
        String chars = "0123456789";
        StringBuilder sb = new StringBuilder(len);
        Random rnd = new Random();
        for (int i = 0; i < len; i++) sb.append(chars.charAt(rnd.nextInt(chars.length())));
        return sb.toString();
    }

    public static String getIpAddress(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.isEmpty()) ip = request.getHeader("X-Real-IP");
        if (ip == null || ip.isEmpty()) ip = request.getRemoteAddr();
        if ("0:0:0:0:0:0:0:1".equals(ip)) {
            try { ip = InetAddress.getLocalHost().getHostAddress(); }
            catch (UnknownHostException ignored) {}
        }
        return ip;
    }

    public static String hmacSHA512(String key, String data) {
        try {
            Mac hmac512 = Mac.getInstance("HmacSHA512");
            SecretKeySpec sk = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA512");
            hmac512.init(sk);
            byte[] result = hmac512.doFinal(data.getBytes(StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder(2 * result.length);
            for (byte b : result) sb.append(String.format("%02x", b & 0xff));
            return sb.toString();
        } catch (Exception ex) {
            throw new RuntimeException("Error while calculating HMAC SHA512", ex);
        }
    }

    /** Ghép "key=value" (không encode) theo alpha, nối '&' — giữ để tương thích cũ */
    public static String hashAllFields(Map<String, String> fields) {
        List<String> names = new ArrayList<>(fields.keySet());
        Collections.sort(names);
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < names.size(); i++) {
            String k = names.get(i);
            String v = fields.get(k);
            sb.append(k).append("=").append(v);
            if (i < names.size() - 1) sb.append("&");
        }
        return hmacSHA512(secretKey, sb.toString());
    }
}
