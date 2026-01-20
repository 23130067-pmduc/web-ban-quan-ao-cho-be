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
    public boolean verifyOtpForReset(String email, String otp) {
        int count = getJdbi().withHandle(h ->
                h.createQuery(
                                "SELECT COUNT(*) FROM users " +
                                        "WHERE email=:e AND otp_code=:otp AND otp_expired_at > NOW()").bind("e", email).bind("otp", otp).mapTo(int.class).one());

        System.out.println("VERIFY RESET COUNT = " + count);
        return count > 0;
    }
    public void updatePassword(String email, String password) {
        getJdbi().withHandle(h ->
                h.createUpdate("UPDATE users SET password=:p, otp_code=NULL, otp_expired_at=NULL " +
                                        "WHERE email=:e").bind("p", password).bind("e", email).execute()
        );
    }
    public void updateOtpForReset(String email, String otp, LocalDateTime expiredAt) {
        getJdbi().withHandle(h ->
                h.createUpdate("UPDATE users SET otp_code=:otp, otp_expired_at=:exp WHERE email=:e").bind("otp", otp).bind("exp", expiredAt).bind("e", email).execute());
    }
    public boolean checkOtpCuoi(String email, String otp) {
        return getJdbi().withHandle(h ->
                h.createQuery("SELECT COUNT(*) FROM users " +
                                        "WHERE email=:e AND otp_code=:otp AND otp_expired_at > NOW()").bind("e", email).bind("otp", otp).mapTo(int.class).one()) > 0;
    }


    public User findUserById(int id) {
        return getJdbi().withHandle(handle -> handle.createQuery("""
                SELECT id, username , email, created_at, full_name , birthday, gender, phone , address
                FROM users
                WHERE id = :id""")
                .bind("id", id)
                .mapToBean(User.class)
                .findOne()
                .orElse(null));
    }

    public void update(User user) {
         getJdbi().withHandle(handle -> handle.createUpdate("""
                        UPDATE users
                                    SET full_name = :fullName,
                                        phone = :phone,
                                        email = :email,
                                        birthday = :birthday,
                                        gender = :gender,
                                        address = :address
                                    WHERE id = :id
                        """)
                .bind("fullName", user.getFullName())
                .bind("phone", user.getPhone())
                .bind("email", user.getEmail())
                .bind("birthday", user.getBirthday()) // LocalDate OK
                .bind("gender", user.getGender())
                .bind("address", user.getAddress())
                .bind("id", user.getId())
                .execute()
        );

    }

    public boolean checkOldPass(int id, String oldPass) {

        return false;
    }


    public boolean updatePasss(int id, String hash) {
        return false;
    }
}

