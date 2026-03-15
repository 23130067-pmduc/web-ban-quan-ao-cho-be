package vn.edu.nlu.fit.shopquanao.Service;

import vn.edu.nlu.fit.shopquanao.Dao.ColorDao;
import vn.edu.nlu.fit.shopquanao.model.Color;

import java.util.List;

public class ColorService {
    private final ColorDao colorDao = new ColorDao();

    public List<Color> getColorByProductId(int id) {
        return  colorDao.getColorByProductId(id);
    }
}
