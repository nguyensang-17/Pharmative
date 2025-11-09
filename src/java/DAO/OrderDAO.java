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
        String sql = "SELECT o.*, u.fullname, u.email, u.phone_number, "
                  + "a.recipient_name, a.recipient_phone, a.street_address, a.ward, a.district, a.city "
                  + "FROM orders o "
                  + "LEFT JOIN users u ON o.user_id = u.user_id "
                  + "LEFT JOIN addresses a ON o.shipping_address_id = a.address_id "
                  + "ORDER BY o.order_date DESC";
        List<Order> list = new ArrayList<>();
        try ( Connection c = DBContext.getConnection();  PreparedStatement ps = c.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(map(rs));
            }
        }
        return list;
    }

    public boolean createOrder(Order order) {
        Connection conn = null;
        PreparedStatement psOrder = null;
        PreparedStatement psDetail = null;
        PreparedStatement psUpdateStock = null;
        ResultSet rs = null;

        try {
            conn = getConnection();
            conn.setAutoCommit(false);

            // Insert order
            String sqlOrder = "INSERT INTO orders "
                      + "(user_id, customer_name, customer_email, customer_phone, "
                      + "shipping_address, payment_method, note, total_amount, status, order_date) "
                      + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";

            psOrder = conn.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS);
            psOrder.setInt(1, order.getUserId());
            psOrder.setString(2, order.getCustomerName());
            psOrder.setString(3, order.getCustomerEmail());
            psOrder.setString(4, order.getCustomerPhone());
            psOrder.setString(5, order.getShippingAddress());
            psOrder.setString(6, order.getPaymentMethod());
            psOrder.setString(7, order.getNote() != null ? order.getNote() : "");
            psOrder.setBigDecimal(8, order.getTotalAmount());
            psOrder.setString(9, order.getStatus());

            int affectedRows = psOrder.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Tạo đơn hàng thất bại");
            }

            // Get order ID
            rs = psOrder.getGeneratedKeys();
            if (rs.next()) {
                order.setOrderId(rs.getInt(1));
            } else {
                throw new SQLException("Không lấy được order ID");
            }

            // Insert order details
            String sqlDetail = "INSERT INTO order_details "
                      + "(order_id, product_id, quantity, price_per_unit) "
                      + "VALUES (?, ?, ?, ?)";
            psDetail = conn.prepareStatement(sqlDetail);

            // Update stock
            String sqlUpdateStock = "UPDATE products SET stock_quantity = stock_quantity - ? "
                      + "WHERE product_id = ? AND stock_quantity >= ?";
            psUpdateStock = conn.prepareStatement(sqlUpdateStock);

            List<OrderDetail> details = order.getOrderDetails();
            if (details == null || details.isEmpty()) {
                throw new SQLException("Đơn hàng phải có ít nhất một sản phẩm");
            }

            for (OrderDetail detail : details) {
                // Insert detail
                psDetail.setInt(1, order.getOrderId());
                psDetail.setInt(2, detail.getProductId());
                psDetail.setInt(3, detail.getQuantity());
                psDetail.setBigDecimal(4, detail.getPricePerUnit());
                psDetail.addBatch();

                // Update stock
                psUpdateStock.setInt(1, detail.getQuantity());
                psUpdateStock.setInt(2, detail.getProductId());
                psUpdateStock.setInt(3, detail.getQuantity());
                psUpdateStock.addBatch();
            }

            // Execute batches
            psDetail.executeBatch();
            int[] stockResults = psUpdateStock.executeBatch();

            // Check stock update results
            for (int i = 0; i < stockResults.length; i++) {
                if (stockResults[i] == 0) {
                    throw new SQLException("Không đủ tồn kho cho sản phẩm ID: "
                              + details.get(i).getProductId());
                }
            }

            conn.commit();
            return true;

        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;

        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (psOrder != null) {
                    psOrder.close();
                }
                if (psDetail != null) {
                    psDetail.close();
                }
                if (psUpdateStock != null) {
                    psUpdateStock.close();
                }
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * Lấy thông tin đơn hàng theo ID
     *
     * @param orderId ID của đơn hàng
     * @return Đối tượng Order hoặc null nếu không tìm thấy
     */
    public Order getOrderById(int orderId) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = getConnection();
            String sql = "SELECT * FROM orders WHERE order_id = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            rs = ps.executeQuery();

            if (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setCustomerName(rs.getString("customer_name"));
                order.setCustomerEmail(rs.getString("customer_email"));
                order.setCustomerPhone(rs.getString("customer_phone"));
                order.setShippingAddress(rs.getString("shipping_address"));
                order.setPaymentMethod(rs.getString("payment_method"));
                order.setNote(rs.getString("note"));
                order.setTotalAmount(rs.getBigDecimal("total_amount"));
                order.setStatus(rs.getString("status"));
                order.setOrderDate(rs.getTimestamp("order_date"));

                return order;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return null;
    }

    /**
     * Cập nhật trạng thái đơn hàng
     *
     * @param orderId ID đơn hàng
     * @param status Trạng thái mới
     * @return true nếu thành công
     */
    public boolean updateOrderStatus(int orderId, String status) {
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = getConnection();
            String sql = "UPDATE orders SET status = ? WHERE order_id = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, orderId);

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // PHƯƠNG THỨC LẤY CHI TIẾT ĐƠN HÀNG - ĐÃ SỬA
    public List<OrderDetail> getOrderDetailsByOrderId(int orderId) throws SQLException {
        String sql = "SELECT od.*, p.product_name, p.image_url "
                  + "FROM order_details od "
                  + "LEFT JOIN products p ON od.product_id = p.product_id "
                  + "WHERE od.order_id = ?";
        List<OrderDetail> details = new ArrayList<>();
        try ( Connection c = DBContext.getConnection();  PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try ( ResultSet rs = ps.executeQuery()) {
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
        String address = rs.getString("recipient_name") + " - "
                  + rs.getString("street_address") + ", "
                  + rs.getString("ward") + ", "
                  + rs.getString("district") + ", "
                  + rs.getString("city");
        o.setShippingAddress(address);

        return o;
    }

    // PHƯƠNG THỨC TÌM KIẾM ĐƠN HÀNG
// PHƯƠNG THỨC TÌM KIẾM ĐƠN HÀNG - CHỈ TÌM GẦN ĐÚNG
    public List<Order> searchOrders(String keyword, String status, String dateFrom) throws SQLException {
        StringBuilder sql = new StringBuilder(
                  "SELECT o.*, u.fullname, u.email, u.phone_number, "
                  + "a.recipient_name, a.recipient_phone, a.street_address, a.ward, a.district, a.city "
                  + "FROM orders o "
                  + "LEFT JOIN users u ON o.user_id = u.user_id "
                  + "LEFT JOIN addresses a ON o.shipping_address_id = a.address_id "
                  + "WHERE 1=1"
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
        try ( Connection c = DBContext.getConnection();  PreparedStatement ps = c.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(map(rs));
                }
            }
        }
        return list;
    }

    public List<Order> getByUser(int userId, int limit) throws SQLException {
        // SỬA: THÊM ĐẦY ĐỦ CÁC CỘT
        String sql = "SELECT o.*, a.recipient_name, a.recipient_phone, a.street_address, a.ward, a.district, a.city "
                  + "FROM orders o "
                  + "LEFT JOIN addresses a ON o.shipping_address_id = a.address_id "
                  + "WHERE o.user_id=? ORDER BY o.order_date DESC LIMIT ?";
        List<Order> list = new ArrayList<>();
        try ( Connection c = DBContext.getConnection();  PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, limit);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(map(rs));
                }
            }
        }
        return list;
    }

    public List<Order> getOrdersByUserId(int userId) {
        // SỬA: THÊM ĐẦY ĐỦ CÁC CỘT
        String sql = "SELECT o.*, a.recipient_name, a.recipient_phone, a.street_address, a.ward, a.district, a.city "
                  + "FROM orders o "
                  + "LEFT JOIN addresses a ON o.shipping_address_id = a.address_id "
                  + "WHERE o.user_id=? ORDER BY o.order_date DESC";
        List<Order> list = new ArrayList<>();
        try ( Connection c = DBContext.getConnection();  PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(map(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // CÁC PHƯƠNG THỨC THỐNG KÊ GIỮ NGUYÊN
    public int countAllOrders() throws SQLException {
        String sql = "SELECT COUNT(*) FROM orders";
        try ( Connection conn = DBContext.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public double getTotalRevenue() throws SQLException {
        String sql = "SELECT COALESCE(SUM(total_amount), 0) "
                  + "FROM orders "
                  + "WHERE status IN ('delivered', 'processing', 'shipped')";
        try ( Connection conn = DBContext.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getDouble(1);
            }
        }
        return 0.0;
    }

    public int countOrdersByStatus(String status) throws SQLException {
        String sql = "SELECT COUNT(*) FROM orders WHERE status = ?";
        try ( Connection conn = DBContext.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    public int getTotalOrders() throws SQLException {
        String sql = "SELECT COUNT(*) FROM orders";
        try ( Connection conn = getConnection();  PreparedStatement stmt = conn.prepareStatement(sql);  ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    public double getRevenueByDateRange(java.sql.Date startDate, java.sql.Date endDate) throws SQLException {
        String sql = "SELECT COALESCE(SUM(total_amount), 0) "
                  + "FROM orders "
                  + "WHERE order_date BETWEEN ? AND ? "
                  + "AND status IN ('delivered', 'processing', 'shipped')";
        try ( Connection conn = DBContext.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDate(1, startDate);
            ps.setDate(2, endDate);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble(1);
                }
            }
        }
        return 0.0;
    }
}
