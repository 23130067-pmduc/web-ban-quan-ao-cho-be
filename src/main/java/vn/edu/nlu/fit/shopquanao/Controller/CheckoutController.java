//package vn.edu.nlu.fit.shopquanao.Controller;
//
//import jakarta.servlet.*;
//import jakarta.servlet.http.*;
//import jakarta.servlet.annotation.*;
//import vn.edu.nlu.fit.shopquanao.Cart.Cart;
//import vn.edu.nlu.fit.shopquanao.Cart.CartItem;
//import vn.edu.nlu.fit.shopquanao.Dao.CartItemDao;
//
//import java.io.IOException;
//import java.util.ArrayList;
//import java.util.List;
//
//@WebServlet(name = "CheckoutController", value = "/checkout")
//public class CheckoutController extends HttpServlet {
//
//    private CartItemDao cartItemDao;
//
//    @Override
//    public void init() {
//        cartItemDao = new CartItemDao();
//    }
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        HttpSession session = request.getSession();
//        Cart cart = (Cart) session.getAttribute("cart");
//
//        String ids = request.getParameter("selectedIds");
//        if (cart == null || ids == null || ids.isEmpty()) {
//            response.sendRedirect(request.getContextPath() + "/my-cart");
//            return;
//        }
//
//        String[] idArr = ids.split(",");
//        List<CartItem> checkoutItems = new ArrayList<>();
//
//        for (String idStr : idArr) {
//            int pid = Integer.parseInt(idStr);
//            CartItem item = cart.get(pid);
//            if (item != null) {
//                checkoutItems.add(item);
//            }
//        }
//
//        request.setAttribute("checkoutItems", checkoutItems);
//        request.getRequestDispatcher("thanhtoan.jsp").forward(request, response);
//    }
//
//
//
//}