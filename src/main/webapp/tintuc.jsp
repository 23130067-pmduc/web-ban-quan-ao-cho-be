<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tin tức</title>
    <link rel="stylesheet" href="../css/tintuc.css">
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
                    <li><a href="trangchu.jsp">Trang chủ</a></li>
                    <li ><a href="sanpham.jsp">Sản phẩm ▾</a>
                        <ul class="sub">
                            <li class="subItem"> <a href="listqabt.jsp">Quần áo bé trai</a> </li>
                            <li class="subItem"> <a href="listbegai.jsp">Quần áo bé gái</a> </li>
                            <li class="subItem"> <a href="phukien.jsp">Phụ kiện</a> </li>
                        </ul>
                    </li>
                    <li><a href="tintuc.html">Tin tức</a></li>
                    <li><a href="khuyenmai.jsp">Khuyến mãi</a></li>
                    <li><a href="lienhe.jsp">Liên hệ</a></li>
                </ul>
            </div>

            <div class="actions">
                <a href="#" class="iconSearch"><i class="fa-solid fa-magnifying-glass"></i></a>
                <div class="user-menu">
                    <a href="#" class="iconUser"><i class="fa-regular fa-user"></i></a>
                    <ul class="user-dropdown">
                        <li><a href="login.jsp">Đăng nhập</a></li>
                        <li><a href="register.jsp">Đăng ký</a></li>
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
    <!-- =========== MAIN ============= -->
    <div class="title">
        <span>TIN TỨC</span>
    </div>

    <main class="container">

        <div class="newsContainer">
            <div class="newsItem">
                <a href="tintuc_1.jsp">
                    <img src="../img/quanaokonen.webp" alt="Quần áo không nên cho trẻ em">
                </a>
                <h3><a href="tintuc_1.jsp">Những loại quần áo không nên mua cho trẻ em</a> </h3>
                <p>Quần áo kiểu dáng sành điệu của người lớn, khăn quàng cổ dài hay áo nhiều họa tiết... là những có
                    vẻ thời trang, nhưng dễ khiến con bạn bị thương.</p>
            </div>

            <div class="newsItem">
                <a href="tintuc_2.jsp">
                    <img src="../img/xuhuong.jpg" alt="Xu hướng thời trang 2025">
                </a>
                <h3><a href="#">Xu hướng thời trang trẻ em cao cấp năm 2025</a> </h3>
                <p>Dưới đây là những xu hướng nổi bật, bạn không nên bỏ lỡ khi tìm mua quần áo trẻ em
                    trong năm nay.</p>
            </div>

            <div class="newsItem">
                <a href="tintuc_3.jsp">
                    <img src="..//img/quanao.jpg" alt="SunnyBear Kids Clothing">
                </a>
                <h3><a href="#">SunnyBear Kids Clothing - Shop quần áo trẻ em</a> </h3>
                <p>SunnyBear Kids Clothing - Shop quần áo trẻ em trai/gái 2025. là thương hiệu thời trang trẻ em
                    mang phong cách hiện đại, đáng yêu và an toàn cho bé...</p>
            </div>
        </div>

    </main>

    <!-- ========== FOOTER ========== -->
    <div class="footer">
        <section class="s-footer-1">
            <div class="footer-info">
                <h3>SunnyBear Kids Clothing</h3>
                <p class="slogan">Thời trang trẻ em chất lượng, an toàn cho bé yêu</p>
                <p class="fa-phone"> <i class="fa-solid fa-phone"></i> Hotline: 0909 999 999</p>
                <p class="fa-mail"> <i class="fa-solid fa-envelope"></i> Email: contact@sunnybear.vn</p>
            </div>
        </section>
        <section class="s-footer-2">

            <div class="footer-danhmuc">
                <h3>Danh mục</h3>
                <a href="trangchu.jsp">Trang chủ</a>
                <a href="sanpham.jsp">Sản Phẩm</a>
                <a href="tintuc.html">Tin Tức</a>
                <a href="khuyenmai.jsp">Khuyến mãi</a>
                <a href="lienhe.jsp">Liên hệ</a>

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
</body>
<script src="../javaScript/header.js"></script>
<script src="../javaScript/thongBao.js"></script>
<script src="../javaScript/search.js"></script>
</html>