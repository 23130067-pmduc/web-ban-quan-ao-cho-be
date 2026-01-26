package vn.edu.nlu.fit.shopquanao.Controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.nlu.fit.shopquanao.Dao.CartItemDao;
import vn.edu.nlu.fit.shopquanao.Cart.CartItem;
import vn.edu.nlu.fit.shopquanao.Dao.OrderDao;
import vn.edu.nlu.fit.shopquanao.Dao.OrderItemDao;
import vn.edu.nlu.fit.shopquanao.model.User;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "CheckoutController", value = "/checkout")
public class CheckoutController extends HttpServlet {

    private CartItemDao cartItemDao;

    @Override
    public void init() {
        cartItemDao = new CartItemDao();
    }



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("userlogin");

        if (user == null) {
            resp.sendRedirect("login");
            return;
        }

        int cartId = (int) session.getAttribute("cartId");

        List<CartItem> items = cartItemDao.getByCartId(cartId);
        if (items.isEmpty()) {
            resp.sendRedirect("my-cart");
            return;
        }

        req.setAttribute("checkoutItems", items);
        req.getRequestDispatcher("thanhtoan.jsp").forward(req, resp);
    }
}