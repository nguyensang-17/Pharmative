package DAO;

import models.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import java.util.LinkedHashMap;
import java.util.Map;

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
    
    // Lấy top sản phẩm bán chạy
    public Map<String, Integer> getTopSellingProducts(int limit) throws SQLException {
        Map<String, Integer> topProducts = new LinkedHashMap<>();
        String sql = """
            SELECT 
                p.product_name,
                SUM(od.quantity) as total_sold
            FROM order_details od
            JOIN products p ON od.product_id = p.product_id
            JOIN orders o ON od.order_id = o.order_id
            WHERE o.status = 'completed'
            GROUP BY p.product_id, p.product_name
            ORDER BY total_sold DESC
            LIMIT ?
            """;
            
        try (Connection c = DBContext.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    String productName = rs.getString("product_name");
                    int totalSold = rs.getInt("total_sold");
                    topProducts.put(productName, totalSold);
                }
            }
        }
        return topProducts;
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
    System.out.println("Getting product by ID: " + id);
    
    try (Connection c = DBContext.getConnection();
         PreparedStatement ps = c.prepareStatement(sql)) {
        ps.setInt(1, id);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                Product product = map(rs);
                System.out.println("✅ Product found: " + product.getProductName());
                System.out.println("Image URL: " + product.getImageUrl());
                return product;
            } else {
                System.out.println("❌ Product not found with ID: " + id);
                return null;
            }
        }
    } catch (SQLException e) {
        System.err.println("❌ SQL Error getting product by ID: " + e.getMessage());
        throw e;
    }
}

    /* =========================
       CRUD admin
       ========================= */

    public void addProduct(Product p) throws SQLException {
    String sql = "INSERT INTO products(product_name, description, price, stock_quantity, image_url, " +
            "category_id, brand_id, supplier_id, created_at) " +
            "VALUES(?,?,?,?,?,?,?,?,NOW())";
    
    System.out.println("=== ADDING PRODUCT TO DATABASE ===");
    System.out.println("Name: " + p.getProductName());
    System.out.println("Price: " + p.getPrice());
    System.out.println("Stock: " + p.getStockQuantity());
    System.out.println("Category: " + p.getCategoryId());
    System.out.println("Brand: " + p.getBrandId());
    System.out.println("Supplier: " + p.getSupplierId());
    System.out.println("Image: " + p.getImageUrl());
    
    try (Connection c = DBContext.getConnection();
         PreparedStatement ps = c.prepareStatement(sql)) {
        ps.setString(1, p.getProductName());
        ps.setString(2, p.getDescription());
        ps.setBigDecimal(3, p.getPrice() == null ? BigDecimal.ZERO : p.getPrice());
        ps.setInt(4, p.getStockQuantity());
        ps.setString(5, p.getImageUrl());
        ps.setInt(6, p.getCategoryId());
        
        // Xử lý brand_id có thể null
        if (p.getBrandId() != null) {
            ps.setInt(7, p.getBrandId());
        } else {
            ps.setNull(7, Types.INTEGER);
        }
        
        // Xử lý supplier_id có thể null
        if (p.getSupplierId() != null) {
            ps.setInt(8, p.getSupplierId());
        } else {
            ps.setNull(8, Types.INTEGER);
        }
        
        int rowsAffected = ps.executeUpdate();
        System.out.println("Rows affected: " + rowsAffected);
        
        if (rowsAffected > 0) {
            System.out.println("✅ Product added to database successfully");
        } else {
            System.out.println("❌ Failed to add product to database");
        }
    } catch (SQLException e) {
        System.err.println("❌ SQL Error adding product: " + e.getMessage());
        throw e;
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
    
    System.out.println("=== UPDATING PRODUCT IN DATABASE ===");
    System.out.println("ID: " + p.getProductId());
    System.out.println("Name: " + p.getProductName());
    System.out.println("Brand: " + p.getBrandId());
    System.out.println("Supplier: " + p.getSupplierId());
    
    try (Connection c = DBContext.getConnection();
         PreparedStatement ps = c.prepareStatement(sql)) {
        ps.setString(1, p.getProductName());
        ps.setString(2, p.getDescription());
        ps.setBigDecimal(3, p.getPrice());
        ps.setInt(4, p.getStockQuantity());
        ps.setString(5, p.getImageUrl());
        ps.setInt(6, p.getCategoryId());
        
        // Xử lý brand_id có thể null
        if (p.getBrandId() != null) {
            ps.setInt(7, p.getBrandId());
        } else {
            ps.setNull(7, Types.INTEGER);
        }
        
        // Xử lý supplier_id có thể null
        if (p.getSupplierId() != null) {
            ps.setInt(8, p.getSupplierId());
        } else {
            ps.setNull(8, Types.INTEGER);
        }
        
        ps.setInt(9, p.getProductId());
        
        int rowsAffected = ps.executeUpdate();
        System.out.println("Rows affected: " + rowsAffected);
        
        return rowsAffected > 0;
    } catch (SQLException e) {
        System.err.println("❌ SQL Error updating product: " + e.getMessage());
        throw e;
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
/**
 * Lấy tất cả sản phẩm (không phân trang) - cho admin
 */
public List<Product> getAllProductsForAdmin() throws SQLException {
    System.out.println("=== GETTING ALL PRODUCTS FOR ADMIN ===");
    String sql = "SELECT * FROM products ORDER BY created_at DESC";
    List<Product> list = new ArrayList<>();
    try (Connection c = DBContext.getConnection();
         PreparedStatement ps = c.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
            Product product = map(rs);
            System.out.println("Product: " + product.getProductName() + " - ID: " + product.getProductId());
            list.add(product);
        }
    }
    System.out.println("Total products found: " + list.size());
    return list;
}
/**
 * Tìm kiếm sản phẩm với phân trang
 */
public List<Product> searchProductsWithPagination(String keyword, String status, int page, int pageSize) throws SQLException {
    System.out.println("=== SEARCHING PRODUCTS ===");
    System.out.println("Keyword: " + keyword + ", Status: " + status + ", Page: " + page + ", PageSize: " + pageSize);
    
    StringBuilder sql = new StringBuilder(
        "SELECT p.* FROM products p WHERE 1=1"
    );
    List<Object> params = new ArrayList<>();
    
    // Thêm điều kiện tìm kiếm theo keyword
    if (keyword != null && !keyword.trim().isEmpty()) {
        sql.append(" AND (p.product_name LIKE ? OR p.description LIKE ?)");
        String searchTerm = "%" + keyword.trim() + "%";
        params.add(searchTerm);
        params.add(searchTerm);
    }
    
    // Thêm điều kiện lọc theo status
    if (status != null && !status.isEmpty()) {
        if ("instock".equals(status)) {
            sql.append(" AND p.stock_quantity > 0");
        } else if ("outstock".equals(status)) {
            sql.append(" AND p.stock_quantity <= 0");
        }
    }
    
    // Thêm phân trang
    sql.append(" ORDER BY p.created_at DESC LIMIT ? OFFSET ?");
    int offset = (page - 1) * pageSize;
    params.add(pageSize);
    params.add(offset);
    
    System.out.println("SQL: " + sql.toString());
    System.out.println("Params: " + params);
    
    List<Product> list = new ArrayList<>();
    try (Connection c = DBContext.getConnection();
         PreparedStatement ps = c.prepareStatement(sql.toString())) {
        
        // Set parameters
        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }
        
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Product product = map(rs);
                System.out.println("Found product: " + product.getProductName());
                list.add(product);
            }
        }
    }
    System.out.println("Total products found in search: " + list.size());
    return list;
}

/**
 * Đếm tổng số sản phẩm sau khi tìm kiếm
 */
public int countSearchProducts(String keyword, String status) throws SQLException {
    StringBuilder sql = new StringBuilder(
        "SELECT COUNT(*) FROM products p WHERE 1=1"
    );
    List<Object> params = new ArrayList<>();
    
    // Thêm điều kiện tìm kiếm theo keyword
    if (keyword != null && !keyword.trim().isEmpty()) {
        sql.append(" AND (p.product_name LIKE ? OR p.description LIKE ?)");
        String searchTerm = "%" + keyword.trim() + "%";
        params.add(searchTerm);
        params.add(searchTerm);
    }
    
    // Thêm điều kiện lọc theo status
    if (status != null && !status.isEmpty()) {
        if ("instock".equals(status)) {
            sql.append(" AND p.stock_quantity > 0");
        } else if ("outstock".equals(status)) {
            sql.append(" AND p.stock_quantity <= 0");
        }
    }
    
    System.out.println("Count SQL: " + sql.toString());
    
    try (Connection c = DBContext.getConnection();
         PreparedStatement ps = c.prepareStatement(sql.toString())) {
        
        // Set parameters
        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }
        
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                int count = rs.getInt(1);
                System.out.println("Total count: " + count);
                return count;
            }
        }
    }
    return 0;
}
}
