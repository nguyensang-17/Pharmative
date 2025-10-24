package DAO;

import models.Product;

import java.sql.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    /* ======================= Public APIs ======================= */
    /**
     * Lấy danh sách sản phẩm theo trang (mặc định sort mới nhất).
     */
    public List<Product> getAllProducts(int page, int pageSize) throws SQLException {
        int p = Math.max(1, page);
        int s = Math.max(1, pageSize);
        int offset = (p - 1) * s;

        String sql = """
            SELECT product_id, name, category_id, price, stock_quantity, description, image_url, created_at
            FROM products
            ORDER BY created_at DESC, product_id DESC
            LIMIT ? OFFSET ?
        """;

        try ( Connection cn = DBContext.getConnection();  PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, s);
            ps.setInt(2, offset);
            try ( ResultSet rs = ps.executeQuery()) {
                List<Product> list = new ArrayList<>();
                while (rs.next()) {
                    list.add(map(rs));
                }
                return list;
            }
        }
    }

    /**
     * Overload tiện: lấy 1000 bản ghi (giữ tương thích controller hiện tại).
     */
    public List<Product> getAllProducts() throws SQLException {
        return getAllProducts(1, 1000);
    }

    /**
     * Lấy 1 sản phẩm theo id.
     */
    public Product getProductById(int id) throws SQLException {
        String sql = """
            SELECT product_id, name, category_id, price, stock_quantity, description, image_url, created_at
            FROM products
            WHERE product_id = ?
        """;
        try ( Connection cn = DBContext.getConnection();  PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try ( ResultSet rs = ps.executeQuery()) {
                return rs.next() ? map(rs) : null;
            }
        }
    }

    /**
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
                }
            }
        }
        return 0;
    }

    /**
     * Cập nhật sản phẩm theo id của p. Trả true nếu có bản ghi bị ảnh hưởng.
     */
    public boolean updateProduct(Product p) throws SQLException {
        String sql = """
            UPDATE products
            SET name = ?, category_id = ?, price = ?, stock_quantity = ?, description = ?, image_url = ?
            WHERE product_id = ?
        """;
        try ( Connection cn = DBContext.getConnection();  PreparedStatement ps = cn.prepareStatement(sql)) {
            bindForInsertOrUpdate(ps, p);
            ps.setInt(7, p.getId());
            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Xoá 1 sản phẩm theo id.
     */
    public boolean deleteProduct(int id) throws SQLException {
        String sql = "DELETE FROM products WHERE product_id = ?";
        try ( Connection cn = DBContext.getConnection();  PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Đếm tổng số sản phẩm (phục vụ phân trang).
     */
    public int countAllProducts() throws SQLException {
        String sql = "SELECT COUNT(*) FROM products";
        try ( Connection cn = DBContext.getConnection();  PreparedStatement ps = cn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

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
            }
        }
    }

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
        if (categoryId != null) {
            sb.append(" AND category_id = ? ");
            params.add(categoryId);
        }
        sb.append(" ORDER BY created_at DESC, product_id DESC LIMIT ? OFFSET ? ");
        params.add(s);
        params.add(offset);

        try ( Connection cn = DBContext.getConnection();  PreparedStatement ps = cn.prepareStatement(sb.toString())) {
            for (int i = 0; i < params.size(); i++) {
                Object val = params.get(i);
                if (val instanceof Integer) {
                    ps.setInt(i + 1, (Integer) val);
                } else if (val instanceof String) {
                    ps.setString(i + 1, (String) val);
                } else {
                    ps.setObject(i + 1, val);
                }
            }
            try ( ResultSet rs = ps.executeQuery()) {
                List<Product> list = new ArrayList<>();
                while (rs.next()) {
                    list.add(map(rs));
                }
                return list;
            }
        }
    }

    /* ======================= Private helpers ======================= */
    /**
     * Gán tham số chung cho INSERT/UPDATE (không set id).
     */
    private void bindForInsertOrUpdate(PreparedStatement ps, Product p) throws SQLException {
        ps.setString(1, nvl(p.getName()));
        if (p.getCategoryId() != null) {
            ps.setInt(2, p.getCategoryId());
        } else {
            ps.setNull(2, Types.INTEGER);
        }
        ps.setBigDecimal(3, safe(p.getPrice()));
        ps.setInt(4, p.getStockQuantity() == null ? 0 : Math.max(0, p.getStockQuantity()));
        ps.setString(5, nvl(p.getDescription()));
        ps.setString(6, nvl(p.getImageUrl()));
    }

    private Product map(ResultSet rs) throws SQLException {
        Product x = new Product();
        x.setId(rs.getInt("product_id"));
        x.setName(rs.getString("name"));
        x.setCategoryId(getIntOrNull(rs, "category_id"));
        x.setPrice(rs.getBigDecimal("price"));
        x.setStockQuantity(getIntOrNull(rs, "stock_quantity"));
        x.setDescription(rs.getString("description"));
        x.setImageUrl(rs.getString("image_url"));
        // Nếu Product có trường createdAt kiểu java.util.Date/Timestamp:
        try {
            x.setCreatedAt(rs.getTimestamp("created_at"));
        } catch (SQLException ignored) {
            /* cột có thể không tồn tại */ }
        return x;
    }

    private static String nvl(String s) {
        return s == null ? "" : s.trim();
    }

    private static BigDecimal safe(BigDecimal v) {
        return v == null ? BigDecimal.ZERO : v;
    }

    private static Integer getIntOrNull(ResultSet rs, String col) throws SQLException {
        int v = rs.getInt(col);
        return rs.wasNull() ? null : v;
    }
}
