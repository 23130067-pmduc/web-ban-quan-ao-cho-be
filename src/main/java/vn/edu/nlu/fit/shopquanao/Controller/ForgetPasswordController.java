package vn.edu.nlu.fit.shopquanao.Controller;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.nlu.fit.shopquanao.Service.UserService;

@WebServlet(name = "ForgetPasswordController", value = "/fpcl")
public class ForgetPasswordController extends HttpServlet {

    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String email = request.getParameter("email");

        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập email");
            request.getRequestDispatcher("/forget.jsp").forward(request, response);
            return;
        }

        try {
            userService.sendOtpResetPassword(email);

            // sang trang nhập OTP
            response.sendRedirect("Verify.jsp?email=" + email + "&type=reset");

        } catch (RuntimeException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/forget.jsp").forward(request, response);
        }
    }
}