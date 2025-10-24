package DAO;

import java.sql.*;
import java.util.*;
import models.Product;

public class ProductDAO {

    public Product getById(int id) throws SQLException {
        String sql = "SELECT * FROM products WHERE product_id=?";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) { return rs.next() ? map(rs) : null; }
        }
    }

    public List<Product> getAll(int page, int pageSize, String keyword, Integer categoryId, Integer brandId, String sortBy) throws SQLException {
        StringBuilder sql = new StringBuilder(
            "SELECT * FROM products WHERE 1=1 ");
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.isBlank()) {
            sql.append(" AND product_name LIKE ? ");
            params.add("%" + keyword.trim() + "%");
        }
        if (categoryId != null) {
            sql.append(" AND category_id = ? ");
            params.add(categoryId);
        }
        if (brandId != null) {
            sql.append(" AND brand_id = ? ");
            params.add(brandId);
        }

        // sort
        if ("price_asc".equalsIgnoreCase(sortBy)) sql.append(" ORDER BY price ASC ");
        else if ("price_desc".equalsIgnoreCase(sortBy)) sql.append(" ORDER BY price DESC ");
        else sql.append(" ORDER BY created_at DESC ");

        // paging
        if (pageSize > 0) {
            sql.append(" LIMIT ? OFFSET ? ");
            params.add(pageSize);
            params.add(Math.max(0, (page - 1) * pageSize));
        }

        List<Product> list = new ArrayList<>();
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) ps.setObject(i + 1, params.get(i));
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        }
        return list;
    }

    public int countAll(String keyword, Integer categoryId, Integer brandId) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM products WHERE 1=1 ");
        List<Object> params = new ArrayList<>();
        if (keyword != null && !keyword.isBlank()) { sql.append(" AND product_name LIKE ? "); params.add("%"+keyword.trim()+"%"); }
        if (categoryId != null) { sql.append(" AND category_id=? "); params.add(categoryId); }
        if (brandId != null) { sql.append(" AND brand_id=? "); params.add(brandId); }

        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql.toString())) {
            for (int i=0;i<params.size();i++) ps.setObject(i+1, params.get(i));
            try (ResultSet rs = ps.executeQuery()) { rs.next(); return rs.getInt(1); }
        }
    }

    public boolean create(Product p) throws SQLException {
        String sql = "INSERT INTO products(product_name, description, price, stock_quantity, image_url, category_id, brand_id, supplier_id) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, p.getProductName());
            ps.setString(2, p.getDescription());
            ps.setBigDecimal(3, p.getPrice());
            ps.setInt(4, p.getStockQuantity());
            ps.setString(5, p.getImageUrl());
            if (p.getCategoryId()==null) ps.setNull(6, Types.INTEGER); else ps.setInt(6, p.getCategoryId());
            if (p.getBrandId()==null) ps.setNull(7, Types.INTEGER); else ps.setInt(7, p.getBrandId());
            if (p.getSupplierId()==null) ps.setNull(8, Types.INTEGER); else ps.setInt(8, p.getSupplierId());
            boolean ok = ps.executeUpdate() > 0;
            if (ok) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) p.setProductId(rs.getInt(1));
                }
            }
            return ok;
        }
    }

    public boolean update(Product p) throws SQLException {
        String sql = "UPDATE products SET product_name=?, description=?, price=?, stock_quantity=?, image_url=?, category_id=?, brand_id=?, supplier_id=? "
                   + "WHERE product_id=?";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, p.getProductName());
            ps.setString(2, p.getDescription());
            ps.setBigDecimal(3, p.getPrice());
            ps.setInt(4, p.getStockQuantity());
            ps.setString(5, p.getImageUrl());
            if (p.getCategoryId()==null) ps.setNull(6, Types.INTEGER); else ps.setInt(6, p.getCategoryId());
            if (p.getBrandId()==null) ps.setNull(7, Types.INTEGER); else ps.setInt(7, p.getBrandId());
            if (p.getSupplierId()==null) ps.setNull(8, Types.INTEGER); else ps.setInt(8, p.getSupplierId());
            ps.setInt(9, p.getProductId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM products WHERE product_id=?";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean updateStock(int productId, int delta) throws SQLException {
        String sql = "UPDATE products SET stock_quantity = stock_quantity + ? WHERE product_id=?";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, delta);
            ps.setInt(2, productId);
            return ps.executeUpdate() > 0;
        }
    }

    private Product map(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setProductId(rs.getInt("product_id"));
        p.setProductName(rs.getString("product_name"));
        p.setDescription(rs.getString("description"));
        p.setPrice(rs.getBigDecimal("price"));
        p.setStockQuantity(rs.getInt("stock_quantity"));
        p.setImageUrl(rs.getString("image_url"));
        int v;
        v = rs.getInt("category_id"); p.setCategoryId(rs.wasNull() ? null : v);
        v = rs.getInt("brand_id");    p.setBrandId(rs.wasNull() ? null : v);
        v = rs.getInt("supplier_id"); p.setSupplierId(rs.wasNull() ? null : v);
        p.setCreatedAt(rs.getTimestamp("created_at"));
        return p;
    }
}