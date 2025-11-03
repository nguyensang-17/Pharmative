package filter;

import models.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/admin/*")
public class AdminAuthFilter implements Filter {
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        // ✅ DEBUG: In ra thông tin request
        System.out.println("=== ADMIN AUTH FILTER ===");
        System.out.println("Requested URI: " + httpRequest.getRequestURI());
        
        // Get the current session, but don't create one if it doesn't exist
        HttpSession session = httpRequest.getSession(false);
        
        // ✅ DEBUG: Kiểm tra session
        System.out.println("Session exists: " + (session != null));
        if (session != null) {
            System.out.println("Session ID: " + session.getId());
        }
        
        boolean isLoggedIn = (session != null && session.getAttribute("currentUser") != null); // ✅ ĐỔI TỪ "user" THÀNH "currentUser"
        boolean isAdmin = false;
        
        if (isLoggedIn) {
            User user = (User) session.getAttribute("currentUser"); // ✅ ĐỔI TỪ "user" THÀNH "currentUser"
            
            // ✅ DEBUG: In thông tin user
            if (user != null) {
                System.out.println("User found in session:");
                System.out.println("  - ID: " + user.getId());
                System.out.println("  - Email: " + user.getEmail());
                System.out.println("  - Role: " + user.getRole());
                
                // Check if the logged-in user has the 'admin' role
                if ("admin".equalsIgnoreCase(user.getRole())) { // ✅ Thêm equalsIgnoreCase để an toàn
                    isAdmin = true;
                    System.out.println("✓ User is admin - access granted");
                } else {
                    System.out.println("✗ User is not admin - role: " + user.getRole());
                }
            } else {
                System.out.println("✗ User object is null in session");
            }
        } else {
            System.out.println("✗ User not logged in");
        }
        
        // If the user is an admin, allow the request to proceed
        if (isAdmin) {
            // Thêm vào AdminAuthFilter, trước khi chain.doFilter
System.out.println("✓ Forwarding to: " + httpRequest.getRequestURI());
            chain.doFilter(request, response);
        } else {
            // If the user is not an admin, redirect to login page
            System.out.println("Access Denied. Redirecting to login page.");
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp?error=accessDenied");
        }
    }
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("AdminAuthFilter initialized");
    }
    
    @Override
    public void destroy() {
        System.out.println("AdminAuthFilter destroyed");
    }
}