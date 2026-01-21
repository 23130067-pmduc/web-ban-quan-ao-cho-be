package vn.edu.nlu.fit.shopquanao.Controller.Cart;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.nlu.fit.shopquanao.Cart.Cart;
import vn.edu.nlu.fit.shopquanao.Dao.CartItemDao;

import java.io.IOException;

@WebServlet(name = "UpdateCart", value = "/update-cart")
public class UpdateCart extends HttpServlet {
    private CartItemDao cartItemDao;

    @Override
    public void init() {
        cartItemDao = new CartItemDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("cartId") == null) {
            response.sendRedirect("login");
            return;
        }

        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        int cartId = (Integer) session.getAttribute("cartId");

        if (quantity <= 0) {
            cartItemDao.delete(cartId, productId);
        } else {
            cartItemDao.updateQuantity(cartId, productId, quantity);
        }
        int cartSize = cartItemDao.countDistinctItems(cartId);
        session.setAttribute("cartSize", cartSize);

        response.sendRedirect("my-cart");
    }
}