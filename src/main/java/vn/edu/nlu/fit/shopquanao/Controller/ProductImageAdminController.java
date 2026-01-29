package vn.edu.nlu.fit.shopquanao.Controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vn.edu.nlu.fit.shopquanao.Service.ProductImageService;
import vn.edu.nlu.fit.shopquanao.model.ProductImage;

@WebServlet(name = "ProductImageAdminController", value = "/product-image-admin")
@MultipartConfig(
        maxFileSize = 10 * 1024 * 1024,      // 10MB
        maxRequestSize = 50 * 1024 * 1024    // 50MB
)
public class ProductImageAdminController extends HttpServlet {
    private ProductImageService productImageService;

    @Override
    public void init() {
        productImageService = new ProductImageService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String productIdParam = request.getParameter("productId");
        if (productIdParam == null || productIdParam.isEmpty()) {
            response.sendRedirect("product-admin");
            return;
        }

        int productId = Integer.parseInt(productIdParam);
        String mode = request.getParameter("mode");

        // Nếu không có mode, hiển thị danh sách ảnh
        if (mode == null) {
            List<ProductImage> images = productImageService.getImageByProduct(productId);

            request.setAttribute("images", images);
            request.setAttribute("productId", productId);
            request.setAttribute("totalImages", images.size());

            request.getRequestDispatcher("/product-image-admin.jsp").forward(request, response);
            return;
        }

        // Mode: add - Hiển thị form thêm ảnh
        if ("add".equals(mode)) {
            request.setAttribute("mode", "add");
            request.setAttribute("productId", productId);
            request.getRequestDispatcher("/product-image-form.jsp").forward(request, response);
            return;
        }

        // Mode: edit - Hiển thị form sửa ảnh
        if ("edit".equals(mode)) {
            int id = Integer.parseInt(request.getParameter("id"));
            ProductImage image = productImageService.getImageById(id);

            request.setAttribute("image", image);
            request.setAttribute("productId", productId);
            request.setAttribute("mode", "edit");
            request.getRequestDispatcher("/product-image-form.jsp").forward(request, response);
            return;
        }

        // Mode: view - Xem chi tiết ảnh
        if ("view".equals(mode)) {
            int id = Integer.parseInt(request.getParameter("id"));
            ProductImage image = productImageService.getImageById(id);

            request.setAttribute("image", image);
            request.setAttribute("productId", productId);
            request.setAttribute("mode", "view");
            request.getRequestDispatcher("/product-image-form.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        int productId = Integer.parseInt(request.getParameter("productId"));

        try {
            switch (action) {
                case "create" -> createImage(request, response, productId);
                case "update" -> updateImage(request, response, productId);
                case "delete" -> deleteImage(request, response, productId);
                default -> response.sendRedirect("product-image-admin?productId=" + productId);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("product-image-admin?productId=" + productId + "&error=true");
        }
    }

    private void createImage(HttpServletRequest request, HttpServletResponse response, int productId)
            throws ServletException, IOException {

        String imagePath = handleFileUpload(request, "imageFile");
        String isMainParam = request.getParameter("isMain");

        if (imagePath == null || imagePath.isEmpty()) {
            response.sendRedirect("product-image-admin?productId=" + productId + "&error=no_image");
            return;
        }

        ProductImage image = new ProductImage();
        image.setProductId(productId);
        image.setImageUrl(imagePath);
        image.setMain(isMainParam != null && isMainParam.equals("true"));

        productImageService.createImage(image);
        response.sendRedirect("product-image-admin?productId=" + productId);
    }

    private void updateImage(HttpServletRequest request, HttpServletResponse response, int productId)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String isMainParam = request.getParameter("isMain");

        ProductImage image = productImageService.getImageById(id);
        image.setMain(isMainParam != null && isMainParam.equals("true"));

        // Xử lý ảnh mới (nếu có)
        String newImage = handleFileUpload(request, "imageFile");
        if (newImage != null && !newImage.isEmpty()) {
            image.setImageUrl(newImage);
        }

        productImageService.updateImage(image);
        response.sendRedirect("product-image-admin?productId=" + productId);
    }

    private void deleteImage(HttpServletRequest request, HttpServletResponse response, int productId)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        productImageService.deleteImage(id);
        response.sendRedirect("product-image-admin?productId=" + productId);
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

        // Tạo tên file unique
        String uniqueFileName = "product_img_" + System.currentTimeMillis() + extension;
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
}
