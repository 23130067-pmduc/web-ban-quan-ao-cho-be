package vn.edu.nlu.fit.shopquanao.Service;

import vn.edu.nlu.fit.shopquanao.Dao.BannerDao;
import vn.edu.nlu.fit.shopquanao.model.Banner;

import java.util.List;

public class BannerService {

    private BannerDao bannerDao = new BannerDao();

    public List<Banner> getActiveBanners() {
        return  bannerDao.findActiveBanners();
    }
}
