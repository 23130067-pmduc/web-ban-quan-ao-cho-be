package vn.edu.nlu.fit.shopquanao.Controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.nlu.fit.shopquanao.Service.ProductService;
import vn.edu.nlu.fit.shopquanao.Service.ReviewService;
import vn.edu.nlu.fit.shopquanao.model.Product;
import vn.edu.nlu.fit.shopquanao.model.Review;

import java.io.IOException;
import java.util.List;

@WebServlet("/chi-tiet-san-pham")
public class ProductDetailController extends HttpServlet {

    private ProductService productService;
    private ReviewService reviewService;

    @Override
    public void init()  {

        productService = new ProductService();
        reviewService = new ReviewService();
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idRaw = request.getParameter("id");

        if(idRaw == null){
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        int id = Integer.parseInt(idRaw);
        Product product = productService.getProductById(id);

        if(product == null){
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        List<Review> reviews = reviewService.getReviewByProductID(id);


        request.setAttribute("product", product);
        request.setAttribute("reviews",reviews);
        request.getRequestDispatcher("/pageatxl.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}