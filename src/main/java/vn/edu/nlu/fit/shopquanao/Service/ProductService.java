package vn.edu.nlu.fit.shopquanao.Service;

import vn.edu.nlu.fit.shopquanao.Dao.ProductDao;
import vn.edu.nlu.fit.shopquanao.model.Product;

import java.util.List;

public class ProductService {

    ProductDao pdao = new ProductDao();


    public List<Product> getListProduct() {
        return pdao.getListProduct();
    }
}
