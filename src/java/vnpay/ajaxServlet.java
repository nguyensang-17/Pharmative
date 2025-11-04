package vnpay;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.*;

@WebServlet("/vnpay")
public class ajaxServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String vnp_Version = "2.1.0";
        String vnp_Command = "pay";
        String orderType   = "other";

        // ===== TỔNG TIỀN TỪ GIỎ HÀNG (VND) → vnp_Amount (VND × 100) =====
        BigDecimal cartTotalVnd = BigDecimal.ZERO;
        HttpSession session = req.getSession(false);
        if (session != null) {
            @SuppressWarnings("unchecked")
            Map<Integer, controller.CartController.CartItem> cart =
                (Map<Integer, controller.CartController.CartItem>) session.getAttribute("cart");
            if (cart != null) {
                for (controller.CartController.CartItem it : cart.values()) {
                    BigDecimal price = it.getProduct().getPrice();
                    if (price == null) price = BigDecimal.ZERO;
                    int qty = it.getQuantity();
                    cartTotalVnd = cartTotalVnd.add(price.multiply(BigDecimal.valueOf(qty)));
                }
            }
        }
        long vnpAmount;
        String amountParam = req.getParameter("amount"); // fallback khi giỏ rỗng
        if (cartTotalVnd.compareTo(BigDecimal.ZERO) > 0) {
            vnpAmount = cartTotalVnd.multiply(BigDecimal.valueOf(100L)).longValueExact();
        } else if (amountParam != null && !amountParam.isEmpty()) {
            amountParam = amountParam.replaceAll("[^0-9]", "");
            vnpAmount = new BigDecimal(amountParam).multiply(BigDecimal.valueOf(100L)).longValueExact();
        } else {
            vnpAmount = 10000L * 100L; // default 10.000 VND
        }

        String bankCode   = req.getParameter("bankCode"); // optional
        String locate     = req.getParameter("language"); // "vn"/"en"
        String vnp_TxnRef = Config.getRandomNumber(8);
        String vnp_IpAddr = Config.getIpAddress(req);
        String vnp_TmnCode= Config.vnp_TmnCode;

        Map<String,String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", vnp_Version);
        vnp_Params.put("vnp_Command", vnp_Command);
        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.put("vnp_Amount", String.valueOf(vnpAmount));
        vnp_Params.put("vnp_CurrCode", "VND");
        if (bankCode != null && !bankCode.isEmpty()) vnp_Params.put("vnp_BankCode", bankCode);
        vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
        vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang: " + vnp_TxnRef);
        vnp_Params.put("vnp_OrderType", orderType);
        vnp_Params.put("vnp_Locale", (locate != null && !locate.isEmpty()) ? locate : "vn");
        vnp_Params.put("vnp_ReturnUrl", Config.vnp_ReturnUrl);
        vnp_Params.put("vnp_IpAddr",    vnp_IpAddr);

        Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
        SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddHHmmss");
        vnp_Params.put("vnp_CreateDate", fmt.format(cld.getTime()));
        cld.add(Calendar.MINUTE, 15);
        vnp_Params.put("vnp_ExpireDate", fmt.format(cld.getTime()));

        // ===== SORT + BUILD query (URL-encode) + HMAC =====
        List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
        Collections.sort(fieldNames);

        StringBuilder hashData = new StringBuilder();
        StringBuilder query    = new StringBuilder();
        for (Iterator<String> itr = fieldNames.iterator(); itr.hasNext();) {
            String name  = itr.next();
            String value = vnp_Params.get(name);
            if (value != null && !value.isEmpty()) {
                hashData.append(name).append('=').append(URLEncoder.encode(value, StandardCharsets.US_ASCII));
                query.append(URLEncoder.encode(name,  StandardCharsets.US_ASCII))
                     .append('=')
                     .append(URLEncoder.encode(value, StandardCharsets.US_ASCII));
                if (itr.hasNext()) { hashData.append('&'); query.append('&'); }
            }
        }
        String vnp_SecureHash = Config.hmacSHA512(Config.secretKey, hashData.toString());
        query.append("&vnp_SecureHash=").append(vnp_SecureHash);

        String paymentUrl = Config.vnp_PayUrl + "?" + query;

        // (Optional) debug
        System.out.println("[VNPAY] vnp_Amount=" + vnpAmount);
        System.out.println("[VNPAY] hashData(before sign)=" + hashData);
        System.out.println("[VNPAY] vnp_SecureHash=" + vnp_SecureHash);

        JsonObject job = new JsonObject();
        job.addProperty("code", "00");
        job.addProperty("message", "success");
        job.addProperty("data", paymentUrl);

        resp.setContentType("application/json;charset=UTF-8");
        resp.getWriter().write(new Gson().toJson(job));
    }
}
