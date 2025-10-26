package DAO;

import models.Category;
import java.sql.*;
<<<<<<< Updated upstream
import java.util.ArrayList;
import java.util.List;
import models.Category;
=======
import java.util.*;
>>>>>>> Stashed changes

/**
 * DAO for handling CRUD operations for the Category entity.
 */
public class CategoryDAO {
    private Connection conn;

<<<<<<< Updated upstream
    /**
     * Retrieves all categories from the database.
     * @return 
     * @throws java.sql.SQLException
     */
    public List<Category> getAllCategories() throws SQLException {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT * FROM categories ORDER BY name ASC";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                categories.add(new Category(rs.getInt("id"), rs.getString("name")));
=======
    public CategoryDAO() {
        try {
            conn = DBContext.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /** Lấy danh mục cha (parent_category_id IS NULL) */
    public List<Category> getRoots() throws SQLException {
        String sql = "SELECT category_id, category_name FROM categories " +
                     "WHERE parent_category_id IS NULL ORDER BY category_id";
        List<Category> list = new ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Category(
                        rs.getInt("category_id"),
                        rs.getString("category_name"),
                        null
                ));
>>>>>>> Stashed changes
            }
        }
        return categories;
    }

<<<<<<< Updated upstream
    /**
     * Retrieves a single category by its ID.
     * @param id
     * @return 
     * @throws java.sql.SQLException
     */
    public Category getCategoryById(int id) throws SQLException {
        String sql = "SELECT * FROM categories WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Category(rs.getInt("id"), rs.getString("name"));
                }
            }
        }
        return null;
    }

    /**
     * Adds a new category to the database.
     * @param category
     * @throws java.sql.SQLException
     */
    public void addCategory(Category category) throws SQLException {
        String sql = "INSERT INTO categories (name) VALUES (?)";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, category.getName());
            ps.executeUpdate();
        }
    }

    /**
     * Updates an existing category's name.
     * @param category
     * @return 
     * @throws java.sql.SQLException
     */
    public boolean updateCategory(Category category) throws SQLException {
        String sql = "UPDATE categories SET name = ? WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, category.getName());
            ps.setInt(2, category.getId());
            return ps.executeUpdate() > 0;
=======
    /** Lấy danh mục con theo cha */
    public List<Category> getChildren(int parentId) throws SQLException {
        String sql = "SELECT category_id, category_name, parent_category_id " +
                     "FROM categories WHERE parent_category_id=? ORDER BY category_id";
        List<Category> list = new ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, parentId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Category(
                            rs.getInt("category_id"),
                            rs.getString("category_name"),
                            rs.getInt("parent_category_id")
                    ));
                }
            }
        }
        return list;
    }

    /** Dữ liệu dạng cây cha-con (Map<CategoryCha, List<CategoryCon>) */
    public Map<Category, List<Category>> getTree2Levels() throws SQLException {
        Map<Category, List<Category>> map = new LinkedHashMap<>();
        for (Category root : getRoots()) {
            map.put(root, getChildren(root.getId()));
>>>>>>> Stashed changes
        }
        return map;
    }
<<<<<<< Updated upstream

    /**
     * Deletes a category from the database.
     * @param id
     * @return 
     * @throws java.sql.SQLException
     */
    public boolean deleteCategory(int id) throws SQLException {
        String sql = "DELETE FROM categories WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }
}
=======
}
>>>>>>> Stashed changes
