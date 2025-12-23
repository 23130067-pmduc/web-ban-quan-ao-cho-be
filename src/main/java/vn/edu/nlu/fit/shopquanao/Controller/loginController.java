package vn.edu.nlu.fit.shopquanao.Controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.nlu.fit.shopquanao.Service.UserService;
import vn.edu.nlu.fit.shopquanao.model.User;

@WebServlet(name = "loginController", value = "/login")
public class loginController extends HttpServlet {

    private UserService userService;

    @Override
    public void init() {
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // validate
        if (username == null || password == null || username.isEmpty() || password.isEmpty()) {

            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        User user = userService.login(username, password);

        if (user == null) {
            request.setAttribute("error", "Tài khoản hoặc mật khẩu không đúng");
            request.setAttribute("username", username);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        if (user.getIsActive() == 0) {
            request.setAttribute("error", "Tài khoản chưa xác nhận OTP. Vui lòng kiểm tra email.");
            request.setAttribute("username", username);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // reset session
        HttpSession oldSession = request.getSession(false);
        if (oldSession != null) oldSession.invalidate();

        HttpSession session = request.getSession(true);
        session.setAttribute("userlogin", user);

        if ("admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/admin.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/index_login.jsp");
        }
    }
}