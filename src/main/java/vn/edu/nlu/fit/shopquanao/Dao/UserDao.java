package vn.edu.nlu.fit.shopquanao.Dao;

import vn.edu.nlu.fit.shopquanao.model.User;
import vn.edu.nlu.fit.shopquanao.Service.EmailService;
import vn.edu.nlu.fit.shopquanao.Dao.UserDao;


import java.time.LocalDateTime;
import java.util.List;
import java.util.Random;

public class UserDao extends BaseDao {
    public User finduser(String username) {
        return getJdbi().withHandle(handle ->
                handle.createQuery("select * from users where username=:username OR email=:username")
                        .bind("username", username).mapToBean(User.class).findFirst().orElse(null)
        );
    }

    public List<User> getListUser() {
        return getJdbi().withHandle(handle ->
                handle.createQuery("SELECT * FROM users")
                        .mapToBean(User.class)
                        .list()
        );
    }

    public static void main(String[] args) {
        UserDao ud = new UserDao();
        System.out.println(ud.finduser("123@gmail.com"));
    }

    public void addUser(String username, String email, String password) {
        getJdbi().withHandle(handle ->
                handle.createUpdate("insert into users (username,email,password) values(:username, :email, :password)").bind("username", username).bind("email", email).bind("password", password).execute()
        );
    }

    public void updatePass(String password) {
        getJdbi().withHandle(handle ->
                handle.createUpdate("update users  set password=:password").bind("password", password).execute()
        );
    }
    // tạo user tạm (chưa active)
    public void insertPendingUser(String username, String email, String password,
                                  String otp, LocalDateTime expiredAt) {
        getJdbi().withHandle(h ->
                h.createUpdate(
                                "INSERT INTO users(username,email,password,otp_code,otp_expired_at,is_active) " +
                                        "VALUES (:u,:e,:p,:otp,:exp,0)"
                        )
                        .bind("u", username)
                        .bind("e", email)
                        .bind("p", password)
                        .bind("otp", otp)
                        .bind("exp", expiredAt)
                        .execute()
        );
    }

    // verify OTP
    public boolean verifyOtp(String email, String otp) {
        return getJdbi().withHandle(h ->
                h.createUpdate(
                                "UPDATE users SET is_active=1, otp_code=NULL, otp_expired_at=NULL " +
                                        "WHERE email=:e AND otp_code=:otp AND otp_expired_at > NOW()"
                        )
                        .bind("e", email)
                        .bind("otp", otp)
                        .execute()
        ) > 0;
    }
    public void updateOtp(String email, String otp, LocalDateTime expiredAt) {
        getJdbi().withHandle(h ->
                h.createUpdate(
                                "UPDATE users SET otp_code=:otp, otp_expired_at=:exp " +
                                        "WHERE email=:e AND is_active=0"
                        )
                        .bind("otp", otp)
                        .bind("exp", expiredAt)
                        .bind("e", email)
                        .execute()
        );
    }


}


