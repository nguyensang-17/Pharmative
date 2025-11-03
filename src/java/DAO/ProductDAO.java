package DAO;

import models.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

public class ProductDAO {

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
    public List<Product> getAllProducts(int page, int pageSize) throws SQLException {
        String sql = "SELECT * FROM products ORDER BY created_at DESC LIMIT ? OFFSET ?";
        List<Product> list = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        try (Connection c = DBContext.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, pageSize);
            ps.setInt(2, offset);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(map(rs));
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
    }

    public Product getProductById(int id) throws SQLException {
        String sql = "SELECT * FROM products WHERE product_id = ?";
        try (Connection c = DBContext.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? map(rs) : null;
            }
        }
    }

    /* =========================
       CRUD admin
       ========================= */

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

    public boolean deleteProduct(int id) throws SQLException {
        String sql = "DELETE FROM products WHERE product_id=?";
        try (Connection c = DBContext.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

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
    /**
 * Lấy tất cả sản phẩm (không phân trang) - cho admin
 */
public List<Product> getAllProducts() throws SQLException {
    String sql = "SELECT * FROM products ORDER BY created_at DESC";
    List<Product> list = new ArrayList<>();
    try (Connection c = DBContext.getConnection();
         PreparedStatement ps = c.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        while (rs.next()) list.add(map(rs));
    }
    return list;
}
}
