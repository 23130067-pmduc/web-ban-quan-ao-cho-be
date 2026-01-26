package vn.edu.nlu.fit.shopquanao.Dao;

import vn.edu.nlu.fit.shopquanao.model.Address;
import java.util.List;

public class AddressDao extends BaseDao {

    // ================== GET BY USER (CHỈ HIỂN THỊ ĐANG ACTIVE) ==================
    public List<Address> getByUser(int userId) {
        return getJdbi().withHandle(h ->
                h.createQuery("""
                SELECT 
                    id,
                    user_id,
                    receiver_name,
                    phone,
                    city,
                    district,
                    ward,
                    detail_address,
                    is_default,
                    is_active
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
                    user_id,
                    receiver_name,
                    phone,
                    city,
                    district,
                    ward,
                    detail_address,
                    is_default,
                    is_active
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

    // ================== INSERT (TRÙNG → BẬT LẠI) ==================
    public void insert(Address a) {
        getJdbi().useTransaction(h -> {

            Integer oldId = h.createQuery("""
                SELECT id
                FROM addresses
                WHERE user_id = :uid
                  AND receiver_name = :name
                  AND phone = :phone
                  AND detail_address = :detail
            """)
                    .bind("uid", a.getUserId())
                    .bind("name", a.getReceiverName())
                    .bind("phone", a.getPhone())
                    .bind("detail", a.getDetailAddress())
                    .mapTo(Integer.class)
                    .findOne()
                    .orElse(null);

            // Nếu trùng → bật lại
            if (oldId != null) {
                h.createUpdate("""
                    UPDATE addresses
                    SET is_active = 1
                    WHERE id = :id
                """)
                        .bind("id", oldId)
                        .execute();
                return;
            }

            // Nếu đặt mặc định → reset cái cũ
            if (a.isDefault()) {
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
                    .bind("def", a.isDefault() ? 1 : 0)
                    .execute();
        });
    }

    // ================== UPDATE ==================
    public void update(Address a) {
        getJdbi().useHandle(h -> {

            if (a.isDefault()) {
                h.createUpdate("""
                    UPDATE addresses
                    SET is_default = 0
                    WHERE user_id = :uid
                """)
                        .bind("uid", a.getUserId())
                        .execute();
            }

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
                    .bind("def", a.isDefault() ? 1 : 0)
                    .execute();
        });
    }

    // ================== SOFT DELETE ==================
    public void softDelete(int id, int userId) {
        getJdbi().useHandle(h ->
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
        getJdbi().useHandle(h -> {

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
}
