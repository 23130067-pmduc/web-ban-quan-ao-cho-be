package vn.edu.nlu.fit.shopquanao.Service;

import vn.edu.nlu.fit.shopquanao.Dao.ProductDao;
import vn.edu.nlu.fit.shopquanao.model.Product;

import java.util.List;

public class ProductService {

    private final ProductDao productDao = new ProductDao();

    /**
     * Lấy toàn bộ sản phẩm đang ACTIVE
     */
    public List<Product> getAllProducts() {
        return productDao.findAll();
    }

    /**
     * Lấy sản phẩm theo ID
     */
    public Product getProductById(int id) {
        return productDao.findById(id);
    }

    /**
     * Lấy sản phẩm theo category
     */
    public List<Product> getProductsByCategory(int categoryId) {
        return productDao.findByCategory(categoryId);
    }


    public List<Product> getProductsByCategories(List<Integer> categoryIds) {
        return productDao.findByCategories(categoryIds);
    }
    /**
     * Lấy sản phẩm mới nhất
     */
    public List<Product> getLatestProducts(int limit) {
        return productDao.findLatest(limit);
    }

    /**
     * Tìm kiếm sản phẩm theo tên
     */
    public List<Product> searchProducts(String keyword) {
        return productDao.searchByName(keyword);
    }
}
