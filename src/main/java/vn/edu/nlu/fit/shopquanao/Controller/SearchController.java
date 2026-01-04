package vn.edu.nlu.fit.shopquanao.Controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.nlu.fit.shopquanao.Dao.CategoryDao;
import vn.edu.nlu.fit.shopquanao.Service.ProductService;
import vn.edu.nlu.fit.shopquanao.model.Category;
import vn.edu.nlu.fit.shopquanao.model.Product;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "SearchController", value = "/SearchController")
public class SearchController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String keyword = request.getParameter("keyword");
        ProductService ps = new ProductService();
        List<Product> list = ps.searchProducts(keyword);
        request.setAttribute("list", list);
        CategoryDao cd = new CategoryDao();
        List<Category> danhMuc = cd.findAll();

        request.setAttribute("danhMuc", danhMuc);
        request.getRequestDispatcher("/search.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}