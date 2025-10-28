package DAO;

import java.sql.*;
import models.ProductPrice;

public class ProductPriceDAO {

    public ProductPrice getByProduct(int productId) throws SQLException {
        String sql = "SELECT product_id, price, compare_at, updated_at FROM product_prices WHERE product_id=?";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return map(rs);
            }
        }
        return null;
    }

    public boolean upsert(ProductPrice x) throws SQLException {
        String sql = "INSERT INTO product_prices(product_id,price,compare_at,updated_at) VALUES(?,?,?,NOW()) "
                   + "ON DUPLICATE KEY UPDATE price=VALUES(price), compare_at=VALUES(compare_at), updated_at=NOW()";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, x.getProductId());
            ps.setBigDecimal(2, x.getPrice());
            if (x.getCompareAt()==null) ps.setNull(3, Types.DECIMAL); else ps.setBigDecimal(3, x.getCompareAt());
            return ps.executeUpdate() > 0;
        }
    }

    private ProductPrice map(ResultSet rs) throws SQLException {
        ProductPrice p = new ProductPrice();
        p.setProductId(rs.getInt("product_id"));
        p.setPrice(rs.getBigDecimal("price"));
        p.setCompareAt(rs.getBigDecimal("compare_at"));
        p.setUpdatedAt(rs.getTimestamp("updated_at"));
        return p;
    }
}
