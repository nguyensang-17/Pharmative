package DAO;

import java.sql.*;
import java.util.*;
import models.Brand;

public class BrandDAO {
    public List<Brand> getAll() throws SQLException {
        String sql = "SELECT brand_id, brand_name FROM brands ORDER BY brand_name";
        List<Brand> list = new ArrayList<>();
        try (Connection c = DBContext.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Brand b = new Brand();
                b.setBrandId(rs.getInt("brand_id"));
                b.setBrandName(rs.getString("brand_name"));
                list.add(b);
            }
        }
        return list;
    }

    public Brand getById(int id) throws SQLException {
        String sql = "SELECT brand_id, brand_name FROM brands WHERE brand_id=?";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Brand b = new Brand();
                    b.setBrandId(rs.getInt("brand_id"));
                    b.setBrandName(rs.getString("brand_name"));
                    return b;
                }
            }
        }
        return null;
    }
}
