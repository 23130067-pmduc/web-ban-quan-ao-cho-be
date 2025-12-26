package vn.edu.nlu.fit.shopquanao.Controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.nlu.fit.shopquanao.Service.ProductService;
import vn.edu.nlu.fit.shopquanao.model.Product;

@WebServlet(name = "ListProduct", value = "/list-product")
public class ListProduct extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductService ps = new ProductService();
        // Lấy toàn bộ sản phẩm (chỉ sản phẩm ACTIVE)
        List<Product> list = ps.getAllProducts();
        
        // DEBUG: Kiểm tra dữ liệu
        System.out.println("========================================");
        System.out.println("DEBUG - ListProduct Controller");
        System.out.println("Số lượng sản phẩm: " + (list != null ? list.size() : "NULL"));
        if (list != null && !list.isEmpty()) {
            System.out.println("Sản phẩm đầu tiên:");
            Product first = list.get(0);
            System.out.println("  - ID: " + first.getId());
            System.out.println("  - Tên: " + first.getName());
            System.out.println("  - Giá: " + first.getPrice());
            System.out.println("  - Status: " + first.getStatus());
        } else {
            System.out.println("CẢNH BÁO: List sản phẩm TRỐNG hoặc NULL!");
        }
        System.out.println("========================================");
        
        // Đặt attribute name trùng với JSP đang sử dụng (${list})
        request.setAttribute("list", list);
        request.getRequestDispatcher("/sanpham.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Gọi lại doGet để xử lý POST giống GET (nếu cần)
        doGet(request, response);
    }
}