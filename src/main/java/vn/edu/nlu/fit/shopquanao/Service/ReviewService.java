package vn.edu.nlu.fit.shopquanao.Service;

import vn.edu.nlu.fit.shopquanao.Dao.ReviewDao;
import vn.edu.nlu.fit.shopquanao.model.Review;

import java.util.List;

public class ReviewService {

    private ReviewDao reviewDao = new ReviewDao();

    public void addOrUpdateReview(Review review) {
        Review exist = reviewDao.findByProductAndUser(
                review.getProductId(),
                review.getUserId()
        );

        if (exist == null) {
            reviewDao.insert(review);
        } else {
            reviewDao.update(review);
        }
    }


    public List<Review> getReviewByProductID(int productID){
        return reviewDao.findByProductID(productID);
    }

    public double getAvgRating(int id) {
        return reviewDao.getAvgRating(id);
    }

    public int getTotalReviews(int id) {
        return reviewDao.getTotalReviews(id);
    }
}
