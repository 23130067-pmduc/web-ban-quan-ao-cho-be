package vn.edu.nlu.fit.shopquanao.Dao;

import vn.edu.nlu.fit.shopquanao.model.Product;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import java.time.LocalDateTime;

public class ProductDao {
    static Map<Integer,Product> data = new HashMap<Integer, Product>();
    static{
        data.put(1, new Product(
                1,
                1,
                "Set áo dài nhung bé gái",
                "Áo dài nhung thêu hoa – hàng Tết",
                399000,
                199000,
                "https://product.hstatic.net/1000290074/product/9160202410205_07a9cac73e0140278b07e2b6cf35e3d9_1024x1024.jpg",
                LocalDateTime.now(),
                0,
                "ACTIVE"
        ));

        data.put(2, new Product(
                2,
                3,
                "Áo kiểu dài tay bé gái",
                "Áo thô dài tay, dễ thương",
                299000,
                102000,
                "https://cdn.hstatic.net/products/1000290074/913003__1__da8b3cb48cc04437814e02804599a6d1_1024x1024.png",
                LocalDateTime.now(),
                0,
                "ACTIVE"
        ));

        data.put(3, new Product(
                3, 5,
                "Đầm nhung dài tay bé gái",
                "Đầm nhung ấm áp, phong cách",
                199000, 178000,
                "https://cdn.hstatic.net/products/1000290074/thi_t_k__ch_a_c__t_n__3__e2533ad0c5364bc79d47ffe96677808e_1024x1024.png",
                LocalDateTime.now(), 0, "ACTIVE"
        ));

        data.put(4, new Product(
                4, 6,
                "Bộ nỉ dài tay bé gái",
                "Bộ nỉ mặc ở nhà siêu xinh",
                199000, 131000,
                "https://product.hstatic.net/1000290074/product/91768-1_d2af02af86ee4f399a7335101f1ecd56_1024x1024.jpg",
                LocalDateTime.now(), 0, "ACTIVE"
        ));

        data.put(5, new Product(
                5, 5,
                "Giày thể thao bé trai/bé gái",
                "Thiết kế năng động, dễ phối đồ",
                469000, 208000,
                "https://cdn.hstatic.net/products/1000290074/684006-5_b582a59eb7884ec9adc8a694a3336ed7_1024x1024.png",
                LocalDateTime.now(), 0, "ACTIVE"
        ));

        data.put(6, new Product(
                6, 5,
                "Mũ len cho bé",
                "Mũ len giữ ấm mùa lạnh",
                109000, 109000,
                "https://mediacdn1.bibomart.net/images/2025/5/24/1/origin/mu-len-cho-be-hello-dinh-2-cuc-bong-bh012-1748067338.jpg",
                LocalDateTime.now(), 0, "ACTIVE"
        ));
    }


    public List<Product> getListProduct() {
        return new ArrayList<Product>(data.values());
    }
}
