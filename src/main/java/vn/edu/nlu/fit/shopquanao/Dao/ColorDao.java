package vn.edu.nlu.fit.shopquanao.Dao;

import vn.edu.nlu.fit.shopquanao.model.Color;

import java.util.List;

public class ColorDao extends BaseDao {
    public List<Color> getColorByProductId(int id) {
        return getJdbi().withHandle(handle -> handle.createQuery("""
                SELECT DISTINCT c.id, c.name, c.hex
                FROM product_variants p
                JOIN colors c ON p.color_id = c.id
                WHERE p.product_id = :id
                """)
                .bind("id",id)
                .mapToBean(Color.class)
                .list());
    }
}
