package controller;

import DAO.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import models.CartItem;
import models.Product;

@WebServlet("/cart")
public class CartController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
        }

        String action = request.getParameter("action");
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));

            switch (action) {
                case "add":
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    addToCart(productId, quantity, cart);
                    break;
                case "update":
                    int newQuantity = Integer.parseInt(request.getParameter("quantity"));
                    updateCart(productId, newQuantity, cart);
                    break;
                case "remove":
                    removeFromCart(productId, cart);
                    break;
            }
        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
            // Xử lý lỗi
        }

        session.setAttribute("cart", cart);
        response.sendRedirect(request.getContextPath() + "/cart");
    }

    private void addToCart(int productId, int quantity, Map<Integer, CartItem> cart) throws SQLException {
        if (cart.containsKey(productId)) {
            // Nếu sản phẩm đã có trong giỏ, tăng số lượng
            CartItem item = cart.get(productId);
            item.setQuantity(item.getQuantity() + quantity);
        } else {
            // Nếu chưa có, thêm mới
            Product product = productDAO.getProductById(productId);
            if (product != null) {
                cart.put(productId, new CartItem(product, quantity));
            }
        }
    }

    private void updateCart(int productId, int newQuantity, Map<Integer, CartItem> cart) {
        if (cart.containsKey(productId)) {
            if (newQuantity > 0) {
                cart.get(productId).setQuantity(newQuantity);
            } else {
                cart.remove(productId); // Nếu số lượng <= 0, xóa sản phẩm
            }
        }
    }

    private void removeFromCart(int productId, Map<Integer, CartItem> cart) {
        cart.remove(productId);
    }
}