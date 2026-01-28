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
import vn.edu.nlu.fit.shopquanao.model.Category;

@WebServlet("/category-admin")
@MultipartConfig(
        maxFileSize = 10 * 1024 * 1024,      // 10MB
        maxRequestSize = 20 * 1024 * 1024    // 20MB
)
public class CategoryAdminController extends HttpServlet {

    private final CategoryDao categoryDao = new CategoryDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String mode = req.getParameter("mode");
        String idParam = req.getParameter("id");

        /* ===== XỬ LÝ FORM: ADD / EDIT / VIEW ===== */
        if (mode != null) {
            req.setAttribute("mode", mode);

            if ("add".equals(mode)) {
                // Trang thêm mới
                req.getRequestDispatcher("/category-form.jsp").forward(req, resp);
                return;
            }

            if (idParam != null && ("edit".equals(mode) || "view".equals(mode))) {
                int id = Integer.parseInt(idParam);
                Category category = categoryDao.findById(id);
                req.setAttribute("category", category);
                req.getRequestDispatcher("/category-form.jsp").forward(req, resp);
                return;
            }
        }

        /* ===== AJAX: XEM CHI TIẾT (CHO MODAL NẾU CẦN) ===== */
        String action = req.getParameter("action");
        if ("view".equals(action)) {
            int id = Integer.parseInt(idParam);
            Category c = categoryDao.findById(id);

            resp.setContentType("application/json;charset=UTF-8");
            PrintWriter out = resp.getWriter();

            out.print("{");
            out.print("\"id\":" + c.getId() + ",");
            out.print("\"name\":\"" + escape(c.getName()) + "\",");
            out.print("\"image\":\"" + (c.getImage() != null ? c.getImage() : "") + "\",");
            out.print("\"status\":\"" + c.getStatus() + "\"");
            out.print("}");
            return;
        }

        /* ===== LOAD TRANG QUẢN LÝ DANH MỤC ===== */
        String search = req.getParameter("search");
        List<Category> categories;
        
        if (search != null && !search.trim().isEmpty()) {
            categories = categoryDao.searchByName(search);
        } else {
            categories = categoryDao.findAll();
        }

        req.setAttribute("categories", categories);
        req.setAttribute("totalCategories", categories.size());
        req.setAttribute("activeCategories",
                categories.stream().filter(c -> c.getStatus() == 1).count());
        req.setAttribute("lockedCategories",
                categories.stream().filter(c -> c.getStatus() == 0).count());

        req.setAttribute("page", "category");
        req.getRequestDispatcher("/admin.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        try {
            switch (action) {
                case "create":
                    createCategory(req, resp);
                    break;
                case "update":
                    updateCategory(req, resp);
                    break;
                case "toggle-status":
                    toggleStatus(req, resp);
                    break;
                case "search":
                    searchCategory(req, resp);
                    break;
                default:
                    resp.sendRedirect(req.getContextPath() + "/category-admin");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/category-admin?error=" + e.getMessage());
        }
    }

    private void createCategory(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String imagePath = handleFileUpload(req, "imageFile");

        Category category = new Category();
        category.setName(name);
        category.setImage(imagePath);
        category.setStatus(1); // 1 = Đang dùng

        categoryDao.insert(category);
        resp.sendRedirect(req.getContextPath() + "/category-admin");
    }

    private void updateCategory(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");
        String status = req.getParameter("status");

        Category category = categoryDao.findById(id);
        category.setName(name);
        if (status != null) {
            category.setStatus(status);
        }

        // Xử lý ảnh mới (nếu có)
        String newImage = handleFileUpload(req, "imageFile");
        if (newImage != null && !newImage.isEmpty()) {
            category.setImage(newImage);
        }
        // Giữ nguyên ảnh cũ nếu không upload ảnh mới

        categoryDao.update(category);
        resp.sendRedirect(req.getContextPath() + "/category-admin");
    }

    private void toggleStatus(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        Category category = categoryDao.findById(id);

        // Toggle status: 1 = Đang dùng, 0 = Đã khóa
        int newStatus = (category.getStatus() == 1) ? 0 : 1;
        category.setStatus(newStatus);

        categoryDao.update(category);
        resp.sendRedirect(req.getContextPath() + "/category-admin");
    }

    private void searchCategory(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String keyword = req.getParameter("keyword");
        List<Category> categories = categoryDao.searchByName(keyword);

        req.setAttribute("categories", categories);
        req.setAttribute("totalCategories", categories.size());
        req.setAttribute("page", "category");
        req.getRequestDispatcher("/admin.jsp").forward(req, resp);
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

        // Tạo tên file unique
        String extension = fileName.substring(fileName.lastIndexOf("."));
        String uniqueFileName = "category_" + System.currentTimeMillis() + extension;

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
        if (s == null) return "";
        return s.replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r");
    }
}
