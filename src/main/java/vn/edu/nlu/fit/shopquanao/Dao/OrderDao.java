package vn.edu.nlu.fit.shopquanao.Dao;

public class OrderDao extends BaseDao{
    public int createOrder(int userId,
                           String receiver,
                           String phone,
                           String address,
                           String note,
                           String paymentMethod,
                           double totalPrice) {

        return getJdbi().withHandle(h ->
                h.createUpdate("""
            INSERT INTO orders(
                user_id, receiver_name, phone, shipping_address,
                total_price, discount, shipping_fee, final_amount,
                payment_methods, payment_statuses, order_status, created_at
            )
            VALUES(
                :uid, :receiver, :phone, :address,
                :total, 0, 0, :total,
                :payment, 'UNPAID', 'PENDING', NOW()
            )
        """)
                        .bind("uid", userId)
                        .bind("receiver", receiver)
                        .bind("phone", phone)
                        .bind("address", address)
                        .bind("total", totalPrice)
                        .bind("payment", paymentMethod)
                        .executeAndReturnGeneratedKeys("id")
                        .mapTo(int.class)
                        .one()
        );
    }


}
