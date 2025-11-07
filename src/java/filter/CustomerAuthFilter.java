package filter;

import models.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter({"/account/*", "/change-password", "/order-history", "/checkout", "/cart"})
public class CustomerAuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        System.out.println("=== CUSTOMER AUTH FILTER ===");
        System.out.println("Requested URI: " + httpRequest.getRequestURI());

        HttpSession session = httpRequest.getSession(false);

        System.out.println("Session exists: " + (session != null));
        if (session != null) {
            System.out.println("Session ID: " + session.getId());
        }

        boolean isLoggedIn = (session != null && session.getAttribute("currentUser") != null);
        boolean isCustomer = false;

        if (isLoggedIn) {
            User user = (User) session.getAttribute("currentUser");

            if (user != null) {
                System.out.println("User found in session:");
                System.out.println("  - ID: " + user.getId());
                System.out.println("  - Email: " + user.getEmail());
                System.out.println("  - Role: " + user.getRole());

                // Check if the logged-in user has the 'customer' role
                if ("customer".equalsIgnoreCase(user.getRole())) {
                    isCustomer = true;
                    System.out.println("✓ User is customer - access granted");
                } else {
                    System.out.println("✗ User is not customer - role: " + user.getRole());
                }
            } else {
                System.out.println("✗ User object is null in session");
            }
        } else {
            System.out.println("✗ User not logged in");
        }

        if (isCustomer) {
            System.out.println("✓ Forwarding to: " + httpRequest.getRequestURI());
            chain.doFilter(request, response);
        } else {
            System.out.println("Access Denied. Redirecting to login page.");
            // Lưu URL hiện tại để redirect sau khi login
            if (session != null) {
                session.setAttribute("redirectAfterLogin", httpRequest.getRequestURI());
            }
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp?error=accessDenied");
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("CustomerAuthFilter initialized");
    }

    @Override
    public void destroy() {
        System.out.println("CustomerAuthFilter destroyed");
    }
}