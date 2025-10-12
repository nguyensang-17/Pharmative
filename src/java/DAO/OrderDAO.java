package DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import models.Order;
import models.OrderDetail;

/**
 * DAO for handling all database operations for Orders and OrderDetails.
 */
public class OrderDAO {

    /**
     * Creates a new order in a single transaction.
     * @param order
     * @return true if the order was created successfully, false otherwise.
     */
    public boolean createOrder(Order order) {
        String insertOrderSQL = "INSERT INTO orders (user_id, total_amount, status, shipping_address) VALUES (?, ?, ?, ?)";
        String insertOrderDetailSQL = "INSERT INTO order_details (order_id, product_id, quantity, price_per_unit) VALUES (?, ?, ?, ?)";
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            conn.setAutoCommit(false); // Start transaction

            // 1. Insert into 'orders' table
            try (PreparedStatement psOrder = conn.prepareStatement(insertOrderSQL, Statement.RETURN_GENERATED_KEYS)) {
                psOrder.setInt(1, order.getUserId());
                psOrder.setBigDecimal(2, order.getTotalAmount());
                psOrder.setString(3, "pending");
                psOrder.setString(4, order.getShippingAddress());
                psOrder.executeUpdate();

                int orderId;
                try (ResultSet generatedKeys = psOrder.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        orderId = generatedKeys.getInt(1);
                    } else {
                        throw new SQLException("Creating order failed, no ID obtained.");
                    }
                }

                // 2. Insert into 'order_details' and 3. Update stock
                ProductDAO productDAO = new ProductDAO();
                try (PreparedStatement psOrderDetail = conn.prepareStatement(insertOrderDetailSQL)) {
                    for (OrderDetail detail : order.getOrderDetails()) {
                        psOrderDetail.setInt(1, orderId);
                        psOrderDetail.setInt(2, detail.getProductId());
                        psOrderDetail.setInt(3, detail.getQuantity());
                        psOrderDetail.setBigDecimal(4, detail.getPricePerUnit());
                        psOrderDetail.addBatch();
                        
                        productDAO.updateStock(conn, detail.getProductId(), detail.getQuantity());
                    }
                    psOrderDetail.executeBatch();
                }
            }
            conn.commit(); // Commit transaction
            return true;
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback(); // Rollback on error
                } catch (SQLException ex) {
                }
            }
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                }
            }
        }
    }

    /**
     * Retrieves all orders for a specific user.
     * @param userId
     * @return 
     * @throws java.sql.SQLException
     */
    public List<Order> getOrdersByUserId(int userId) throws SQLException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    orders.add(mapResultSetToOrder(rs));
                }
            }
        }
        return orders;
    }

    /**
     * Retrieves all orders in the system.For admin use.
     * @return 
     * @throws java.sql.SQLException
     */
    public List<Order> getAllOrders() throws SQLException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders ORDER BY order_date DESC";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                orders.add(mapResultSetToOrder(rs));
            }
        }
        return orders;
    }

    /**
     * Retrieves a single order and its details by ID.
     * @param orderId
     * @return 
     * @throws java.sql.SQLException
     */
    public Order getOrderById(int orderId) throws SQLException {
        Order order = null;
        String orderSQL = "SELECT * FROM orders WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement psOrder = conn.prepareStatement(orderSQL)) {
            psOrder.setInt(1, orderId);
            try (ResultSet rsOrder = psOrder.executeQuery()) {
                if (rsOrder.next()) {
                    order = mapResultSetToOrder(rsOrder);
                    order.setOrderDetails(getOrderDetailsByOrderId(conn, orderId));
                }
            }
        }
        return order;
    }
    
    /**
     * Helper to get order details for a given order ID.
     */
    private List<OrderDetail> getOrderDetailsByOrderId(Connection conn, int orderId) throws SQLException {
        List<OrderDetail> details = new ArrayList<>();
        String detailSQL = "SELECT * FROM order_details WHERE order_id = ?";
        try (PreparedStatement psDetail = conn.prepareStatement(detailSQL)) {
            psDetail.setInt(1, orderId);
            try (ResultSet rsDetail = psDetail.executeQuery()) {
                while (rsDetail.next()) {
                    details.add(mapResultSetToOrderDetail(rsDetail));
                }
            }
        }
        return details;
    }

    /**
     * Updates the status of an order.For admin use.
     * @param orderId
     * @param status
     * @return 
     * @throws java.sql.SQLException
     */
    public boolean updateOrderStatus(int orderId, String status) throws SQLException {
        String sql = "UPDATE orders SET status = ? WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        }
    }

    private Order mapResultSetToOrder(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setId(rs.getInt("id"));
        order.setUserId(rs.getInt("user_id"));
        order.setOrderDate(rs.getTimestamp("order_date"));
        order.setTotalAmount(rs.getBigDecimal("total_amount"));
        order.setStatus(rs.getString("status"));
        order.setShippingAddress(rs.getString("shipping_address"));
        return order;
    }
    
    private OrderDetail mapResultSetToOrderDetail(ResultSet rs) throws SQLException {
        OrderDetail detail = new OrderDetail();
        detail.setId(rs.getInt("id"));
        detail.setOrderId(rs.getInt("order_id"));
        detail.setProductId(rs.getInt("product_id"));
        detail.setQuantity(rs.getInt("quantity"));
        detail.setPricePerUnit(rs.getBigDecimal("price_per_unit"));
        return detail;
    }
}