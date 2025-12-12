<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>SunnyBear Shop</title>
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
            border: 1px;
            border-radius: 8px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
            list-style: none;
            margin: 0;
            padding: 0;
            z-index: 1000;
            width: 90px;
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

        /* ========== BANNER ========== */
        .banner {
            height: 500px;
            position: relative;
            overflow: hidden;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .anh {
            display: flex;
            justify-content: center;
        }

        .banner img {
            width: 100%;
            height: 500px;
            cursor: pointer;
            object-fit: cover;
            transition: opacity 0.5s ease;
        }


        .banner-text {
            position: absolute;
            z-index: 2;
            opacity: 0;               /* ẩn ban đầu */
            transition: opacity 0.5s ease, transform 0.5s ease;
        }

        .btn-primary {
            background-color: #A9C87D;
            border: none;
            color: white;
            padding: 12px 25px;
            border-radius: 25px;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #C89F7B;
            transform: scale(1.05);
        }
        /* phủ mờ ảnh */
        /* .banner:hover img {
            opacity: 0.5;
        /*} */

        .banner:hover .banner-text {
            opacity: 1;               /* hiện nút */
            transform: translateY(-30px);
        }

        /* ========== SLIDER ========== */
        .slider {
            position: relative;
            width: 100%;
            height: 100%;
            overflow: hidden;
            background-color: #f5f5f5;
        }

        .img-slides {
            display: flex;
            width: 100%;
            height: 100%;
            position: relative;
            transition: transform 0.6s ease-in-out;

        }

        .slide {
            flex: 0 0 100%;
            min-width: 100%;
            height: 100%;
            flex-shrink: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #f5f5f5;

        }

        .slide img {
            flex: 0 0 100%;
            height: 100%;
            object-fit: cover;  /* Ảnh vừa khung, giữ tỷ lệ gốc, không bị cắt */

            display: block;
        }

        /* Nút prev/next */
        .slider button {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            background-color: rgba(0, 0, 0, 0.5);
            color: white;
            border: none;
            padding: 15px 20px;
            font-size: 24px;
            cursor: pointer;
            transition: all 0.4s ease;
            z-index: 10;
            border-radius: 5px;
            opacity: 0;
            visibility: hidden;
            transform-origin: center center;

        }

        .slider button:hover {
            background-color: rgba(0, 0, 0, 0.8);
            transform: translateY(-50%);
        }

        .slider .prev {
            left: 20px;
        }

        .slider .next {
            right: 20px;
        }



        /* Khi hover vào vùng slider thì hiện nút */
        .slider:hover button {
            opacity: 1;
            visibility: visible;
            scale: 1.05;
        }

        /* ========== DANH MỤC ========== */
        .categories {
            padding: 60px 80px;
            background-color: #ffffff;
        }

        .categories h2 {
            font-size: 28px;
            color: #222222;
            margin-bottom: 60px;
            text-transform: uppercase;
            letter-spacing: 1px;
            text-align: center;
            position: relative;
        }

        .categories h2::after {
            content: "";
            display: block;
            width: 80px;
            height: 3px;
            background-color: #5B3A29;
            margin: 12px auto 0;
            border-radius: 3px;
        }

        .category-block {
            margin-bottom: 80px;
        }

        .category-title {
            font-size: 24px;
            color: #222222;
            margin-bottom: 35px;
            border-left: 5px solid #A9C87D;
            padding-left: 15px;
            font-weight: bold;
        }

        .category-products {
            display: flex;
            gap: 40px;
            flex-wrap: wrap;
            justify-content: center;
        }

        .product-mini{
            background-color: #ffffff;
            border-radius: 20px;
            box-shadow: 0 4px 8px #333333;
            width: 280px;
            padding: 20px;
            transition: all 0.3s ease;
            cursor: pointer;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            align-items: center;
            position: relative;
        }
        .product-mini .price::before {
            content: "Giá: ";
            color: #666666;
            font-weight: 600;
        }
        .link-cover {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 5;
            text-indent: -9999px;
        }
        .product-mini:hover {
            box-shadow: 0 8px 16px #333333;
            transform: translateY(-6px);
        }

        .product-mini img{
            width: 100%;
            height: 250px;
            object-fit: cover;
            border-radius: 15px;
            margin-bottom: 15px;
            transition: transform 0.3s ease;
        }


        .product-mini p{
            color: black;
            font-size: 18px;
            margin-bottom: 15px;
            font-weight: bold;
            text-align: center;
        }

        .product-mini .price{
            color: #dc2626;
            font-weight: bold;
            font-size: 16px;
        }

        .btn-add {
            position: relative;
            z-index: 10;
            background-color: #A9C87D;
            color: #ffffff;
            border: none;
            padding-bottom: 20px;
            border-radius: 25px;
            cursor: pointer;
            font-size: 15px;
            transition: all 0.3s ease;
        }

        .btn-add:hover {
            background-color: #ffffff;
            transform: scale(1.05);
        }
        .btn-view-more {
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
        }

        .btn-view-more::before,
        .btn-view-more::after {
            content: "";
            position: absolute;
            top: 50%;
            width: 550px;
            height: 2px;
            background-color: #C89F7B;
            transform: translateY(-50%);
        }

        .btn-view-more::before {
            left: -550px;
        }

        .btn-view-more::after {
            right: -550px;
        }


        .btn-view-more:hover {
            background-color: #5B3A29;
            color: #FFF8E7;
            transform: scale(1.05);
        }


        /* ========== SẢN PHẨM ========== */
        .products {
            padding: 60px 100px;
            background-color: #ffffff;
            text-align: center;
            border-top: 1px solid #5B3A29;
        }
        .products h2 {
            font-size: 28px;
            color: black;
            margin-bottom: 40px;
            text-transform: uppercase;
            letter-spacing: 1px;
            position: relative;
        }
        .products h2::after {
            content: "";
            display: block;
            width: 80px;
            height: 3px;
            background-color: #5B3A29;
            margin: 10px auto 0;
            border-radius: 3px;
        }

        .product-list {
            display: flex;
            justify-content: center;
            align-items: stretch;
            flex-wrap: wrap;
            gap: 40px;
        }
        .product-card{
            position: relative;
            background-color: #ffffff;
            border-radius: 20px;
            box-shadow: 0 4px 8px #333333;
            width: 280px;
            padding: 20px;
            transition: all 0.3s ease;
            cursor: pointer;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .product-card:hover {
            box-shadow: 0 8px 16px #333333;
            transform: scale(1.05);
        }
        .product-card img {
            width: 100%;
            height: 250px;
            object-fit: cover;
            border-radius: 15px;
            margin-bottom: 15px;
            transition: transform 0.3s ease;

        }
        .product-card h3 {
            font-size: 18px;
            color: black;
            margin: 10px 0;
        }

        .product-card p {
            color: #666666;
            font-size: 15px;
            margin-bottom: 15px;
            font-weight: 700;
        }

        /* Price container and responsive ordering */
        .price,
        .product-card p,
        .product-mini .price {
            display: inline-flex;
            align-items: baseline;
            gap: 8px;
            flex-wrap: nowrap;
        }

        .new-price {
            order: 1;
            color: #dc2626;
            font-weight: 800;
            font-size: 1rem;
        }

        .old-price {
            order: 2;
            color: #888888;
            font-weight: 400;
            font-size: 0.75rem;
            text-decoration-line: line-through;
            text-decoration-color: rgba(0,0,0,0.15);
            text-decoration-thickness: 2px;
            opacity: 0.95;
        }

        .btn-add {
            position: relative;
            z-index: 10;
            background-color: #A9C87D;
            color: #ffffff;
            border: none;
            padding: 10px 20px;
            border-radius: 25px;
            cursor: pointer;
            font-size: 15px;
            transition: all 0.3s ease;
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
            <img src="http://127.0.0.1:5500/img/gau.jpg" alt="SunnyBear Logo">
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

<div class="search-overlay" id="searchOverlay">
    <img class="logo" src="http://127.0.0.1:5500/img/gau.jpg" alt="Logo">

    <div class="boxSearch">
        <input type="text" placeholder="Tìm kiếm sản phẩm..."/>
        <button> <i class="fa-solid fa-magnifying-glass"></i> </button>
    </div>

    <span class="closeSearch" id="closeSearch">&times; </span>
</div>

<!-- ========== BANNER ========== -->
<section class="banner">
    <div class="slider">
        <div class="img-slides">

            <div class="slide">
                <a href="product.jsp">
                    <img src="${pageContext.request.contextPath}/img/banner1.png" alt="Slide 1">
                </a>
            </div>

            <div class="slide">
                <a href="product.jsp">
                    <img src="${pageContext.request.contextPath}/img/ab.png" alt="Slide 2">
                </a>
            </div>

            <div class="slide">
                <a href="product.jsp">
                    <img src="${pageContext.request.contextPath}/img/dodep1.png" alt="Slide 3">
                </a>
            </div>

            <div class="slide">
                <a href="product.jsp">
                    <img src="${pageContext.request.contextPath}/img/ban.png" alt="Slide 4">
                </a>
            </div>

        </div>
        <button class="prev">&#10094;</button>
        <button class="next">&#10095;</button>
    </div>

</section>

<!-- ========== SẢN PHẨM ========== -->
<section class="products">
    <h2>Sản phẩm mới nhất</h2>
    <div class="product-list">
        <div class="product-card">
            <img src="http://127.0.0.1:5500/img/aox.webp" alt="Áo polo in hình khủng long">
            <a href="pageatxl.jsp" class="link-cover"></a>
            <h3>Áo polo in hình khủng long</h3>
            <p>Giá: <span class="old-price">180.000đ</span> <span class="new-price">150.000đ</span></p>
            <button class="btn-add">Thêm vào giỏ</button>
        </div>
        <div class="product-card">
            <img src="http://127.0.0.1:5500/img/vayhong.png" alt="Váy hồng">
            <h3>Váy hồng dễ thương</h3>
            <p>Giá: <span class="old-price">264.000đ</span> <span class="new-price">220.000đ</span></p>
            <button class="btn-add">Thêm vào giỏ</button>
        </div>
        <div class="product-card">
            <img src="http://127.0.0.1:5500/img/dongu.webp" alt="Bộ đồ ngủ">
            <h3>Bộ đồ ngủ gấu</h3>
            <p>Giá: <span class="old-price">216.000đ</span> <span class="new-price">180.000đ</span></p>
            <button class="btn-add">Thêm vào giỏ</button>
        </div>
        <div class="product-card">
            <img src="http://127.0.0.1:5500/img/somi.png" alt="Áo sơ mi">
            <h3>Áo sơ mi</h3>
            <p>Giá: <span class="old-price">210.000đ</span> <span class="new-price">175.000đ</span></p>
            <button class="btn-add">Thêm vào giỏ</button>
        </div>


    </div>
</section>

<!-- ========== DANH MỤC ========== -->
<section class="categories">
    <h2>Danh mục nổi bật</h2>
    <!-- Bé trai -->
    <div class="category-block">
        <div class="category-title">Bé trai 👕</div>
        <div class="category-products">
            <div  class="product-mini">
                <a href="product.jsp" class="link-cover"></a>
                <img src="http://127.0.0.1:5500/img/aox.webp" alt="Áo polo in hình khủng long">
                <p>Áo polo in hình khủng long</p>
                <p class="price"><span class="old-price">180.000đ</span> <span class="new-price">150.000đ</span></p>
                <button class="btn-add">Thêm vào giỏ</button>
            </div>
            <div class="product-mini">
                <img src="http://127.0.0.1:5500/img/somi.png" alt="Áo sơ mi bé trai">
                <p>Áo sơ mi bé trai</p>
                <p class="price"><span class="old-price">210.000đ</span> <span class="new-price">175.000đ</span></p>
                <button class="btn-add">Thêm vào giỏ</button>
            </div>
            <div class="product-mini">
                <img src="http://127.0.0.1:5500/img/quanjogger.jpg" alt="Quần Jogger">
                <p>Quần Jogger</p>
                <p class="price"><span class="old-price">221.000đ</span> <span class="new-price">184.000đ</span></p>
                <button class="btn-add">Thêm vào giỏ</button>
            </div>
            <div class="product-mini">
                <img src="http://127.0.0.1:5500/img/aobalogame.jpg" alt="Áo ba lỗ hình Game Play">
                <p>Áo ba lỗ hình Game Play</p>
                <p class="price"><span class="old-price">115.000đ</span> <span class="new-price">96.000đ</span></p>
                <button class="btn-add">Thêm vào giỏ</button>
            </div>
        </div>
        <a href="product.jsp" class="btn-view-more">Xem thêm</a>
    </div>

    <!-- Bé gái -->
    <div class="category-block">
        <div class="category-title">Bé gái 👗</div>
        <div class="category-products">
            <div class="product-mini">
                <img src="http://127.0.0.1:5500/img/vayhong.png" alt="Váy hồng dễ thương">
                <p>Váy hồng dễ thương</p>
                <p class="price"><span class="old-price">264.000đ</span> <span class="new-price">220.000đ</span></p>
                <button class="btn-add">Thêm vào giỏ</button>
            </div>
            <div class="product-mini">
                <img src="http://127.0.0.1:5500/img/vayhalo.jpg" alt="Váy Halloween">
                <p>Váy Halloween</p>
                <p class="price"><span class="old-price">642.000đ</span> <span class="new-price">535.000đ</span></p>
                <button class="btn-add">Thêm vào giỏ</button>
            </div>
            <div class="product-mini">
                <img src="http://127.0.0.1:5500/img/hoodie.jpg" alt="Sét áo hoodie và chân váy xếp ly">
                <p>Sét áo hoodie và chân váy xếp ly</p>
                <p class="price"><span class="old-price">420.000đ</span> <span class="new-price">350.000đ</span></p>
                <button class="btn-add">Thêm vào giỏ</button>
            </div>
            <div class="product-mini">
                <img src="http://127.0.0.1:5500/img/vaycongchua.jpg" alt="Váy công chúa tay phồng">
                <p>Váy công chúa tay phồng</p>
                <p class="price"><span class="old-price">408.000đ</span> <span class="new-price">340.000đ</span></p>
                <button class="btn-add">Thêm vào giỏ</button>
            </div>
        </div>
        <a href="product.jsp" class="btn-view-more">Xem thêm</a>
    </div>

    <!-- Phụ kiện -->
    <div class="category-block">
        <div class="category-title">Phụ kiện 🎒</div>
        <div class="category-products">
            <div class="product-mini">
                <img src="http://127.0.0.1:5500/img/tathong.jpg" alt="Combo 5 đôi tất hoa màu hồng">
                <p>Combo 5 đôi tất hoa màu hồng</p>
                <p class="price"><span class="old-price">104.000đ</span> <span class="new-price">87.000đ</span></p>
                <button class="btn-add">Thêm vào giỏ</button>
            </div>
            <div class="product-mini">
                <img src="http://127.0.0.1:5500/img/muvanh.jpg" alt="Mũ vành kiểu dáng basic">
                <p>Mũ vành kiểu dáng basic</p>
                <p class="price"><span class="old-price">190.000đ</span> <span class="new-price">158.000đ</span></p>
                <button class="btn-add">Thêm vào giỏ</button>
            </div>
            <div class="product-mini">
                <img src="http://127.0.0.1:5500/img/balomeo.jpg" alt="Balo dạng trứng hình MÈO">
                <p>Balo dạng trứng hình MÈO</p>
                <p class="price"><span class="old-price">143.000đ</span> <span class="new-price">119.000đ</span></p>
                <button class="btn-add">Thêm vào giỏ</button>
            </div>
            <div class="product-mini">
                <img src="http://127.0.0.1:5500/img/donghokl.jpg" alt="Đồng hồ kim khủng long 3D">
                <p>Đồng hồ kim khủng long 3D</p>
                <p class="price"><span class="old-price">107.000đ</span> <span class="new-price">89.000đ</span></p>
                <button class="btn-add">Thêm vào giỏ</button>
            </div>
        </div>
        <a href="product.jsp" class="btn-view-more">Xem thêm</a>
    </div>


    <!-- ========== Khi nhấn thêm vào giỏ hàng-->
    <div id="toast"></div>
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
                <a href="#."><img src="http://127.0.0.1:5500/img/zalo.webp" alt="Zalo"></a>
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
<script>    let lastScrollTop = 0;
const header = document.getElementById("header");

window.addEventListener("scroll", function() {
    const currentScroll = window.pageYOffset || document.documentElement.scrollTop;
    if (currentScroll > lastScrollTop) {

        header.classList.add("hide");
    }else {
        header.classList.remove("hide");
    }

    lastScrollTop = currentScroll <= 0 ? 0 : currentScroll;
})
</script>
<script>
    // SLIDER - Hiệu ứng lướt sang trái/phải

    // Lấy phần tử slider và các slide
    const slider = document.querySelector('.img-slides');
    const slides = document.querySelectorAll('.img-slides .slide');
    const prevBtn = document.querySelector('.slider .prev');
    const nextBtn = document.querySelector('.slider .next');

    // Nếu không có slider thì thôi, tránh lỗi JS
    if (slider && slides.length > 0 && prevBtn && nextBtn) {
        let currentIndex = 0;
        const totalSlides = slides.length;

        function updateSlider() {
            const offset = -currentIndex * 100;
            slider.style.transform = 'translateX(' + offset + '%)';
        }

        // Next
        nextBtn.addEventListener('click', function () {
            currentIndex = (currentIndex + 1) % totalSlides;
            updateSlider();
        });

        // Prev
        prevBtn.addEventListener('click', function () {
            currentIndex = (currentIndex - 1 + totalSlides) % totalSlides;
            updateSlider();
        });

        // Tự động chuyển sau 6s
        setInterval(function () {
            currentIndex = (currentIndex + 1) % totalSlides;
            updateSlider();
        }, 6000);
    }
</script>
<script>const  thongbaoBtn = document.getElementById("thongBao");
const  notificationBox = document.getElementById("notification-box");


thongbaoBtn.addEventListener("click", function(event){
    event.stopPropagation();  // Cái này dùng để ngăn click lan ra ngoài.
    notificationBox.classList.toggle("active");

})
document.addEventListener("click", function(event){
    if (!notificationBox.contains(event.target) && !thongbaoBtn.contains(event.target)){
        notificationBox.classList.remove("active");
    }
})</script>
<script>document.addEventListener("DOMContentLoaded", () => {
    const searchIcon = document.querySelector(".iconSearch");
    const searchOverlay = document.getElementById("searchOverlay");
    const closeSearch = document.getElementById("closeSearch");

    //Khi nhấn vào icon Search thì trang trượt xuống.
    searchIcon.addEventListener("click", (e) => {
        e.preventDefault();
        searchOverlay.classList.add("active");
    })

    // Khi nhấn vào dấu X thì ânr đi
    closeSearch.addEventListener("click", () => {
        searchOverlay.classList.remove("active");
    })

    // Khi nhấn ra ngoài cũng ẩn đi
    document.addEventListener("click", (e) => {
        if (!searchOverlay.contains(e.target) && !searchIcon.contains(e.target)) {
            searchOverlay.classList.remove("active");
        }
    })
})</script>
<script>function showToast(message){
    const toast = document.getElementById("toast");
    toast.textContent = message;
    toast.className = "show";

    setTimeout(() => toast.className = toast.className.replace("show", ""), 3000);
}

const addBtn = document.querySelectorAll(".btn-add");
addBtn.forEach(button => {
    button.addEventListener("click", () =>{
        showToast("Đã thêm vào giỏ hàng!");
    });
});
</script>
</html>