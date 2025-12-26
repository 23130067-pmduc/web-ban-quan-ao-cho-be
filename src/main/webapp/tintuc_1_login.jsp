<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Không nên mua cho trẻ em</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
    <link rel="stylesheet" href="./css/tintuc_1.css">
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
                        <li><a href="donmua.jsp"><i class="fa-solid fa-clipboard-list"></i> Đơn hàng của tôi</a></li>
                        <li><a href="trangchu.jsp"><i class="fa fa-sign-out"></i> Đăng xuất</a></li>
                    </ul>
                </div>
                <a href="giohang_login.jsp" class="iconCart"><i class="fa-solid fa-cart-shopping"></i></a>
            </div>
        </nav>


    </header>
    <div class="search-overlay" id="searchOverlay">
      <img class="logo" src="./img/gau.jpg" alt="Logo">

      <div class="boxSearch">
          <input type="text" placeholder="Tìm kiếm sản phẩm..."/>
          <button> <i class="fa-solid fa-magnifying-glass"></i> </button>
      </div>

      <span class="closeSearch" id="closeSearch">&times; </span>
    </div>


    <!-- ============== MAIN =================== -->
    <div class="title">
        <span>TIN TỨC / Những loại quần áo không nên mua cho trẻ em</span>
    </div>

    <main class="content">
        <article class="mainArticle">
            <h2>Những loại quần áo không nên mua cho trẻ em</h2>
            <p class="meta">🗓 2/11/2025 08:45 AM &nbsp; 👁 166 Lượt xem</p>
            <p>Quần áo kiểu dáng sành điệu của người lớn, khăn quàng cổ dài hay đồ nhiều họa tiết... là những có vẻ
                thời trang, nhưng dễ khiến con bạn bị thương.</p>


            <h3> - Váy có nhiều hạt trang trí:</h3>
            <p>Quần áo trẻ em không nên có nhiều phụ kiện trang trí. Những đứa trẻ tò mò có thể xé nhỏ, cho vào mũi,
                tai hoặc nuốt những thứ hấp dẫn, nhiều màu sắc này.</p>
            <img src="./img/nhieutrangtri.webp" alt="Quần áo có hạt trang trí">


            <h3> - Khăn quàng cổ dài:</h3>
            <p>Một chiếc khăn quàng cổ của trẻ em thoạt nhìn thường vô thưởng vô phạt, nhưng lại là mối nguy hiểm
                tiềm tàng. Khăn dài dễ vướng vào đồ chơi hoặc cầu trượt, xích đu... Đứa trẻ rất khó thoát ra nếu
                không có sự trợ giúp của người lớn.<br>
                <br>
                Ở một số quốc gia còn cấm quàng khăn khi trẻ đi học mẫu giáo.</p>
            <img src=".//img/khancodai.webp" alt="Khăn quàng cổ dài">



            <h3> - Áo có mũ trừm long dầy:</h3>
            <p>Chiếc mũ trùm đầu lòa xòa khiến trẻ khó nhìn thấy những vật xung quanh và có thể trở thành nguyên nhân
                của một sự cố, nhất là khi đi trên đường hoặc trời tối. <br>
                <br>
                Bên cạnh đó, cũng giống như một chiếc khăn quàng cổ, mũ trùm đầu dễ vướng vào đồ ở khu vui chơi.</p>
            <img src=".//img/aoday.webp" alt="Áo có mũ trùm long dầy">
        </article>


        <aside class="sidebar">
            <h3>Tin tức liên quan:</h3>

            <div class="related">
                <div class="relativeContent">
                    <a href="tintuc_2_login.jsp">
                        <img src="./img/xuhuong.jpg" alt="Xu hướng thời trang 2025">
                        <p>Xu hướng thời trang trẻ em cao cấp năm 2025</p>
                    </a>
                </div>

            </div>

            <div class="related">
                <div class="relativeContent">
                    <a href="tintuc_3_login.jsp">
                        <img src="./img/quanao.jpg" alt="SunnyBear Kids Clothing">
                        <p>SunnyBear Kids Clothing</p>
                    </a>
                </div>

            </div>

        </aside>
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

</body>
<script src="./javaScript/header.js"></script>
<script src="./javaScript/thongBao.js"></script>
<script src="./javaScript/search.js"></script>
</html>