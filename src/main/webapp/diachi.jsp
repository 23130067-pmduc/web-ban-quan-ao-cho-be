<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Địa chỉ của tôi - SunnyBear Kids</title>
    <link rel="stylesheet" href="./css/diachi.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
</head>
<body>

<!-- ========== HEADER ========== -->
<header class="header" id="header">

    <nav class="topbar">
        <p id="hotline">Hotline: <b> 0909 999 999</b> (8h30 - 12h) Tất cả các ngày trong tuần | </p>
        <p id="thongBao">
            <i class="fa-regular fa-bell"></i>
            Thông báo của tôi
        </p>

        <div id="notification-box">
            <ul>
                <li>Hiện không có thông báo nào.</li>
                <li>Đăng nhập để được nhận thêm nhiều ưu đãi.</li>

            </ul>

        </div>
    </nav>



    <nav class="navbar">
        <div class="logo">
            <img src="./img/gau.jpg" alt="SunnyBear Logo">
        </div>

        <div class="menu">
            <ul>
                <li><a href="trangchu_login.jsp">Trang chủ</a></li>
                <li ><a href="sanpham_login.jsp">Sản phẩm ▾</a>
                    <ul class="sub">
                        <li class="subItem"> <a href="listqabt_login.jsp">Quần áo bé trai</a> </li>
                        <li class="subItem"> <a href="listbegai_login.jsp">Quần áo bé gái</a> </li>
                        <li class="subItem"> <a href="phukien_login.jsp">Phụ kiện</a> </li>
                    </ul>
                </li>
                <li><a href="tintuc_login.jsp">Tin tức</a></li>
                <li><a href="khuyenmai_login.jsp">Khuyến mãi</a></li>
                <li><a href="lienhe_login.jsp">Liên hệ</a></li>
            </ul>
        </div>

        <div class="actions">
            <a href="#" class="iconSearch"><i class="fa-solid fa-magnifying-glass"></i></a>
            <div class="user-menu">
                <a href="#" class="iconUser"><i class="fa-regular fa-user"></i></a>
                <ul class="user-dropdown">
                    <li><a href="profile.jsp"><i class="fa-solid fa-user"></i> Thông tin cá nhân</a></li>
                    <li><a href="#"><i class="fa-solid fa-clipboard-list"></i> Đơn hàng của tôi</a></li>
                    <li><a href="trangchu.jsp"><i class="fa fa-sign-out"></i> Đăng xuất</a></li>
                </ul>
            </div>
            <a href="giohang.jsp" class="iconCart"><i class="fa-solid fa-cart-shopping"></i></a>
        </div>
    </nav>
</header>

<!-- ========== THANH TÌM KIẾM ẨN ========== -->
<div class="search-overlay" id="search-overlay">
    <div class="logo">
        <img src="./img/logo.png" alt="logo">
    </div>
    <div class="boxSearch">
        <input type="text" id="search-input" placeholder="Tìm kiếm sản phẩm...">
        <button id="search-btn"><i class="fa fa-search"></i></button>
    </div>
    <div class="closeSearch" id="close-search">
        <i class="fa fa-times"></i>
    </div>
</div>

<!-- ========== NỘI DUNG CHÍNH ========== -->
<div class="address-container">
    <!-- Sidebar Navigation -->
    <div class="address-sidebar">
        <div class="user-info">
            <div class="avatar">
                <img src="./img/aochuV.jpg" alt="Avatar">
                <button class="change-avatar-btn">Đổi ảnh</button>
            </div>
            <h3>Nguyễn Văn A</h3>
            <p>Thành viên từ: 15/03/2024</p>
        </div>

        <nav class="profile-menu">
            <ul>
                <li><a href="profile.jsp"><i class="fas fa-user"></i> Thông tin cá nhân</a></li>
                <li class="active"><a href="diachi.jsp"><i class="fas fa-map-marker-alt"></i> Địa chỉ của tôi</a></li>
                <li><a href="donmua.jsp"><i class="fas fa-clipboard-list"></i> Đơn hàng của tôi</a></li>
                <li><a href="doimatkhau.jsp"><i class="fas fa-lock"></i> Đổi mật khẩu</a></li>
                <li><a href="trangchu.jsp"><i class="fa fa-sign-out"></i> Đăng xuất</a></li>
            </ul>
        </nav>
    </div>

    <!-- Address Content -->
    <div class="address-content">
        <div class="address-header">
            <h2>Địa chỉ của tôi</h2>
            <button class="btn-add-address"><i class="fas fa-plus"></i> Thêm địa chỉ mới</button>
        </div>
        
        <div class="address-list">
            <!-- Địa chỉ sẽ được render bởi JavaScript -->
        </div>
    </div>
</div>

<!-- Modal thêm/sửa địa chỉ -->
<div class="modal-overlay" id="addressModal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>Thêm địa chỉ mới</h3>
            <span class="modal-close">&times;</span>
        </div>
        <form class="address-form">
            <div class="form-group">
                <label for="recipient-name">Họ và tên người nhận <span class="required">*</span></label>
                <input type="text" id="recipient-name" placeholder="Nhập họ tên người nhận" required>
            </div>

            <div class="form-group">
                <label for="recipient-phone">Số điện thoại <span class="required">*</span></label>
                <input type="tel" id="recipient-phone" placeholder="Nhập số điện thoại" required>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="city">Tỉnh/Thành phố <span class="required">*</span></label>
                    <select id="city" required>
                        <option value="">-- Chọn Tỉnh/Thành phố --</option>
                        <option value="hcm">TP. Hồ Chí Minh</option>
                        <option value="hn">Hà Nội</option>
                        <option value="dn">Đà Nẵng</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="district">Quận/Huyện <span class="required">*</span></label>
                    <select id="district" required>
                        <option value="">-- Chọn Quận/Huyện --</option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label for="ward">Phường/Xã <span class="required">*</span></label>
                <select id="ward" required>
                    <option value="">-- Chọn Phường/Xã --</option>
                </select>
            </div>

            <div class="form-group">
                <label for="detail-address">Địa chỉ chi tiết <span class="required">*</span></label>
                <textarea id="detail-address" rows="3" placeholder="Số nhà, tên đường..." required></textarea>
            </div>

            <div class="form-group">
                <label class="checkbox-label">
                    <input type="checkbox" id="set-default">
                    Đặt làm địa chỉ mặc định
                </label>
            </div>

            <div class="form-actions">
                <button type="button" class="btn-cancel">Hủy</button>
                <button type="submit" class="btn-save">Lưu địa chỉ</button>
            </div>
        </form>
    </div>
</div>

<!-- ========== FOOTER ========== -->
<div class="footer">
    <section class="s-footer-1">
        <div class="footer-info">
            <h3>THÔNG TIN LIÊN HỆ</h3>
            <p><i class="fa fa-map-marker"></i> 123 Đường Hạnh Phúc, Quận 5, TP.HCM</p>
            <p><i class="fa fa-phone"></i> Hotline: 0909 999 999</p>
            <p><i class="fa fa-envelope"></i> Email: sunnybear@gmail.com</p>
        </div>
    </section>

    <section class="s-footer-2">
        <div class="footer-danhmuc">
            <h3>DANH MỤC</h3>
            <a href="listbegai_login.jsp">Bé gái</a>
            <a href="listqabt_login.jsp">Bé trai</a>
            <a href="phukien_login.jsp">Phụ kiện</a>
            <a href="khuyenmai_login.jsp">Khuyến mãi</a>
        </div>
    </section>

    <section class="s-footer-3">
        <div class="footer-contact">
            <h3>CHĂM SÓC KHÁCH HÀNG</h3>
            <div class="work-time">
                <p>Thứ 2 - Thứ 6: <strong>8h30 - 17h30</strong></p>
                <p>Thứ 7 - Chủ nhật: <strong>8h30 - 12h00</strong></p>
            </div>
        </div>
    </section>

    <section class="s-footer-4">
        <div class="footer-social">
            <h3>KẾT NỐI VỚI CHÚNG TÔI</h3>
            <div class="social-icons">
                <a href="#"><i class="fa-brands fa-facebook-f"></i></a>
                <a href="#"><img src="./img/zalo.webp" alt="Zalo"></a>
                <a href="#"><i class="fa-brands fa-twitter"></i></a>
                <a href="#"><i class="fa-brands fa-instagram"></i></a>
                <a href="#"><i class="fa-brands fa-tiktok"></i></a>
                <a href="#"><i class="fa-brands fa-youtube"></i></a>
            </div>
        </div>
    </section>
</div>
<p class="copyright">© 2025 SunnyBear. All rights reserved.</p>

</body>
<script src="./javaScript/header.js"></script>
<script src="./javaScript/thongBao.js"></script>
<script src="./javaScript/search.js"></script>
<script src="./javaScript/address.js"></script>
</html>
