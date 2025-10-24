package DAO;

import java.sql.*;
import java.util.*;
import models.CartItem;

public class CartItemDAO {

    public List<CartItem> getItems(long cartId) throws SQLException {
        String sql = "SELECT * FROM cart_items WHERE cart_id=? ORDER BY added_at DESC";
        List<CartItem> list = new ArrayList<>();
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setLong(1, cartId);
            try (ResultSet rs = ps.executeQuery()) { while (rs.next()) list.add(map(rs)); }
        }
        return list;
    }

    public boolean upsert(long cartId, int productId, int quantity) throws SQLException {
        // tăng/giảm số lượng: nếu đã có -> cập nhật; nếu chưa có -> insert
        String sql = "INSERT INTO cart_items(cart_id,product_id,quantity) VALUES(?,?,?) "
                   + "ON DUPLICATE KEY UPDATE quantity = GREATEST(0, quantity + VALUES(quantity))";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setLong(1, cartId);
            ps.setInt(2, productId);
            ps.setInt(3, quantity);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean setQuantity(long cartItemId, int quantity) throws SQLException {
        String sql = "UPDATE cart_items SET quantity=? WHERE cart_item_id=?";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, quantity);
            ps.setLong(2, cartItemId);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean remove(long cartItemId) throws SQLException {
        String sql = "DELETE FROM cart_items WHERE cart_item_id=?";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setLong(1, cartItemId);
            return ps.executeUpdate() > 0;
        }
    }

    private CartItem map(ResultSet rs) throws SQLException {
        CartItem x = new CartItem();
        x.setCartItemId(rs.getLong("cart_item_id"));
        x.setCartId(rs.getLong("cart_id"));
        x.setProductId(rs.getInt("product_id"));
        x.setQuantity(rs.getInt("quantity"));
        x.setAddedAt(rs.getTimestamp("added_at"));
        return x;
    }
}
