package DAO;

import java.sql.*;

public class InventoryDAO {

    public Integer getQuantity(int productId, int branchId) throws SQLException {
        String sql = "SELECT quantity FROM inventory WHERE product_id=? AND branch_id=?";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.setInt(2, branchId);
            try (ResultSet rs = ps.executeQuery()) { return rs.next() ? rs.getInt(1) : null; }
        }
    }

    public boolean upsert(int productId, int branchId, int quantity) throws SQLException {
        String sql = "INSERT INTO inventory(product_id,branch_id,quantity) VALUES(?,?,?) "
                   + "ON DUPLICATE KEY UPDATE quantity=VALUES(quantity)";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.setInt(2, branchId);
            ps.setInt(3, quantity);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean addDelta(int productId, int branchId, int delta) throws SQLException {
        String sql = "UPDATE inventory SET quantity = quantity + ? WHERE product_id=? AND branch_id=?";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, delta);
            ps.setInt(2, productId);
            ps.setInt(3, branchId);
            return ps.executeUpdate() > 0;
        }
    }
}