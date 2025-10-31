package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;
import DAO.ProductDAO;
import models.Product;

@WebServlet("/cart")
public class CartController extends HttpServlet {
    private ProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart == null) cart = new HashMap<>();

        try {
            switch (action) {
                case "add": {
                    int productId = Integer.parseInt(request.getParameter("productId"));
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    Product product = productDAO.getProductById(productId);

                    if (product != null) {
                        if (product.getPrice() == null) product.setPrice(BigDecimal.ZERO);

                        CartItem item = cart.get(productId);
                        if (item == null) {
                            item = new CartItem(product, quantity);
                        } else {
                            item.setQuantity(item.getQuantity() + quantity);
                        }

                        cart.put(productId, item);
                        session.setAttribute("cart", cart);
                    }
                    response.sendRedirect(request.getContextPath() + "/cart.jsp?success=added");
                    return;
                }

                case "remove": {
                    int productId = Integer.parseInt(request.getParameter("productId"));
                    cart.remove(productId);
                    session.setAttribute("cart", cart);
                    response.sendRedirect(request.getContextPath() + "/cart.jsp?success=removed");
                    return;
                }

                case "update": {
                    response.setContentType("application/json;charset=UTF-8");

                    int productId = Integer.parseInt(request.getParameter("productId"));
                    int quantity = Integer.parseInt(request.getParameter("quantity"));

                    if (cart.containsKey(productId)) {
                        CartItem item = cart.get(productId);
                        item.setQuantity(quantity);
                    }

                    // Tính lại tổng dòng và tổng giỏ
                    BigDecimal lineTotal = BigDecimal.ZERO;
                    BigDecimal cartTotal = BigDecimal.ZERO;

                    for (CartItem i : cart.values()) {
                        BigDecimal price = (i.getProduct().getPrice() == null)
                                ? BigDecimal.ZERO
                                : i.getProduct().getPrice();
                        BigDecimal itemTotal = price.multiply(BigDecimal.valueOf(i.getQuantity()));

                        if (i.getProduct().getProductId() == productId) {
                            lineTotal = itemTotal;
                        }
                        cartTotal = cartTotal.add(itemTotal);
                    }

                    // Lưu lại vào session
                    session.setAttribute("cart", cart);

                    // Trả về JSON cho AJAX
                    String lineTotalFormatted = String.format("%,.0f₫", lineTotal);
                    String cartTotalFormatted = String.format("%,.0f₫", cartTotal);

                    String json = String.format(
                            "{\"lineTotalFormatted\":\"%s\",\"cartTotalFormatted\":\"%s\"}",
                            lineTotalFormatted, cartTotalFormatted
                    );

                    response.getWriter().write(json);
                    return;
                }

                default:
                    response.sendRedirect(request.getContextPath() + "/cart.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/cart.jsp?error=true");
        }
    }

    // ===============================
    // Lớp CartItem phụ trợ
    // ===============================
    public static class CartItem {
        private Product product;
        private int quantity;

        public CartItem(Product product, int quantity) {
            this.product = product;
            this.quantity = quantity;
        }

        public Product getProduct() { return product; }
        public int getQuantity() { return quantity; }
        public void setQuantity(int q) { this.quantity = q; }

        public BigDecimal getTotal() {
            BigDecimal price = (product.getPrice() == null ? BigDecimal.ZERO : product.getPrice());
            return price.multiply(BigDecimal.valueOf(quantity));
        }
    }
}
