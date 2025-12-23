package vn.edu.nlu.fit.shopquanao.Controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.nlu.fit.shopquanao.Service.UserService;
import vn.edu.nlu.fit.shopquanao.Service.EmailService;

@WebServlet(name = "OtpController", value = "/otp")
public class OtpController extends HttpServlet {

    private UserService userService;

    @Override
    public void init() {
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/otplogin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String otp = request.getParameter("otp");

        boolean ok = userService.verifyOtp(email, otp);
        if (ok) {
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            request.setAttribute("error", "OTP sai hoặc đã hết hạn");
            request.getRequestDispatcher("/otplogin.jsp").forward(request, response);
        }
    }
}