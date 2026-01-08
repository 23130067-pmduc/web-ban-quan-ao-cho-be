package vn.edu.nlu.fit.shopquanao.Controller.Cart;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.nlu.fit.shopquanao.Cart.Cart;

import java.io.IOException;

@WebServlet(name = "RemoveItem", value = "/del-item")
public class RemoveItem extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productID=Integer.parseInt(request.getParameter("productId"));
        Cart cart=(Cart)request.getSession().getAttribute("cart");
        if(cart==null){
            cart = new Cart();
            return;
        }
        cart.removeItem(productID);
        request.getSession().setAttribute("cart",cart);
        response.sendRedirect("my-cart");


    }
}