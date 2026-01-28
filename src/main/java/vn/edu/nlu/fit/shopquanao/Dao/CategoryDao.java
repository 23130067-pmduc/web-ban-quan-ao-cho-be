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
        String sql = "SELECT * FROM category_product ORDER BY id";
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
        String sql = "SELECT * FROM category_product WHERE id = :id";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("id", id)
                        .mapToBean(Category.class)
                        .findOne()
                        .orElse(null)
        );
    }

    public List<Category> getCategoryChild(int parentId) {
        String sql = "SELECT * FROM category_product WHERE parent_id = :pid AND status = 1";
        return getJdbi().withHandle(h ->
                h.createQuery(sql)
                        .bind("pid", parentId)
                        .mapToBean(Category.class)
                        .list()
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

    /**
     * Thêm danh mục mới
     */
    public void insert(Category category) {
        getJdbi().useHandle(handle ->
                handle.createUpdate("""
                INSERT INTO category_product (name, image, status)
                VALUES (:name, :image, :status)
            """)
                        .bind("name", category.getName())
                        .bind("image", category.getImage())
                        .bind("status", category.getStatus())
                        .execute()
        );
    }

    /**
     * Cập nhật danh mục
     */
    public void update(Category category) {
        getJdbi().useHandle(handle ->
                handle.createUpdate("""
                UPDATE category_product
                SET name = :name,
                    image = :image
                WHERE id = :id
            """)
                        .bind("id", category.getId())
                        .bind("name", category.getName())
                        .bind("image", category.getImage())
                        .execute()
        );
    }

    /**
     * Cập nhật trạng thái danh mục
     */
    public void updateStatus(int id, String status) {
        getJdbi().useHandle(handle ->
                handle.createUpdate("""
                UPDATE category_product
                SET status = :status
                WHERE id = :id
            """)
                        .bind("id", id)
                        .bind("status", status)
                        .execute()
        );
    }

    /**
     * Tìm kiếm danh mục theo tên
     */
    public List<Category> searchByName(String keyword) {
        String sql = "SELECT * FROM category_product WHERE name LIKE :keyword ORDER BY id";
        return getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("keyword", "%" + keyword + "%")
                        .mapToBean(Category.class)
                        .list()
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
