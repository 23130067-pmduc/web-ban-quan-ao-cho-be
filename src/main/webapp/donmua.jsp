<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Đơn mua</title>
    <link rel="stylesheet" href="../css/donmua.css">
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
<!-- Ô TÌM KIẾM ẨN -->
<div class="search-overlay" id="searchOverlay">
    <img class="logo" src="../img/gau.jpg" alt="Logo">

    <div class="boxSearch">
        <input type="text" placeholder="Tìm kiếm sản phẩm..."/>
        <button> <i class="fa-solid fa-magnifying-glass"></i> </button>
    </div>

    <span class="closeSearch" id="closeSearch">&times; </span>
</div>


<!-- Đơn hàng của tôi -->
<section class="profile-container">
    <div class="profile-sidebar">
        <div class="user-info">
            <div class="avatar">
                <img src="../img/aochuV.jpg" alt="Avatar">
                <button class="change-avatar-btn">Đổi ảnh</button>
            </div>
            <h3>Nguyễn Văn A</h3>
            <p>Thành viên từ: 15/03/2024</p>
        </div>

        <nav class="profile-menu">
            <ul>
                <li><a href="profile.jsp"><i class="fas fa-user"></i> Thông tin cá nhân</a></li>
                <li><a href="diachi.jsp"><i class="fas fa-map-marker-alt"></i> Địa chỉ của tôi</a></li>
                <li class="active"><a href="donmua.html"><i class="fas fa-clipboard-list"></i> Đơn hàng của tôi</a></li>
                <li><a href="doimatkhau.jsp"><i class="fas fa-lock"></i> Đổi mật khẩu</a></li>
                <li><a href="trangchu.jsp"><i class="fa fa-sign-out"></i> Đăng xuất</a></li>
            </ul>
        </nav>
    </div>

    <div class="profile-content">
        <h2>Đơn hàng của tôi</h2>

        <form class="profile-form">
            <!-- Ô trạng thái -->
            <div class="orderTab">
                <button type="button" class="tab active" data-tab="tat-ca">Tất cả</button>
                <button type="button" class="tab" data-tab="cho-xac-nhan">Chờ xác nhận</button>
                <button type="button" class="tab" data-tab="dang-giao">Đang giao</button>
                <button type="button" class="tab" data-tab="hoan-thanh">Hoàn thành</button>
                <button type="button" class="tab" data-tab="da-huy">Đã hủy</button>
            </div>

            <!-- Tìm kiếm -->
            <div class="timkiem">
                <i class="fa-solid fa-magnifying-glass"></i>
                <input type="text" placeholder="Bạn có thể tìm kiếm theo tên Shop, ID đơn hàng hoặc Tên sản phẩm">
            </div>

            <!-- Đơn hàng 1 -->
            <div class="order-item" data-status="dang-giao">
                <div class="order-center">
                    <div class="order-left">
                        <img src="../img/aox.webp" alt="sp">
                        <div class="order-info">
                            <h3>Áo polo in hình khủng long SunnyBear</h3>
                            <p>Phân loại: Xanh lá, 10-15kg</p>
                            <p>x1</p>
                        </div>
                    </div>

                    <div class="order-right">
                        <span class="status dang-giao">Đang giao</span>
                        <p class="price">150.000đ</p>
                    </div>
                </div>


                <div class="order-bottom">
                    <div class="order-total">
                        <strong>Thành tiền:</strong> <span>150.000₫</span>
                    </div>


                    <p class="order-note">
                        Vui lòng chỉ nhấn <strong>'Đã nhận hàng'</strong> khi đơn hàng đã được giao đến bạn và sản phẩm nhận được không có lỗi và đầy đủ.
                    </p>

                    <div class="order-buttons">
                        <button disabled class="btn disabled">Đã Nhận Hàng</button>
                        <button disabled class="btn disabled">Yêu Cầu Trả Hàng/Hoàn Tiền</button>
                        <button class="contact">Liên Hệ Người Bán</button>
                    </div>

                </div>
            </div>

            <!-- Đơn hàng 2 -->
            <div class="order-item" data-status="hoan-thanh">
                <div class="order-center">
                    <div class="order-left">
                        <img src="../img/aox.webp" alt="sp">
                        <div class="order-info">
                            <h3>Áo polo in hình khủng long SunnyBear</h3>
                            <p>Phân loại: Xanh lá, 10-15kg</p>
                            <p>x1</p>
                        </div>
                    </div>

                    <div class="order-right">
                        <span class="status hoan-thanh">Hoàn thành</span>
                        <p class="price">150.000đ</p>
                    </div>
                </div>


                <div class="order-bottom">
                    <div class="order-total">
                        <strong>Thành tiền:</strong> <span>150.000₫</span>
                    </div>


                    <div class="order-buttons">
                        <button class="btn-mualai">Mua lại</button>
                        <button class="contact">Liên Hệ Người Bán</button>
                    </div>

                </div>

            </div>

            <!-- Đơn hàng 3 -->
            <div class="order-item" data-status="da-huy">
                <div class="order-center">
                    <div class="order-left multiple">
                        <!-- Sản phẩm 1 -->
                        <div class="single-product">
                            <img src="../img/aox.webp" alt="sp">
                            <div class="order-info">
                                <h3>Áo polo in hình khủng long SunnyBear</h3>
                                <p>Phân loại: Xanh lá, 10-15kg</p>
                                <p>x1</p>
                            </div>
                        </div>

                        <!-- Sản phẩm 2 (Mới thêm) -->
                        <div class="single-product">
                            <img src="../img/xanhnhat.webp" alt="sp">
                            <div class="order-info">
                                <h3>Áo polo in hình khủng long SunnyBear</h3>
                                <p>Phân loại: Xanh nhạt, 10-15kg</p>
                                <p>x2</p>
                            </div>
                        </div>
                    </div>

                    <div class="order-right">
                        <span class="status da-huy">Đã hủy</span>
                        <p class="price">450.000đ</p>
                    </div>
                </div>


                <div class="order-bottom">
                    <div class="order-total">
                        <strong>Thành tiền:</strong> <span>450.000₫</span>
                    </div>


                    <div class="order-buttons">
                        <button class="btn-mualai">Mua lại</button>
                        <a href="../html/chitietdonhuy.html" class="btn-huydon">Xem chi tiết hủy đơn</a>
                        <button class="contact">Liên Hệ Người Bán</button>
                    </div>

                </div>

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
<script src="../javaScript/donmua.js    "></script>
<script src="../javaScript/pageatxl.js"></script>
<script src="../javaScript/header.js"></script>
<script src="../javaScript/thongBao.js"></script>
<script src="../javaScript/search.js"></script>
</html>