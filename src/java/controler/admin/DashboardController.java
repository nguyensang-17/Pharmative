package controler.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/dashboard")
public class DashboardController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Gọi các DAO để lấy thống kê (tổng user, sản phẩm, đơn hàng, doanh thu)
        // Ví dụ: int userCount = userDAO.getUserCount();
        // request.setAttribute("userCount", userCount);
        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}