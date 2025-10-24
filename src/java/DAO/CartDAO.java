package DAO;

import java.sql.*;
import models.Cart;

public class CartDAO {

    public Long create(int customerId) throws SQLException {
        String sql = "INSERT INTO carts(customer_id, is_active) VALUES(?, TRUE)";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, customerId);
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) { return rs.next() ? rs.getLong(1) : null; }
        }
    }

    public Cart getActiveByCustomer(int customerId) throws SQLException {
        String sql = "SELECT * FROM carts WHERE customer_id=? AND is_active=TRUE ORDER BY created_at DESC LIMIT 1";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            try (ResultSet rs = ps.executeQuery()) { return rs.next() ? map(rs) : null; }
        }
    }

    public boolean deactivate(long cartId) throws SQLException {
        String sql = "UPDATE carts SET is_active=FALSE WHERE cart_id=?";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setLong(1, cartId);
            return ps.executeUpdate() > 0;
        }
    }

    private Cart map(ResultSet rs) throws SQLException {
        Cart x = new Cart();
        x.setCartId(rs.getLong("cart_id"));
        x.setCustomerId(rs.getInt("customer_id"));
        x.setCreatedAt(rs.getTimestamp("created_at"));
        x.setUpdatedAt(rs.getTimestamp("updated_at"));
        x.setActive(rs.getBoolean("is_active"));
        return x;
    }
}
