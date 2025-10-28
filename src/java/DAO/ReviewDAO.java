package DAO;

import java.sql.*;
import java.util.*;
import models.Review;

public class ReviewDAO {

    public List<Review> getByProduct(int productId) throws SQLException {
        String sql = "SELECT * FROM reviews WHERE product_id=? ORDER BY review_date DESC";
        List<Review> list = new ArrayList<>();
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) { while (rs.next()) list.add(map(rs)); }
        }
        return list;
    }

    public boolean add(Review r) throws SQLException {
        String sql = "INSERT INTO reviews(product_id,user_id,rating,comment) VALUES(?,?,?,?)";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, r.getProductId());
            ps.setInt(2, r.getUserId());
            ps.setInt(3, r.getRating());
            ps.setString(4, r.getComment());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean delete(int reviewId, int userId) throws SQLException {
        String sql = "DELETE FROM reviews WHERE review_id=? AND user_id=?";
        try (Connection c = DBContext.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, reviewId); ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        }
    }

    private Review map(ResultSet rs) throws SQLException {
        Review r = new Review();
        r.setReviewId(rs.getInt("review_id"));
        r.setProductId(rs.getInt("product_id"));
        r.setUserId(rs.getInt("user_id"));
        r.setRating(rs.getInt("rating"));
        r.setComment(rs.getString("comment"));
        r.setReviewDate(rs.getTimestamp("review_date"));
        return r;
    }
}
