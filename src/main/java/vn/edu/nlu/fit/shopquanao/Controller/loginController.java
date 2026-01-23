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

        // ===== VALIDATE =====
        if (username == null || password == null
                || username.trim().isEmpty()
                || password.trim().isEmpty()) {

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

        // ===== RESET SESSION CŨ =====
        HttpSession oldSession = request.getSession(false);
        if (oldSession != null) {
            oldSession.invalidate();
        }

        // ===== TẠO SESSION MỚI (QUAN TRỌNG) =====
        HttpSession session = request.getSession(true);

        // 🔥 BẮT BUỘC: LƯU userId
        session.setAttribute("userId", user.getId());

        // giữ user object cho profile, header
        session.setAttribute("userlogin", user);

        // ====== CART LOGIC ======
        Integer cartId = cartDao.findCartIdByUser(user.getId());
        if (cartId == null) {
            cartId = cartDao.createCart(user.getId());
        }
        session.setAttribute("cartId", cartId);

        int cartSize = new CartItemDao().countDistinctItems(cartId);
        session.setAttribute("cartSize", cartSize);

        // ===== REDIRECT =====
        if ("admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/admin.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/trang-chu");
        }
    }
}
