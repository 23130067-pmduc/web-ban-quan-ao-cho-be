package vn.edu.nlu.fit.shopquanao.Controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.nlu.fit.shopquanao.Dao.CartDao;
import vn.edu.nlu.fit.shopquanao.Dao.CartItemDao;
import vn.edu.nlu.fit.shopquanao.Service.UserService;
import vn.edu.nlu.fit.shopquanao.model.User;

@WebServlet(name = "loginController", value = "/login")
public class loginController extends HttpServlet {

    private UserService userService;
    private CartDao cartDao;

    @Override
    public void init() {
        userService = new UserService();
        cartDao = new CartDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // 1. Validate
        if (username == null || password == null
                || username.trim().isEmpty()
                || password.trim().isEmpty()) {

            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // 2. Login
        User user = userService.login(username, password);

        // 3. Sai tài khoản / mật khẩu
        if (user == null) {
            request.setAttribute("error", "Tài khoản hoặc mật khẩu không đúng");
            request.setAttribute("username", username);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        if (user.getStatus() == null) {
            request.setAttribute("error", "Tài khoản chưa được kích hoạt");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }
        //Khóa block
        if ("BLOCKED".equalsIgnoreCase(user.getStatus())) {
            request.setAttribute("error", "Tài khoản đã bị khóa");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // 5. Check OTP
        if (user.getIsActive() == 0) {
            request.setAttribute("error", "Tài khoản chưa xác nhận OTP. Vui lòng kiểm tra email.");
            request.setAttribute("username", username);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        HttpSession oldSession = request.getSession(false);
        if (oldSession != null) {
            oldSession.invalidate();
        }

        HttpSession session = request.getSession(true);
        session.setAttribute("userId", user.getId());
        session.setAttribute("userlogin", user);

        Integer cartId = cartDao.findCartIdByUser(user.getId());
        if (cartId == null) {
            cartId = cartDao.createCart(user.getId());
        }
        session.setAttribute("cartId", cartId);
        int cartSize = new CartItemDao().countTotalQuantity(cartId);
        session.setAttribute("cartSize", cartSize);

        // Redirect based on role
        if ("admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/admin.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/trang-chu");
        }
    }
}
