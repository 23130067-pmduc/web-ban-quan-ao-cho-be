package vn.edu.nlu.fit.shopquanao.Controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import vn.edu.nlu.fit.shopquanao.Dao.*;
import vn.edu.nlu.fit.shopquanao.Cart.CartItem;
import vn.edu.nlu.fit.shopquanao.model.User;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "PlaceOrderController", value = "/place-order")
public class PlaceOrderController extends HttpServlet {

    private OrderDao orderDao;
    private OrderItemDao orderItemDao;
    private CartItemDao cartItemDao;
    private ProductVariantDao variantDao;

    @Override
    public void init() {
        orderDao = new OrderDao();
        orderItemDao = new OrderItemDao();
        cartItemDao = new CartItemDao();
        variantDao = new ProductVariantDao();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userlogin") == null) {
            response.sendRedirect("login");
            return;
        }

        User user = (User) session.getAttribute("userlogin");
        int cartId = (int) session.getAttribute("cartId");

        String receiverName = request.getParameter("receiverName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String note = request.getParameter("note");
        String paymentMethod = request.getParameter("paymentMethod");

        if (receiverName == null || phone == null || address == null) {
            response.sendRedirect("checkout");
            return;
        }

        List<CartItem> cartItems = cartItemDao.getByCartId(cartId);
        if (cartItems.isEmpty()) {
            response.sendRedirect("my-cart");
            return;
        }

        double totalPrice = 0;
        for (CartItem item : cartItems) {
            totalPrice += item.getPrice() * item.getQuantity();
        }

        int orderId = orderDao.createOrder(
                user.getId(),
                receiverName,
                phone,
                address,
                note,
                paymentMethod,
                totalPrice
        );

        for (CartItem item : cartItems) {
            int variantId = item.getVariantId();
            int qty = item.getQuantity();
            double price = item.getPrice();

            orderItemDao.insert(
                    orderId,
                    variantId,
                    item.getProduct().getName(),
                    item.getSize(),
                    item.getColor(),
                    qty,
                    price,
                    price * qty
            );

            variantDao.decreaseStock(variantId, qty);
        }

        cartItemDao.clearCart(cartId);
        session.setAttribute("cartSize", 0);

        response.sendRedirect("thanhtoanthanhcong.jsp");
    }
}