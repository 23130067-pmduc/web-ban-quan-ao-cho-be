package vn.edu.nlu.fit.shopquanao.Service;

import vn.edu.nlu.fit.shopquanao.Dao.ProductVariantDao;
import vn.edu.nlu.fit.shopquanao.model.Color;
import vn.edu.nlu.fit.shopquanao.model.ProductVariant;
import vn.edu.nlu.fit.shopquanao.model.Size;

import java.util.List;

public class ProductVariantService {
    private final ProductVariantDao productVariantDao = new ProductVariantDao();

    public List<ProductVariant> getVariantByProductId(int id) {
        return productVariantDao.getVariantByProduct(id);
    }


    public int countVariant(int productId) {
        return productVariantDao.countVariant(productId);
    }

    public int countStock(int productId) {
        return productVariantDao.countStock(productId);
    }

    public int countSize(int productId) {
        return productVariantDao.countSize(productId);
    }

    public int countColor(int productId) {
        return productVariantDao.countColor(productId);
    }

    public List<Size> getAllSizes() {
        return productVariantDao.getAllSizes();
    }

    public List<Color> getAllColors() {
        return productVariantDao.getAllColor();
    }


    public ProductVariant getVariantById(int id) {
        return productVariantDao.getVariantById(id);
    }

    public void createVariant(ProductVariant variant) {
        productVariantDao.createVariant(variant);
    }

    public void updateVariant(ProductVariant variant) {
        productVariantDao.updateVariant(variant);
    }

    public void deleteVariant(int id) {
        productVariantDao.deleteVariant(id);
    }

    public List<ProductVariant> getProductVariantByProductId(int productId) {
        return productVariantDao.getProductVariantByProductId(productId);
    }
}
