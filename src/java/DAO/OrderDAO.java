package DAO;

import static DAO.DBContext.getConnection;
import java.sql.*;
import java.util.*;
import models.Order;
import models.OrderDetail;
import models.User;

public class OrderDAO {

    // PHƯƠNG THỨC LẤY TẤT CẢ ĐƠN HÀNG CHO ADMIN - ĐÃ SỬA
    public List<Order> getAllOrders() throws SQLException {
    // THÊM CÁC CỘT ward, district, city VÀO SELECT
    String sql = "SELECT o.*, u.fullname, u.email, u.phone_number, " +
                "a.recipient_name, a.recipient_phone, a.street_address, a.ward, a.district, a.city " +
                "FROM orders o " +
                "LEFT JOIN users u ON o.user_id = u.user_id " +
                "LEFT JOIN addresses a ON o.shipping_address_id = a.address_id " +
                "ORDER BY o.order_date DESC";
    List<Order> list = new ArrayList<>();
    try (Connection c = DBContext.getConnection(); 
         PreparedStatement ps = c.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
            list.add(map(rs));
        }
    }
    return list;
}

    // PHƯƠNG THỨC LẤY ĐƠN HÀNG THEO ID - ĐÃ SỬA
    public Order getOrderById(int id) throws SQLException {
        String sql = "SELECT o.*, u.fullname, u.email, u.phone_number, " +
                    "a.recipient_name, a.recipient_phone, a.street_address, a.ward, a.district, a.city " +
                    "FROM orders o " +
                    "LEFT JOIN users u ON o.user_id = u.user_id " +
                    "LEFT JOIN addresses a ON o.shipping_address_id = a.address_id " +
                    "WHERE o.order_id = ?";
        try (Connection c = DBContext.getConnection(); 
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
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
    
    // Lấy tên khách hàng
    String customerName = rs.getString("fullname");
    if (customerName != null && !customerName.trim().isEmpty()) {
        o.setCustomerName(customerName);
    } else {
        o.setCustomerName("Khách hàng #" + rs.getInt("user_id"));
    }
    
    // Tạo địa chỉ giao hàng
    String address = rs.getString("recipient_name") + " - " + 
                    rs.getString("street_address") + ", " +
                    rs.getString("ward") + ", " +
                    rs.getString("district") + ", " +
                    rs.getString("city");
    o.setShippingAddress(address);
    
    return o;
}
   
   // PHƯƠNG THỨC TÌM KIẾM ĐƠN HÀNG
// PHƯƠNG THỨC TÌM KIẾM ĐƠN HÀNG - CHỈ TÌM GẦN ĐÚNG
public List<Order> searchOrders(String keyword, String status, String dateFrom) throws SQLException {
    StringBuilder sql = new StringBuilder(
        "SELECT o.*, u.fullname, u.email, u.phone_number, " +
        "a.recipient_name, a.recipient_phone, a.street_address, a.ward, a.district, a.city " +
        "FROM orders o " +
        "LEFT JOIN users u ON o.user_id = u.user_id " +
        "LEFT JOIN addresses a ON o.shipping_address_id = a.address_id " +
        "WHERE 1=1"
    );
    
    List<Object> params = new ArrayList<>();
    
    // Tìm kiếm theo keyword - CHỈ TÌM GẦN ĐÚNG
    if (keyword != null && !keyword.trim().isEmpty()) {
        sql.append(" AND (o.order_id LIKE ? OR u.fullname LIKE ? OR u.email LIKE ? OR u.phone_number LIKE ?)");
        String likeKeyword = "%" + keyword.trim() + "%";
        params.add(likeKeyword);
        params.add(likeKeyword);
        params.add(likeKeyword);
        params.add(likeKeyword);
    }
    
    // Tìm kiếm theo trạng thái - CHỈ TÌM GẦN ĐÚNG (để hỗ trợ cả chữ hoa/thường)
    if (status != null && !status.trim().isEmpty()) {
        sql.append(" AND LOWER(o.status) LIKE LOWER(?)");
        params.add("%" + status.trim() + "%");
    }
    
    // Tìm kiếm theo ngày từ - VẪN TÌM CHÍNH XÁC (vì ngày thường cần chính xác)
    if (dateFrom != null && !dateFrom.trim().isEmpty()) {
        sql.append(" AND DATE(o.order_date) >= ?");
        params.add(dateFrom.trim());
    }
    
    sql.append(" ORDER BY o.order_date DESC");
    
    System.out.println("SQL Search: " + sql.toString());
    System.out.println("Params: " + params);
    
    List<Order> list = new ArrayList<>();
    try (Connection c = DBContext.getConnection(); 
         PreparedStatement ps = c.prepareStatement(sql.toString())) {
        
        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }
        
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(map(rs));
            }
        }
    }
    return list;
}

    // PHƯƠNG THỨC CREATE ORDER MỚI - PHÙ HỢP VỚI DATABASE
    // CẬP NHẬT PHƯƠNG THỨC CREATE ORDER
public boolean createOrder(Order order) {
    Connection conn = null;
    try {
        conn = DBContext.getConnection();
        conn.setAutoCommit(false);

        // 1. Insert vào bảng orders - CẬP NHẬT VỚI CÁC TRƯỜNG MỚI
        String orderSql = "INSERT INTO orders (user_id, total_amount, status, shipping_address, customer_name, customer_email, customer_phone, payment_method, note) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        int orderId;
        
        try (PreparedStatement orderStmt = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS)) {
            orderStmt.setInt(1, order.getUserId());
            orderStmt.setBigDecimal(2, order.getTotalAmount());
            orderStmt.setString(3, order.getStatus());
            orderStmt.setString(4, order.getShippingAddress());
            orderStmt.setString(5, order.getCustomerName());
            orderStmt.setString(6, order.getCustomerEmail());
            orderStmt.setString(7, order.getCustomerPhone());
            orderStmt.setString(8, order.getPaymentMethod());
            orderStmt.setString(9, order.getNote());
            orderStmt.executeUpdate();
            
            try (ResultSet rs = orderStmt.getGeneratedKeys()) {
                if (rs.next()) {
                    orderId = rs.getInt(1);
                    order.setOrderId(orderId);
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
    }
}

    public List<Order> getByUser(int userId, int limit) throws SQLException {
    // SỬA: THÊM ĐẦY ĐỦ CÁC CỘT
    String sql = "SELECT o.*, a.recipient_name, a.recipient_phone, a.street_address, a.ward, a.district, a.city " +
                "FROM orders o " +
                "LEFT JOIN addresses a ON o.shipping_address_id = a.address_id " +
                "WHERE o.user_id=? ORDER BY o.order_date DESC LIMIT ?";
    List<Order> list = new ArrayList<>();
    try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
        ps.setInt(1, userId); 
        ps.setInt(2, limit);
        try (ResultSet rs = ps.executeQuery()) { 
            while (rs.next()) list.add(map(rs)); 
        }
    }
    return list;
}

public List<Order> getOrdersByUserId(int userId) {
    // SỬA: THÊM ĐẦY ĐỦ CÁC CỘT
    String sql = "SELECT o.*, a.recipient_name, a.recipient_phone, a.street_address, a.ward, a.district, a.city " +
                "FROM orders o " +
                "LEFT JOIN addresses a ON o.shipping_address_id = a.address_id " +
                "WHERE o.user_id=? ORDER BY o.order_date DESC";
    List<Order> list = new ArrayList<>();
    try (Connection c = DBContext.getConnection(); 
         PreparedStatement ps = c.prepareStatement(sql)) {
        ps.setInt(1, userId);
        try (ResultSet rs = ps.executeQuery()) { 
            while (rs.next()) list.add(map(rs)); 
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return list;
}

    // CÁC PHƯƠNG THỨC THỐNG KÊ GIỮ NGUYÊN
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
    public int getTotalOrders() throws SQLException {
        String sql = "SELECT COUNT(*) FROM orders";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
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