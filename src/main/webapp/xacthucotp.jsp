<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xác thực OTP - VCB</title>
    <link rel="stylesheet" href="./css/xacthucotp.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
</head>

<body>
<!-- THÔNG TIN ĐƠN HÀNG -->
<section class="wrapper">

     <!-- ====== TOP HEADER WITH LOGO & TIMER ====== -->
    <div class="top-header">
        <img src="img/Vietcombank_Logo.png" class="vnpay-logo">

        <div class="timer-top">
            Giao dịch hết hạn sau 
            <span id="min">14</span> : <span id="sec">57</span>
        </div>
    </div>
    <div class="top-notice"><i class="fa-solid fa-triangle-exclamation"></i> Qúy khách vui lòng không tắt trình duyệt cho đến khi nhận được kết quả giao dịch trên website. Xin cảm ơn.</div>

    <!-- LEFT: ORDER INFO -->
    <div class="order-box">
    <h3>Thông tin đơn hàng</h3>

    <div class="info-row">
        <span class="info-label">Số tiền thanh toán</span>
        <span class="info-price">300.000 VND</span>
    </div>

    <div class="info-row">
        <span class="info-label">Giá trị đơn hàng</span>
        <span class="info-value">300.000 VND</span>
    </div>

    <div class="info-row">
        <span class="info-label">Phí giao dịch</span>
        <span class="info-value">0 VND</span>
    </div>

    <div class="info-row">
        <span class="info-label">Mã đơn hàng</span>
        <span class="info-value">1be2ea49-1966-4ba3-bfca-8e6dcddf68cb</span>
    </div>

    <div class="info-row">
        <span class="info-label">Nhà cung cấp</span>
        <span class="info-value">VIETCOMBANK</span>
    </div>

</div>

    <!-- RIGHT: OTP VERIFICATION FORM -->
    <div class="payment-box">
        <div class="payment-header">
            <h3>Xác thực OTP</h3>
        </div>

        <div class="tab-title">Nhập mã OTP</div>

        <div class="form-group">
            <label for="otp">Mã OTP</label>
            <input type="text" id="otp" placeholder="Nhập mã OTP bạn nhận được">
        </div>

        <p class="term">Mã OTP sẽ được gửi đến số điện thoại đăng ký của bạn.</p>

        <div class="payment-buttons">
            <a href="thongtindonhang.jsp" class="btn-cancel">Hủy giao dịch</a>
            <a href="thanhtoanthanhcong.jsp" class="btn-submit">Xác nhận</a>
        </div>
    </div>

    <!-- SUPPORT BOTTOM INFO -->
    <div class="support-sdt">
        <p class="fa-phone"> <i class="fa-solid fa-phone"></i>: 1900 54 54 13</p>
    </div>

    <div class="support-email">
        <p class="fa-mail"> <i class="fa-solid fa-envelope"></i>: support@vcb.com.vn</p>
    </div>
</section>
<p class="copyright">Phát triển bởi Vietcombank © 2025.</p>
</body>
<script src="./javaScript/timer.js"></script>
</html>
