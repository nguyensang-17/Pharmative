package DAO;

import java.sql.*;
import java.util.*;
import models.Order;

public class OrderDAO {

    public Order getById(int id) throws SQLException {
        String sql = "SELECT * FROM orders WHERE order_id=?";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) { return rs.next() ? map(rs) : null; }
        }
    }

    public List<Order> getByUser(int userId, int limit) throws SQLException {
        String sql = "SELECT * FROM orders WHERE user_id=? ORDER BY order_date DESC LIMIT ?";
        List<Order> list = new ArrayList<>();
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId); ps.setInt(2, limit);
            try (ResultSet rs = ps.executeQuery()) { while (rs.next()) list.add(map(rs)); }
        }
        return list;
    }

    // PHƯƠNG THỨC ĐÃ SỬA - KHÔNG THROW EXCEPTION
    public List<Order> getOrdersByUserId(int userId) {
        String sql = "SELECT * FROM orders WHERE user_id=? ORDER BY order_date DESC";
        List<Order> list = new ArrayList<>();
        try (Connection c = DBContext.getConnection(); 
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) { 
                while (rs.next()) list.add(map(rs)); 
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Có thể log lỗi ở đây
            System.err.println("Lỗi khi lấy orders cho user: " + userId + " - " + e.getMessage());
        }
        return list;
    }

    public int create(Order o) throws SQLException {
        String sql = "INSERT INTO orders(user_id, total_amount, status, shipping_address_id) VALUES(?,?,?,?)";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, o.getUserId());
            ps.setBigDecimal(2, o.getTotalAmount());
            ps.setString(3, o.getStatus());
            ps.setInt(4, o.getShippingAddressId());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) { if (rs.next()) return rs.getInt(1); }
        }
        return 0;
    }

    public boolean updateStatus(int orderId, String status) throws SQLException {
        String sql = "UPDATE orders SET status=? WHERE order_id=?";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, status); ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        }
    }

    private Order map(ResultSet rs) throws SQLException {
        Order o = new Order();
        o.setOrderId(rs.getInt("order_id"));
        o.setUserId(rs.getInt("user_id"));
        o.setOrderDate(rs.getTimestamp("order_date"));
        o.setTotalAmount(rs.getBigDecimal("total_amount"));
        o.setStatus(rs.getString("status"));
        o.setShippingAddressId(rs.getInt("shipping_address_id"));
        return o;
    }

    public int countAllOrders() throws SQLException {
        String sql = "SELECT COUNT(*) FROM orders";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }
    
    public double getTotalRevenue() throws SQLException {
        String sql = "SELECT COALESCE(SUM(total_amount), 0) " +
                    "FROM orders " +
                    "WHERE status IN ('delivered', 'processing', 'shipped')";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getDouble(1);
            }
        }
        return 0.0;
    }
    
    public int countOrdersByStatus(String status) throws SQLException {
        String sql = "SELECT COUNT(*) FROM orders WHERE status = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }
    
    public double getRevenueByDateRange(java.sql.Date startDate, java.sql.Date endDate) throws SQLException {
        String sql = "SELECT COALESCE(SUM(total_amount), 0) " +
                    "FROM orders " +
                    "WHERE order_date BETWEEN ? AND ? " +
                    "AND status IN ('delivered', 'processing', 'shipped')";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDate(1, startDate);
            ps.setDate(2, endDate);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble(1);
                }
            }
        }
        return 0.0;
    }
}