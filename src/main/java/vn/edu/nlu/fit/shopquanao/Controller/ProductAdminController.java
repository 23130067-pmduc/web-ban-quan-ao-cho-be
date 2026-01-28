package vn.edu.nlu.fit.shopquanao.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.edu.nlu.fit.shopquanao.Dao.ProductDao;
import vn.edu.nlu.fit.shopquanao.model.Product;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/product-admin")
public class ProductAdminController extends HttpServlet {

    private final ProductDao productDao = new ProductDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        /* ===== AJAX XEM SẢN PHẨM ===== */
        if ("view".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            Product p = productDao.findById(id);

            resp.setContentType("application/json;charset=UTF-8");
            PrintWriter out = resp.getWriter();

            out.print("{");
            out.print("\"name\":\"" + escape(p.getName()) + "\",");
            out.print("\"price\":" + p.getPrice() + ",");
            out.print("\"thumbnail\":\"" + p.getThumbnail() + "\",");
            out.print("\"category\":\"" + escape(p.getCategoryName()) + "\",");
            out.print("\"status\":\"" + p.getStatus() + "\"");
            out.print("}");
            return;
        }

        /* ===== LOAD TRANG ADMIN ===== */
        List<Product> products = productDao.findAll();

        req.setAttribute("products", products);
        req.setAttribute("totalProducts", products.size());
        req.setAttribute("activeProducts",
                products.stream().filter(p -> "Đang bán".equals(p.getStatus())).count());
        req.setAttribute("inactiveProducts",
                products.stream().filter(p -> !"Đang bán".equals(p.getStatus())).count());

        req.setAttribute("page", "product");
        req.getRequestDispatcher("/admin.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        String action = req.getParameter("action");

        switch (action) {
            case "search" -> {
                String kw = req.getParameter("keyword");
                req.getSession().setAttribute("products",
                        productDao.searchByName(kw));
            }
            case "add" -> {
                Product p = new Product();
                p.setName(req.getParameter("name"));
                p.setPrice(Double.parseDouble(req.getParameter("price")));
                p.setCategory_id(Integer.parseInt(req.getParameter("category_id")));
                p.setThumbnail(req.getParameter("thumbnail"));
                productDao.insert(p);
            }
            case "update" -> {
                Product p = new Product();
                p.setId(Integer.parseInt(req.getParameter("id")));
                p.setName(req.getParameter("name"));
                p.setPrice(Double.parseDouble(req.getParameter("price")));
                p.setCategory_id(Integer.parseInt(req.getParameter("category_id")));
                p.setThumbnail(req.getParameter("thumbnail"));
                p.setStatus(req.getParameter("status"));
                productDao.update(p);
            }
            case "delete" -> {
                productDao.softDelete(
                        Integer.parseInt(req.getParameter("id")));
            }
        }

        resp.sendRedirect(req.getContextPath() + "/product-admin");
    }

    private String escape(String s) {
        return s == null ? "" : s.replace("\"", "\\\"");
    }
}
