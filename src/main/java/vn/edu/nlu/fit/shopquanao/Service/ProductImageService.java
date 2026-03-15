package vn.edu.nlu.fit.shopquanao.Service;


import java.util.List;

import vn.edu.nlu.fit.shopquanao.Dao.ProductImageDao;
import vn.edu.nlu.fit.shopquanao.model.ProductImage;

public class ProductImageService {
    private ProductImageDao productImageDao = new ProductImageDao();

    public List<ProductImage> getImageByProduct(int id) {
        return productImageDao.getImageByProduct(id);
    }

    public ProductImage getImageById(int id) {
        return productImageDao.getImageById(id);
    }

    public void createImage(ProductImage image) {
        productImageDao.insert(image);
    }

    public void updateImage(ProductImage image) {
        productImageDao.update(image);
    }

    public void deleteImage(int id) {
        productImageDao.delete(id);
    }
}
