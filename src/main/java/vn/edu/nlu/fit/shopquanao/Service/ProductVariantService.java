package vn.edu.nlu.fit.shopquanao.Service;

import vn.edu.nlu.fit.shopquanao.Dao.ProductVariantDao;
import vn.edu.nlu.fit.shopquanao.model.ProductVariant;

import java.util.List;

public class ProductVariantService {
    private final ProductVariantDao productVariantDao = new ProductVariantDao();

    public List<ProductVariant> getVariantByProductId(int id) {
        return productVariantDao.getVariantByProduct(id);
    }
}
