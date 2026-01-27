package vn.edu.nlu.fit.shopquanao.Dao;
import java.util.List;
import vn.edu.nlu.fit.shopquanao.model.OrderItem;

public class OrderItemDao extends BaseDao{
    public void insert(int orderId,
                       int variantId,
                       String productName,
                       String size,
                       String color,
                       int quantity,
                       double price,
                       double total) {

        getJdbi().useHandle(h ->
                h.createUpdate("""
            INSERT INTO order_items
            (order_id, variant_id, product_name, size, color, quantity, price, total)
            VALUES (:oid, :vid, :name, :size, :color, :qty, :price, :total)
        """)
                        .bind("oid", orderId)
                        .bind("vid", variantId)
                        .bind("name", productName)
                        .bind("size", size)
                        .bind("color", color)
                        .bind("qty", quantity)
                        .bind("price", price)
                        .bind("total", total)
                        .execute()
        );
    }


    public List<OrderItem> getByOrderId(int orderId) {
        return getJdbi().withHandle(h ->
                h.createQuery("""
                SELECT *
                FROM order_items
                WHERE order_id = :oid
            """)
                        .bind("oid", orderId)
                        .mapToBean(OrderItem.class)
                        .list()
        );
    }
}