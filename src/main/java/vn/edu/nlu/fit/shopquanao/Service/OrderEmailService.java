package vn.edu.nlu.fit.shopquanao.Service;

import vn.edu.nlu.fit.shopquanao.model.Order;
import vn.edu.nlu.fit.shopquanao.model.OrderItem;

import java.util.List;

public class OrderEmailService {

    public static String build(Order order, List<OrderItem> items) {

        StringBuilder sb = new StringBuilder();

        sb.append(String.format("""
            <div style="font-family:Arial,sans-serif;background:#f6f6f6;padding:20px">
              <div style="max-width:700px;margin:auto;background:#ffffff;padding:24px;border-radius:8px">
                
                <h2 style="color:#3a2418">🐻 SunnyBear cảm ơn bạn đã mua hàng!</h2>
                <p>Đơn hàng của bạn đã được ghi nhận thành công.</p>

                <hr>

                <h3>🧾 Thông tin đơn hàng</h3>
                <p><b>Mã đơn hàng:</b> #%d</p>
                <p><b>Ngày đặt:</b> %s</p>
                <p><b>Phương thức thanh toán:</b> %s</p>

                <hr>

                <h3>👤 Thông tin khách hàng</h3>
                <p><b>Người nhận:</b> %s</p>
                <p><b>SĐT:</b> %s</p>
                <p><b>Địa chỉ:</b> %s</p>
                %s

                <hr>

                <h3>📦 Sản phẩm</h3>
                <table width="100%%" border="1" cellpadding="8" cellspacing="0" style="border-collapse:collapse">
                  <tr style="background:#f2f2f2">
                    <th>Sản phẩm</th>
                    <th>Size</th>
                    <th>Màu</th>
                    <th>SL</th>
                    <th>Thành tiền</th>
                  </tr>
        """,
                order.getId(),
                order.getCreatedAt(),
                order.getPaymentMethods(),
                order.getReceiverName(),
                order.getPhone(),
                order.getShippingAddress(),
                order.getNote() != null && !order.getNote().isBlank()
                        ? "<p><b>Ghi chú:</b> " + order.getNote() + "</p>"
                        : ""
        ));

        for (OrderItem item : items) {
            sb.append(String.format("""
                <tr>
                  <td>%s</td>
                  <td>%s</td>
                  <td>%s</td>
                  <td align="center">%d</td>
                  <td align="right">%,.0f ₫</td>
                </tr>
            """,
                    item.getProductName(),
                    item.getSize(),
                    item.getColor(),
                    item.getQuantity(),
                    item.getTotal()
            ));
        }

        sb.append(String.format("""
                </table>

                <hr>

                <h3 style="text-align:right">Tổng thanh toán: <span style="color:#e53935">%,.0f ₫</span></h3>

                <p style="margin-top:30px">
                  💛 SunnyBear sẽ sớm liên hệ để xác nhận và giao hàng cho bạn.<br>
                  Nếu cần hỗ trợ, vui lòng phản hồi email này.
                </p>

                <p style="color:#888;font-size:13px">
                  © SunnyBear Kids Clothing
                </p>

              </div>
            </div>
        """, order.getFinalAmount()));

        return sb.toString();
    }
}
