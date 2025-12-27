package vn.edu.nlu.fit.shopquanao.Controller;

import vn.edu.nlu.fit.shopquanao.Service.ProductService;
import vn.edu.nlu.fit.shopquanao.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/san-pham")
public class ProductController extends HttpServlet {

    private ProductService productService;

    @Override
    public void init() {
        productService = new ProductService();
    }

    /**
     * Hiển thị danh sách sản phẩm
     * URL: /san-pham
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String group = request.getParameter("group");
        String category = request.getParameter("category");

        List<Product> products;
        Integer categoryId = null;
        if (category != null) {
            try{
                categoryId = Integer.parseInt(category);
            } catch (NumberFormatException e){}

        }
        // Ưu tiên lọc theo categoryID
        if (categoryId != null){
            products = productService.getProductsByCategory(categoryId);


            // Lọc theo group
        } else if ("betrai".equals(group)) {
            products = productService.getProductsByCategories(List.of(1, 2, 3, 9));
        } else if ("begai".equals(group)) {
            products = productService.getProductsByCategories(List.of(4, 5, 6, 7, 9));
        } else if ("phukien".equals(group)) {
            products = productService.getProductsByCategories(List.of(8, 10));

        } else {
            products = productService.getAllProducts();
        }

        request.setAttribute("list", products);
        request.getRequestDispatcher("/sanpham.jsp").forward(request, response);

    }
}
