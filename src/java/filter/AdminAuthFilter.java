package filter;

import models.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * This filter intercepts all requests to the /admin/* path to ensure that
 * only authenticated administrators can access these pages.
 * If a non-admin user tries to access, they are redirected to the login page.
 */
@WebFilter("/admin/*")
public class AdminAuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // Get the current session, but don't create one if it doesn't exist.
        HttpSession session = httpRequest.getSession(false);

        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
        boolean isAdmin = false;

        if (isLoggedIn) {
            User user = (User) session.getAttribute("user");
            // Check if the logged-in user has the 'admin' role.
            if (user != null && "admin".equals(user.getRole())) {
                isAdmin = true;
            }
        }

        // If the user is an admin, allow the request to proceed to the target servlet.
        if (isAdmin) {
            chain.doFilter(request, response);
        } else {
            // If the user is not an admin, redirect them to the login page.
            // Add an error message to inform the user why they were redirected.
            System.out.println("Access Denied. Redirecting to login page.");
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp?error=accessDenied");
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code, if any.
    }

    @Override
    public void destroy() {
        // Cleanup code, if any.
    }
}
