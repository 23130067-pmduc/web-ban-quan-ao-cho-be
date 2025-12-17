<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thông tin đơn hàng - Thanh toán VCB</title>
    <link rel="stylesheet" href="../css/thongtindonhang.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
</head>

<body>
<!-- THÔNG TIN ĐƠN HÀNG -->
<section class="wrapper">

     <!-- ====== TOP HEADER WITH LOGO & TIMER ====== -->
    <div class="top-header">
        <img src="../img/Vietcombank_Logo.png" class="vnpay-logo">

        <div class="timer-top">
            Giao dịch hết hạn sau 
            <span id="min">14</span> : <span id="sec">57</span>
        </div>
    </div>

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


    <!-- RIGHT: BANK PAYMENT FORM -->
    <div class="payment-box">
        <div class="payment-header">
            <h3>Thanh toán qua Ngân hàng VCB</h3>
        </div>

        <div class="tab-title">Thẻ nội địa</div>

        <div class="form-group">
            <label for="st">Số thẻ</label>
            <input type="text" id="st" placeholder="Nhập số thẻ">
        </div>

        <div class="form-group">
            <label for="tcl">Tên chủ thẻ</label>
            <input type="text" id="tcl" placeholder="Nhập tên chủ thẻ (không dấu)">
        </div>

        <div class="form-group">
            <label for="km">Mã khuyến mại</label>
            <div class="promo-box">
                <input type="text" id="km" placeholder="Nhập mã khuyến mại">
                <button class="btn-select">Chọn mã</button>
            </div>
        </div>

        <p class="term"><a href="#">Điều kiện sử dụng dịch vụ</a></p>

        <div class="payment-buttons">
            <a href="thanhtoan_login.jsp" class="btn-cancel">Hủy thanh toán</a>
            <a href="xacthucotp.jsp" class="btn-submit">Tiếp tục</a>
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
<script src="../javaScript/timer.js"></script>
</html>