package DAO;

import java.sql.*;
import java.util.*;
import models.OrderDetail;

public class OrderDetailDAO {

    public List<OrderDetail> getByOrder(int orderId) throws SQLException {
        String sql = "SELECT * FROM order_details WHERE order_id=?";
        List<OrderDetail> list = new ArrayList<>();
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) { while (rs.next()) list.add(map(rs)); }
        }
        return list;
    }

    public boolean add(OrderDetail d) throws SQLException {
        String sql = "INSERT INTO order_details(order_id, product_id, quantity, price_per_unit) VALUES(?,?,?,?)";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, d.getOrderId());
            ps.setInt(2, d.getProductId());
            ps.setInt(3, d.getQuantity());
            ps.setBigDecimal(4, d.getPricePerUnit());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean deleteByOrder(int orderId) throws SQLException {
        String sql = "DELETE FROM order_details WHERE order_id=?";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            return ps.executeUpdate() > 0;
        }
    }

    private OrderDetail map(ResultSet rs) throws SQLException {
        OrderDetail d = new OrderDetail();
        d.setOrderDetailId(rs.getInt("order_detail_id"));
        d.setOrderId(rs.getInt("order_id"));
        d.setProductId(rs.getInt("product_id"));
        d.setQuantity(rs.getInt("quantity"));
        d.setPricePerUnit(rs.getBigDecimal("price_per_unit"));
        return d;
    }
}
