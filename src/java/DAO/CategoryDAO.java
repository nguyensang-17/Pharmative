package DAO;

import java.sql.*;
import java.util.*;
import models.Category;

public class CategoryDAO {

    public List<Category> getAll() throws SQLException {
        String sql = "SELECT category_id, category_name, parent_category_id FROM categories ORDER BY category_name";
        List<Category> list = new ArrayList<>();
        try (Connection c = DBContext.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(map(rs));
            }
        }
        return list;
    }

    public Category getById(int id) throws SQLException {
        String sql = "SELECT category_id, category_name, parent_category_id FROM categories WHERE category_id=?";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? map(rs) : null;
            }
        }
    }

    public boolean create(Category cat) throws SQLException {
        String sql = "INSERT INTO categories(category_name, parent_category_id) VALUES(?, ?)";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, cat.getCategoryName());
            if (cat.getParentCategoryId() == null) ps.setNull(2, Types.INTEGER); else ps.setInt(2, cat.getParentCategoryId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean update(Category cat) throws SQLException {
        String sql = "UPDATE categories SET category_name=?, parent_category_id=? WHERE category_id=?";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, cat.getCategoryName());
            if (cat.getParentCategoryId() == null) ps.setNull(2, Types.INTEGER); else ps.setInt(2, cat.getParentCategoryId());
            ps.setInt(3, cat.getCategoryId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM categories WHERE category_id=?";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    public int countProducts(int categoryId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM products WHERE category_id=?";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            try (ResultSet rs = ps.executeQuery()) { rs.next(); return rs.getInt(1); }
        }
    }

    private Category map(ResultSet rs) throws SQLException {
        Category x = new Category();
        x.setCategoryId(rs.getInt("category_id"));
        x.setCategoryName(rs.getString("category_name"));
        int p = rs.getInt("parent_category_id");
        x.setParentCategoryId(rs.wasNull() ? null : p);
        return x;
    }
}