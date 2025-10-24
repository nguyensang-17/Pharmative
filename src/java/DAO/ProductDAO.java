package DAO;

import java.sql.*;
import java.util.*;
import java.math.BigDecimal;
import models.Product;

/**
 * DAO for handling all database operations for the Product entity.
 */
//public class ProductDAO {
//
//    /**
//     * Retrieves a paginated list of all products.
//     * @param page
//     * @param pageSize
//     * @return 
//     * @throws java.sql.SQLException
//     */
//    public List<Product> getAllProducts(int page, int pageSize) throws SQLException {
//        List<Product> products = new ArrayList<>();
//        int offset = (page - 1) * pageSize;
//        String sql = "SELECT * FROM products ORDER BY created_at DESC LIMIT ? OFFSET ?";
//        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
//            ps.setInt(1, pageSize);
//            ps.setInt(2, offset);
//            try (ResultSet rs = ps.executeQuery()) {
//                while (rs.next()) {
//                    products.add(mapResultSetToProduct(rs));
//                }
//            }
//        }
//        return products;
//    }
//
//    /**
//     * Gets the total count of products for pagination purposes.
//     * @return 
//     * @throws java.sql.SQLException
//     */
//    public int getTotalProductCount() throws SQLException {
//        String sql = "SELECT COUNT(id) FROM products";
//        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
//            if (rs.next()) {
//                return rs.getInt(1);
//            }
//        }
//        return 0;
//    }
//
//    /**
//     * Retrieves products filtered by a category ID.
//     * @param categoryId
//     * @return 
//     * @throws java.sql.SQLException
//     */
//    public List<Product> getProductsByCategory(int categoryId) throws SQLException {
//        List<Product> products = new ArrayList<>();
//        String sql = "SELECT * FROM products WHERE category_id = ? ORDER BY name ASC";
//        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
//            ps.setInt(1, categoryId);
//            try (ResultSet rs = ps.executeQuery()) {
//                while (rs.next()) {
//                    products.add(mapResultSetToProduct(rs));
//                }
//            }
//        }
//        return products;
//    }
//
//    /**
//     * Searches for products by name (case-insensitive).
//     * @param keyword
//     * @return 
//     * @throws java.sql.SQLException
//     */
//    public List<Product> searchProductsByName(String keyword) throws SQLException {
//        List<Product> products = new ArrayList<>();
//        String sql = "SELECT * FROM products WHERE name LIKE ?";
//        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
//            ps.setString(1, "%" + keyword + "%");
//            try (ResultSet rs = ps.executeQuery()) {
//                while (rs.next()) {
//                    products.add(mapResultSetToProduct(rs));
//                }
//            }
//        }
//        return products;
//    }
//
//    /**
//     * Retrieves the latest products for the home page.
//     * @param limit
//     * @return 
//     * @throws java.sql.SQLException
//     */
//    public List<Product> getFeaturedProducts(int limit) throws SQLException {
//        List<Product> products = new ArrayList<>();
//        String sql = "SELECT * FROM products ORDER BY created_at DESC LIMIT ?";
//        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
//            ps.setInt(1, limit);
//            try (ResultSet rs = ps.executeQuery()) {
//                while (rs.next()) {
//                    products.add(mapResultSetToProduct(rs));
//                }
//            }
//        }
//        return products;
//    }
//
//    /**
//     * Retrieves a single product by its ID.
//     * @param id
//     * @return 
//     * @throws java.sql.SQLException
//     */
//    public Product getProductById(int id) throws SQLException {
//        String sql = "SELECT * FROM products WHERE id = ?";
//        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
//            ps.setInt(1, id);
//            try (ResultSet rs = ps.executeQuery()) {
//                if (rs.next()) {
//                    return mapResultSetToProduct(rs);
//                }
//            }
//        }
//        return null;
//    }
//
//    /**
//     * Adds a new product to the database.For admin use.
//     * @param product
//     * @throws java.sql.SQLException
//     */
//    public void addProduct(Product product) throws SQLException {
//        String sql = "INSERT INTO products (name, category_id, price, description, image_url, stock_quantity) VALUES (?, ?, ?, ?, ?, ?)";
//        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
//            ps.setString(1, product.getName());
//            ps.setInt(2, product.getCategoryId());
//            ps.setBigDecimal(3, product.getPrice());
//            ps.setString(4, product.getDescription());
//            ps.setString(5, product.getImageUrl());
//            ps.setInt(6, product.getStockQuantity());
//            ps.executeUpdate();
//        }
//    }
//
//    /**
//     * Updates an existing product.For admin use.
//     * @param product
//     * @return 
//     * @throws java.sql.SQLException
//     */
//    public boolean updateProduct(Product product) throws SQLException {
//        String sql = "UPDATE products SET name = ?, category_id = ?, price = ?, description = ?, image_url = ?, stock_quantity = ? WHERE id = ?";
//        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
//            ps.setString(1, product.getName());
//            ps.setInt(2, product.getCategoryId());
//            ps.setBigDecimal(3, product.getPrice());
//            ps.setString(4, product.getDescription());
//            ps.setString(5, product.getImageUrl());
//            ps.setInt(6, product.getStockQuantity());
//            ps.setInt(7, product.getId());
//            return ps.executeUpdate() > 0;
//        }
//    }
//
//    /**
//     * Deletes a product from the database.For admin use.
//     * @param id
//     * @return 
//     * @throws java.sql.SQLException
//     */
//    public boolean deleteProduct(int id) throws SQLException {
//        String sql = "DELETE FROM products WHERE id = ?";
//        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
//            ps.setInt(1, id);
//            return ps.executeUpdate() > 0;
//        }
//    }
//
//    /**
//     * Updates product stock quantity.Used within a transaction in OrderDAO.
//     * @param conn
//     * @param productId
//     * @param quantityChange
//     * @throws java.sql.SQLException
//     */
//    public void updateStock(Connection conn, int productId, int quantityChange) throws SQLException {
//        String sql = "UPDATE products SET stock_quantity = stock_quantity - ? WHERE id = ? AND stock_quantity >= ?";
//        try (PreparedStatement ps = conn.prepareStatement(sql)) {
//            ps.setInt(1, quantityChange);
//            ps.setInt(2, productId);
//            ps.setInt(3, quantityChange); // Ensure stock doesn't go negative
//            int rowsAffected = ps.executeUpdate();
//            if (rowsAffected == 0) {
//                throw new SQLException("Update stock failed, possibly insufficient stock for product ID: " + productId);
//            }
//        }
//    }
//
//    private Product mapResultSetToProduct(ResultSet rs) throws SQLException {
//        Product product = new Product();
//        product.setId(rs.getInt("id"));
//        product.setName(rs.getString("name"));
//        product.setCategoryId(rs.getInt("category_id"));
//        product.setPrice(rs.getBigDecimal("price"));
//        product.setDescription(rs.getString("description"));
//        product.setImageUrl(rs.getString("image_url"));
//        product.setStockQuantity(rs.getInt("stock_quantity"));
//        product.setCreatedAt(rs.getTimestamp("created_at"));
//        return product;
//    }
//
//}
public class ProductDAO {

    private static final int ONLINE_BRANCH_ID = 1; // 1 chi nhánh online

    /* ===========================
       Helpers
       =========================== */

    private Product map(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setId(rs.getInt("product_id"));
        p.setName(rs.getString("product_name"));
        p.setCategoryId(rs.getInt("category_id"));
        p.setPrice(rs.getBigDecimal("price"));
        p.setDescription(rs.getString("short_desc")); // dùng short_desc làm mô tả ngắn
        p.setImageUrl(rs.getString("image_url"));
        p.setStockQuantity(rs.getInt("quantity"));
        Timestamp ts = rs.getTimestamp("created_at");
        if (ts != null) p.setCreatedAt(ts);
        return p;
    }
    private Product mapResultSetToProduct(ResultSet rs) throws SQLException {
    Product product = new Product();
    return product;
}


    private String baseSelect() {
        // Chọn ảnh primary; nếu không có thì NULL
        return "SELECT p.product_id, p.product_name, p.category_id, p.short_desc, p.created_at, " +
               "       pp.price, inv.quantity, " +
               "       (SELECT pi.image_url FROM product_images pi " +
               "         WHERE pi.product_id = p.product_id AND pi.is_primary = TRUE " +
               "         ORDER BY pi.sort_order ASC LIMIT 1) AS image_url " +
               "FROM products p " +
               "JOIN product_prices pp ON pp.product_id = p.product_id " +
               "LEFT JOIN inventory inv ON inv.product_id = p.product_id AND inv.branch_id = " + ONLINE_BRANCH_ID + " " +
               "WHERE p.is_active = TRUE ";
    }

    /* ===========================
       Public APIs
       =========================== */

    /** Phân trang toàn bộ sản phẩm (active) */
    public List<Product> getAllProducts(int page, int pageSize) throws SQLException {
        List<Product> list = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        String sql = baseSelect() +
                     "ORDER BY p.created_at DESC " +
                     "LIMIT ? OFFSET ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, pageSize);
            ps.setInt(2, offset);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        }
        return list;
    }

    /** Tổng số sản phẩm (active) – để tính totalPages */
    public int getTotalProductCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM products WHERE is_active = TRUE";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            rs.next();
            return rs.getInt(1);
        }
    }

    /** Lọc theo category (active), có thể dùng cho trang shop */
    public List<Product> getProductsByCategory(int categoryId) throws SQLException {
        List<Product> list = new ArrayList<>();
        String sql = baseSelect() +
                     "AND p.category_id = ? " +
                     "ORDER BY p.product_id DESC";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        }
        return list;
    }

    /** Tìm theo tên (LIKE) – không phân trang (bạn có thể thêm limit tuỳ nhu cầu) */
    public List<Product> searchProductsByName(String keyword) throws SQLException {
        List<Product> list = new ArrayList<>();
        String sql = baseSelect() +
                     "AND p.product_name LIKE ? " +
                     "ORDER BY p.product_id DESC";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        }
        return list;
    }

    /** Sản phẩm mới/featured cho trang chủ (order by created_at DESC) */
    public List<Product> getFeaturedProducts(int limit) throws SQLException {
        List<Product> list = new ArrayList<>();
        String sql = baseSelect() +
                     "ORDER BY p.created_at DESC " +
                     "LIMIT ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        }
        return list;
    }

    /** Lấy chi tiết sản phẩm theo id */
    public Product getProductById(int id) throws SQLException {
        String sql = baseSelect() + "AND p.product_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return map(rs);
            }
        }
        return null;
    }

    /** (Admin) Thêm sản phẩm – chèn vào nhiều bảng (transaction) */
    public void addProduct(Product product) throws SQLException {
        String insertProduct =
            "INSERT INTO products (category_id, brand_id, sku, product_name, short_desc, form_factor, unit_size, is_active) " +
            "VALUES (?, ?, ?, ?, ?, 'viên', '1 hộp', TRUE)";
        String insertPrice = "INSERT INTO product_prices (product_id, price, compare_at) VALUES (?, ?, NULL)";
        String insertImage = "INSERT INTO product_images (product_id, image_url, is_primary, sort_order) VALUES (?, ?, TRUE, 1)";
        String insertInv   = "INSERT INTO inventory (product_id, branch_id, quantity) VALUES (?, " + ONLINE_BRANCH_ID + ", ?)";

        try (Connection conn = DBContext.getConnection()) {
            conn.setAutoCommit(false);
            try (PreparedStatement ps1 = conn.prepareStatement(insertProduct, Statement.RETURN_GENERATED_KEYS)) {
                // brand_id và sku tối thiểu – nếu chưa có UI nhập, mình đặt mặc định
                int brandId = 1; // tạm thời
                String sku = "SKU-" + System.currentTimeMillis();

                ps1.setInt(1, product.getCategoryId());
                ps1.setInt(2, brandId);
                ps1.setString(3, sku);
                ps1.setString(4, product.getName());
                ps1.setString(5, product.getDescription());
                ps1.executeUpdate();

                int newId;
                try (ResultSet keys = ps1.getGeneratedKeys()) {
                    keys.next();
                    newId = keys.getInt(1);
                }

                try (PreparedStatement ps2 = conn.prepareStatement(insertPrice);
                     PreparedStatement ps3 = conn.prepareStatement(insertInv)) {
                    ps2.setInt(1, newId);
                    ps2.setBigDecimal(2, product.getPrice() != null ? product.getPrice() : BigDecimal.ZERO);
                    ps2.executeUpdate();

                    ps3.setInt(1, newId);
                    ps3.setInt(2, product.getStockQuantity());
                    ps3.executeUpdate();
                }

                if (product.getImageUrl() != null && !product.getImageUrl().isEmpty()) {
                    try (PreparedStatement ps4 = conn.prepareStatement(insertImage)) {
                        ps4.setInt(1, newId);
                        ps4.setString(2, product.getImageUrl());
                        ps4.executeUpdate();
                    }
                }

                conn.commit();
            } catch (Exception e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
        }
    }

    /** (Admin) Cập nhật – cập nhật bảng products + product_prices + (ảnh & tồn kho nếu có) */
    public boolean updateProduct(Product product) throws SQLException {
        String updP = "UPDATE products SET product_name=?, category_id=?, short_desc=? WHERE product_id=?";
        String updPrice = "UPDATE product_prices SET price=? WHERE product_id=?";
        String upsertImg =
            "INSERT INTO product_images(product_id, image_url, is_primary, sort_order) " +
            "VALUES (?, ?, TRUE, 1) " +
            "ON DUPLICATE KEY UPDATE image_url=VALUES(image_url), is_primary=TRUE, sort_order=1";
        String updInv = "UPDATE inventory SET quantity=? WHERE product_id=? AND branch_id=" + ONLINE_BRANCH_ID;

        try (Connection conn = DBContext.getConnection()) {
            conn.setAutoCommit(false);
            try (PreparedStatement ps1 = conn.prepareStatement(updP);
                 PreparedStatement ps2 = conn.prepareStatement(updPrice);
                 PreparedStatement ps3 = conn.prepareStatement(updInv)) {

                ps1.setString(1, product.getName());
                ps1.setInt(2, product.getCategoryId());
                ps1.setString(3, product.getDescription());
                ps1.setInt(4, product.getId());
                int a1 = ps1.executeUpdate();

                ps2.setBigDecimal(1, product.getPrice());
                ps2.setInt(2, product.getId());
                ps2.executeUpdate();

                ps3.setInt(1, product.getStockQuantity());
                ps3.setInt(2, product.getId());
                ps3.executeUpdate();

                if (product.getImageUrl() != null && !product.getImageUrl().isEmpty()) {
                    try (PreparedStatement ps4 = conn.prepareStatement(upsertImg)) {
                        ps4.setInt(1, product.getId());
                        ps4.setString(2, product.getImageUrl());
                        ps4.executeUpdate();
                    }
                }

                conn.commit();
                return a1 > 0;
            } catch (Exception e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
        }
    }

    /** (Admin) Xoá mềm sản phẩm */
    public boolean deleteProduct(int id) throws SQLException {
        String sql = "UPDATE products SET is_active = FALSE WHERE product_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    /** Cập nhật tồn kho trong giao dịch (OrderDAO gọi) */
    public void updateStock(Connection conn, int productId, int quantityChange) throws SQLException {
        // giảm tồn kho của chi nhánh online, đảm bảo không âm
        String sql = "UPDATE inventory SET quantity = quantity - ? " +
                     "WHERE product_id = ? AND branch_id = ? AND quantity >= ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, quantityChange);
            ps.setInt(2, productId);
            ps.setInt(3, ONLINE_BRANCH_ID);
            ps.setInt(4, quantityChange);
            int rows = ps.executeUpdate();
            if (rows == 0) throw new SQLException("Insufficient stock for product_id=" + productId);
        }
    }
    // Thêm vào ProductDAO của bạn:

public int countAllActive(Integer categoryId, String q) throws SQLException {
    StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM products WHERE 1=1");
    List<Object> args = new java.util.ArrayList<>();
    if (categoryId != null) { sql.append(" AND category_id=?"); args.add(categoryId); }
    if (q != null && !q.isEmpty()) { sql.append(" AND name LIKE ?"); args.add("%"+q+"%"); }
    try (Connection c = DBContext.getConnection();
         PreparedStatement ps = c.prepareStatement(sql.toString())) {
        for (int i=0;i<args.size();i++) ps.setObject(i+1, args.get(i));
        try (ResultSet rs = ps.executeQuery()) { rs.next(); return rs.getInt(1); }
    }
}

public List<Product> listPaged(int page, int size, Integer categoryId, String q) throws SQLException {
    int offset = (page - 1) * size;
    StringBuilder sql = new StringBuilder("SELECT * FROM products WHERE 1=1");
    List<Object> args = new java.util.ArrayList<>();
    if (categoryId != null) { sql.append(" AND category_id=?"); args.add(categoryId); }
    if (q != null && !q.isEmpty()) { sql.append(" AND name LIKE ?"); args.add("%"+q+"%"); }
    sql.append(" ORDER BY created_at DESC LIMIT ? OFFSET ?");
    try (Connection c = DBContext.getConnection();
         PreparedStatement ps = c.prepareStatement(sql.toString())) {
        int idx=1; for (Object a: args) ps.setObject(idx++, a);
        ps.setInt(idx++, size); ps.setInt(idx, offset);
        try (ResultSet rs = ps.executeQuery()) {
            java.util.List<Product> out = new java.util.ArrayList<>();
            while (rs.next()) out.add(mapResultSetToProduct(rs));
            return out;
        }
    }
}

// Nếu bạn đã có view v_home_best_sellers thì viết getHot(); còn không, có thể trả về featured:
public List<Product> getHot(int limit) throws SQLException {
    return getFeaturedProducts(limit);
}


}