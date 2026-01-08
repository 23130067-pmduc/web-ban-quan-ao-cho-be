package vn.edu.nlu.fit.shopquanao.Controller.Cart;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.nlu.fit.shopquanao.Cart.Cart;
import vn.edu.nlu.fit.shopquanao.Service.ProductService;
import vn.edu.nlu.fit.shopquanao.model.Product;

import java.io.IOException;

@WebServlet(name = "AddCart", value = "/add-cart")
public class AddCart extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        HttpSession session = request.getSession();
        Cart cart = (Cart)session.getAttribute("cart");
        if(cart==null){
            cart = new Cart();
        }
        ProductService productService = new ProductService();
        Product product = productService.getProductById(productId);
        if(product!=null){
            cart.addItem(product,quantity);
            session.setAttribute("cart",cart);
            response.sendRedirect("san-pham");
            return;
        }

        request.setAttribute("msg", "Không tìm sản phầm");
        request.getRequestDispatcher("trang_chu.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}