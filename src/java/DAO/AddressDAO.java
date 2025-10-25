package DAO;

import java.sql.*;
import java.util.*;
import models.Address;

public class AddressDAO {

    public List<Address> getByUser(int userId) throws SQLException {
        String sql = "SELECT * FROM addresses WHERE user_id=? ORDER BY is_default DESC, address_id DESC";
        List<Address> list = new ArrayList<>();
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) { while (rs.next()) list.add(map(rs)); }
        }
        return list;
    }

    public Address getDefault(int userId) throws SQLException {
        String sql = "SELECT * FROM addresses WHERE user_id=? AND is_default=TRUE LIMIT 1";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) { return rs.next() ? map(rs) : null; }
        }
    }

    public boolean create(Address a) throws SQLException {
        String sql = "INSERT INTO addresses(user_id,recipient_name,recipient_phone,street_address,ward,district,city,is_default) "
                   + "VALUES(?,?,?,?,?,?,?,?)";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, a.getUserId());
            ps.setString(2, a.getRecipientName());
            ps.setString(3, a.getRecipientPhone());
            ps.setString(4, a.getStreetAddress());
            ps.setString(5, a.getWard());
            ps.setString(6, a.getDistrict());
            ps.setString(7, a.getCity());
            ps.setBoolean(8, a.getIsDefault());
            boolean ok = ps.executeUpdate() > 0;
            if (ok && a.getIsDefault()) setDefault(a.getUserId()); // đảm bảo chỉ 1 địa chỉ mặc định
            try (ResultSet rs = ps.getGeneratedKeys()) { if (rs.next()) a.setAddressId(rs.getInt(1)); }
            return ok;
        }
    }

    public boolean setDefault(int userId, int addressId) throws SQLException {
        try (Connection c = DBContext.getConnection()) {
            c.setAutoCommit(false);
            try (PreparedStatement off = c.prepareStatement("UPDATE addresses SET is_default=FALSE WHERE user_id=?");
                 PreparedStatement on  = c.prepareStatement("UPDATE addresses SET is_default=TRUE  WHERE address_id=? AND user_id=?")) {
                off.setInt(1, userId); off.executeUpdate();
                on.setInt(1, addressId); on.setInt(2, userId); on.executeUpdate();
                c.commit(); return true;
            } catch (Exception e) { c.rollback(); throw e; }
            finally { c.setAutoCommit(true); }
        }
    }

    // tiện gọi khi vừa chèn 1 địa chỉ có is_default=true
    private void setDefault(int userId) throws SQLException {
        try (Connection c = DBContext.getConnection();
             PreparedStatement ps = c.prepareStatement(
                     "UPDATE addresses a JOIN (SELECT MAX(address_id) id FROM addresses WHERE user_id=?) x " +
                     "ON a.address_id=x.id SET a.is_default=TRUE")) {
            ps.setInt(1, userId); ps.executeUpdate();
        }
    }

    public boolean delete(int id, int userId) throws SQLException {
        String sql = "DELETE FROM addresses WHERE address_id=? AND user_id=?";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id); ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        }
    }

    private Address map(ResultSet rs) throws SQLException {
        Address a = new Address();
        a.setAddressId(rs.getInt("address_id"));
        a.setUserId(rs.getInt("user_id"));
        a.setRecipientName(rs.getString("recipient_name"));
        a.setRecipientPhone(rs.getString("recipient_phone"));
        a.setStreetAddress(rs.getString("street_address"));
        a.setWard(rs.getString("ward"));
        a.setDistrict(rs.getString("district"));
        a.setCity(rs.getString("city"));
        a.setIsDefault(rs.getBoolean("is_default"));
        return a;
    }
}
