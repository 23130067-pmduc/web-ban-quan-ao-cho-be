package vn.edu.nlu.fit.shopquanao.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.nlu.fit.shopquanao.Service.ProductService;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/trang-chu")

public class HomeController extends HttpServlet {
    private ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("latestProducts",
                productService.getLatestProducts(8));

        req.setAttribute("boyProducts",
                productService.getBoyProducts(8));

        req.setAttribute("girlProducts",
                productService.getGirlProducts(8));

        req.setAttribute("accessoryProducts",
                productService.getAccessoryProducts(8));

        req.getRequestDispatcher("trangchu.jsp").forward(req, resp);
    }
}
