package DAO;

import java.sql.*;
import models.Payment;

public class PaymentDAO {

    public long create(Payment p) throws SQLException {
        String sql = "INSERT INTO payments(order_id, method, amount, status, txn_ref, paid_at) VALUES(?,?,?,?,?,?)";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, p.getOrderId());
            ps.setString(2, p.getMethod());
            ps.setBigDecimal(3, p.getAmount());
            ps.setString(4, p.getStatus());
            ps.setString(5, p.getTxnRef());
            if (p.getPaidAt()==null) ps.setNull(6, Types.TIMESTAMP); else ps.setTimestamp(6, p.getPaidAt());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) { return rs.next()? rs.getLong(1):0L; }
        }
    }

    public boolean updateStatus(long paymentId, String status) throws SQLException {
        String sql = "UPDATE payments SET status=? , paid_at=CASE WHEN ?='SUCCESS' THEN NOW() ELSE paid_at END WHERE payment_id=?";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, status);
            ps.setLong(3, paymentId);
            return ps.executeUpdate() > 0;
        }
    }
}
