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

        if (!user.getPassword().equals(password)) return null;

        return user;
    }
    private String checkPasswordStrength(String password) {
        if (password == null || password.length() < 8)
            return "Mật khẩu phải có ít nhất 8 ký tự";

        boolean hasUpper = false;
        boolean hasLower = false;
        boolean hasDigit = false;
        boolean hasSpecial = false;

        for (char c : password.toCharArray()) {
            if (Character.isUpperCase(c)) hasUpper = true;
            else if (Character.isLowerCase(c)) hasLower = true;
            else if (Character.isDigit(c)) hasDigit = true;
            else hasSpecial = true;
        }

        if (!hasUpper) return "Mật khẩu phải có ít nhất 1 chữ hoa";
        if (!hasLower) return "Mật khẩu phải có ít nhất 1 chữ thường";
        if (!hasDigit) return "Mật khẩu phải có ít nhất 1 chữ số";
        if (!hasSpecial) return "Mật khẩu phải có ít nhất 1 ký tự đặc biệt";

        return null; // hợp lệ
    }


    public void registerSendOtp(String username, String email, String password) {

        String passwordError = checkPasswordStrength(password);
        if (passwordError != null) {
            throw new RuntimeException(passwordError);
        }

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

    public boolean verifyOtpForReset(String email, String otp) {
        return userDao.verifyOtpForReset(email, otp);
    }

    public boolean checkOtpCuoi(String email, String otp) {
        return userDao.checkOtpCuoi(email, otp);
    }

    public void sendOtpResetPassword(String email) {

        User user = userDao.finduser(email);
        if (user == null) {throw new RuntimeException("Email không tồn tại");
        }

        String otp = String.format("%06d", new Random().nextInt(1_000_000));
        LocalDateTime expiredAt = LocalDateTime.now().plusMinutes(5);

        userDao.updateOtpForReset(email, otp, expiredAt);

        EmailService.sendEmail(
                email, "OTP đặt lại mật khẩu", "<h3>Mã OTP của bạn: <b>" + otp + "</b></h3>"
        );
    }

    public void resetPassword(String email, String otp, String newPassword) {

        String error = checkPasswordStrength(newPassword);
        if (error != null) {
            throw new RuntimeException(error);
        }

        boolean ok = userDao.verifyOtpForReset(email, otp);
        if (!ok) {
            throw new RuntimeException("OTP sai hoặc đã hết hạn");
        }

        userDao.updatePassword(email, newPassword);
    }
}
