package vn.edu.nlu.fit.shopquanao.Service;

import java.util.List;

import vn.edu.nlu.fit.shopquanao.Dao.CategoryDao;
import vn.edu.nlu.fit.shopquanao.model.Category;

public class CategoryService {
    private CategoryDao categoryDao;

    public CategoryService() {
        this.categoryDao = new CategoryDao();
    }

    public List<Category> getAllCategories() {
        return categoryDao.findAll();
    }

    public Category getCategoryById(int id) {
        return categoryDao.findById(id);
    }

    public int countProductsByCategory(int categoryId) {
        return categoryDao.countProductsByCategory(categoryId);
    }
}
