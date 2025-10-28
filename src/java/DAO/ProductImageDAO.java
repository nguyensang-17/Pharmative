package DAO;

import java.sql.*;
import java.util.*;
import models.ProductImage;

public class ProductImageDAO {

    public List<ProductImage> getByProduct(int productId) throws SQLException {
        String sql = "SELECT image_id, product_id, image_url, is_primary, sort_order FROM product_images WHERE product_id=? ORDER BY is_primary DESC, sort_order ASC";
        List<ProductImage> list = new ArrayList<>();
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        }
        return list;
    }

    public void setPrimary(int imageId, int productId) throws SQLException {
        try (Connection c = DBContext.getConnection()) {
            c.setAutoCommit(false);
            try (PreparedStatement off = c.prepareStatement("UPDATE product_images SET is_primary=FALSE WHERE product_id=?");
                 PreparedStatement on  = c.prepareStatement("UPDATE product_images SET is_primary=TRUE  WHERE image_id=? AND product_id=?")) {
                off.setInt(1, productId); off.executeUpdate();
                on.setInt(1, imageId); on.setInt(2, productId); on.executeUpdate();
                c.commit();
            } catch (Exception e) { c.rollback(); throw e; }
            finally { c.setAutoCommit(true); }
        }
    }

    public boolean add(ProductImage img) throws SQLException {
        String sql = "INSERT INTO product_images(product_id,image_url,is_primary,sort_order) VALUES(?,?,?,?)";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, img.getProductId());
            ps.setString(2, img.getImageUrl());
            ps.setBoolean(3, img.isPrimary());
            ps.setInt(4, img.getSortOrder());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean delete(long imageId) throws SQLException {
        String sql = "DELETE FROM product_images WHERE image_id=?";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setLong(1, imageId);
            return ps.executeUpdate() > 0;
        }
    }

    private ProductImage map(ResultSet rs) throws SQLException {
        ProductImage x = new ProductImage();
        x.setImageId(rs.getLong("image_id"));
        x.setProductId(rs.getInt("product_id"));
        x.setImageUrl(rs.getString("image_url"));
        x.setPrimary(rs.getBoolean("is_primary"));
        x.setSortOrder(rs.getInt("sort_order"));
        return x;
    }
}