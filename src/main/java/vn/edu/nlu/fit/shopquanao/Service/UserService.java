package vn.edu.nlu.fit.shopquanao.Service;

import vn.edu.nlu.fit.shopquanao.Dao.UserDao;
import vn.edu.nlu.fit.shopquanao.model.User;

public class UserService {

    private final UserDao userDao = new UserDao();

    public User login(String username, String password) {
        User user = userDao.finduser(username);

        if (user == null) return null;

        // tạm thời so plain text (sau đổi sang hash)
        if (!user.getPassword().equals(password)) return null;

        return user;
    }

    public boolean register(String fullname, String email, String password) {
        if (userDao.finduser(email) != null) return false;

        userDao.addUser(fullname, email, password);
        return true;
    }
}

