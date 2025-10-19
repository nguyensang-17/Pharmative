package DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import models.User;
import util.PasswordUtil;

public class UserDAO {

    // ĐĂNG NHẬP: check email -> lấy password_hash -> BCrypt.check -> trả User
    public User checkLogin(String email, String password) throws SQLException {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String hashed = rs.getString("password_hash");
                    if (PasswordUtil.checkPassword(password, hashed)) {
                        return mapResultSetToUser(rs);
                    }
                }
            }
        }
        return null;
    }

    // TẠO USER MỚI 
    public void createUser(User user) throws SQLException {
        String sql = "INSERT INTO users (fullname, email, phone_number, password_hash, role, is_verified, verification_code) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getFullname());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhoneNumber());
            ps.setString(4, PasswordUtil.hashPassword(user.getPassword())); // băm bằng BCrypt
            ps.setString(5, user.getRole() == null ? "customer" : user.getRole());
            ps.setBoolean(6, user.isVerified()); // thường là false khi mới đăng ký
            ps.setString(7, user.getVerificationCode());
            ps.executeUpdate();
        }
    }

    public User findUserByEmail(String email) throws SQLException {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        }
        return null;
    }

    public User findUserByVerificationCode(String code) throws SQLException {
        String sql = "SELECT * FROM users WHERE verification_code = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, code);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        }
        return null;
    }
   
    public void activateUser(int userId) throws SQLException {
        String sql = "UPDATE users SET is_verified = TRUE, verification_code = NULL WHERE user_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.executeUpdate();
        }
    }

    public void createPasswordResetToken(String email, String token) throws SQLException {
        Timestamp expiryDate = new Timestamp(System.currentTimeMillis() + 3600 * 1000); // 1h
        String sql = "UPDATE users SET reset_token = ?, reset_token_expiry = ? WHERE email = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, token);
            ps.setTimestamp(2, expiryDate);
            ps.setString(3, email);
            ps.executeUpdate();
        }
    }

    public User findUserByResetToken(String token) throws SQLException {
        String sql = "SELECT * FROM users WHERE reset_token = ? AND reset_token_expiry > NOW()";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, token);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        }
        return null;
    }

    public User getUserById(int id) throws SQLException {
        String sql = "SELECT * FROM users WHERE user_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapResultSetToUser(rs);
            }
        }
        return null;
    }

    public boolean updateUser(User user) throws SQLException {
        String sql = "UPDATE users SET fullname = ?, phone_number = ? WHERE user_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getFullname());
            ps.setString(2, user.getPhoneNumber());
            ps.setInt(3, user.getId());
            return ps.executeUpdate() > 0;
        }
    }

    public void updateUserPassword(int userId, String newPassword) throws SQLException {
        String hashed = PasswordUtil.hashPassword(newPassword);
        String sql = "UPDATE users SET password_hash = ?, reset_token = NULL, reset_token_expiry = NULL WHERE user_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, hashed);
            ps.setInt(2, userId);
            ps.executeUpdate();
        }
    }

    public List<User> getAllUsers() throws SQLException {
        List<User> userList = new ArrayList<>();
        String sql = "SELECT * FROM users ORDER BY created_at DESC";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                userList.add(mapResultSetToUser(rs));
            }
        }
        return userList;
    }

    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("user_id"));
        user.setFullname(rs.getString("fullname"));
        user.setEmail(rs.getString("email"));        
        user.setPassword(rs.getString("password_hash"));
        user.setRole(rs.getString("role"));
        user.setVerified(rs.getBoolean("is_verified"));
        user.setVerificationCode(rs.getString("verification_code"));
        return user;
    }
}