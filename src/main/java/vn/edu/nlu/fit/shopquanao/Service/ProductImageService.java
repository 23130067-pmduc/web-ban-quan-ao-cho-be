package vn.edu.nlu.fit.shopquanao.Service;


import vn.edu.nlu.fit.shopquanao.Dao.ProductImageDao;
import vn.edu.nlu.fit.shopquanao.model.ProductImage;

import java.util.List;

public class ProductImageService {
    private ProductImageDao productImageDao = new ProductImageDao();


    public List<ProductImage> getImageByProduct(int id) {
        return productImageDao.getImageByProduct(id);
    }
}
