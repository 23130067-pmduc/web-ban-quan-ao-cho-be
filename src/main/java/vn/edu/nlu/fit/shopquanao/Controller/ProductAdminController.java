package vn.edu.nlu.fit.shopquanao.Controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vn.edu.nlu.fit.shopquanao.Dao.CategoryDao;
import vn.edu.nlu.fit.shopquanao.Dao.ProductDao;
import vn.edu.nlu.fit.shopquanao.model.Category;
import vn.edu.nlu.fit.shopquanao.model.Product;

@WebServlet("/product-admin")
@MultipartConfig(
        maxFileSize = 10 * 1024 * 1024,      // 10MB
        maxRequestSize = 20 * 1024 * 1024    // 20MB
)
public class ProductAdminController extends HttpServlet {

    private final ProductDao productDao = new ProductDao();
    private final CategoryDao categoryDao = new CategoryDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String mode = req.getParameter("mode");
        String idParam = req.getParameter("id");

        /* ===== XỬ LÝ FORM: ADD / EDIT / VIEW ===== */
        if (mode != null) {
            List<Category> categories = categoryDao.findAll();
            req.setAttribute("categories", categories);
            req.setAttribute("mode", mode);

            if ("add".equals(mode)) {
                // Trang thêm mới
                req.getRequestDispatcher("/product-form.jsp").forward(req, resp);
                return;
            }

            if (idParam != null && ("edit".equals(mode) || "view".equals(mode))) {
                int id = Integer.parseInt(idParam);
                Product product = productDao.findById(id);
                req.setAttribute("product", product);
                req.getRequestDispatcher("/product-form.jsp").forward(req, resp);
                return;
            }
        }

        /* ===== AJAX XEM SẢN PHẨM (CHO MODAL - NẾU VẪN CẦN) ===== */
        String action = req.getParameter("action");
        if ("view".equals(action)) {
            int id = Integer.parseInt(idParam);
            Product p = productDao.findById(id);

            resp.setContentType("application/json;charset=UTF-8");
            PrintWriter out = resp.getWriter();

            out.print("{");
            out.print("\"id\":" + p.getId() + ",");
            out.print("\"name\":\"" + escape(p.getName()) + "\",");
            out.print("\"price\":" + p.getPrice() + ",");
            out.print("\"category_id\":" + p.getCategory_id() + ",");
            out.print("\"thumbnail\":\"" + escape(p.getThumbnail()) + "\",");
            out.print("\"categoryName\":\"" + escape(p.getCategoryName()) + "\",");
            out.print("\"status\":\"" + escape(p.getStatus()) + "\"");
            out.print("}");
            return;
        }

        /* ===== LOAD TRANG ADMIN ===== */
        // Phân trang
        int page = 1;
        int pageSize = 10;
        
        String pageParam = req.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        
        List<Product> allProducts = productDao.findAll();
        int totalProducts = allProducts.size();
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
        
        if (page < 1) page = 1;
        if (page > totalPages && totalPages > 0) page = totalPages;
        
        int start = (page - 1) * pageSize;
        int end = Math.min(start + pageSize, totalProducts);
        List<Product> products = allProducts.subList(start, end);

        req.setAttribute("products", products);
        req.setAttribute("totalProducts", totalProducts);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("pageSize", pageSize);
        req.setAttribute("activeProducts",
                allProducts.stream().filter(p -> "Đang bán".equals(p.getStatus())).count());
        req.setAttribute("inactiveProducts",
                allProducts.stream().filter(p -> !"Đang bán".equals(p.getStatus())).count());

        req.setAttribute("page", "product");
        req.getRequestDispatcher("/admin.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        String action = req.getParameter("action");

        switch (action) {
            case "search" -> {
                String kw = req.getParameter("keyword");
                req.setAttribute("products", productDao.searchByName(kw));
                req.setAttribute("page", "product");
                req.getRequestDispatcher("/admin.jsp").forward(req, resp);
                return;
            }
            case "add" -> {
                Product p = new Product();
                p.setName(req.getParameter("name"));
                p.setPrice(Double.parseDouble(req.getParameter("price")));
                p.setCategory_id(Integer.parseInt(req.getParameter("category_id")));
                
                // Xử lý file upload
                String imagePath = handleFileUpload(req, "imageFile");
                if (imagePath != null && !imagePath.isEmpty()) {
                    p.setThumbnail(imagePath);
                }
                
                p.setStatus(req.getParameter("status"));
                productDao.insert(p);
            }
            case "update" -> {
                Product p = new Product();
                p.setId(Integer.parseInt(req.getParameter("id")));
                p.setName(req.getParameter("name"));
                p.setPrice(Double.parseDouble(req.getParameter("price")));
                p.setCategory_id(Integer.parseInt(req.getParameter("category_id")));
                
                // Xử lý file upload mới hoặc giữ ảnh cũ
                String imagePath = handleFileUpload(req, "imageFile");
                if (imagePath != null && !imagePath.isEmpty()) {
                    p.setThumbnail(imagePath);
                } else {
                    // Giữ ảnh cũ
                    Product oldProduct = productDao.findById(p.getId());
                    if (oldProduct != null && oldProduct.getThumbnail() != null) {
                        p.setThumbnail(oldProduct.getThumbnail());
                    }
                }
                
                p.setStatus(req.getParameter("status"));
                productDao.update(p);
            }
            case "toggle-status" -> {
                int id = Integer.parseInt(req.getParameter("id"));
                Product p = productDao.findById(id);
                // Toggle giữa "Đang bán" và "Hết hàng"
                String newStatus = "Đang bán".equals(p.getStatus()) ? "Hết hàng" : "Đang bán";
                p.setStatus(newStatus);
                productDao.update(p);
            }
            case "delete" -> {
                productDao.softDelete(
                        Integer.parseInt(req.getParameter("id")));
            }
        }

        resp.sendRedirect(req.getContextPath() + "/product-admin");
    }

    private String handleFileUpload(HttpServletRequest req, String fieldName)
            throws IOException, ServletException {

        Part filePart = req.getPart(fieldName);
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }

        String fileName = filePart.getSubmittedFileName();
        if (fileName == null || fileName.isEmpty()) {
            return null;
        }

        // Lấy extension
        String extension = "";
        int lastDotIndex = fileName.lastIndexOf(".");
        if (lastDotIndex > 0) {
            extension = fileName.substring(lastDotIndex);
        }

        // Tạo tên file unique, loại bỏ ký tự đặc biệt
        String uniqueFileName = "product_" + System.currentTimeMillis() + extension;
        // Đảm bảo tên file chỉ chứa ký tự hợp lệ
        uniqueFileName = uniqueFileName.replaceAll("[^a-zA-Z0-9._-]", "_");

        // Lưu vào thư mục img
        String uploadPath = req.getServletContext().getRealPath("") + File.separator + "img";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String filePath = uploadPath + File.separator + uniqueFileName;
        filePart.write(filePath);

        return "img/" + uniqueFileName;
    }

    private String escape(String s) {
        return s == null ? "" : s.replace("\"", "\\\"");
    }
}