package controller;

import DAO.CustomerDao;
import models.Address;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "ProfileController", urlPatterns = {"/profile"})
public class ProfileController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final CustomerDao dao = new CustomerDao();

    // Lấy userId từ session (tạm gán 2 để test nếu chưa đăng nhập)
    private int getUserId(HttpServletRequest req) {
        Object uid = req.getSession().getAttribute("userId");
        return (uid == null) ? 2 : (int) uid;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int userId = getUserId(req);
        try {
            Map<String, Object> profile = dao.getProfile(userId);
            List<Address> addresses = dao.listAddresses(userId);

            req.setAttribute("profile", profile);
            req.setAttribute("addresses", addresses);
            req.getRequestDispatcher("/profile-customer.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        int userId = getUserId(req);
        String action = req.getParameter("action");

        try {
            if ("update-profile".equals(action)) {
                // form fields: full_name, phone
                String fullName = req.getParameter("full_name");
                String phone    = req.getParameter("phone");
                dao.updateProfile(userId, fullName, phone);
                req.setAttribute("msg", "Cập nhật hồ sơ thành công!");

            } else if ("add-address".equals(action)) {
                // form fields: recipient_name, recipient_phone, street_address, ward, district, city, is_default
                dao.addAddress(
                        userId,
                        req.getParameter("recipient_name"),
                        req.getParameter("recipient_phone"),
                        req.getParameter("street_address"),
                        req.getParameter("ward"),
                        req.getParameter("district"),
                        req.getParameter("city"),
                        "on".equals(req.getParameter("is_default"))
                );
                req.setAttribute("msg", "Đã thêm địa chỉ.");

            } else if ("set-default".equals(action)) {
                int addressId = Integer.parseInt(req.getParameter("address_id"));
                dao.setDefaultAddress(userId, addressId);
                req.setAttribute("msg", "Đã đặt địa chỉ mặc định.");

            } else if ("delete-address".equals(action)) {
                int addressId = Integer.parseInt(req.getParameter("address_id"));
                dao.deleteAddress(userId, addressId);
                req.setAttribute("msg", "Đã xóa địa chỉ.");

            } else {
                req.setAttribute("msg", "Hành động không hợp lệ.");
            }

            // load lại dữ liệu sau thao tác
            req.setAttribute("profile", dao.getProfile(userId));
            req.setAttribute("addresses", dao.listAddresses(userId));
            req.getRequestDispatcher("/profile-customer.jsp").forward(req, resp);

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
