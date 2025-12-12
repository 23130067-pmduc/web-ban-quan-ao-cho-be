<%--
  Created by IntelliJ IDEA.
  User: VIET
  Date: 12/11/2025
  Time: 8:17 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quần áo bé gái</title>
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
            border: 0;
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
        /* Nút Xem thêm */
        #load-more {
            display: block;
            margin: 60px auto 0;
            background-color: #ffffff;
            color: #666666;
            text-decoration: none;
            padding: 10px 25px;
            border-radius: 25px;
            font-size: 15px;
            font-weight: 500;
            transition: all 0.3s ease;
            width: fit-content;
            position: relative;
            cursor: pointer;
        }

        #load-more::before,
        #load-more::after {
            content: "";
            position: absolute;
            top: 50%;
            width: 550px;
            height: 2px;
            background-color: #C89F7B;
            transform: translateY(-50%);
        }

        #load-more::before {
            left: -550px;
        }

        #load-more::after {
            right: -550px;
        }


        #load-more:hover {
            background-color: #5B3A29;
            color: #FFF8E7;
            transform: scale(1.05);
        }


        .hidden{
            display: none;
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



        /* PHẦN LIST QUẦN ÁO BÉ GÁI */
        .products {
            padding: 80px 100px;
            background-color: #ffffff;
            text-align: center;
            border-top: 2px solid #C89F7B;
        }

        .products h2 {
            font-size: 30px;
            color: #5B3A29;
            margin-bottom: 50px;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            position: relative;
        }

        .products h2::after {
            content: "";
            display: block;
            width: 90px;
            height: 3px;
            background-color: #A9C87D;
            margin: 10px auto 0;
            border-radius: 3px;
        }
        /* ===== THANH LỌC SẢN PHẨM ===== */
        .filter-bar {
            background-color: #ffffff;
            padding: 20px 50px;
            margin: 30px 40px 50px;
            display: flex;
            flex-direction: column;
            gap: 15px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* Dòng nút phân loại */
        .filter-category,
        .filter-sort .sort-buttons {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
            align-items: center;
            justify-content: flex-start;
        }

        /* ===== NÚT CƠ BẢN ===== */
        .filter-bar button {
            background-color: #ffffff;
            border: 1.5px solid #A9C87D;
            color: #222222;
            padding: 7px 16px;
            border-radius: 25px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .filter-bar button:hover {
            background-color: #43a047;
            color: #ffffff;
            box-shadow: 0 3px 8px #A9C87D;
            transform: translateY(-2px);
        }

        /* Nút đang chọn */
        .filter-bar .active {
            background-color: #dc2626;
            color: #ffffff;
            border-color: #A9C87D;
            box-shadow: 0 3px 8px #4b0000;
        }

        /* ===== DROPDOWN ===== */
        .dropdown {
            position: relative;
            display: inline-block;
        }

        .dropdown .dropbtn {
            display: flex;
            align-items: center;
            gap: 5px;
            border: 1.5px solid #A9C87D;
        }

        .dropdown .dropbtn i {
            transition: transform 0.3s ease;
        }

        /* Khi mở menu xổ xuống → icon xoay */
        .dropdown.show .dropbtn i {
            transform: rotate(180deg);
        }

        /* Menu xổ xuống */
        .dropdown-content {
            display: none;
            position: absolute;
            top: 42px;
            left: 0;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 12px #666666;
            min-width: 180px;
            overflow: hidden;
            z-index: 100;
            animation: dropdownFade 0.2s ease;
        }

        /* Hiệu ứng khi mở dropdown */
        @keyframes dropdownFade {
            from {
                opacity: 0;
                transform: translateY(-5px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .dropdown-content a {
            color: #333333;
            padding: 10px 15px;
            text-decoration: none;
            display: block;
            font-size: 14px;
            transition: background-color 0.25s ease, color 0.25s ease;
        }

        .dropdown-content a:hover {
            background-color: #A9C87D;
            color: #ffffff;
        }

        .dropdown.show .dropdown-content {
            display: block;
        }

        /* Liên kết bao quanh sản phẩm hoặc tiêu đề */
        .link-cover {
            display: block;
            color: #333;
            text-decoration: none;
            font-weight: 500;
            position: relative;
            transition: color 0.3s ease, transform 0.3s ease;
        }

        /* Hiệu ứng underline mềm mượt khi hover */
        .link-cover::after {
            content: "";
            position: absolute;
            left: 0;
            bottom: -2px;
            width: 0;
            height: 2px;
            background-color: #C89F7B;
            transition: width 0.3s ease;
        }

        /* Lưới sản phẩm */
        .product-list {
            display: flex;
            justify-content: center;
            align-items: stretch;
            flex-wrap: wrap;
            gap: 40px;
        }

        /* Thẻ sản phẩm */
        .product-card {
            background-color: #ffffff;
            border-radius: 20px;
            box-shadow: 0 4px 10px #666666;
            width: 280px;
            padding: 20px;
            transition: all 0.3s ease;
            cursor: pointer;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
            height: 540px;
        }

        .product-card:hover {
            box-shadow: 0 8px 20px #666666;
            transform: translateY(-8px);
        }

        /* Hình ảnh sản phẩm */
        .product-card img {
            width: 100%;
            height: 250px;
            object-fit: cover;
            border-radius: 15px;
            margin-bottom: 15px;
            transition: transform 0.3s ease;
        }

        /* Tên sản phẩm */
        .product-card h3 {
            font-size: 18px;
            color: #333;
            margin: 10px 0;
        }

        /* Mô tả*/
        .product-card p {
            color: #666666;
            font-size: 15px;
            margin-bottom: 10px;
            font-weight: 500;
        }

        /* Giá nổi bật */
        .product-card span {
            color: #dc2626;
            font-weight: bold;
            font-size: 16px;
            margin-bottom: 12px;
        }

        /* Nút thêm giỏ hàng */
        .btn-add {
            background-color: #A9C87D;
            color: #ffffff;
            border: none;
            padding: 10px 20px;
            border-radius: 25px;
            cursor: pointer;
            font-size: 15px;
            transition: all 0.3s ease;
            display: inline-block;
            align-self: center;
            margin: 0;
        }

        .btn-add:hover {
            background-color: #C89F7B;
            transform: scale(1.05);
        }
        /* ==========Khi nhấn thêm vào giỏ hàng ===========*/
        #toast {
            visibility: hidden;
            min-width: 250px;
            background-color: #4CAF50;
            color: white;
            text-align: center;
            border-radius: 12px;
            padding: 16px;
            position: fixed;
            z-index: 1000;
            right: 30px;
            bottom: 30px;
            font-size: 16px;
            box-shadow: 0 3px 8px rgba(0,0,0,0.2);
            opacity: 0;
            transition: opacity 0.5s, bottom 0.5s;
        }

        #toast.show {
            visibility: visible;
            opacity: 1;
            bottom: 50px;
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


<!-- ========== DANH SÁCH SẢN PHẨM ========== -->
<section class="products">
    <h2>QUẦN ÁO BÉ GÁI</h2>
    <!-- Thanh lọc sản phẩm -->
    <div class="filter-bar">
        <div class="filter-category">
            <button>Váy</button>
            <button>Áo, áo khoác</button>
            <button>Quần</button>
        </div>

        <!-- Nhóm sắp xếp -->
        <div class="filter-sort">
            <div class="sort-buttons">
                <button class="active">Mới nhất</button>
                <button>Bán chạy</button>
                <button>Khuyến mãi</button>

                <!-- Dropdown: Cân nặng -->
                <div class="dropdown">
                    <button class="dropbtn">
                        Cân nặng <i class="fa-solid fa-caret-down"></i>
                    </button>
                    <div class="dropdown-content">
                        <a href="#">Dưới 10kg</a>
                        <a href="#">10 - 20kg</a>
                        <a href="#">Trên 20kg</a>
                    </div>
                </div>


                <!-- Dropdown: Giá -->
                <div class="dropdown">
                    <button class="dropbtn">
                        Giá <i class="fa-solid fa-caret-down"></i>
                    </button>
                    <div class="dropdown-content">
                        <a href="#">Giá thấp đến cao</a>
                        <a href="#">Giá cao đến thấp</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="product-list">

        <div class="product-card">
            <img src="../img/vaycongchua.jpg" alt="Váy công chúa tay phồng">
            <h3>Váy công chúa tay phồng</h3>
            <p>Chất vải mềm, cổ điển xinh xắn</p>
            <span>340.000đ</span>
            <button class="btn-add">Thêm vào giỏ</button>
        </div>

        <div class="product-card">
            <img src="../img/vayhong.png" alt="Váy hồng dễ thương">
            <h3>Váy hồng dễ thương</h3>
            <p>Váy xinh xắn dễ thương, cute</p>
            <span>220.000đ</span>
            <button class="btn-add">Thêm vào giỏ</button>
        </div>

        <div class="product-card">
            <img src="../img/hoodie.jpg" alt="Sét áo hoodie và chân váy xếp ly">
            <h3>Sét áo hoodie và chân váy xếp ly</h3>
            <p>Phong cách đơn giản, năng động.</p>
            <span>350.000đ</span>
            <button class="btn-add">Thêm vào giỏ</button>
        </div>

        <div class="product-card">
            <img src="../img/vayhalo.jpg" alt="Váy Halloween">
            <h3>Váy Halloween</h3>
            <p>Phong cách halloween đầy ma mị</p>
            <span>535.000đ</span>
            <button class="btn-add">Thêm vào giỏ</button>
        </div>

        <div class="product-card">
            <img src="../img/aokhoaclong.jpg" alt="Áo khoác lông dài tay trơn">
            <h3>Áo khoác lông dài tay trơn</h3>
            <p>Mềm mại ấm áp sang trọng</p>
            <span>229.000₫</span>
            <button class="btn-add">Thêm vào giỏ</button>
        </div>

        <div class="product-card">
            <img src="../img/vaycono.jpg" alt="Váy công chúa nơ bèo nhún lớp lưới">
            <h3>Váy công chúa nơ bèo nhún lớp lưới</h3>
            <p>Sang trọng, cao cấp, quý tộc</p>
            <span>693.000đ</span>
            <button class="btn-add">Thêm vào giỏ</button>
        </div>

        <div class="product-card">
            <img src="../img/damlua.jpg" alt="Đầm công chúa lụa satin xếp ly kết nơ">
            <h3>Đầm công chúa lụa satin xếp ly kết nơ</h3>
            <p>Mềm mại, sang trọng, đẳng cấp</p>
            <span>385.000₫</span>
            <button class="btn-add">Thêm vào giỏ</button>
        </div>

        <div class="product-card">
            <img src="../img/aokhoacni.jpg" alt="Áo khoác nỉ nỉ">
            <h3>Áo khoác nỉ nỉ</h3>
            <p>In chữ cá tính, kiểu dáng mới mẻ</p>
            <span>220.000₫</span>
            <button class="btn-add">Thêm vào giỏ</button>
        </div>

        <div class="product-card">
            <img src="../img/aothun.jpg" alt="Áo thun dài tay">
            <h3>Áo thun dài tay</h3>
            <p>Mềm mại, không quá dày, họa tiết xinh xắn.”</p>
            <span>178.000₫</span>
            <button class="btn-add">Thêm vào giỏ</button>
        </div>

        <div class="product-card">
            <img src="../img/quanlegging.jpg" alt="Quần Legging">
            <h3>Quần Legging</h3>
            <p>Màu trơn mềm mịn co giãn.</p>
            <span>153.000₫</span>
            <button class="btn-add">Thêm vào giỏ</button>
        </div>

        <div class="product-card">
            <img src="../img/dambaby.jpg" alt="Đầm baby doll không tay">
            <h3>Đầm baby doll không tay</h3>
            <p>Tặng kèm túi đeo chéo thời trang.</p>
            <span>285.000đ</span>
            <button class="btn-add">Thêm vào giỏ</button>
        </div>

        <div class="product-card">
            <img src="../img/quanongrong.jpg" alt="Quần bé gái ống rộng kẻ sọc Colorblock">
            <h3>Quần bé gái ống rộng kẻ sọc Colorblock</h3>
            <p>Cá tính, đột phá, thời trang.</p>
            <span>178.000đ</span>
            <button class="btn-add">Thêm vào giỏ</button>
        </div>

        <div class="product-card">
            <img src="../img/quanongsuong.jpg" alt="Quần dáng suông ống rộng chữ G">
            <h3>Quần dáng suông ống rộng chữ G</h3>
            <p>Cá tính, năng động, xinh xắn</p>
            <span>119.000đ</span>
            <button class="btn-add">Thêm vào giỏ</button>
        </div>

        <div class="product-card">
            <img src="../img/aothatcavat.jpg" alt="Sét áo thắt cà vạt và chân váy xếp ly">
            <h3>Sét áo thắt cà vạt và chân váy xếp ly</h3>
            <p>Phong cách thủy thủ, xinh xắn.</p>
            <span>279.000đ</span>
            <button class="btn-add">Thêm vào giỏ</button>
        </div>

        <div class="product-card">
            <img src="../img/damthunsuong.jpg" alt="Đầm thun suông xẻ tà">
            <h3>Đầm thun suông xẻ tà</h3>
            <p>Cá tính, kiêu sa, xinh xắn.</p>
            <span>75.000đ</span>
            <button class="btn-add">Thêm vào giỏ</button>
        </div>

        <div class="product-card">
            <img src="../img/aovaquan.jpg" alt="Set Áo Sơ Mi Trắng & Quần Ống Rộng Sọc">
            <h3>Set Áo Sơ Mi Trắng & Quần Ống Rộng Sọc</h3>
            <p>Phong Cách Hè Năng Động.</p>
            <span>339.000đ</span>
            <button class="btn-add">Thêm vào giỏ</button>
        </div>

        <div class="load-more-container">
            <button id="load-more">Xem thêm</button>
        </div>
    </div>
</section>
<!-- ========== Khi nhấn thêm vào giỏ hàng-->
<div id="toast"></div>
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
<script>
    document.addEventListener("click", function (e) {
        const dropdowns = document.querySelectorAll(".dropdown");
        dropdowns.forEach((dropdown) => {
            if (dropdown.contains(e.target)) {
                dropdown.classList.toggle("show");
            } else {
                dropdown.classList.remove("show");
            }
        });
    });
</script>
<script src="javaScript/pageatxl.js"></script>
<script src="javaScript/header.js"></script>
<script src="javaScript/thongBao.js"></script>
<script src="javaScript/search.js"></script>
<script src="javaScript/themvaogiohang.js"></script>
<script src="javaScript/loadMore.js"></script>
</html>
