package DAO;

import models.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

public class ProductDAO {

<<<<<<< HEAD
    /* =========================
       Mapping helper
       ========================= */
    private Product map(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setProductId(rs.getInt("product_id"));
        p.setProductName(rs.getString("product_name"));
        p.setDescription(rs.getString("description"));
        p.setPrice(rs.getBigDecimal("price"));
        p.setStockQuantity(rs.getInt("stock_quantity"));
        p.setImageUrl(rs.getString("image_url"));
        p.setCategoryId(rs.getInt("category_id"));
        p.setBrandId(rs.getInt("brand_id"));
        p.setSupplierId(rs.getInt("supplier_id"));
        p.setCreatedAt(rs.getTimestamp("created_at"));
        return p;
    }

    /* =========================
       Public APIs cơ bản
       ========================= */

    /** Phân trang tất cả sản phẩm (không lọc) */
=======
<<<<<<< Updated upstream
    /* ======================= Public APIs ======================= */
    /**
     * Lấy danh sách sản phẩm theo trang (mặc định sort mới nhất).
     */
>>>>>>> sang
    public List<Product> getAllProducts(int page, int pageSize) throws SQLException {
        String sql = "SELECT * FROM products ORDER BY created_at DESC LIMIT ? OFFSET ?";
        List<Product> list = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        try (Connection c = DBContext.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, pageSize);
            ps.setInt(2, offset);
<<<<<<< HEAD
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(map(rs));
=======
            try ( ResultSet rs = ps.executeQuery()) {
                List<Product> list = new ArrayList<>();
                while (rs.next()) {
                    list.add(map(rs));
                }
                return list;
=======
    private static final int ONLINE_BRANCH_ID = 1; // 1 chi nhánh online

    /* ===========================
       Helpers
       =========================== */
    private Product map(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setProductId(rs.getInt("product_id"));
        p.setProductName(rs.getString("product_name"));
        p.setCategoryId(rs.getInt("category_id"));
        p.setPrice(rs.getBigDecimal("price"));
        p.setDescription(rs.getString("short_desc")); // dùng short_desc làm mô tả ngắn
        p.setImageUrl(rs.getString("image_url"));
        p.setStockQuantity(rs.getInt("quantity"));
        Timestamp ts = rs.getTimestamp("created_at");
        if (ts != null) {
            p.setCreatedAt(ts);
        }
        return p;
    }

    private Product mapResultSetToProduct(ResultSet rs) throws SQLException {
        Product product = new Product();
        return product;
    }

    private String baseSelect() {
        // Chọn ảnh primary; nếu không có thì NULL
        return "SELECT p.product_id, p.product_name, p.category_id, p.short_desc, p.created_at, "
                  + "       pp.price, inv.quantity, "
                  + "       (SELECT pi.image_url FROM product_images pi "
                  + "         WHERE pi.product_id = p.product_id AND pi.is_primary = TRUE "
                  + "         ORDER BY pi.sort_order ASC LIMIT 1) AS image_url "
                  + "FROM products p "
                  + "JOIN product_prices pp ON pp.product_id = p.product_id "
                  + "LEFT JOIN inventory inv ON inv.product_id = p.product_id AND inv.branch_id = " + ONLINE_BRANCH_ID + " "
                  + "WHERE p.is_active = TRUE ";
    }

    /* ===========================
       Public APIs
       =========================== */
    /**
     * Phân trang toàn bộ sản phẩm (active)
     */
    public List<Product> getAllProducts(int page, int pageSize) throws SQLException {
        List<Product> list = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        String sql = baseSelect()
                  + "ORDER BY p.created_at DESC "
                  + "LIMIT ? OFFSET ?";
        try ( Connection conn = DBContext.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, pageSize);
            ps.setInt(2, offset);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(map(rs));
                }
>>>>>>> Stashed changes
>>>>>>> sang
            }
        }
        return list;
    }

    public int getTotalProductCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM products";
        try (Connection c = DBContext.getConnection();
             Statement st = c.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

<<<<<<< HEAD
    /** Lọc theo đúng category_id (đơn) – ít dùng cho menu, giữ lại để tái sử dụng */
    public List<Product> getProductsByCategory(int categoryId) throws SQLException {
        String sql = "SELECT * FROM products WHERE category_id=? ORDER BY created_at DESC";
        List<Product> list = new ArrayList<>();
        try (Connection c = DBContext.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        }
        return list;
    }

    public List<Product> searchProductsByName(String keyword) throws SQLException {
        String sql = "SELECT * FROM products WHERE product_name LIKE ? ORDER BY created_at DESC";
        List<Product> list = new ArrayList<>();
        try (Connection c = DBContext.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        }
        return list;
    }

    public List<Product> getFeaturedProducts(int limit) throws SQLException {
        String sql = "SELECT * FROM products ORDER BY created_at DESC LIMIT ?";
        List<Product> list = new ArrayList<>();
        try (Connection c = DBContext.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        }
        return list;
=======
    /**
<<<<<<< Updated upstream
     * Overload tiện: lấy 1000 bản ghi (giữ tương thích controller hiện tại).
     */
    public List<Product> getAllProducts() throws SQLException {
        return getAllProducts(1, 1000);
>>>>>>> sang
    }

    public Product getProductById(int id) throws SQLException {
        String sql = "SELECT * FROM products WHERE product_id = ?";
        try (Connection c = DBContext.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? map(rs) : null;
=======
     * Tổng số sản phẩm (active) – để tính totalPages
     * @throws java.sql.SQLException
     */
    public int getTotalProductCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM products WHERE is_active = TRUE";
        try ( Connection conn = DBContext.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            rs.next();
            return rs.getInt(1);
        }
    }

    /**
     * Lọc theo category (active), có thể dùng cho trang shop
     */
    public List<Product> getProductsByCategory(int categoryId) throws SQLException {
        List<Product> list = new ArrayList<>();
        String sql = baseSelect()
                  + "AND p.category_id = ? "
                  + "ORDER BY p.product_id DESC";
        try ( Connection conn = DBContext.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(map(rs));
                }
            }
        }
        return list;
    }

    /**
     * Tìm theo tên (LIKE) – không phân trang (bạn có thể thêm limit tuỳ nhu
     * cầu)
     */
    public List<Product> searchProductsByName(String keyword) throws SQLException {
        List<Product> list = new ArrayList<>();
        String sql = baseSelect()
                  + "AND p.product_name LIKE ? "
                  + "ORDER BY p.product_id DESC";
        try ( Connection conn = DBContext.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(map(rs));
                }
            }
        }
        return list;
    }

    /**
     * Sản phẩm mới/featured cho trang chủ (order by created_at DESC)
     */
    public List<Product> getFeaturedProducts(int limit) throws SQLException {
        List<Product> list = new ArrayList<>();
        String sql = baseSelect()
                  + "ORDER BY p.created_at DESC "
                  + "LIMIT ?";
        try ( Connection conn = DBContext.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(map(rs));
                }
            }
        }
        return list;
    }

    /**
     * Lấy chi tiết sản phẩm theo id
     */
    public Product getProductById(int id) throws SQLException {
        String sql = baseSelect() + "AND p.product_id = ?";
        try ( Connection conn = DBContext.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return map(rs);
                }
            }
        }
        return null;
    }

    /**
     * (Admin) Thêm sản phẩm – chèn vào nhiều bảng (transaction)
     */
    public void addProduct(Product product) throws SQLException {
        String insertProduct
                  = "INSERT INTO products (category_id, brand_id, sku, product_name, short_desc, form_factor, unit_size, is_active) "
                  + "VALUES (?, ?, ?, ?, ?, 'viên', '1 hộp', TRUE)";
        String insertPrice = "INSERT INTO product_prices (product_id, price, compare_at) VALUES (?, ?, NULL)";
        String insertImage = "INSERT INTO product_images (product_id, image_url, is_primary, sort_order) VALUES (?, ?, TRUE, 1)";
        String insertInv = "INSERT INTO inventory (product_id, branch_id, quantity) VALUES (?, " + ONLINE_BRANCH_ID + ", ?)";

        try ( Connection conn = DBContext.getConnection()) {
            conn.setAutoCommit(false);
            try ( PreparedStatement ps1 = conn.prepareStatement(insertProduct, Statement.RETURN_GENERATED_KEYS)) {
                // brand_id và sku tối thiểu – nếu chưa có UI nhập, mình đặt mặc định
                int brandId = 1; // tạm thời
                String sku = "SKU-" + System.currentTimeMillis();

                ps1.setInt(1, product.getCategoryId());
                ps1.setInt(2, brandId);
                ps1.setString(3, sku);
                ps1.setString(4, product.getProductName());
                ps1.setString(5, product.getDescription());
                ps1.executeUpdate();

                int newId;
                try ( ResultSet keys = ps1.getGeneratedKeys()) {
                    keys.next();
                    newId = keys.getInt(1);
                }

                try ( PreparedStatement ps2 = conn.prepareStatement(insertPrice);  PreparedStatement ps3 = conn.prepareStatement(insertInv)) {
                    ps2.setInt(1, newId);
                    ps2.setBigDecimal(2, product.getPrice() != null ? product.getPrice() : BigDecimal.ZERO);
                    ps2.executeUpdate();

                    ps3.setInt(1, newId);
                    ps3.setInt(2, product.getStockQuantity());
                    ps3.executeUpdate();
                }

                if (product.getImageUrl() != null && !product.getImageUrl().isEmpty()) {
                    try ( PreparedStatement ps4 = conn.prepareStatement(insertImage)) {
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
>>>>>>> Stashed changes
            }
        }
    }

<<<<<<< HEAD
    /* =========================
       CRUD admin
       ========================= */
=======
    /**
<<<<<<< Updated upstream
     * Thêm mới sản phẩm, trả về id sinh ra.
     */
    public int addProduct(Product p) throws SQLException {
        String sql = """
            INSERT INTO products (name, category_id, price, stock_quantity, description, image_url, created_at)
            VALUES (?, ?, ?, ?, ?, ?, NOW())
        """;
        try ( Connection cn = DBContext.getConnection();  PreparedStatement ps = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            bindForInsertOrUpdate(ps, p);
            ps.executeUpdate();
            try ( ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) {
                    return keys.getInt(1);
=======
     * (Admin) Cập nhật – cập nhật bảng products + product_prices + (ảnh & tồn
     * kho nếu có)
     */
    public boolean updateProduct(Product product) throws SQLException {
        String updP = "UPDATE products SET product_name=?, category_id=?, short_desc=? WHERE product_id=?";
        String updPrice = "UPDATE product_prices SET price=? WHERE product_id=?";
        String upsertImg
                  = "INSERT INTO product_images(product_id, image_url, is_primary, sort_order) "
                  + "VALUES (?, ?, TRUE, 1) "
                  + "ON DUPLICATE KEY UPDATE image_url=VALUES(image_url), is_primary=TRUE, sort_order=1";
        String updInv = "UPDATE inventory SET quantity=? WHERE product_id=? AND branch_id=" + ONLINE_BRANCH_ID;

        try ( Connection conn = DBContext.getConnection()) {
            conn.setAutoCommit(false);
            try ( PreparedStatement ps1 = conn.prepareStatement(updP);  PreparedStatement ps2 = conn.prepareStatement(updPrice);  PreparedStatement ps3 = conn.prepareStatement(updInv)) {

                ps1.setString(1, product.getProductName());
                ps1.setInt(2, product.getCategoryId());
                ps1.setString(3, product.getDescription());
                ps1.setInt(4, product.getProductId());
                int a1 = ps1.executeUpdate();

                ps2.setBigDecimal(1, product.getPrice());
                ps2.setInt(2, product.getProductId());
                ps2.executeUpdate();

                ps3.setInt(1, product.getStockQuantity());
                ps3.setInt(2, product.getProductId());
                ps3.executeUpdate();

                if (product.getImageUrl() != null && !product.getImageUrl().isEmpty()) {
                    try ( PreparedStatement ps4 = conn.prepareStatement(upsertImg)) {
                        ps4.setInt(1, product.getProductId());
                        ps4.setString(2, product.getImageUrl());
                        ps4.executeUpdate();
                    }
>>>>>>> Stashed changes
                }
            }
        }
        return 0;
    }
>>>>>>> sang

    public void addProduct(Product p) throws SQLException {
        String sql = "INSERT INTO products(product_name, description, price, stock_quantity, image_url, " +
                "category_id, brand_id, supplier_id, created_at) " +
                "VALUES(?,?,?,?,?,?,?,?,NOW())";
        try (Connection c = DBContext.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, p.getProductName());
            ps.setString(2, p.getDescription());
            ps.setBigDecimal(3, p.getPrice() == null ? BigDecimal.ZERO : p.getPrice());
            ps.setInt(4, p.getStockQuantity());
            ps.setString(5, p.getImageUrl());
            ps.setInt(6, p.getCategoryId());
            ps.setInt(7, p.getBrandId());
            ps.setInt(8, p.getSupplierId());
            ps.executeUpdate();
        }
    }
    /**
 * Đếm tổng số sản phẩm
 */
public int countProducts() throws SQLException {
    String sql = "SELECT COUNT(*) FROM products";
    
    try (Connection conn = DBContext.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        
        if (rs.next()) {
            return rs.getInt(1);
        }
    }
    
    return 0;
}

    public boolean updateProduct(Product p) throws SQLException {
        String sql = "UPDATE products SET product_name=?, description=?, price=?, stock_quantity=?, " +
                "image_url=?, category_id=?, brand_id=?, supplier_id=? WHERE product_id=?";
        try (Connection c = DBContext.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, p.getProductName());
            ps.setString(2, p.getDescription());
            ps.setBigDecimal(3, p.getPrice());
            ps.setInt(4, p.getStockQuantity());
            ps.setString(5, p.getImageUrl());
            ps.setInt(6, p.getCategoryId());
            ps.setInt(7, p.getBrandId());
            ps.setInt(8, p.getSupplierId());
            ps.setInt(9, p.getProductId());
            return ps.executeUpdate() > 0;
        }
    }

<<<<<<< HEAD
    public boolean deleteProduct(int id) throws SQLException {
        String sql = "DELETE FROM products WHERE product_id=?";
        try (Connection c = DBContext.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
=======
    /**
<<<<<<< Updated upstream
     * Xoá 1 sản phẩm theo id.
     */
    public boolean deleteProduct(int id) throws SQLException {
        String sql = "DELETE FROM products WHERE product_id = ?";
        try ( Connection cn = DBContext.getConnection();  PreparedStatement ps = cn.prepareStatement(sql)) {
=======
     * (Admin) Xoá mềm sản phẩm
     */
    public boolean deleteProduct(int id) throws SQLException {
        String sql = "UPDATE products SET is_active = FALSE WHERE product_id = ?";
        try ( Connection conn = DBContext.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
>>>>>>> Stashed changes
>>>>>>> sang
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

<<<<<<< HEAD
    public void updateStock(Connection conn, int productId, int quantityChange) throws SQLException {
        String sql = "UPDATE products SET stock_quantity = stock_quantity - ? " +
                "WHERE product_id=? AND stock_quantity >= ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, quantityChange);
            ps.setInt(2, productId);
            ps.setInt(3, quantityChange);
            int rows = ps.executeUpdate();
            if (rows == 0) throw new SQLException("Insufficient stock for product_id=" + productId);
        }
    }

    /* =========================
       Hỗ trợ phân trang có lọc
       - cat: có thể là id của CHA hoặc CON
       - q : từ khóa tìm kiếm
       ========================= */

    /** Đếm tổng theo bộ lọc; nếu cat là id cha → tính cả con trực tiếp */
    public int countAllActive(Integer categoryId, String q) throws SQLException {
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) " +
                "FROM products p " +
                "JOIN categories c ON c.category_id = p.category_id " +
                "WHERE 1=1"
        );
        List<Object> args = new ArrayList<>();

=======
    /**
<<<<<<< Updated upstream
     * Đếm tổng số sản phẩm (phục vụ phân trang).
     */
    public int countAllProducts() throws SQLException {
        String sql = "SELECT COUNT(*) FROM products";
        try ( Connection cn = DBContext.getConnection();  PreparedStatement ps = cn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
=======
     * Cập nhật tồn kho trong giao dịch (OrderDAO gọi)
     */
    public void updateStock(Connection conn, int productId, int quantityChange) throws SQLException {
        // giảm tồn kho của chi nhánh online, đảm bảo không âm
        String sql = "UPDATE inventory SET quantity = quantity - ? "
                  + "WHERE product_id = ? AND branch_id = ? AND quantity >= ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, quantityChange);
            ps.setInt(2, productId);
            ps.setInt(3, ONLINE_BRANCH_ID);
            ps.setInt(4, quantityChange);
            int rows = ps.executeUpdate();
            if (rows == 0) {
                throw new SQLException("Insufficient stock for product_id=" + productId);
            }
>>>>>>> Stashed changes
        }
    }

<<<<<<< Updated upstream
    /**
     * Lấy sản phẩm theo category (có trang).
     */
    public List<Product> getProductsByCategory(int categoryId, int page, int pageSize) throws SQLException {
        int p = Math.max(1, page);
        int s = Math.max(1, pageSize);
        int offset = (p - 1) * s;

        String sql = """
            SELECT product_id, name, category_id, price, stock_quantity, description, image_url, created_at
            FROM products
            WHERE category_id = ?
            ORDER BY created_at DESC, product_id DESC
            LIMIT ? OFFSET ?
        """;
        try ( Connection cn = DBContext.getConnection();  PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            ps.setInt(2, s);
            ps.setInt(3, offset);
            try ( ResultSet rs = ps.executeQuery()) {
                List<Product> list = new ArrayList<>();
                while (rs.next()) {
                    list.add(map(rs));
                }
                return list;
=======
    public int countAllActive(Integer categoryId, String q) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM products WHERE 1=1");
        List<Object> args = new java.util.ArrayList<>();
        if (categoryId != null) {
            sql.append(" AND category_id=?");
            args.add(categoryId);
        }
        if (q != null && !q.isEmpty()) {
            sql.append(" AND name LIKE ?");
            args.add("%" + q + "%");
        }
        try ( Connection c = DBContext.getConnection();  PreparedStatement ps = c.prepareStatement(sql.toString())) {
            for (int i = 0; i < args.size(); i++) {
                ps.setObject(i + 1, args.get(i));
            }
            try ( ResultSet rs = ps.executeQuery()) {
                rs.next();
                return rs.getInt(1);
            }
        }
    }

    public List<Product> listPaged(int page, int size, Integer categoryId, String q) throws SQLException {
        int offset = (page - 1) * size;
        StringBuilder sql = new StringBuilder("SELECT * FROM products WHERE 1=1");
        List<Object> args = new java.util.ArrayList<>();
        if (categoryId != null) {
            sql.append(" AND category_id=?");
            args.add(categoryId);
        }
        if (q != null && !q.isEmpty()) {
            sql.append(" AND name LIKE ?");
            args.add("%" + q + "%");
        }
        sql.append(" ORDER BY created_at DESC LIMIT ? OFFSET ?");
        try ( Connection c = DBContext.getConnection();  PreparedStatement ps = c.prepareStatement(sql.toString())) {
            int idx = 1;
            for (Object a : args) {
                ps.setObject(idx++, a);
            }
            ps.setInt(idx++, size);
            ps.setInt(idx, offset);
            try ( ResultSet rs = ps.executeQuery()) {
                java.util.List<Product> out = new java.util.ArrayList<>();
                while (rs.next()) {
                    out.add(mapResultSetToProduct(rs));
                }
                return out;
>>>>>>> Stashed changes
            }
        }
    }

<<<<<<< Updated upstream
    /**
     * Tìm kiếm theo tên + lọc category (tham số tuỳ chọn), có trang.
     */
    public List<Product> searchProducts(String q, Integer categoryId, int page, int pageSize) throws SQLException {
        int p = Math.max(1, page);
        int s = Math.max(1, pageSize);
        int offset = (p - 1) * s;

        StringBuilder sb = new StringBuilder("""
            SELECT product_id, name, category_id, price, stock_quantity, description, image_url, created_at
            FROM products
            WHERE 1=1
        """);
        List<Object> params = new ArrayList<>();

        if (q != null && !q.trim().isEmpty()) {
            sb.append(" AND LOWER(name) LIKE ? ");
            params.add("%" + q.trim().toLowerCase() + "%");
        }
>>>>>>> sang
        if (categoryId != null) {
            sql.append(" AND (c.category_id = ? OR c.parent_category_id = ?)");
            args.add(categoryId);
            args.add(categoryId);
        }
        if (q != null && !q.isEmpty()) {
            sql.append(" AND p.product_name LIKE ?");
            args.add("%" + q + "%");
        }

        try (Connection c = DBContext.getConnection();
             PreparedStatement ps = c.prepareStatement(sql.toString())) {
            for (int i = 0; i < args.size(); i++) ps.setObject(i + 1, args.get(i));
            try (ResultSet rs = ps.executeQuery()) {
                rs.next();
                return rs.getInt(1);
            }
        }
    }

    /** Lấy danh sách theo trang; cat hỗ trợ cha + con trực tiếp */
    public List<Product> listPaged(int page, int size, Integer categoryId, String q) throws SQLException {
        int offset = (page - 1) * size;

        StringBuilder sql = new StringBuilder(
                "SELECT p.* " +
                "FROM products p " +
                "JOIN categories c ON c.category_id = p.category_id " +
                "WHERE 1=1"
        );
        List<Object> args = new ArrayList<>();

        if (categoryId != null) {
            sql.append(" AND (c.category_id = ? OR c.parent_category_id = ?)");
            args.add(categoryId);
            args.add(categoryId);
        }
        if (q != null && !q.isEmpty()) {
            sql.append(" AND p.product_name LIKE ?");
            args.add("%" + q + "%");
        }

        sql.append(" ORDER BY p.created_at DESC LIMIT ? OFFSET ?");
        args.add(size);
        args.add(offset);

        try (Connection c = DBContext.getConnection();
             PreparedStatement ps = c.prepareStatement(sql.toString())) {
            for (int i = 0; i < args.size(); i++) ps.setObject(i + 1, args.get(i));
            List<Product> out = new ArrayList<>();
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) out.add(map(rs));
            }
            return out;
        }
    }

    /** “Hot” tạm thời = sp mới nhất */
    public List<Product> getHot(int limit) throws SQLException {
        return getFeaturedProducts(limit);
    }
=======
// Nếu bạn đã có view v_home_best_sellers thì viết getHot(); còn không, có thể trả về featured:
    public List<Product> getHot(int limit) throws SQLException {
        return getFeaturedProducts(limit);
    }

>>>>>>> Stashed changes
}
