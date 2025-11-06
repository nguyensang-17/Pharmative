package controller.admin;

import DAO.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Order;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet("/admin/orders/export")
public class ExportOrdersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("=== Bắt đầu xuất file CSV ===");
        
        try {
            // Lấy danh sách orders từ DAO
            List<Order> orders = orderDAO.getAllOrders();
            System.out.println("Số lượng orders để export: " + orders.size());
            
            // Thiết lập response cho file CSV
            response.setContentType("text/csv; charset=UTF-8");
            response.setCharacterEncoding("UTF-8");
            response.setHeader("Content-Disposition", 
                "attachment; filename=\"danh_sach_don_hang_" + System.currentTimeMillis() + ".csv\"");
            
            PrintWriter writer = response.getWriter();
            
            // Viết header CSV với BOM để hỗ trợ UTF-8 (giúp Excel hiển thị tiếng Việt)
            writer.write("\uFEFF"); // UTF-8 BOM
            writer.println("Mã đơn hàng,Khách hàng,Ngày đặt,Tổng tiền (VNĐ),Trạng thái,Địa chỉ giao hàng");
            
            // Định dạng ngày tháng
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
            
            // Viết dữ liệu từng dòng
            int count = 0;
            for (Order order : orders) {
                String line = String.join(",",
                    String.valueOf(order.getOrderId()),
                    escapeCsv(order.getCustomerName() != null ? order.getCustomerName() : "Khách hàng #" + order.getUserId()),
                    order.getOrderDate() != null ? dateFormat.format(order.getOrderDate()) : "",
                    order.getTotalAmount() != null ? order.getTotalAmount().toString() : "0",
                    escapeCsv(getStatusText(order.getStatus())),
                    escapeCsv(order.getShippingAddress() != null ? order.getShippingAddress() : "")
                );
                writer.println(line);
                count++;
            }
            
            writer.flush();
            System.out.println("=== Xuất file CSV thành công: " + count + " dòng ===");
            
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("=== Lỗi khi xuất file CSV: " + e.getMessage() + " ===");
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi xuất dữ liệu: " + e.getMessage());
        }
    }
    
    /**
     * Escape giá trị CSV - thêm dấu ngoặc kép nếu có dấu phẩy hoặc dấu ngoặc kép
     */
    private String escapeCsv(String value) {
        if (value == null) return "";
        
        // Nếu có dấu phẩy, xuống dòng, dấu ngoặc kép, hoặc khoảng trắng ở đầu/cuối
        if (value.contains(",") || value.contains("\"") || value.contains("\n") || 
            value.startsWith(" ") || value.endsWith(" ")) {
            // Thay thế " bằng "" (theo chuẩn CSV)
            return "\"" + value.replace("\"", "\"\"") + "\"";
        }
        return value;
    }
    
    /**
     * Chuyển đổi status code thành text tiếng Việt
     */
    private String getStatusText(String status) {
        if (status == null) return "Không xác định";
        
        switch (status.toUpperCase()) {
            case "PENDING":
                return "Chờ xử lý";
            case "PROCESSING":
                return "Đang xử lý";
            case "DELIVERED":
                return "Đã giao";
            case "CANCELLED":
                return "Đã hủy";
            default:
                return status;
        }
    }
}