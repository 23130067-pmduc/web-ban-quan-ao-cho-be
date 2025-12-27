package vn.edu.nlu.fit.shopquanao.Dao;

import java.util.List;

import org.jdbi.v3.core.Jdbi;

import vn.edu.nlu.fit.shopquanao.model.Product;

public class ProductDao extends BaseDao {

    /**
     * Lấy toàn bộ sản phẩm đang bán
     */
    public List<Product> findAll() {
        Jdbi jdbi = getJdbi();
        return jdbi.withHandle(handle ->
                handle.createQuery(
                                "SELECT * FROM products WHERE status = 'Đang bán'"
                        )
                        .mapToBean(Product.class)
                        .list()
        );
    }

    /**
     * Lấy sản phẩm theo ID
     */
    public Product findById(int id) {
        Jdbi jdbi = getJdbi();
        return jdbi.withHandle(handle ->
                handle.createQuery(
                                "SELECT * FROM products WHERE id = :id"
                        )
                        .bind("id", id)
                        .mapToBean(Product.class)
                        .findOne()
                        .orElse(null)
        );
    }

    /**
     * Lấy sản phẩm theo category
     */
    public List<Product> findByCategory(int categoryId) {
        Jdbi jdbi = getJdbi();
        return jdbi.withHandle(handle ->
                handle.createQuery(
                                "SELECT * FROM products WHERE category_id = :cid AND status = 'Đang bán'"
                        )
                        .bind("cid", categoryId)
                        .mapToBean(Product.class)
                        .list()
        );
    }

    /**
     * Lấy sản phẩm mới nhất
     */
    public List<Product> findLatest(int limit) {
        Jdbi jdbi = getJdbi();
        return jdbi.withHandle(handle ->
                handle.createQuery(
                                "SELECT * FROM products WHERE status = 'Đang bán' ORDER BY created_at DESC LIMIT :limit"
                        )
                        .bind("limit", limit)
                        .mapToBean(Product.class)
                        .list()
        );
    }

    /**
     * Tìm kiếm sản phẩm theo tên
     */
    public List<Product> searchByName(String keyword) {
        Jdbi jdbi = getJdbi();
        return jdbi.withHandle(handle ->
                handle.createQuery(
                                "SELECT * FROM products WHERE name LIKE :kw AND status = 'Đang bán'"
                        )
                        .bind("kw", "%" + keyword + "%")
                        .mapToBean(Product.class)
                        .list()
        );
    }
    public List<Product> findBoyProducts(int limit) {
        return getJdbi().withHandle(handle ->
                handle.createQuery("""
            SELECT * FROM products
            WHERE category_id IN (1,2,3)
              AND status = 'Đang bán'
            ORDER BY created_at DESC
            LIMIT :limit
        """)
                        .bind("limit", limit)
                        .mapToBean(Product.class)
                        .list()
        );
    }

    public List<Product> findGirlProducts(int limit) {
        return getJdbi().withHandle(handle ->
                handle.createQuery("""
            SELECT * FROM products
            WHERE category_id IN (4,5,6,7)
              AND status = 'Đang bán'
            ORDER BY created_at DESC
            LIMIT :limit
        """)
                        .bind("limit", limit)
                        .mapToBean(Product.class)
                        .list()
        );
    }
    public List<Product> findAccessoryProducts(int limit) {
        return getJdbi().withHandle(handle ->
                handle.createQuery("""
            SELECT * FROM products
            WHERE category_id IN (8,9,10)
              AND status = 'Đang bán'
            ORDER BY created_at DESC
            LIMIT :limit
        """)
                        .bind("limit", limit)
                        .mapToBean(Product.class)
                        .list()
        );
    }
}
