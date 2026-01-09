package vn.edu.nlu.fit.shopquanao.Service;

import vn.edu.nlu.fit.shopquanao.Dao.ReviewDao;
import vn.edu.nlu.fit.shopquanao.model.Review;

import java.util.List;

public class ReviewService {

    private ReviewDao reviewDao = new ReviewDao();

    public void addReview(Review review){
        reviewDao.insert(review);
    }

    public List<Review> getReviewByProductID(int productID){
        return reviewDao.findByProductID(productID);
    }

}
