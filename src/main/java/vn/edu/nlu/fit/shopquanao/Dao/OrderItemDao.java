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

        String sql = """
            SELECT oi.id, oi.order_id, oi.variant_id, oi.product_name, oi.size, oi.color, oi.quantity, oi.price, oi.total, p.thumbnail FROM order_items oi JOIN product_variants pv ON oi.variant_id = pv.id JOIN products p ON pv.product_id = p.id WHERE oi.order_id = :oid               
        """;

        return getJdbi().withHandle(h ->
                h.createQuery(sql)
                        .bind("oid", orderId)
                        .map((rs, ctx) -> {
                            OrderItem item = new OrderItem();
                            item.setId(rs.getInt("id"));
                            item.setOrderId(rs.getInt("order_id"));
                            item.setVariantId(rs.getInt("variant_id"));
                            item.setProductName(rs.getString("product_name"));
                            item.setSize(rs.getString("size"));
                            item.setColor(rs.getString("color"));
                            item.setQuantity(rs.getInt("quantity"));
                            item.setPrice(rs.getDouble("price"));
                            item.setTotal(rs.getDouble("total"));
                            item.setThumbnail(rs.getString("thumbnail"));
                            return item;
                        })
                        .list()
        );
    }
}