/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;
import models.Address;
import java.sql.*;
import java.util.*;
/**
 *
 * @author TienSon
 */
public class CustomerDao {
      public Map<String, Object> getProfile(int userId) throws SQLException {
        String sql = "SELECT user_id, full_name, email, phone FROM users WHERE user_id=?";
        try (Connection c = DBContext.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;
                Map<String, Object> m = new HashMap<>();
                m.put("userId", rs.getInt("user_id"));
                m.put("full_name", rs.getString("full_name"));
                m.put("email", rs.getString("email"));
                m.put("phone", rs.getString("phone"));
                return m;
            }
        }
    }

    /** Cập nhật họ tên + số điện thoại trong bảng users */
    public void updateProfile(int userId, String fullName, String phone) throws SQLException {
        String sql = "UPDATE users SET full_name=?, phone=? WHERE user_id=?";
        try (Connection c = DBContext.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, fullName);
            ps.setString(2, phone);
            ps.setInt(3, userId);
            ps.executeUpdate();
        }
    }

    /* =======================
       Địa chỉ (bảng addresses)
       Schema: user_id, recipient_name, recipient_phone, street_address, ward, district, city, is_default
       ======================= */

    /** Danh sách địa chỉ của user */
    public List<Address> listAddresses(int userId) throws SQLException {
        String sql = "SELECT * FROM addresses WHERE user_id=? " +
                     "ORDER BY is_default DESC, address_id DESC";
        List<Address> list = new ArrayList<>();
        try (Connection c = DBContext.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        }
        return list;
    }

    /** Thêm địa chỉ mới (nếu isDefault=true sẽ đặt mặc định và hạ các địa chỉ khác) */
    public void addAddress(int userId, String recipientName, String recipientPhone,
                           String streetAddress, String ward, String district, String city,
                           boolean isDefault) throws SQLException {
        String sql = "INSERT INTO addresses(user_id, recipient_name, recipient_phone, " +
                     "street_address, ward, district, city, is_default) VALUES(?,?,?,?,?,?,?,?)";
        try (Connection c = DBContext.getConnection()) {
            c.setAutoCommit(false);
            try (PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, userId);
                ps.setString(2, recipientName);
                ps.setString(3, recipientPhone);
                ps.setString(4, streetAddress);
                ps.setString(5, ward);
                ps.setString(6, district);
                ps.setString(7, city);
                ps.setBoolean(8, isDefault);
                ps.executeUpdate();

                int newId = 0;
                try (ResultSet keys = ps.getGeneratedKeys()) {
                    if (keys.next()) newId = keys.getInt(1);
                }
                if (isDefault) setDefaultAddress(userId, newId, c);

                c.commit();
            } catch (Exception e) {
                c.rollback(); throw e;
            } finally {
                c.setAutoCommit(true);
            }
        }
    }

    /** Đặt mặc định địa chỉ cho user */
    public void setDefaultAddress(int userId, int addressId) throws SQLException {
        try (Connection c = DBContext.getConnection()) {
            setDefaultAddress(userId, addressId, c);
        }
    }
    private void setDefaultAddress(int userId, int addressId, Connection c) throws SQLException {
        try (PreparedStatement off = c.prepareStatement("UPDATE addresses SET is_default=FALSE WHERE user_id=?");
             PreparedStatement on  = c.prepareStatement("UPDATE addresses SET is_default=TRUE WHERE address_id=? AND user_id=?")) {
            off.setInt(1, userId); off.executeUpdate();
            on.setInt(1, addressId); on.setInt(2, userId); on.executeUpdate();
        }
    }

    /** Xoá địa chỉ của user */
    public void deleteAddress(int userId, int addressId) throws SQLException {
        String sql = "DELETE FROM addresses WHERE address_id=? AND user_id=?";
        try (Connection c = DBContext.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, addressId);
            ps.setInt(2, userId);
            ps.executeUpdate();
        }
    }

    /** Map ResultSet -> Address */
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
