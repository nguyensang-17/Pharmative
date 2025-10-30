package controller.admin;

import DAO.UserDAO;
import models.User;
import models.UserStatistics;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/users", "/admin/users/*"})
public class UserManagementController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserDAO userDAO = new UserDAO();
    private static final int PAGE_SIZE = 10;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // ====== KIỂM TRA QUYỀN ADMIN ======
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User currentUser = (User) session.getAttribute("currentUser");
        if (!"admin".equals(currentUser.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, 
                "Bạn không có quyền truy cập trang này!");
            return;
        }
        
        // ====== ROUTING ======
        String pathInfo = request.getPathInfo();
        
        try {
            if (pathInfo == null || pathInfo.equals("/") || pathInfo.equals("/list")) {
                listUsers(request, response);
            } 
            else if (pathInfo.equals("/view")) {
                viewUser(request, response);
            } 
            else if (pathInfo.equals("/edit")) {
                showEditForm(request, response);
            } 
            else if (pathInfo.equals("/toggle-status")) {
                toggleUserStatus(request, response);
            } 
            else if (pathInfo.equals("/delete")) {
                deleteUser(request, response);
            } 
            else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Lỗi database: " + e.getMessage(), e);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String pathInfo = request.getPathInfo();
        
        try {
            if (pathInfo != null && pathInfo.equals("/update")) {
                updateUser(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Lỗi database: " + e.getMessage(), e);
        }
    }
    
    // ========== 1. DANH SÁCH USERS ==========
    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        
        // Lấy tham số phân trang
        int page = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        
        // Lấy tham số tìm kiếm & lọc
        String keyword = request.getParameter("keyword");
        String roleFilter = request.getParameter("role");
        
        List<User> users;
        int totalUsers;
        
        // Xử lý theo điều kiện
        if (keyword != null && !keyword.trim().isEmpty()) {
            // TÌM KIẾM
            users = userDAO.searchUsers(keyword.trim(), page, PAGE_SIZE);
            totalUsers = userDAO.countSearchResults(keyword.trim());
            request.setAttribute("keyword", keyword.trim());
        } 
        else if (roleFilter != null && !roleFilter.isEmpty() && 
                 (roleFilter.equals("customer") || roleFilter.equals("admin"))) {
            // LỌC THEO ROLE
            users = userDAO.getUsersByRole(roleFilter, page, PAGE_SIZE);
            totalUsers = userDAO.countUsersByRole(roleFilter);
            request.setAttribute("roleFilter", roleFilter);
        } 
        else {
            // TẤT CẢ USERS
            users = userDAO.getAllUsers(page, PAGE_SIZE);
            totalUsers = userDAO.getTotalUsers();
        }
        
        // Tính tổng số trang
        int totalPages = (int) Math.ceil((double) totalUsers / PAGE_SIZE);
        if (totalPages < 1) totalPages = 1;
        
        // Lấy thống kê
        int totalCustomers = userDAO.countUsersByRole("customer");
        int totalAdmins = userDAO.countUsersByRole("admin");
        int newUsersThisMonth = userDAO.countNewUsersThisMonth();
        
        // Set attributes
        request.setAttribute("users", users);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalCustomers", totalCustomers);
        request.setAttribute("totalAdmins", totalAdmins);
        request.setAttribute("newUsersThisMonth", newUsersThisMonth);
        
        // Forward đến JSP
        request.getRequestDispatcher("/admin/users/list.jsp")
               .forward(request, response);
    }
    
    // ========== 2. XEM CHI TIẾT USER ==========
    private void viewUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        
        String userIdParam = request.getParameter("id");
        
        if (userIdParam == null || userIdParam.isEmpty()) {
            request.getSession().setAttribute("error", "Thiếu ID người dùng!");
            response.sendRedirect(request.getContextPath() + "/admin/users/list");
            return;
        }
        
        try {
            int userId = Integer.parseInt(userIdParam);
            User user = userDAO.getUserById(userId);
            
            if (user == null) {
                request.getSession().setAttribute("error", "Không tìm thấy người dùng!");
                response.sendRedirect(request.getContextPath() + "/admin/users/list");
                return;
            }
            
            // Lấy thống kê của user (nếu có method)
            try {
                UserStatistics stats = userDAO.getUserStatistics(userId);
                request.setAttribute("stats", stats);
            } catch (Exception e) {
                // Nếu chưa có method getUserStatistics thì bỏ qua
                System.out.println("Chưa có thống kê user: " + e.getMessage());
            }
            
            request.setAttribute("user", user);
            request.getRequestDispatcher("/admin/users/view.jsp")
                   .forward(request, response);
                   
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "ID không hợp lệ!");
            response.sendRedirect(request.getContextPath() + "/admin/users/list");
        }
    }
    
    // ========== 3. HIỂN THỊ FORM CHỈNH SỬA ==========
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        
        String userIdParam = request.getParameter("id");
        
        if (userIdParam == null || userIdParam.isEmpty()) {
            request.getSession().setAttribute("error", "Thiếu ID người dùng!");
            response.sendRedirect(request.getContextPath() + "/admin/users/list");
            return;
        }
        
        try {
            int userId = Integer.parseInt(userIdParam);
            User user = userDAO.getUserById(userId);
            
            if (user == null) {
                request.getSession().setAttribute("error", "Không tìm thấy người dùng!");
                response.sendRedirect(request.getContextPath() + "/admin/users/list");
                return;
            }
            
            request.setAttribute("user", user);
            request.getRequestDispatcher("/admin/users/edit.jsp")
                   .forward(request, response);
                   
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "ID không hợp lệ!");
            response.sendRedirect(request.getContextPath() + "/admin/users/list");
        }
    }
    
    // ========== 4. CẬP NHẬT USER ==========
    private void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        
        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            
            // Kiểm tra email trùng (nếu có method isEmailExist)
            String newEmail = request.getParameter("email");
            try {
                if (userDAO.isEmailExist(newEmail, userId)) {
                    request.getSession().setAttribute("error", 
                        "Email " + newEmail + " đã được sử dụng bởi tài khoản khác!");
                    response.sendRedirect(request.getContextPath() + "/admin/users/edit?id=" + userId);
                    return;
                }
            } catch (Exception e) {
                // Nếu chưa có method isEmailExist thì bỏ qua
            }
            
            // Tạo user object
            User user = new User();
            user.setId(userId);
            user.setFullname(request.getParameter("fullname"));
            user.setEmail(newEmail);
            
            String phone = request.getParameter("phoneNumber");
            user.setPhoneNumber(phone != null && !phone.trim().isEmpty() ? phone.trim() : null);
            
            user.setRole(request.getParameter("role"));
            
            // Checkbox: nếu checked thì value = "on"
            boolean isVerified = "on".equals(request.getParameter("isVerified"));
            user.setVerified(isVerified);
            
            // Update
            boolean success = false;
            try {
                success = userDAO.updateUserByAdmin(user);
            } catch (Exception e) {
                // Nếu chưa có updateUserByAdmin, dùng updateUser
                success = userDAO.updateUser(user);
            }
            
            if (success) {
                request.getSession().setAttribute("message", 
                    "✅ Cập nhật thông tin người dùng thành công!");
                response.sendRedirect(request.getContextPath() + "/admin/users/view?id=" + userId);
            } else {
                request.getSession().setAttribute("error", 
                    "❌ Không thể cập nhật thông tin người dùng!");
                response.sendRedirect(request.getContextPath() + "/admin/users/edit?id=" + userId);
            }
            
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "Dữ liệu không hợp lệ!");
            response.sendRedirect(request.getContextPath() + "/admin/users/list");
        }
    }
    
    // ========== 5. KHÓA/MỞ KHÓA USER ==========
    private void toggleUserStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        
        String userIdParam = request.getParameter("id");
        
        if (userIdParam == null || userIdParam.isEmpty()) {
            request.getSession().setAttribute("error", "Thiếu ID người dùng!");
            response.sendRedirect(request.getContextPath() + "/admin/users/list");
            return;
        }
        
        try {
            int userId = Integer.parseInt(userIdParam);
            
            // Không cho toggle chính mình
            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("currentUser");
            if (currentUser.getId() == userId) {
                session.setAttribute("error", 
                    "⚠️ Không thể thay đổi trạng thái của chính mình!");
                response.sendRedirect(request.getContextPath() + "/admin/users/list");
                return;
            }
            
            boolean success = userDAO.toggleUserStatus(userId);
            
            if (success) {
                request.getSession().setAttribute("message", 
                    "✅ Đã thay đổi trạng thái xác thực của người dùng!");
            } else {
                request.getSession().setAttribute("error", 
                    "❌ Không thể thay đổi trạng thái!");
            }
            
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "ID không hợp lệ!");
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/users/list");
    }
    
    // ========== 6. XÓA USER ==========
    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        
        String userIdParam = request.getParameter("id");
        
        if (userIdParam == null || userIdParam.isEmpty()) {
            request.getSession().setAttribute("error", "Thiếu ID người dùng!");
            response.sendRedirect(request.getContextPath() + "/admin/users/list");
            return;
        }
        
        try {
            int userId = Integer.parseInt(userIdParam);
            
            // Không cho xóa chính mình
            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("currentUser");
            if (currentUser.getId() == userId) {
                session.setAttribute("error", 
                    "⚠️ Không thể xóa tài khoản của chính mình!");
                response.sendRedirect(request.getContextPath() + "/admin/users/list");
                return;
            }
            
            // Kiểm tra xem user có phải admin không
            User userToDelete = userDAO.getUserById(userId);
            if (userToDelete != null && "admin".equals(userToDelete.getRole())) {
                int adminCount = userDAO.countUsersByRole("admin");
                if (adminCount <= 1) {
                    session.setAttribute("error", 
                        "⚠️ Không thể xóa admin duy nhất trong hệ thống!");
                    response.sendRedirect(request.getContextPath() + "/admin/users/list");
                    return;
                }
            }
            
            try {
                boolean success = userDAO.deleteUser(userId);
                
                if (success) {
                    session.setAttribute("message", 
                        "✅ Đã xóa người dùng thành công!");
                } else {
                    session.setAttribute("error", 
                        "❌ Không thể xóa người dùng!");
                }
            } catch (SQLException e) {
                // Foreign key constraint error
                session.setAttribute("error", 
                    "❌ Không thể xóa người dùng vì còn dữ liệu liên quan (đơn hàng, đánh giá...)");
            }
            
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "ID không hợp lệ!");
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/users/list");
    }
}
