<%--
  Created by IntelliJ IDEA.
  User: VIET
  Date: 12/11/2025
  Time: 8:19 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Shop quần áo trẻ em SunnyBear Kids</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
    <style>
        *{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        html, body {
            overflow-x: hidden;
            max-width: 100%;
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
            width: 100%;

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


        .user-menu {
            position: relative;
            display: inline-block;
        }

        /* Icon user căn giữa */
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


        /* ============== GIỎ HÀNG ================ */
        .card{
            padding: 50px 0;

        }
        .card .container {
            display: flex;
            align-items: flex-start; /* canh trên cùng hàng */
            justify-content: space-between; /* tách đều hai bên nếu muốn */
        }


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


        .card-content-left{
            flex: 2;
            padding-right: 20px;
            padding-left: 50px;

        }
        .card-content-left table{
            width: 100%;
            text-align: center;

        }
        .card-content-left table th{
            padding-bottom: 30px;
            font-size: 14px;
            text-transform: uppercase;
            color: #333;
            border-collapse: collapse;
            border-bottom: 2px solid #dddddd;
        }
        .card-content-left table p{
            font-size: 14px;
            color: #333;
        }
        .card-content-left table input{
            width: 30px;
        }

        .card-content-left table .colorImg{
            width: 25px;
            height: 25px;
            justify-items: center;
            text-align: center;
        }
        .card-content-left table span{
            display: flex;
            justify-content: center;
            align-items: center;
            width: 25px;
            height: 25px;
            border: 1px solid #dddddd;
            margin: 0 auto;
            cursor: pointer;
        }
        .card-content-left table td{
            padding: 20px 0;
            border-bottom: 1px solid #dddddd;
        }
        .card-content-left td:first-child img{
            width: 120px;
        }
        .card-content-left td:nth-child(2){
            max-width: 120px;
        }


        .card-content-right{
            flex: 1;
            padding-left: 20px;
            padding-right: 50px;
            border-left: 2px solid #dddddd;
        }
        .card-content-right table{
            width: 100%;
        }
        .card-content-right table th{
            padding-bottom: 30px;
            font-size: 14px;
            color: #333;
            text-align: center;
            border-collapse: collapse;
            border-bottom: 2px solid #dddddd;
        }
        .card-content-right table td{
            padding: 10px 0;
            font-size: 14px;
            color: #333;
        }
        .card-content-right table tr:nth-child(4) td{
            border-bottom: 2px solid #dddddd;
        }

        .card-content-right tr td:last-child {
            text-align: right;
        }
        .card-content-right-text{
            margin: 20px 0;
            text-align: center;

        }
        .card-content-right-text p{
            padding: 10px 0;
            font-size: 14px;
            color: #333;
        }
        .card-content-right-button{
            text-align: center;
            align-items: center;

        }
        .card-content-right-button button{
            padding: 0 20px;
            height: 35px;
            cursor: pointer;
            border-radius: 25px;
            font-weight: bold;

        }
        .card-content-right-button button:first-child{
            background-color: #fff;
            border: 1px solid black;
            margin-right: 20px;

        }
        .card-content-right-button button:first-child:hover{
            background-color: #ddd;
            transform: scale(1.03);
        }

        .card-content-right-button button:last-child{
            background-color: red;
            color: #fff;
            border: none;
        }
        .card-content-right-button button:last-child:hover{
            background-color: #c62828;
            border: 1px solid black;
            transform: scale(1.03);
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
                    <td><img src="img/aox.webp" alt=""></td>
                    <td><p>Áo polo in hình khủng long SunnyBear</p></td>
                    <td><img class="colorImg" src="img/green.webp" alt="mauXanh"></td>
                    <td><p>10-15kg</p></td>
                    <td><input type="number" value="1" min="1"></td>
                    <td><p>150.000₫</p></td>
                    <td><span>X</span></td>
                </tr>
                <tr>
                    <td><img src="img/den.webp" alt=""></td>
                    <td><p>Áo polo in hình khủng long SunnyBear</p></td>
                    <td><img class="colorImg" src="img/black.webp" alt="mauDen"></td>
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
                <button>TIẾP TỤC MUA SẮM</button>
                <a href="thanhtoan.html">
                    <button>THANH TOÁN</button>
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
<p class="copyright">© 2025 SunnyBear. All rights reserved.</p>
</body>
<script src="javaScript/header.js"></script>
<script src="javaScript/slider.js"></script>
<script src="javaScript/search.js"></script>
<script src="javaScript/thongBao.js"></script>

</html>