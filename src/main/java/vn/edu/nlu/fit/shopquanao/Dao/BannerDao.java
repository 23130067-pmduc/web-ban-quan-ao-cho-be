package vn.edu.nlu.fit.shopquanao.Dao;

import org.jdbi.v3.core.Jdbi;
import vn.edu.nlu.fit.shopquanao.model.Banner;

import java.util.List;

public class BannerDao extends BaseDao {


    public List<Banner> findActiveBanners() {
        Jdbi jdbi = getJdbi();

        return jdbi.withHandle(handle ->
                handle.createQuery(
                            "SELECT id, image_url, navigate_to, status, created_at " +
                                "FROM banners " +
                                "WHERE status = 1 " +
                                "ORDER BY id ASC"
                ).mapToBean(Banner.class).list()
        );

    }

}
