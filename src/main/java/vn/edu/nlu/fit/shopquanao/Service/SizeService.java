package vn.edu.nlu.fit.shopquanao.Service;

import vn.edu.nlu.fit.shopquanao.Dao.SizeDao;
import vn.edu.nlu.fit.shopquanao.model.Size;

import java.util.List;

public class SizeService {
    private final SizeDao sizeDao = new SizeDao();


    public List<Size> getSizeByProductId(int id) {
        return sizeDao.getSizeByProductId(id);
    }
}
