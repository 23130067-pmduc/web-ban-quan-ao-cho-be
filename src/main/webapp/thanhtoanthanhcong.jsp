<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thanh toán thành công</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
    <link rel="stylesheet" href="../css/thanhtoanthanhcong.css">
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
            <img src="../img/gau.jpg" alt="SunnyBear Logo">
        </div>

        <div class="menu">
            <ul>
                <li><a href="index_login.jsp">Trang chủ</a></li>
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

<div class="search-overlay" id="searchOverlay">
    <img class="logo" src="../img/gau.jpg" alt="Logo">

    <div class="boxSearch">
        <input type="text" placeholder="Tìm kiếm sản phẩm..."/>
        <button> <i class="fa-solid fa-magnifying-glass"></i> </button>
    </div>

    <span class="closeSearch" id="closeSearch">&times; </span>
</div>
<div class="success-box">
    <h1>✔ Đặt hàng thành công!</h1>
    <p>Vui lòng giữ máy & bắt máy để SunnyBear Shop liên lạc xác nhận đơn hàng. Cảm ơn Quý Khách.</p>
    <a href="index_login.jsp">Quay về trang chủ</a>
</div>

<!-- Gợi ý sản phẩm -->
<section class="products">
    <h2>Gợi ý cho bạn</h2>
    <div class="product-list">
        <div class="product-card">
            <img src="../img/blazer.jpg" alt="Set Áo Blazer & Quần Short">
            <h3>Set Áo Blazer & Quần Short</h3>
            <p>Phong Cách Lịch Lãm</p>
            <span>429.000₫</span>
            <button class="btn-add">Thêm vào giỏ</button>
        </div>

        <div class="product-card">
            <img src="../img/aosomitrang.jpg" alt="Áo sơ mi trắng">
            <h3>Áo sơ mi trắng</h3>
            <p>Lịch sự, dễ phối đồ</p>
            <span>175.000₫</span>
            <button class="btn-add">Thêm vào giỏ</button>
        </div>

        <div class="product-card">
            <img src="../img/aokhoac.jpg" alt="Áo Khoác Hoodie">
            <h3>Áo Khoác Hoodie</h3>
            <p>Lịch sự, dễ phối đồ</p>
            <span>329.000₫</span>
            <button class="btn-add">Thêm vào giỏ</button>
        </div>

        <div class="product-card">
            <img src="../img/vest.jpg" alt="Set Vest 2 In 1 SHEIN">
            <h3>Set Vest 2 In 1 SHEIN</h3>
            <p>Lịch Lãm & Thoải Mái</p>
            <span>430.000₫</span>
            <button class="btn-add">Thêm vào giỏ</button>
        </div>

        <div class="product-card">
            <img src="../img/vestt.jpg" alt="Bộ vest bé trai">
            <h3>Bộ vest bé trai</h3>
            <p>Tặng thêm áo thun sành điệu</p>
            <span>590.000₫</span>
            <button class="btn-add">Thêm vào giỏ</button>
        </div>

        <div class="product-card">
            <img src="../img/nasa.jpg" alt="Bộ thun tay ngắn cổ tròn NASA">
            <h3>Bộ thun tay ngắn cổ tròn NASA</h3>
            <p>Phù hợp bé trai năng động</p>
            <span>192.000₫</span>
            <button class="btn-add">Thêm vào giỏ</button>
        </div>

        <div class="product-card">
            <img src="../img/aolen.jpg" alt="Áo len tay dài đính cúc đơn giản">
            <h3>Áo len tay dài đính cúc đơn giảnh</h3>
            <p>Đơn giản, ấp áp, dễ phối đồ</p>
            <span>240.000₫</span>
            <button class="btn-add">Thêm vào giỏ</button>
        </div>

        <div class="product-card" date-category="dobo">
            <img src="../img/aokemtui.jpg" alt="Bộ thun cao cấp kèm túi đeo chéo">
            <h3>Bộ thun cao cấp kèm túi đeo chéo</h3>
            <p>Bền, gọn nhẹ, thoải mái</p>
            <span>272.000₫</span>
            <button class="btn-add">Thêm vào giỏ</button>
        </div>
    </div>
    <a href="listqabt_login.jsp" class="btn-view-more">Xem thêm</a>
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
            <a href="index_login.jsp">Trang chủ</a>
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
                <a href="#"><img src="../img/zalo.webp" alt="Zalo"></a>
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
<script src="../javaScript/pageatxl.js"></script>
<script src="../javaScript/header.js"></script>
<script src="../javaScript/thongBao.js"></script>
<script src="../javaScript/search.js"></script>
</html>

