<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shop quần áo trẻ em SunnyBear Kids</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
    <link rel="stylesheet" href="./css/giohang.css">



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
                <li><a href="trangchu.jsp">Trang chủ</a></li>
                <li ><a href="sanpham.jsp">Sản phẩm ▾</a>
                    <ul class="sub">
                        <li class="subItem"> <a href="listqabt.jsp">Quần áo bé trai</a> </li>
                        <li class="subItem"> <a href="listbegai.jsp">Quần áo bé gái</a> </li>
                        <li class="subItem"> <a href="phukien.jsp">Phụ kiện</a> </li>
                    </ul>
                </li>
                <li><a href="tintuc.jsp">Tin tức</a></li>
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
            <a href="giohang.html" class="iconCart"><i class="fa-solid fa-cart-shopping"></i></a>
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


<!-- ============MAIN GIỎ HÀNG ==================== -->
<div class="title">
    <span>GIỎ HÀNG CỦA BẠN</span>
</div>
<section class="card">

    <div class="container">
        <div class="card-content-left">
            <table>
                <tr>
                    <th>Sản phẩm</th>
                    <th>Tên sản phẩm</th>
                    <th>Màu</th>
                    <th>Size</th>
                    <th>Số lượng</th>
                    <th>Thành tiền</th>
                    <th>Xóa</th>
                </tr>
                <tr>
                    <td><img src="./img/aox.webp" alt=""></td>
                    <td><p>Áo polo in hình khủng long SunnyBear</p></td>
                    <td><img class="colorImg" src="./img/green.webp" alt="mauXanh"></td>
                    <td><p>10-15kg</p></td>
                    <td><input type="number" value="1" min="1"></td>
                    <td><p>150.000₫</p></td>
                    <td><span>X</span></td>
                </tr>
                <tr>
                    <td><img src="./img/den.webp" alt=""></td>
                    <td><p>Áo polo in hình khủng long SunnyBear</p></td>
                    <td><img class="colorImg" src="./img/black.webp" alt="mauDen"></td>
                    <td><p>16-20kg</p></td>
                    <td><input type="number" value="1" min="1"></td>
                    <td><p>150.000₫</p></td>
                    <td><span>X</span></td>
                </tr>
            </table>
        </div>
        <div class="card-content-right">
            <table>
                <tr>
                    <th colspan="2">TỔNG TIỀN GIỎ HÀNG</th>
                </tr>
                <tr>
                    <td>TỔNG SẢN PHẨM</td>
                    <td>2</td>
                </tr>
                <tr>
                    <td>TỔNG TIỀN HÀNG</td>
                    <td><p>300.000₫</p></td>
                </tr>
                <tr>
                    <td>TẠM TÍNH</td>
                    <td><p style="color: black; font-weight: bold">300.000₫</p></td>
                </tr>
            </table>

            <div class="card-content-right-text">
                <p>Bạn sẽ được miễn phí ship khi đơn hàng của bạn có tổng giá trị trên 500.000₫</p>
                <p style="color: red; font-weight: bold">Mua thêm 200.000₫ để được miễn phí ship</p>

            </div>

            <div class="card-content-right-button">
                <a href="sanpham.jsp">
                    <button id="ttms">TIẾP TỤC MUA SẮM</button>
                </a>
                <a href="thanhtoan.jsp">
                    <button id="tt">THANH TOÁN</button>
                </a>
            </div>
        </div>
    </div>
</section>


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
            <a href="tintuc.jsp">Tin Tức</a>
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
<script src="script.js"></script>

<script src="thongbao.js"></script>
</body>
<script src="./javaScript/header.js"></script>
<script src="./javaScript/slider.js"></script>
<script src="./javaScript/search.js"></script>
<script src="./javaScript/thongBao.js"></script>

</html>