package vn.edu.nlu.fit.shopquanao.Service;

import vn.edu.nlu.fit.shopquanao.Dao.ProductDao;
import vn.edu.nlu.fit.shopquanao.model.Product;

import java.util.Comparator;
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


    // Mới nhất * theo ngày tạo
    public List<Product> sortByNewest(List<Product> products) {
        products.sort(Comparator.comparing(Product::getCreated_at).reversed());
        return products;
    }


    //Bán chạy . Tạm theo view
    public List<Product> sortByBestSeller(List<Product> products) {
        products.sort(Comparator.comparing(Product::getViews).reversed());
        return products;
    }

    // Khuyến mãi sale_price
    public List<Product> sortBySale(List<Product> products) {
        products.sort(Comparator.comparing((Product p) -> p.getSale_price() > 0 ? 0 : 1)
                .thenComparing(Product::getSale_price));
        return products;
    }

    // Theo giá
    public List<Product> sortByPriceAsc(List<Product> products) {
        products.sort(Comparator.comparing(Product::getSale_price));
        return products;
    }

    public List<Product> sortByPriceDesc(List<Product> products) {
        products.sort(Comparator.comparing((Product::getSale_price))
                .reversed());

        return products;
    }

    public List<Product> getBoyProducts(int limit) {
        return productDao.findBoyProducts(limit);
    }

    public List<Product> getGirlProducts(int limit) {
        return productDao.findGirlProducts(limit);
    }

    public List<Product> getAccessoryProducts(int limit) {
        return productDao.findAccessoryProducts(limit);
    }
}