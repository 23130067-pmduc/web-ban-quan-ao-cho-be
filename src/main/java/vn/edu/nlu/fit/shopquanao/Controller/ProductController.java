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

        // 1. Lấy danh sách sản phẩm từ Service
        List<Product> products = productService.getAllProducts();

        // 2. Debug nhanh (xóa khi chạy ổn)
        System.out.println("Số sản phẩm lấy được: " + products.size());

        // 3. Đẩy dữ liệu sang JSP
        request.setAttribute("products", products);

        // 4. Forward sang trang hiển thị
        request.getRequestDispatcher("/sanpham.jsp").forward(request, response);
    }
}
