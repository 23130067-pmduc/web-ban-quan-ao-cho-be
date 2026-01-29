package vn.edu.nlu.fit.shopquanao.Controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.nlu.fit.shopquanao.Service.ProductVariantService;
import vn.edu.nlu.fit.shopquanao.model.ProductVariant;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductVariantAdminController", value = "/product-variant-admin")
public class ProductVariantAdminController extends HttpServlet {
    private ProductVariantService productVariantService;

    @Override
    public void init(){
        productVariantService = new ProductVariantService();
    }



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productIdRaw = request.getParameter("productId");
        if (productIdRaw == null || productIdRaw.isEmpty()) {
            response.sendRedirect("product-admin");
            return;
        }

        String mode = request.getParameter("mode");
        int productId = Integer.parseInt(request.getParameter("productId"));

        if (mode == null) {

            List<ProductVariant> variants =
                    productVariantService.getProductVariantByProductId(productId);

            request.setAttribute("variants", variants);
            request.setAttribute("productId", productId);

            request.setAttribute("total", productVariantService.countVariant(productId));
            request.setAttribute("totalStock", productVariantService.countStock(productId));
            request.setAttribute("totalSize", productVariantService.countSize(productId));
            request.setAttribute("totalColor", productVariantService.countColor(productId));

            request.getRequestDispatcher("/product-variant-admin.jsp").forward(request, response);
            return;
        }


        if ("add".equals(mode)) {

            request.setAttribute("productId", productId);
            request.setAttribute("sizes", productVariantService.getAllSizes());
            request.setAttribute("colors", productVariantService.getAllColors());

            request.getRequestDispatcher("/product-variant-form.jsp").forward(request, response);
            return;
        }

        if ("edit".equals(mode)) {

            int id = Integer.parseInt(request.getParameter("id"));

            ProductVariant variant = productVariantService.getVariantById(id);


            request.setAttribute("variant", variant);
            request.setAttribute("productId", variant.getProductId());
            request.setAttribute("sizes", productVariantService.getAllSizes());
            request.setAttribute("colors", productVariantService.getAllColors());
            request.setAttribute("mode", "edit");

            request.getRequestDispatcher("/product-variant-form.jsp").forward(request, response);
            return;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if ("create".equals(action)) {

            ProductVariant variant = new ProductVariant();

            variant.setProductId(Integer.parseInt(request.getParameter("productId")));
            variant.setSizeId(Integer.parseInt(request.getParameter("sizeId")));
            variant.setColorId(Integer.parseInt(request.getParameter("colorId")));
            variant.setStock(Integer.parseInt(request.getParameter("stock")));
            variant.setPrice(Double.parseDouble(request.getParameter("price")));
            variant.setSalePrice(Double.parseDouble(request.getParameter("salePrice")));

            productVariantService.createVariant(variant);

            response.sendRedirect(
                    "product-variant-admin?productId=" + variant.getProductId()
            );
            return;
        }


        if ("update".equals(action)) {

            ProductVariant variant = new ProductVariant();

            variant.setId(Integer.parseInt(request.getParameter("id")));
            variant.setProductId(Integer.parseInt(request.getParameter("productId")));
            variant.setStock(Integer.parseInt(request.getParameter("stock")));
            variant.setPrice(Double.parseDouble(request.getParameter("price")));
            variant.setSalePrice(Double.parseDouble(request.getParameter("salePrice")));

            productVariantService.updateVariant(variant);

            response.sendRedirect("product-variant-admin?productId=" + variant.getProductId()
            );
            return;
        }
        if ("delete".equals(action)) {

            int id = Integer.parseInt(request.getParameter("id"));
            int productId = Integer.parseInt(request.getParameter("productId"));

            productVariantService.deleteVariant(id);

            response.sendRedirect("product-variant-admin?productId=" + productId
            );
        }
    }
}