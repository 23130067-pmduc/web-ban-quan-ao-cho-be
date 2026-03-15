package vn.edu.nlu.fit.shopquanao.Controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.nlu.fit.shopquanao.Service.UserService;

@WebServlet(name = "RegisterController", value = "/register")
public class RegisterController extends HttpServlet {

    private UserService userService;

    @Override
    public void init() {
        userService = new UserService();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String repassword = request.getParameter("repassword");

        // 1. Validate rỗng
        if (username == null || email == null ||
                password == null || repassword == null ||
                username.isEmpty() || email.isEmpty() ||
                password.isEmpty() || repassword.isEmpty()) {

            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // 2. Check password match
        if (!password.equals(repassword)) {
            request.setAttribute("error", "Mật khẩu nhập lại không khớp");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        try {
            // 3. Gửi OTP (INSERT hoặc UPDATE)
            userService.registerSendOtp(username, email, password);

            // 4. Chuyển sang trang nhập OTP
            response.sendRedirect(
                    request.getContextPath() + "/otp?email=" + email
            );

        } catch (RuntimeException e) {
            // Email đã tồn tại & active
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }

    }
}