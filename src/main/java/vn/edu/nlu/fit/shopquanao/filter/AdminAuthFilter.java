package vn.edu.nlu.fit.shopquanao.filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.nlu.fit.shopquanao.model.User;

/**
 * Filter để kiểm tra đăng nhập và quyền admin
 * Áp dụng cho tất cả các URL admin
 */
@WebFilter(urlPatterns = {
        "/product-admin",
        "/category-admin",
        "/user-admin",
        "/order-admin",
        "/banner-admin",
        "/contact-admin",
        "/dashboard",
        "/admin.jsp",
        "/product-form.jsp",
        "/category-form.jsp",
        "/user-form.jsp"
})
public class AdminAuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Khởi tạo filter nếu cần
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        // Lấy session
        HttpSession session = req.getSession(false);

        // Kiểm tra đã đăng nhập chưa
        if (session == null || session.getAttribute("userlogin") == null) {
            // Chưa đăng nhập -> chuyển về trang login
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=require_login&redirect=admin");
            return;
        }

        // Lấy thông tin user từ session
        User user = (User) session.getAttribute("userlogin");

        // Kiểm tra role có phải admin không
        if (!"admin".equalsIgnoreCase(user.getRole())) {
            // Không phải admin -> từ chối truy cập
            resp.sendRedirect(req.getContextPath() + "/access-denied.jsp");
            return;
        }

        // Đã đăng nhập và là admin -> cho phép truy cập
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Dọn dẹp tài nguyên nếu cần
    }
}
