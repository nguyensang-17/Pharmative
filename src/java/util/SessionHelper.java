package util;

import jakarta.servlet.http.HttpSession;
import models.User;

/**
 * Helper class để quản lý session
 */
public class SessionHelper {
    
    /**
     * Lấy user từ session, thử nhiều tên attribute
     * @param session HttpSession
     * @return User object hoặc null
     */
    public static User getCurrentUser(HttpSession session) {
        if (session == null) {
            return null;
        }
        
        // Thử các tên attribute phổ biến
        User user = (User) session.getAttribute("user");
        if (user != null) {
            return user;
        }
        
        user = (User) session.getAttribute("currentUser");
        if (user != null) {
            return user;
        }
        
        user = (User) session.getAttribute("loggedUser");
        if (user != null) {
            return user;
        }
        
        return null;
    }
    
    /**
     * Set user vào session
     * @param session HttpSession
     * @param user User object
     */
    public static void setCurrentUser(HttpSession session, User user) {
        if (session != null) {
            session.setAttribute("user", user);
            session.setAttribute("currentUser", user); // Đảm bảo tương thích
        }
    }
    
    /**
     * Xóa user khỏi session (logout)
     * @param session HttpSession
     */
    public static void removeCurrentUser(HttpSession session) {
        if (session != null) {
            session.removeAttribute("user");
            session.removeAttribute("currentUser");
            session.removeAttribute("loggedUser");
        }
    }
    
    /**
     * Kiểm tra user đã đăng nhập chưa
     * @param session HttpSession
     * @return true nếu đã đăng nhập
     */
    public static boolean isLoggedIn(HttpSession session) {
        return getCurrentUser(session) != null;
    }
    
    /**
     * Debug: In ra tất cả attributes trong session
     * @param session HttpSession
     */
    public static void debugSession(HttpSession session) {
        if (session == null) {
            System.out.println("[Session] Session is null");
            return;
        }
        
        System.out.println("[Session] Session ID: " + session.getId());
        System.out.println("[Session] Attributes:");
        
        java.util.Enumeration<String> attrs = session.getAttributeNames();
        while (attrs.hasMoreElements()) {
            String name = attrs.nextElement();
            Object value = session.getAttribute(name);
            System.out.println("  - " + name + " = " + value + 
                             " (type: " + (value != null ? value.getClass().getSimpleName() : "null") + ")");
        }
    }
}