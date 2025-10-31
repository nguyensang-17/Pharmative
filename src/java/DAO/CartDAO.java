package DAO;

import java.sql.*;
import models.Cart;

public class CartDAO {

    // 🧩 Tạo giỏ hàng mới cho khách hàng
    public Long create(int customerId) throws SQLException {
        String sql = "INSERT INTO carts (customer_id, is_active, created_at, updated_at) VALUES (?, TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)";
        try (Connection c = DBContext.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, customerId);
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getLong(1);
                }
            }
        }
        return null; // Không có ID trả về
    }

    // 🧩 Lấy giỏ hàng đang hoạt động của khách hàng
    public Cart getActiveByCustomer(int customerId) throws SQLException {
        String sql = "SELECT * FROM carts WHERE customer_id = ? AND is_active = TRUE ORDER BY created_at DESC LIMIT 1";
        try (Connection c = DBContext.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, customerId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return map(rs);
                }
            }
        }
        return null;
    }

    // 🧩 Hủy kích hoạt giỏ hàng (đánh dấu là đã thanh toán)
    public boolean deactivate(long cartId) throws SQLException {
        String sql = "UPDATE carts SET is_active = FALSE, updated_at = CURRENT_TIMESTAMP WHERE cart_id = ?";
        try (Connection c = DBContext.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setLong(1, cartId);
            return ps.executeUpdate() > 0;
        }
    }

    // 🧩 Hàm map ResultSet sang đối tượng Cart
    private Cart map(ResultSet rs) throws SQLException {
        Cart cart = new Cart();
        cart.setCartId(rs.getLong("cart_id"));
        cart.setCustomerId(rs.getInt("customer_id"));
        cart.setCreatedAt(rs.getTimestamp("created_at"));
        cart.setUpdatedAt(rs.getTimestamp("updated_at"));
        cart.setActive(rs.getBoolean("is_active"));
        return cart;
    }
}
