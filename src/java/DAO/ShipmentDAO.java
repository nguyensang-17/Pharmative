package DAO;

import java.sql.*;
import models.Shipment;

public class ShipmentDAO {

    public long create(Shipment s) throws SQLException {
        String sql = "INSERT INTO shipments(order_id, carrier, tracking_no, status, shipped_at, delivered_at) VALUES(?,?,?,?,?,?)";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, s.getOrderId());
            ps.setString(2, s.getCarrier());
            ps.setString(3, s.getTrackingNo());
            ps.setString(4, s.getStatus());
            if (s.getShippedAt()==null) ps.setNull(5, Types.TIMESTAMP); else ps.setTimestamp(5, s.getShippedAt());
            if (s.getDeliveredAt()==null) ps.setNull(6, Types.TIMESTAMP); else ps.setTimestamp(6, s.getDeliveredAt());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) { return rs.next()? rs.getLong(1):0L; }
        }
    }

    public boolean updateStatus(long shipmentId, String status) throws SQLException {
        String sql = "UPDATE shipments SET status=?, delivered_at=CASE WHEN ?='DELIVERED' THEN NOW() ELSE delivered_at END WHERE shipment_id=?";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, status);
            ps.setLong(3, shipmentId);
            return ps.executeUpdate() > 0;
        }
    }
}
