<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đổi Mật Khẩu - SunnyBear Kids</title>
    <link rel="stylesheet" href="./css/doimatkhau.css">
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
<!-- Ô TÌM KIẾM ẨN -->
<div class="search-overlay" id="searchOverlay">
    <img class="logo" src="./img/gau.jpg" alt="Logo">

    <div class="boxSearch">
        <input type="text" placeholder="Tìm kiếm sản phẩm..."/>
        <button> <i class="fa-solid fa-magnifying-glass"></i> </button>
    </div>

    <span class="closeSearch" id="closeSearch">&times; </span>
</div>
<!-- ========== ĐỔI MẬT KHẨU ========== -->
<section class="profile-container">
    <div class="profile-sidebar">
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
                <li><a href="diachi.jsp"><i class="fas fa-map-marker-alt"></i> Địa chỉ của tôi</a></li>
                <li><a href="donmua.jsp"><i class="fas fa-clipboard-list"></i> Đơn hàng của tôi</a></li>
                <li class="active"><a href="doimatkhau.jsp"><i class="fas fa-lock"></i> Đổi mật khẩu</a></li>
                <li><a href="trangchu.jsp"><i class="fa fa-sign-out"></i> Đăng xuất</a></li>
            </ul>
        </nav>
    </div>

    <div class="profile-content">
        <h2>Đổi mật khẩu</h2>

        <form class="profile-form">
            <div class="form-row">
                <div class="form-group">
                    <label for="oldpass">Mật khẩu hiện tại</label>
                    <input type="password" id="oldpass" placeholder="Nhập mật khẩu cũ">
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="newpass">Mật khẩu mới</label>
                    <input type="password" id="newpass" placeholder="Nhập mật khẩu mới">
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="repass">Nhập lại mật khẩu mới</label>
                    <input type="password" id="repass" placeholder="Nhập lại mật khẩu mới">
                </div>
            </div>

            <div class="form-actions">
                <button type="button" class="btn-cancel">Hủy</button>
                <button type="submit" class="btn-save">Lưu mật khầu</button>
            </div>
        </form>
    </div>
</section>

<!-- ========== FOOTER ========== -->
<div class="footer">
    <section class="s-footer-1">
        <div class="footer-info">
            <h3>SunnyBear Kids Clothing</h3>
            <p class="slogan">Thời trang trẻ em chất lượng, an toàn cho bé yêu</p>
            <p class="fa-phone"><i class="fa-solid fa-phone"></i> Hotline: 0909 999 999</p>
            <p class="fa-mail"><i class="fa-solid fa-envelope"></i> Email: contact@sunnybear.vn</p>
        </div>
    </section>
    <section class="s-footer-2">

        <div class="footer-danhmuc">
            <h3>Danh mục</h3>
            <a href="trangchu_login.jsp">Trang chủ</a>
            <a href="sanpham_login.jsp">Sản Phẩm</a>
            <a href="tintuc_login.jsp">Tin Tức</a>
            <a href="khuyenmai_login.jsp">Khuyến mãi</a>
            <a href="lienhe_login.jsp">Liên hệ</a>

        </div>

    </section>
    <section class="s-footer-3">
        <div class="footer-contact">
            <h3>Địa chỉ & Thời gian làm việc</h3>
            <p>123 Đường Hạnh Phúc, Quận 5, TP.HCM</p>
            <p>Thời gian làm việc: </p>
            <p>Thứ 2 - Thứ 6: 8h00 - 17h30</p>
            <p>Thứ 7 - Chủ nhật: 9h00 - 17h00</p>
        </div>
    </section>

    <section class="s-footer-4">
        <div class="footer-social">
            <h3>Kết nối với chúng tôi</h3>

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
<script src="./javaScript/pageatxl.js"></script>
<script src="./javaScript/header.js"></script>
<script src="./javaScript/thongBao.js"></script>
<script src="./javaScript/search.js"></script>
</html>