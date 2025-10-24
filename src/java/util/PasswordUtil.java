package util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {

    // Giữ nguyên tên hàm
    public static String hashPassword(String password) {
        if (password == null) return null;
        // BCrypt với cost 10 (khớp dữ liệu seed trong db.sql)
        return BCrypt.hashpw(password, BCrypt.gensalt(10));
    }

    // Giữ nguyên tên hàm
    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        if (plainPassword == null || hashedPassword == null) return false;
        // Hỗ trợ tương thích ngược: nếu hashedPassword trông như SHA-256 (không bắt đầu bằng $2a/$2b/..)
        // thì coi như không hợp lệ với BCrypt
        if (!hashedPassword.startsWith("$2a$") && !hashedPassword.startsWith("$2b$") && !hashedPassword.startsWith("$2y$")) {
            return false;
        }
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }
}