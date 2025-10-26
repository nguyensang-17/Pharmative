package DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import models.User;
import models.UserStatistics;
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
    // ============ PHẦN BỔ SUNG CHO ADMIN USER MANAGEMENT ============

// 1. Lấy users với phân trang
public List<User> getAllUsers(int page, int pageSize) throws SQLException {
    List<User> users = new ArrayList<>();
    String sql = "SELECT * FROM users ORDER BY created_at DESC LIMIT ? OFFSET ?";
    
    try (Connection conn = DBContext.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, pageSize);
        ps.setInt(2, (page - 1) * pageSize);
        
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                users.add(mapResultSetToUser(rs));
            }
        }
    }
    return users;
}

// 2. Đếm tổng số users
public int getTotalUsers() throws SQLException {
    String sql = "SELECT COUNT(*) FROM users";
    try (Connection conn = DBContext.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        if (rs.next()) {
            return rs.getInt(1);
        }
    }
    return 0;
}

// 3. Tìm kiếm users (theo tên, email, SĐT)
public List<User> searchUsers(String keyword, int page, int pageSize) throws SQLException {
    List<User> users = new ArrayList<>();
    String sql = "SELECT * FROM users WHERE " +
                 "fullname LIKE ? OR email LIKE ? OR phone_number LIKE ? " +
                 "ORDER BY created_at DESC LIMIT ? OFFSET ?";
    
    try (Connection conn = DBContext.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        String searchPattern = "%" + keyword + "%";
        ps.setString(1, searchPattern);
        ps.setString(2, searchPattern);
        ps.setString(3, searchPattern);
        ps.setInt(4, pageSize);
        ps.setInt(5, (page - 1) * pageSize);
        
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                users.add(mapResultSetToUser(rs));
            }
        }
    }
    return users;
}

// 4. Đếm kết quả tìm kiếm
public int countSearchResults(String keyword) throws SQLException {
    String sql = "SELECT COUNT(*) FROM users WHERE " +
                 "fullname LIKE ? OR email LIKE ? OR phone_number LIKE ?";
    
    try (Connection conn = DBContext.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        String searchPattern = "%" + keyword + "%";
        ps.setString(1, searchPattern);
        ps.setString(2, searchPattern);
        ps.setString(3, searchPattern);
        
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
    }
    return 0;
}

// 5. Lọc users theo role
public List<User> getUsersByRole(String role, int page, int pageSize) throws SQLException {
    List<User> users = new ArrayList<>();
    String sql = "SELECT * FROM users WHERE role = ? " +
                 "ORDER BY created_at DESC LIMIT ? OFFSET ?";
    
    try (Connection conn = DBContext.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, role);
        ps.setInt(2, pageSize);
        ps.setInt(3, (page - 1) * pageSize);
        
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                users.add(mapResultSetToUser(rs));
            }
        }
    }
    return users;
}

// 6. Đếm users theo role
public int countUsersByRole(String role) throws SQLException {
    String sql = "SELECT COUNT(*) FROM users WHERE role = ?";
    
    try (Connection conn = DBContext.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, role);
        
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
    }
    return 0;
}

// 7. Đếm users mới trong tháng này
public int countNewUsersThisMonth() throws SQLException {
    String sql = "SELECT COUNT(*) FROM users " +
                 "WHERE MONTH(created_at) = MONTH(CURRENT_DATE()) " +
                 "AND YEAR(created_at) = YEAR(CURRENT_DATE())";
    
    try (Connection conn = DBContext.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        if (rs.next()) {
            return rs.getInt(1);
        }
    }
    return 0;
}

// 8. Cập nhật thông tin user (bản admin - có thể sửa role & verified)
public boolean updateUserByAdmin(User user) throws SQLException {
    String sql = "UPDATE users SET fullname = ?, email = ?, " +
                 "phone_number = ?, role = ?, is_verified = ? " +
                 "WHERE user_id = ?";
    
    try (Connection conn = DBContext.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, user.getFullname());
        ps.setString(2, user.getEmail());
        ps.setString(3, user.getPhoneNumber());
        ps.setString(4, user.getRole());
        ps.setBoolean(5, user.isVerified());
        ps.setInt(6, user.getId());
        
        return ps.executeUpdate() > 0;
    }
}

// 9. Toggle trạng thái verified của user
public boolean toggleUserStatus(int userId) throws SQLException {
    String sql = "UPDATE users SET is_verified = NOT is_verified WHERE user_id = ?";
    
    try (Connection conn = DBContext.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, userId);
        return ps.executeUpdate() > 0;
    }
}

// 10. Xóa user (cẩn thận với foreign key constraints!)
public boolean deleteUser(int userId) throws SQLException {
    String sql = "DELETE FROM users WHERE user_id = ?";
    
    try (Connection conn = DBContext.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, userId);
        return ps.executeUpdate() > 0;
    }
}

// 11. Kiểm tra email đã tồn tại (dùng khi update)
public boolean isEmailExist(String email, int excludeUserId) throws SQLException {
    String sql = "SELECT COUNT(*) FROM users WHERE email = ? AND user_id != ?";
    
    try (Connection conn = DBContext.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, email);
        ps.setInt(2, excludeUserId);
        
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }
    }
    return false;
}

// 12. Lấy thống kê chi tiết của user (số đơn hàng, tổng chi tiêu...)
public UserStatistics getUserStatistics(int userId) throws SQLException {
    String sql = "SELECT " +
                 "COUNT(o.order_id) as total_orders, " +
                 "COALESCE(SUM(o.total_amount), 0) as total_spent, " +
                 "MAX(o.order_date) as last_order_date " +
                 "FROM users u " +
                 "LEFT JOIN orders o ON u.user_id = o.user_id " +
                 "WHERE u.user_id = ?";
    
    try (Connection conn = DBContext.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, userId);
        
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                UserStatistics stats = new UserStatistics();
                stats.setTotalOrders(rs.getInt("total_orders"));
                stats.setTotalSpent(rs.getDouble("total_spent"));
                stats.setLastOrderDate(rs.getTimestamp("last_order_date"));
                return stats;
            }
        }
    }
    return null;
}
}