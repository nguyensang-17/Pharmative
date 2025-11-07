package DAO;

import java.sql.*;
import java.util.*;
import models.Order;

public class OrderDAO {

    public Order getById(int id) throws SQLException {
        String sql = "SELECT * FROM orders WHERE order_id=?";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
<<<<<<< HEAD
            try (ResultSet rs = ps.executeQuery()) { return rs.next() ? map(rs) : null; }
=======
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Order order = map(rs);
                    // Lấy chi tiết đơn hàng
                    order.setOrderDetails(getOrderDetailsByOrderId(id));
                    return order;
                }
            }
        }
        return null;
    }

    // PHƯƠNG THỨC LẤY CHI TIẾT ĐƠN HÀNG - ĐÃ SỬA
    public List<OrderDetail> getOrderDetailsByOrderId(int orderId) throws SQLException {
        String sql = "SELECT od.*, p.product_name, p.image_url " +
                    "FROM order_details od " +
                    "LEFT JOIN products p ON od.product_id = p.product_id " +
                    "WHERE od.order_id = ?";
        List<OrderDetail> details = new ArrayList<>();
        try (Connection c = DBContext.getConnection(); 
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderDetail detail = new OrderDetail();
                    detail.setOrderDetailId(rs.getInt("order_detail_id"));
                    detail.setOrderId(rs.getInt("order_id"));
                    detail.setProductId(rs.getInt("product_id"));
                    detail.setQuantity(rs.getInt("quantity"));
                    detail.setPricePerUnit(rs.getBigDecimal("price_per_unit"));
                    
                    // Tạo product để lấy thông tin
                    models.Product product = new models.Product();
                    product.setProductId(rs.getInt("product_id"));
                    product.setProductName(rs.getString("product_name"));
                    product.setImageUrl(rs.getString("image_url"));
                    detail.setProduct(product);
                    
                    details.add(detail);
                }
            }
        }
        return details;
    }

    // PHƯƠNG THỨC CẬP NHẬT TRẠNG THÁI - GIỮ NGUYÊN
    public boolean updateOrderStatus(int orderId, String status) throws SQLException {
        String sql = "UPDATE orders SET status = ? WHERE order_id = ?";
        try (Connection c = DBContext.getConnection(); 
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        }
    }

    // PHƯƠNG THỨC MAP - ĐÃ SỬA THEO DATABASE THỰC TẾ
    private Order map(ResultSet rs) throws SQLException {
        Order o = new Order();
        o.setOrderId(rs.getInt("order_id"));
        o.setUserId(rs.getInt("user_id"));
        o.setOrderDate(rs.getTimestamp("order_date"));
        o.setTotalAmount(rs.getBigDecimal("total_amount"));
        o.setStatus(rs.getString("status"));
        o.setShippingAddressId(rs.getInt("shipping_address_id"));
        
        // Tạo địa chỉ giao hàng từ thông tin address
        String address = rs.getString("recipient_name") + " - " + 
                        rs.getString("street_address") + ", " +
                        rs.getString("ward") + ", " +
                        rs.getString("district") + ", " +
                        rs.getString("city");
        o.setShippingAddress(address);
        
        return o;
    }

    // PHƯƠNG THỨC CREATE ORDER MỚI - PHÙ HỢP VỚI DATABASE
    public boolean createOrder(Order order) {
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            conn.setAutoCommit(false);

            // 1. Insert vào bảng orders - SỬA THEO DATABASE THỰC TẾ
            String orderSql = "INSERT INTO orders (user_id, total_amount, status, shipping_address_id) VALUES (?, ?, ?, ?)";
            int orderId;
            
            try (PreparedStatement orderStmt = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS)) {
                orderStmt.setInt(1, order.getUserId());
                orderStmt.setBigDecimal(2, order.getTotalAmount());
                orderStmt.setString(3, order.getStatus());
                orderStmt.setInt(4, order.getShippingAddressId()); // Sử dụng shipping_address_id
                orderStmt.executeUpdate();
                
                try (ResultSet rs = orderStmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        orderId = rs.getInt(1);
                    } else {
                        throw new SQLException("Không thể lấy order_id");
                    }
                }
            }

            // 2. Insert vào bảng order_details
            String detailSql = "INSERT INTO order_details (order_id, product_id, quantity, price_per_unit) VALUES (?, ?, ?, ?)";
            try (PreparedStatement detailStmt = conn.prepareStatement(detailSql)) {
                for (OrderDetail detail : order.getOrderDetails()) {
                    detailStmt.setInt(1, orderId);
                    detailStmt.setInt(2, detail.getProductId());
                    detailStmt.setInt(3, detail.getQuantity());
                    detailStmt.setBigDecimal(4, detail.getPricePerUnit());
                    detailStmt.addBatch();
                }
                detailStmt.executeBatch();
            }

            // 3. Cập nhật tồn kho
            String updateStockSql = "UPDATE products SET stock_quantity = stock_quantity - ? WHERE product_id = ? AND stock_quantity >= ?";
            try (PreparedStatement stockStmt = conn.prepareStatement(updateStockSql)) {
                for (OrderDetail detail : order.getOrderDetails()) {
                    stockStmt.setInt(1, detail.getQuantity());
                    stockStmt.setInt(2, detail.getProductId());
                    stockStmt.setInt(3, detail.getQuantity());
                    int affected = stockStmt.executeUpdate();
                    if (affected == 0) {
                        throw new SQLException("Số lượng tồn kho không đủ cho sản phẩm ID: " + detail.getProductId());
                    }
                }
            }

            conn.commit();
            return true;

        } catch (SQLException e) {
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
>>>>>>> parent of 92e24ee (Merge branch 'main' of https://github.com/nguyensang-17/Pharmative)
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
        try (Connection conn = DBContext.getConnection(); // ✅ Sửa thành DBContext
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
        try (Connection conn = DBContext.getConnection(); // ✅ Sửa thành DBContext
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
        try (Connection conn = DBContext.getConnection(); // ✅ Sửa thành DBContext
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
    
    /**
     * Lấy doanh thu theo khoảng thời gian - FIXED
     */
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