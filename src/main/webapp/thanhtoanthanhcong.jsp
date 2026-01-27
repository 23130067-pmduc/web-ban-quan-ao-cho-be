<div class="success-box">
    <h1>✔ Đặt hàng thành công!</h1>

    <p>
        Mã đơn hàng: <b>#${order.id}</b>
    </p>

    <p>
        Tổng tiền:
        <b>
            <fmt:formatNumber value="${order.finalAmount}" type="number"/>₫
        </b>
    </p>

    <p>
        Phương thức thanh toán: <b>${order.paymentMethods}</b>
    </p>

    <p>
        Trạng thái: <b>${order.orderStatus}</b>
    </p>

    <p class="note">
        SunnyBear Shop sẽ liên hệ xác nhận đơn hàng trong thời gian sớm nhất 💛
    </p>

    <a href="trangchu_login.jsp" class="btn-home">Quay về trang chủ</a>
    <a href="my-orders" class="btn-orders">Xem đơn hàng của tôi</a>
</div>
