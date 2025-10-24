package DAO;

import java.sql.*;
import java.util.*;
import models.Supplier;

public class SupplierDAO {
    public List<Supplier> getAll() throws SQLException {
        String sql = "SELECT supplier_id, supplier_name, contact_person, email, phone_number FROM suppliers ORDER BY supplier_name";
        List<Supplier> list = new ArrayList<>();
        try (Connection c = DBContext.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(map(rs));
        }
        return list;
    }

    public Supplier getById(int id) throws SQLException {
        String sql = "SELECT supplier_id, supplier_name, contact_person, email, phone_number FROM suppliers WHERE supplier_id=?";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) { return rs.next() ? map(rs) : null; }
        }
    }

    private Supplier map(ResultSet rs) throws SQLException {
        Supplier s = new Supplier();
        s.setSupplierId(rs.getInt("supplier_id"));
        s.setSupplierName(rs.getString("supplier_name"));
        s.setContactPerson(rs.getString("contact_person"));
        s.setEmail(rs.getString("email"));
        s.setPhoneNumber(rs.getString("phone_number"));
        return s;
    }
}
