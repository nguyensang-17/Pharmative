package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet lưu thông tin đơn hàng tạm thời vào session
 * trước khi chuyển hướng đến VNPay
 */
@WebServlet("/saveOrderInfo")
public class SaveOrderInfoController extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        
        HttpSession session = request.getSession();
        
        try {
            // Lấy thông tin từ form
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String note = request.getParameter("note");
            String paymentMethod = request.getParameter("paymentMethod");
            
            // Validate
            if (fullName == null || email == null || phone == null || address == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"status\":\"error\",\"message\":\"Missing required fields\"}");
                return;
            }
            
            // Lưu thông tin vào session
            session.setAttribute("checkout_fullName", fullName);
            session.setAttribute("checkout_email", email);
            session.setAttribute("checkout_phone", phone);
            session.setAttribute("checkout_address", address);
            session.setAttribute("checkout_note", note != null ? note : "");
            session.setAttribute("checkout_paymentMethod", paymentMethod);
            
            // Verify
            String savedName = (String) session.getAttribute("checkout_fullName");
            if (savedName == null || !savedName.equals(fullName)) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"status\":\"error\",\"message\":\"Failed to save to session\"}");
                return;
            }
            
            // Success
            response.getWriter().write("{\"status\":\"success\",\"message\":\"Checkout info saved\"}");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}");
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write("{\"status\":\"error\",\"message\":\"Use POST method\"}");
    }
}