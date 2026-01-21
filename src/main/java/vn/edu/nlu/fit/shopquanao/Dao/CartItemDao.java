package vn.edu.nlu.fit.shopquanao.Dao;

import vn.edu.nlu.fit.shopquanao.Cart.CartItem;
import vn.edu.nlu.fit.shopquanao.model.Product;

import java.util.List;

public class CartItemDao extends BaseDao {

    public void addOrUpdate(int cartId, int productId, int quantity, double price) {
        getJdbi().useHandle(handle -> {
            Integer exists = handle.createQuery(
                            "SELECT id FROM cart_items WHERE cart_id = :cid AND product_id = :pid")
                    .bind("cid", cartId)
                    .bind("pid", productId)
                    .mapTo(Integer.class)
                    .findOne()
                    .orElse(null);

            if (exists != null) {
                handle.createUpdate(
                                "UPDATE cart_items SET quantity = quantity + :q WHERE id = :id")
                        .bind("q", quantity)
                        .bind("id", exists)
                        .execute();
            } else {
                handle.createUpdate(
                                "INSERT INTO cart_items(cart_id, product_id, quantity, price) " +
                                        "VALUES (:cid, :pid, :q, :price)")
                        .bind("cid", cartId)
                        .bind("pid", productId)
                        .bind("q", quantity)
                        .bind("price", price)
                        .execute();
            }
        });
    }

    public int countTotalQuantity(int cartId) {
        return getJdbi().withHandle(h ->
                h.createQuery("SELECT COALESCE(SUM(quantity),0) FROM cart_items WHERE cart_id = :cid")
                        .bind("cid", cartId)
                        .mapTo(int.class)
                        .one()
        );
    }

    public List<CartItem> getItemsByCartId(int cartId) {
        String sql =
                "SELECT ci.quantity, ci.price, " +
                        "p.id AS pid, p.name, p.price AS pprice, p.thumbnail " +
                        "FROM cart_items ci " +
                        "JOIN products p ON ci.product_id = p.id " +
                        "WHERE ci.cart_id = :cid";

        return getJdbi().withHandle(h ->
                h.createQuery(sql)
                        .bind("cid", cartId)
                        .map((rs, ctx) -> {
                            Product product = new Product();
                            product.setId(rs.getInt("pid"));
                            product.setName(rs.getString("name"));
                            product.setPrice(rs.getDouble("pprice"));
                            product.setThumbnail(rs.getString("thumbnail"));

                            CartItem item = new CartItem();
                            item.setQuantity(rs.getInt("quantity"));
                            item.setPrice(rs.getDouble("price"));
                            item.setProduct(product);

                            return item;
                        })
                        .list()
        );
    }


    public void delete(int cartId, int productId) {
        getJdbi().useHandle(h ->
                h.createUpdate(
                                "DELETE FROM cart_items WHERE cart_id = :cid AND product_id = :pid")
                        .bind("cid", cartId)
                        .bind("pid", productId)
                        .execute()
        );
    }
    public void updateQuantity(int cartId, int productId, int quantity) {
        getJdbi().useHandle(h ->
                h.createUpdate(
                                "UPDATE cart_items SET quantity = :q " +
                                        "WHERE cart_id = :cid AND product_id = :pid")
                        .bind("q", quantity)
                        .bind("cid", cartId)
                        .bind("pid", productId)
                        .execute()
        );
    }
    public int countDistinctItems(int cartId) {
        return getJdbi().withHandle(h ->
                h.createQuery(
                                "SELECT COUNT(*) FROM cart_items WHERE cart_id = :cid")
                        .bind("cid", cartId)
                        .mapTo(int.class)
                        .one()
        );
    }




}
