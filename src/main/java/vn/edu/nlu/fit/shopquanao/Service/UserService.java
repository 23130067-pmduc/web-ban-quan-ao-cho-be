package vn.edu.nlu.fit.shopquanao.Service;

import vn.edu.nlu.fit.shopquanao.Dao.UserDao;
import vn.edu.nlu.fit.shopquanao.model.User;

import java.time.LocalDateTime;
import java.util.Random;

public class UserService {

    private final UserDao userDao = new UserDao();

    public User login(String username, String password) {
        User user = userDao.finduser(username);

        if (user == null) return null;

        // tạm thời so plain text (sau đổi sang hash)
        if (!user.getPassword().equals(password)) return null;

        return user;
    }

    public void registerSendOtp(String username, String email, String password) {

        String otp = String.format("%06d", new Random().nextInt(1_000_000));
        LocalDateTime expiredAt = LocalDateTime.now().plusMinutes(5);

        User existing = userDao.finduser(email);

        if (existing == null) {
            // Lần đầu đăng ký → INSERT
            userDao.insertPendingUser(username, email, password, otp, expiredAt);
        } else if (existing.getIsActive() == 0) {
            // Đã tồn tại nhưng chưa active → UPDATE OTP
            userDao.updateOtp(email, otp, expiredAt);
        } else {
            // Đã active rồi
            throw new RuntimeException("Email đã được đăng ký");
        }

        EmailService.sendEmail(
                email,
                "OTP xác nhận đăng ký",
                "<h3>Mã OTP của bạn: <b>" + otp + "</b></h3>"
        );
    }
    public boolean verifyOtp(String email, String otp) {
        return userDao.verifyOtp(email, otp);
    }
}

