package vn.edu.nlu.fit.shopquanao.Controller.Cart;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.nlu.fit.shopquanao.Dao.CartItemDao;
import vn.edu.nlu.fit.shopquanao.Service.ProductService;
import vn.edu.nlu.fit.shopquanao.model.Product;

@WebServlet(name = "AddCart", value = "/add-cart")
public class AddCart extends HttpServlet {

    private CartItemDao cartItemDao;

    @Override
    public void init() {
        cartItemDao = new CartItemDao();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        // Lấy giá khuyến mãi nếu có (từ trang khuyến mãi)
        String salePriceParam = request.getParameter("salePrice");
        Double salePrice = null;
        if (salePriceParam != null && !salePriceParam.isEmpty()) {
            try {
                salePrice = Double.parseDouble(salePriceParam);
            } catch (NumberFormatException e) {
                // Ignore
            }
        }

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("cartId") == null) {
            response.sendRedirect("login");
            return;
        }

        Integer cartId = (Integer) session.getAttribute("cartId");

        ProductService productService = new ProductService();
        Product product = productService.getProductById(productId);

        if(product!=null){
            // Nếu có giá khuyến mãi, ghi đè vào product
            if (salePrice != null) {
                product.setSale_price(salePrice);
            }

            double price = (salePrice != null) ? salePrice : product.getPrice();
            cartItemDao.addOrUpdate(cartId, productId, quantity, price);

            int cartSize = cartItemDao.countDistinctItems(cartId);
            session.setAttribute("cartSize", cartSize);

            // Kiểm tra nếu là AJAX request
            String ajaxHeader = request.getHeader("X-Requested-With");
            if ("XMLHttpRequest".equals(ajaxHeader)) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\":true,\"message\":\"Thêm vào giỏ hàng thành công!\",\"cartSize\":" + cartSize  + "}");
                return;
            }

            String referer = request.getHeader("Referer");
            response.sendRedirect(referer != null ? referer : "san-pham");
            return;
        }

        request.setAttribute("msg", "Product not found");
        request.getRequestDispatcher("trang_chu.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}