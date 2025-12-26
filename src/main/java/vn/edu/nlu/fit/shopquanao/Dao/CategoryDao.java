package vn.edu.nlu.fit.shopquanao.Dao;

import java.util.List;

import org.jdbi.v3.core.Jdbi;

import vn.edu.nlu.fit.shopquanao.model.Category;

public class CategoryDao extends BaseDao {

    /**
     * Lấy tất cả danh mục đang hoạt động
     */
    public List<Category> findAll() {
        Jdbi jdbi = getJdbi();
        String sql = "SELECT * FROM categories WHERE status = 1 ORDER BY id";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .mapToBean(Category.class)
                        .list()
        );
    }

    /**
     * Lấy danh mục theo ID
     */
    public Category findById(int id) {
        Jdbi jdbi = getJdbi();
        String sql = "SELECT * FROM categories WHERE id = :id AND status = 1";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("id", id)
                        .mapToBean(Category.class)
                        .findOne()
                        .orElse(null)
        );
    }

    /**
     * Đếm số sản phẩm theo danh mục
     */
    public int countProductsByCategory(int categoryId) {
        Jdbi jdbi = getJdbi();
        String sql = "SELECT COUNT(*) FROM products WHERE category_id = :categoryId AND status = 'Đang bán'";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("categoryId", categoryId)
                        .mapTo(Integer.class)
                        .one()
        );
    }

    // Test
    public static void main(String[] args) {
        CategoryDao dao = new CategoryDao();
        
        System.out.println("=== Test CategoryDao ===");
        List<Category> categories = dao.findAll();
        System.out.println("Tổng số danh mục: " + categories.size());
        
        for (Category cat : categories) {
            int count = dao.countProductsByCategory(cat.getId());
            System.out.println(cat.getId() + ". " + cat.getName() 
                + " - " + cat.getDescription() 
                + " (" + count + " sản phẩm)");
        }
    }
}
