package vn.edu.nlu.fit.shopquanao.Dao;

import vn.edu.nlu.fit.shopquanao.model.Review;


import java.util.List;

public class ReviewDao extends BaseDao {


    public void insert(Review review) {
        getJdbi().useHandle(handle -> handle.createUpdate(
                """
                        INSERT INTO product_reviews(product_id, customer_id, rating, comment, created_at)
                        VALUES (:pid, :cid, :rating, :comment, NOW())
                    """
                     ).bind("pid", review.getProductId())
                        .bind("cid", review.getCustomerId())
                        .bind("rating", review.getRating())
                        .bind("comment", review.getComment())
                        .execute()
        );

    }


    public List<Review> findByProductID(int productId) {
        return getJdbi().withHandle(handle -> handle.createQuery(
                """
                        SELECT * 
                        FROM product_reviews
                        WHERE product_id = :productId
                        ORDER BY created_at DESC
                        """
        ).bind("productId", productId)
                .mapToBean(Review.class)
                .list());
    }


}
