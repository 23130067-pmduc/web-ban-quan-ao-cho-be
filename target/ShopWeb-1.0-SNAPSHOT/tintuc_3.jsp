<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Xu hướng thời trang 2025</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
    <style>
        *{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body{
            max-height: 100vh;
        }

        /* Ẩn header khi cuộn xuống */
        .header {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            background: white;
            z-index: 999;
            transition: top 0.4s ease;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        /* Khi thêm class hide → header trượt lên */
        .header.hide {
            top: -120px; /* ẩn hẳn khỏi màn hình */
        }

        /* Để phần nội dung không bị header che */
        body {
            padding-top: 130px;
        }


        /* Phần này chỉnh lại @.@*/

        .header .topbar{
            max-height: 30px;
            background-color: black;
            color: white;
            display: flex;
            justify-content: space-between;
            font-size: 13px;
        }

        .header .topbar #hotline{
            padding: 7px 50px;
            margin: 0;
        }
        .header .topbar #thongBao{
            padding: 7px 50px;
            margin: 0;
            cursor: pointer;
            gap: 6px;
            transition: color 0.3s;
        }
        .header .topbar #thongBao:hover{
            color: #C89F7B;
        }
        .header .topbar #thongBao i{
            font-size: 16px;
        }

        #notification-box{
            display: none;
            position: absolute;
            top: 30px;
            right: 50px;
            background: white;
            border-radius: 5px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
            width: 320px;
            z-index: 1000;
            padding: 10px 15px;
            font-size: 14px;
            animation: fadein 0.3s ease;
        }

        #notification-box ul{
            list-style: none;
        }

        #notification-box ul li{
            padding: 10px 5px;
            border-bottom: 1px solid #e4dddd;
            color: black;


        }
        #notification-box ul li:last-child {
            border: none;
        }

        #notification-box.active {
            display: block;
        }

        .header .navbar{
            display: flex;
            justify-content: space-between;
            align-items: center;
            height: 100px;
            border-bottom: 1px solid #C89F7B;

        }
        .logo{
            display: flex;
            justify-content: center;
        }

        .header img{
            height: 120px;
            width: 200px;
            padding: 15px 30px;
            cursor: pointer;

        }
        .header h1{
            padding: 25px 5px;

        }



        /*Thanh ds */
        .navbar ul{
            display: flex;
            gap: 20px;
            list-style: none;
            text-decoration: none;
            margin: 0;
            padding: 0;
        }
        .navbar ul li{
            position: relative;
        }
        .navbar a{
            text-decoration: none;
            color: black;
            font-weight: bold;
            transition: color 0.2s;     /*Màu chữ thay đổi từ từ chứ không phải thay đổi đột ngột*/
            display: block;
            padding: 10px 15px;
        }
        .navbar a:hover{
            color: #C89F7B;
        }

        header .sub{
            display: none;
            position: absolute;
            background-color: white;
            top: 100%;
            left: 0;
            border-radius: 8px;
            border: 1px solid #C89F7B;
            box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2);
            list-style: none;
            margin: 0;
            padding: 0;
            z-index: 1000;
            width: 200px;

        }
        header .sub a{
            display: block;
            padding: 10px 15px;
            text-decoration: none;
            color: black;
            font-weight: normal;
            transition: background-color 0.2s;
        }

        header li:hover .sub{
            display: block;
        }

        /**/
        .sub li a:hover{
            background-color: #C89F7B;
            color: white;
            border-radius: 5px;
        }


        .actions{
            display: flex;
            gap: 40px;
            padding-right: 50px;
        }

        /* ========== USER MENU & DROPDOWN ========== */
        .user-menu {
            position: relative;
            display: inline-block;
        }

        /* Icon căn giữa */
        .iconUser {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            cursor: pointer;
        }

        .iconUser i {
            font-size: 20px;
            color: black;
            transition: color 0.2s, transform 0.2s;
        }

        .iconUser:hover i {
            color: #C89F7B;
        }

        /* Dropdown */
        .user-dropdown {
            display: none;
            position: absolute;
            left: 70%;
            transform: translateX(-70%);
            top: 100%;
            border: 1px solid #C89F7B;
            border-radius: 8px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
            list-style: none;
            margin: 0;
            padding: 0;
            z-index: 1000;
            width: max-content;
            min-width: 100%;
            white-space: nowrap;
            background-color: white;
        }

        /* Hiển thị dropdown khi hover */
        .user-menu:hover .user-dropdown {
            display: block;
        }

        .user-dropdown li a {
            display: block;
            padding: 10px 15px;
            color: black;
            text-decoration: none;
            font-weight: normal;
            transition: background-color 0.2s;
        }


        .user-dropdown li a:hover {
            background-color: #C89F7B;
            color: white;
            border-radius: 5px;
        }

        /* Hiệu ứng icon */
        .icon i {
            font-size: 20px;
            color: black;
        }

        .icon:hover i {
            color: #C89F7B;
        }


        /* Menu con ẩn */
        .navbar .actions .user-dropdown {
            display: none;
            position: absolute;
            top: 100%; /* nằm ngay dưới icon user */

            background-color: #fff;
            border: 1px solid #C89F7B;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            list-style: none;
            margin: 0;
            padding: 0;
            z-index: 1000;
            min-width: 150px;

        }

        /* Các item trong menu con */
        .user-dropdown li a {
            display: block;
            padding: 10px 15px;
            text-decoration: none;
            color: black;
            font-weight: normal;
            transition: background-color 0.2s;
        }

        .user-dropdown li a:hover {
            background-color: #C89F7B;
            color: white;
            border-radius: 5px;
        }

        /* Khi hover vào user thì hiện menu con */
        .user-menu:hover .user-dropdown {
            display: block;
        }

        /* Hiệu ứng icon */
        .icon i {
            font-size: 20px;
            color: black;
            transition: color 0.2s, transform 0.2s;
        }

        .icon:hover i {
            color: #C89F7B;
            transform: scale(1.2);
        }
        /* ===========THANH TÌM KIẾM ẨN==========*/
        .search-overlay{
            position: fixed;
            top: -100%;
            left: 0;
            width: 100%;
            height: 150px;
            background: #fff;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 30px;
            padding: 0 20px;
            z-index: 1000;
            transition: top 0.4s ease;
        }

        .search-overlay.active {
            top: 0;
        }
        /* Ô nhập tìm kiếm */
        .boxSearch{
            position: relative;
            width: 50%;
            max-width: 600px;
        }
        .boxSearch input{
            width: 100%;
            padding: 12px 50px 12px 15px;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 5px;
            outline: none;
        }
        .boxSearch input:focus {
            border-color: #ff6f61;
            box-shadow: 0 0 5px rgba(255, 111, 97, 0.5);
            background: #f8f6f6;
            transition: all 0.2s ease;
        }

        .boxSearch button{
            position: absolute;
            top: 50%;
            right: 10px;
            transform: translateY(-50%);
            border: none;
            background: transparent;
            font-size: 18px;
            cursor: pointer;
        }

        .closeSearch{
            font-size: 40px;
            cursor: pointer;
            flex-shrink: 0;
            padding-right: 50px;

        }
        .search-overlay .logo{
            display: flex;


        }

        .search-overlay img{
            height: 120px;
            width: 200px;
            padding: 15px 30px;
            cursor: pointer;

        }

        /* MAIN */
        .title {
            background-color: #f8f8f8;
            border: 1px solid #eee;
            padding: 15px 50px;
            display: inline-block;
            width: 100%;
            box-sizing: border-box;
        }

        .title span {
            color: #4b0000;
            font-weight: 600;
            letter-spacing: 1px;
        }

        .content{
            display: grid;
            grid-template-columns: 3fr 1fr;
            gap: 50px;
            padding: 30px 60px;
        }
        .content .mainArticle img{
            width: 60%;
            margin: 10px 0;
            border-radius: 10px;

        }
        .content .mainArticle h3{
            padding: 15px 0;
        }

        .meta{
            font-size: 14px;
            color: #c39595;
            margin: 10px;
        }
        .sidebar {
            background: #f6f1f1;
            padding: 15px;
            border-radius: 10px;
            height: fit-content;
            position: sticky;
            top: 150px;
        }

        .sidebar h3 {
            font-size: 16px;
            border-bottom: 2px solid #8B0000;
            padding-bottom: 8px;
            margin-bottom: 10px;
            color: #4b0000;
        }

        .related {
            margin-bottom: 12px;
        }
        .related a {
            display: flex;
            align-items: center;
            text-decoration: none;
            color: inherit;
            gap: 10px;
            padding: 6px;
            border-radius: 8px;
            transition: background 0.2s ease;
        }


        .related img{
            width: 80px;
            height: 70px;
            border-radius: 5px;
            object-fit: cover;
        }
        .related img:hover{
            transform: scale(1.05);
            transition: background 0.3s ease;
        }
        .related p {
            font-size: 14px;
            margin: 0 0 4px;
            color: #222;
            font-weight: 500;
        }

        .related p:hover {
            text-decoration: underline;
            color: #C89F7B;
        }





        /* ========== FOOTER ========== */
        .footer {
            background-color: #222222;
            color: #C89F7B;
            padding: 50px 80px 20px;
            font-size: 15px;
            line-height: 1.8;
            display: flex;
            gap: 0;
            align-items: flex-start;
        }

        .s-footer-1,
        .s-footer-2,
        .s-footer-3 {
            flex: 1;
            padding: 0 30px;
        }

        .s-footer-1 {
            text-align: left;
        }

        .s-footer-2 {
            text-align: center;
            border-right: 2px solid #FFF8E7;
            border-left: 2px solid #FFF8E7;
        }

        .s-footer-3 {
            text-align: center;
            border-right: 2px solid #FFF8E7;

        }

        .footer-info h3 {
            font-size: 22px;
            color: #A9C87D;
            margin-bottom: 15px;
        }
        .footer-info p {
            margin: 5px 0;
            color: #FFF8E7;
        }

        .footer-danhmuc {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .footer-danhmuc h3 {
            font-size: 22px;
            color: #A9C87D;
        }
        .footer-danhmuc a {
            color: #A9C87D;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease, transform 0.3s ease;
        }
        .footer-danhmuc a:hover {
            color: #C89F7B;
            transform: scale(1.05);
        }

        .footer-contact h3 {
            font-size: 22px;
            color: #A9C87D;
            margin-bottom: 15px;

        }

        .footer-contact p {
            margin: 10px 0;
            color: #FFF8E7;
        }

        .footer-contact .work-time {
            padding: 15px;
            border-radius: 10px;
            margin-top: 15px;
            font-size: 14px;
            color: #FFF8E7;
        }

        .footer-contact .work-time p {
            margin: 8px 0;
            line-height: 1.6;
        }

        .footer-contact .work-time p:first-child::before {
            content: "🕐 ";
            font-size: 16px;
            margin-right: 5px;
        }

        .footer-contact .work-time strong {
            color: #A9C87D;
        }

        .copyright {
            border-top: 1.5px solid #666666;
            padding: 15px;
            text-align: center;
            font-size: 13px;
            color: #FFF8E7;
            background-color: #222222;
        }

        .s-footer-4{
            text-align: center;

        }
        .footer-social h3{
            font-size: 22px;
            color: #A9C87D;
            margin-bottom: 15px;
        }

        .footer-social {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 15px;
            padding-left: 50px;
        }

        .social-icons{
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 12px;
        }
        .footer-social a {
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 2px solid #000;
            border-radius: 10px;
            transition: all 0.3s ease;
            text-decoration: none;
            cursor: pointer;
            background: transparent;

        }
        .footer-social a:hover {
            background-color: #000;
            color: #fff;
            transform: scale(1.1);
        }


        .footer-social img {
            width: 20px;
            height: 20px;
            object-fit: contain;
            filter: none;
            transition: all 0.3s ease;
        }

        .footer-social a:hover img {
            transform: scale(1.05)
        }

    </style>
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
            <img src="img/gau.jpg" alt="SunnyBear Logo">
        </div>

        <div class="menu">
            <ul>
                <li><a href="index.jsp">Trang chủ</a></li>
                <li ><a href="product.jsp">Sản phẩm ▾</a>
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
                    <li><a href="loginn.jsp">Đăng nhập</a></li>
                    <li><a href="register.jsp">Đăng ký</a></li>
                </ul>
            </div>
            <a href="giohang.jsp" class="iconCart"><i class="fa-solid fa-cart-shopping"></i></a>
        </div>
    </nav>


</header>


<!-- Ô TÌM KIẾM ẨN -->
<div class="search-overlay" id="searchOverlay">
    <img class="logo" src="img/gau.jpg" alt="Logo">

    <div class="boxSearch">
        <input type="text" placeholder="Tìm kiếm sản phẩm..."/>
        <button> <i class="fa-solid fa-magnifying-glass"></i> </button>
    </div>

    <span class="closeSearch" id="closeSearch">&times; </span>
</div>

<!-- ============== MAIN =================== -->
<div class="title">
    <span>TIN TỨC / SunnyBear Kids Clothing</span>
</div>

<main class="content">
    <article class="mainArticle">
        <h2>SunnyBear Kids Clothing - Shop quần áo trẻ em</h2>
        <p class="meta">🗓 2/11/2025 08:45 AM &nbsp; 👁 19185 Lượt xem</p>
        <p>SunnyBear Kids Clothing là thương hiệu thời trang trẻ em nổi bật trong năm 2025, mang đến phong cách hiện
            đại, năng động và đáng yêu cho các bé trai và bé gái. Với tiêu chí “An toàn – Chất lượng – Thời trang”,
            SunnyBear luôn chú trọng đến chất liệu vải thân thiện với làn da nhạy cảm của trẻ.</p>
        <br>
        <p>Bộ sưu tập mới nhất của SunnyBear Kids Clothing lấy cảm hứng từ gam màu pastel nhẹ nhàng, kết hợp cùng thiết
            kế tối giản nhưng tinh tế, giúp bé luôn thoải mái khi vận động và tự tin thể hiện cá tính. Các mẫu áo thun,
            váy, quần short hay áo khoác đều được gia công tỉ mỉ, phù hợp với khí hậu Việt Nam.</p>

        <img src="img/dodep1.png" alt="Bộ sưu tập mới nhất">

        <br>
        <p>Không chỉ là nơi mua sắm, SunnyBear còn là điểm đến lý tưởng cho các bậc phụ huynh muốn tìm hiểu xu hướng
            thời trang trẻ em mới nhất. Tại đây, bạn sẽ được trải nghiệm không gian thân thiện, cùng đội ngũ tư vấn tận
            tâm giúp chọn lựa trang phục phù hợp cho bé yêu.</p>

        <br>
        <p><strong>SunnyBear Kids Clothing</strong> – Đồng hành cùng con bạn trên hành trình lớn khôn, giúp bé luôn rạng
            rỡ và tự tin mỗi ngày!</p>
    </article>


    <aside class="sidebar">
        <h3>Tin tức liên quan:</h3>

        <div class="related">
            <div class="relativeContent">
                <a href="tintuc_1.jsp">
                    <img src="http://127.0.0.1:5500/img/quanaokonen.webp" alt="Không nên mua cho trẻ em">
                    <p>Những loại quần áo không nên mua cho trẻ em</p>
                </a>
            </div>

        </div>

        <div class="related">
            <div class="relativeContent">
                <a href="tintuc_2.jsp">
                    <img src="http://127.0.0.1:5500/img/xuhuong.jpg" alt="Xu hướng thời trang 2025">
                    <p>Xu hướng thời trang trẻ em cao cấp năm 2025</p>
                </a>
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
            <a href="index.jsp">Trang chủ</a>
            <a href="product.jsp">Sản Phẩm</a>
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
                <a href="#"><img src="http://127.0.0.1:5500/img/zalo.webp" alt="Zalo"></a>
                <a href="#"><i class="fa-brands fa-twitter"></i></a>
                <a href="#"><i class="fa-brands fa-instagram"></i></a>
                <a href="#"><i class="fa-brands fa-tiktok"></i></a>
                <a href="#"><i class="fa-brands fa-youtube"></i></a>
            </div>
        </div>
    </section>
</div>
</body>
<script src="javaScript/thongBao.js"></script>
<script src="javaScript/header.js"></script>
<script src="javaScript/search.js"></script>
</html>