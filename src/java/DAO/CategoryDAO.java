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
    /* ---------------------------
       PHỤC VỤ MENU DANH MỤC
       --------------------------- */

    /** Lấy danh sách cha (parent_category_id IS NULL) */
    public List<Category> getParents() throws SQLException {
        String sql = "SELECT category_id, category_name, parent_category_id " +
                     "FROM categories WHERE parent_category_id IS NULL ORDER BY category_name";
        List<Category> list = new ArrayList<>();
        try (Connection c = DBContext.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(map(rs));
        }
        return list;
    }

    /** Lấy danh sách con trực tiếp của 1 cha */
    public List<Category> getChildren(int parentId) throws SQLException {
        String sql = "SELECT category_id, category_name, parent_category_id " +
                     "FROM categories WHERE parent_category_id = ? ORDER BY category_name";
        List<Category> list = new ArrayList<>();
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, parentId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        }
        return list;
    }

    /**
     * Build tree 2 tầng cho header (1 query → map → gắn children).
     * Phù hợp cấu trúc của bạn: cha + các con trực tiếp.
     */
    public List<Category> getTree() throws SQLException {
        String sql = "SELECT category_id, category_name, parent_category_id FROM categories";
        List<Category> all = new ArrayList<>();
        try (Connection c = DBContext.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) all.add(map(rs));
        }

        Map<Integer, Category> byId = new HashMap<>();
        for (Category x : all) byId.put(x.getCategoryId(), x);

        List<Category> parents = new ArrayList<>();
        for (Category x : all) {
            Integer pid = x.getParentCategoryId();
            if (pid == null) {
                parents.add(x);
            } else {
                Category parent = byId.get(pid);
                if (parent != null) {
                    if (parent.getChildren() == null) parent.setChildren(new ArrayList<>());
                    parent.getChildren().add(x);
                }
            }
        }
        // Sắp xếp tên nếu muốn
        parents.sort(Comparator.comparing(Category::getCategoryName, String.CASE_INSENSITIVE_ORDER));
        for (Category p : parents) {
            if (p.getChildren() != null) {
                p.getChildren().sort(Comparator.comparing(Category::getCategoryName, String.CASE_INSENSITIVE_ORDER));
            }
        }
        return parents;
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