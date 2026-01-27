package vn.edu.nlu.fit.shopquanao.Dao;

import vn.edu.nlu.fit.shopquanao.model.Address;
import java.util.List;

public class AddressDao extends BaseDao {

    // ================== GET BY USER ==================
    public List<Address> getByUser(int userId) {
        return getJdbi().withHandle(h ->
                h.createQuery("""
                    SELECT
                        id,
                        user_id        AS userId,
                        receiver_name  AS receiverName,
                        phone,
                        city,
                        district,
                        ward,
                        detail_address AS detailAddress,
                        is_default     AS defaultAddress,
                        is_active      AS active
                    FROM addresses
                    WHERE user_id = :uid
                      AND is_active = 1
                    ORDER BY is_default DESC, id DESC
                """)
                        .bind("uid", userId)
                        .mapToBean(Address.class)
                        .list()
        );
    }

    // ================== FIND BY ID ==================
    public Address findById(int id, int userId) {
        return getJdbi().withHandle(h ->
                h.createQuery("""
                    SELECT
                        id,
                        user_id        AS userId,
                        receiver_name  AS receiverName,
                        phone,
                        city,
                        district,
                        ward,
                        detail_address AS detailAddress,
                        is_default     AS defaultAddress,
                        is_active      AS active
                    FROM addresses
                    WHERE id = :id
                      AND user_id = :uid
                """)
                        .bind("id", id)
                        .bind("uid", userId)
                        .mapToBean(Address.class)
                        .findOne()
                        .orElse(null)
        );
    }

    // ================== INSERT ==================
    public void insert(Address a) {
        getJdbi().useTransaction(h -> {

            if (a.isDefaultAddress()) {
                h.createUpdate("""
                    UPDATE addresses
                    SET is_default = 0
                    WHERE user_id = :uid
                """)
                        .bind("uid", a.getUserId())
                        .execute();
            }

            h.createUpdate("""
                INSERT INTO addresses
                (user_id, receiver_name, phone, city, district, ward,
                 detail_address, is_default, is_active)
                VALUES
                (:uid, :name, :phone, :city, :district, :ward,
                 :detail, :def, 1)
            """)
                    .bind("uid", a.getUserId())
                    .bind("name", a.getReceiverName())
                    .bind("phone", a.getPhone())
                    .bind("city", a.getCity())
                    .bind("district", a.getDistrict())
                    .bind("ward", a.getWard())
                    .bind("detail", a.getDetailAddress())
                    .bind("def", a.isDefaultAddress() ? 1 : 0)
                    .execute();
        });
    }

    // ================== SOFT DELETE ==================
    public void softDelete(int id, int userId) {
        getJdbi().withHandle(h ->
                h.createUpdate("""
                    UPDATE addresses
                    SET is_active = 0
                    WHERE id = :id
                      AND user_id = :uid
                """)
                        .bind("id", id)
                        .bind("uid", userId)
                        .execute()
        );
    }

    // ================== SET DEFAULT ==================
    public void setDefault(int id, int userId) {
        getJdbi().useTransaction(h -> {

            h.createUpdate("""
                UPDATE addresses
                SET is_default = 0
                WHERE user_id = :uid
            """)
                    .bind("uid", userId)
                    .execute();

            h.createUpdate("""
                UPDATE addresses
                SET is_default = 1
                WHERE id = :id
                  AND user_id = :uid
            """)
                    .bind("id", id)
                    .bind("uid", userId)
                    .execute();
        });
    }
    // ================== UPDATE ĐỊA CHỈ ==================
    public void update(Address a) {
        getJdbi().useTransaction(h -> {

            // Nếu đặt làm mặc định → reset default cũ
            if (a.isDefaultAddress()) {
                h.createUpdate("""
                UPDATE addresses
                SET is_default = 0
                WHERE user_id = :uid
            """)
                        .bind("uid", a.getUserId())
                        .execute();
            }

            // Update địa chỉ
            h.createUpdate("""
            UPDATE addresses
            SET receiver_name = :name,
                phone = :phone,
                city = :city,
                district = :district,
                ward = :ward,
                detail_address = :detail,
                is_default = :def
            WHERE id = :id
              AND user_id = :uid
        """)
                    .bind("id", a.getId())
                    .bind("uid", a.getUserId())
                    .bind("name", a.getReceiverName())
                    .bind("phone", a.getPhone())
                    .bind("city", a.getCity())
                    .bind("district", a.getDistrict())
                    .bind("ward", a.getWard())
                    .bind("detail", a.getDetailAddress())
                    .bind("def", a.isDefaultAddress() ? 1 : 0)
                    .execute();
        });
    }

}
