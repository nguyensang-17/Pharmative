package util;

import controller.CartController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.Map;

public class CartUtils {

    /** Tổng tiền giỏ theo VND (không nhân 100) */
    public static BigDecimal getCartTotalVnd(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        BigDecimal total = BigDecimal.ZERO;

        if (session != null) {
            @SuppressWarnings("unchecked")
            Map<Integer, CartController.CartItem> cart =
                    (Map<Integer, CartController.CartItem>) session.getAttribute("cart");
            if (cart != null) {
                for (CartController.CartItem it : cart.values()) {
                    BigDecimal price = it.getProduct().getPrice();
                    if (price == null) price = BigDecimal.ZERO;
                    int qty = it.getQuantity();
                    total = total.add(price.multiply(BigDecimal.valueOf(qty)));
                }
            }
        }
        return total;
    }

    /** Giá trị đưa lên VNPAY: VND × 100 (kiểu long) */
    public static long getCartAmountForVnpay(HttpServletRequest req) {
        BigDecimal totalVnd = getCartTotalVnd(req);
        // VNPAY yêu cầu nhân 100 (không có phần lẻ)
        return totalVnd.multiply(BigDecimal.valueOf(100L)).longValue();
    }
}