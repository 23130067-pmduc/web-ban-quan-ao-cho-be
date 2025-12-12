<%--
  Created by IntelliJ IDEA.
  User: VIET
  Date: 12/11/2025
  Time: 8:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Áo polo in hình khủng long</title>
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

        /* PHẦN NỘI DUNG */
        .product-detail {
            padding: 50px 80px;
            background-color: #fff;
            font-family: 'Segoe UI', sans-serif;
        }

        .product-container {
            display: flex;
            gap: 50px;
            margin-bottom: 60px;
        }

        /* ========== HÌNH ẢNH ========== */
        .product-image {
            flex: 1;
            text-align: center;
        }

        .product-image img#main-image {
            width: 100%;
            max-width: 400px;
            border-radius: 10px;
            transition: opacity 0.3s ease;
        }

        .product-image img#main-image.fade {
            opacity: 0.5;
        }

        .image-thumbs {
            display: flex;
            justify-content: center;
            margin-top: 15px;
            gap: 10px;
        }

        .image-thumbs img {
            width: 70px;
            height: 70px;
            border-radius: 6px;
            cursor: pointer;
            border: 2px solid transparent;
            transition: 0.3s;
        }

        .image-thumbs img.active,
        .image-thumbs img:hover {
            border-color: #A9C87D;
        }

        /* ========== THÔNG TIN SẢN PHẨM ========== */
        .product-info {
            flex: 1;
        }

        .product-name {
            font-size: 26px;
            font-weight: bold;
        }

        .product-price span {
            color: #e53935;
            font-size: 22px;
            font-weight: bold;
        }

        .product-rating {
            margin: 10px 0 20px;
            color: gold;
            font-size: 18px;
        }

        /* ========== MÀU SẮC & SIZE ========== */
        .color-options,
        .size-options {
            display: flex;
            gap: 10px;
            margin: 10px 0 20px;
            flex-wrap: wrap;
        }
        .color-thumb {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #666666;
            cursor: pointer;
            transition: transform 0.2s ease, border-color 0.2s ease, box-shadow 0.2s ease;

        }

        .color-thumb:hover {
            transform: scale(1.08);
            border-color: #C89F7B;
        }

        .color-thumb.active {
            border-color: #A9C87D;
        }


        .size-btn {
            padding: 6px 14px;
            border: 1px solid #cccccc;
            background: #FFF8E7;
            border-radius: 5px;
            cursor: pointer;
        }

        .size-btn:hover,
        .size-btn.active {
            color: #222222;
            border-color: #ee8322;
        }

        /* ========== SỐ LƯỢNG ========== */
        .quantity-control {
            display: flex;
            align-items: center;
            gap: 5px;
            margin-top: 15px;
        }

        .quantity-control input {
            width: 50px;
            text-align: center;
            font-size: 16px;
            padding: 5px;
        }

        .quantity-control button {
            background: #FFF8E7;
            border: none;
            font-size: 18px;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 4px;
        }

        /* ========== NÚT MUA ========== */
        .product-actions {
            display: flex;
            gap: 15px;
            margin-top: 50px;
            justify-content: flex-start;
            flex-wrap: nowrap;
        }


        .btn-add-cart,
        .btn-buy-now {
            flex: 0 0 auto;
            width: 200px;
            height: 55px;
            font-size: 16px;
            border: none;
            border-radius: 10px;
            font-weight: bold;
            cursor: pointer;
            color: white;
            transition: transform 0.3s, background-color 0.3s;
        }


        .btn-add-cart {
            background: #A9C87D;
        }

        .btn-buy-now {
            background: #dc2626;
        }

        .btn-add-cart:hover {
            background: #43a047;
            transform: scale(1.05);
        }

        .btn-buy-now:hover {
            background: #c62828;
            transform: scale(1.05);
        }
        /* ========== MÔ TẢ, ĐÁNH GIÁ, GỢI Ý ========== */
        .product-description {
            margin-top: 40px;
            border-top: 1px solid #ffffff;
            padding-top: 30px;
            color: #333333;
            line-height: 1.6;
        }

        .product-description h2 {
            color: #222222;
            margin-bottom: 15px;
            font-size: 26px;
        }

        .product-description p {
            margin-bottom: 16px;
        }

        .product-description ul {
            margin-left: 20px;
            list-style-type: disc;
            margin-bottom: 15px;
        }



        /* ========== ĐÁNH GIÁ SẢN PHẨM ========== */
        .product-review {
            margin-top: 50px;
            background-color: #f9f9f9;
            padding: 30px 25px;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .product-review h2 {
            color: #333333;
            font-size: 26px;
            margin-bottom: 20px;
            text-align: left;
        }

        /* Ngôi sao chọn đánh giá */
        .star-select {
            display: flex;
            justify-content: flex-start;
            margin-bottom: 15px;
        }

        .star {
            font-size: 28px;
            color: #ccc;
            cursor: pointer;
            transition: color 0.2s ease, transform 0.2s ease;
            margin: 0 5px;
        }

        .star:hover,
        .star.active {
            color: #FFD700;
            transform: scale(1.2);
        }

        /* Ô nhập nhận xét */
        #review-text {
            width: 100%;
            min-height: 100px;
            border: 1px solid #666666;
            border-radius: 10px;
            padding: 12px;
            font-size: 15px;
            resize: vertical;
            outline: none;
            transition: border-color 0.3s ease;
        }

        #review-text:focus {
            border-color: #A9C87D;
        }

        /* Nút gửi đánh giá */
        #submit-review {
            display: block;
            margin: 15px auto 25px;
            background-color: #43a047;
            color: white;
            border: none;
            padding: 10px 25px;
            border-radius: 25px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        #submit-review:hover {
            background-color: #43a047;
        }

        /* Danh sách đánh giá */
        .review-list {
            border-top: 2px solid #C89F7B;
            padding-top: 20px;
        }

        .review-list h3 {
            color: #333333;
            font-size: 24px;
            margin-bottom: 16px;
            text-align: left;
        }

        .review-item {
            background-color: #ffffff;
            padding: 10px 12px;
            border-radius: 8px;
            margin-bottom: 8px;
            font-size: 16px;
            line-height: 1.6;
            color: #333333;
            word-wrap: break-word;         /* Ngắt dòng nếu quá dài */
            overflow-wrap: break-word;     /* Hỗ trợ trình duyệt mới */
            white-space: normal;           /* Cho phép xuống hàng */
            max-width: 100%;               /* Không tràn khung */
        }

        .review-item strong {
            color: #43a047;
        }
        /* ========== GỢI Ý SẢN PHẨM ========== */
        .suggested-products {
            padding: 60px 80px;
            background-color: #ffffff;
            border-top: 1px solid #C89F7B;
        }

        .suggested-products h2 {
            font-size: 26px;
            color: #222222;
            margin-bottom: 60px;
            letter-spacing: 1px;
            text-align: center;
            position: relative;
        }

        .suggested-list {
            display: flex;
            gap: 40px;
            flex-wrap: wrap;
            justify-content: center;
        }

        .suggested-item {
            background-color: #ffffff;
            border-radius: 20px;
            box-shadow: 0 4px 8px #333333;
            width: 260px;
            padding: 20px;
            transition: all 0.3s ease;
            cursor: pointer;
            display: flex;
            flex-direction: column;
            align-items: center;
            position: relative;
            justify-content: space-between;
            gap: 12px;
            height: 450px;

        }

        .suggested-item:hover {
            box-shadow: 0 8px 16px #333333;
            transform: translateY(-6px);
        }

        .suggested-item img {
            width: 100%;
            height: 220px;
            object-fit: cover;
            border-radius: 15px;
            margin-bottom: 15px;
            transition: transform 0.3s ease;
        }

        .suggested-item .name {
            color: black;
            font-size: 18px;
            margin-bottom: 10px;
            font-weight: bold;
            text-align: center;
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

        .suggested-item .price {
            color: #dc2626;
            font-weight: bold;
            font-size: 16px;
            margin-bottom: 15px;
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

        /* ========== TOAST THÔNG BÁO ========== */
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
<main class="product-detail">
    <div class="product-container">

        <!-- ========== HÌNH ẢNH ========== -->
        <div class="product-image">
            <img id="main-image" src="img/aox.webp" alt="Áo polo in hình khủng long">
            <div class="image-thumbs">
                <img class="thumb active" src="img/aox.webp" data-color="xanh" alt="Xanh lá">
                <img class="thumb" src="img/do.webp" data-color="do" alt="Đỏ">
                <img class="thumb" src="img/den.webp" data-color="den" alt="Đen">
                <img class="thumb" src="img/xanhnhat.webp" data-color="xanhnhat" alt="Xanh nhạt">
                <img class="thumb" src="img/trang.webp" data-color="trang" alt="Trắng">
            </div>
        </div>

        <!-- ========== THÔNG TIN CHUNG ========== -->
        <div class="product-info">
            <h1 class="product-name">Áo polo in hình khủng long SunnyBear</h1>
            <p class="product-price">Giá: <span>150.000₫</span></p>
            <div class="product-rating">⭐⭐⭐⭐☆ (128 đánh giá)</div>

            <!-- CHỌN MÀU -->
            <div class="product-colors">
                <p><strong>Màu sắc:</strong></p>
                <div class="color-options">
                    <img class="color-thumb" data-image="img/aox.webp" src="img/green.webp" alt="xanh">
                    <img class="color-thumb" data-image="img/do.webp" src="img/red.webp" alt="do">
                    <img class="color-thumb" data-image="img/den.webp" src="img/black.webp" alt="den">
                    <img class="color-thumb" data-image="img/xanhnhat.webp" src="img/xn.jpg" alt="xanhnhat">
                    <img class="color-thumb" data-image="img/trang.webp" src="img/t.jpg" alt="trang">

                </div>
            </div>

            <!-- CHỌN SIZE -->
            <div class="product-sizes">
                <p><strong>Chọn size theo cân nặng:</strong></p>
                <div class="size-options">
                    <button class="size-btn">10-15kg</button>
                    <button class="size-btn">16-20kg</button>
                    <button class="size-btn">21-25kg</button>
                    <button class="size-btn">26-30kg</button>
                </div>
            </div>

            <!-- SỐ LƯỢNG -->
            <div class="product-quantity">
                <p><strong>Số lượng:</strong></p>
                <div class="quantity-control">
                    <button class="btn-decrease">−</button>
                    <input type="number" id="quantity" min="1" value="1">
                    <button class="btn-increase">+</button>
                </div>
            </div>

            <!-- NÚT MUA -->
            <div class="product-actions">
                <a href="thanhtoan.html" class="link-cover"><button class="btn-buy-now">Mua ngay</button></a>
                <button class="btn-add-cart">Thêm vào giỏ hàng</button>
            </div>
        </div>
    </div>

    <!-- ========== MÔ TẢ + THÔNG TIN ========== -->
    <section class="product-description">
        <h2>MÔ TẢ SẢN PHẨM</h2>
        <p>
            Áo polo trẻ em SunnyBear được làm từ chất liệu <strong>cotton 100%</strong> mềm mịn, thấm hút mồ hôi tốt,
            giúp bé luôn thoải mái trong mọi hoạt động. Thiết kế <strong>in hình khủng long dễ thương</strong>
            mang lại phong cách năng động, đáng yêu cho các bé trai.
        </p>

        <ul>
            <li>Chất liệu: Cotton co giãn 4 chiều, thoáng mát.</li>
            <li>Kiểu dáng: Áo polo cổ bẻ, tay ngắn.</li>
            <li>Màu sắc: Xanh lá, đỏ, trắng, đen, xanh nhạt.</li>
            <li>Size: Phù hợp cho bé từ 10kg – 35kg.</li>
            <li>Xuất xứ: Việt Nam.</li>
        </ul>

        <p>
            Sản phẩm phù hợp cho bé mặc đi học, đi chơi, hoặc trong các buổi dã ngoại cuối tuần.
            Với đường may tỉ mỉ và chất liệu cao cấp, áo đảm bảo <strong>độ bền cao</strong> sau nhiều lần giặt.
        </p>

        <p><em>Hướng dẫn bảo quản:</em></p>
        <ul>
            <li>Giặt ở nhiệt độ dưới 40°C.</li>
            <li>Không dùng thuốc tẩy mạnh.</li>
            <li>Ủi ở nhiệt độ thấp, tránh in hình.</li>
        </ul>
    </section>

    <!-- ========== ĐÁNH GIÁ ========== -->
    <section class="product-review">
        <h2>Đánh giá sản phẩm</h2>

        <div class="star-select">
            <span class="star" data-value="1">★</span>
            <span class="star" data-value="2">★</span>
            <span class="star" data-value="3">★</span>
            <span class="star" data-value="4">★</span>
            <span class="star" data-value="5">★</span>
        </div>

        <textarea id="review-text" placeholder="Nhập nhận xét của bạn..."></textarea>
        <button id="submit-review">Gửi đánh giá</button>

        <div class="review-list">
            <h3>Nhận xét gần đây</h3>
            <div class="review-item"><strong>Phương Linh:</strong> ⭐⭐⭐⭐⭐ Áo mềm mịn, bé mặc rất thích 💚</div>
            <div class="review-item"><strong>Minh Khang:</strong> ⭐⭐⭐⭐ Màu đẹp, form vừa vặn, giao hàng nhanh.</div>
        </div>
    </section>

    <!-- ========== GỢI Ý SẢN PHẨM ========== -->
    <section class="suggested-products">
        <h2>Sản phẩm phù hợp khác</h2>
        <div class="suggested-list">
            <div class="suggested-item">
                <img src="../img/somi.png" alt="Áo sơ mi bé trai">
                <p class="name">Áo sơ mi bé trai</p>
                <p class="price">175.000₫</p>
                <button class="btn-add">Thêm vào giỏ</button>
            </div>
            <div class="suggested-item">
                <img src="../img/aobalogame.jpg" alt="Áo ba lỗ hình Game Play">
                <p class="name">Áo ba lỗ hình Game Play</p>
                <p class="price">96.000₫</p>
                <button class="btn-add">Thêm vào giỏ</button>
            </div>
            <div class="suggested-item">
                <img src="../img/satvqs.jpg" alt="Set Áo Thun & Quần Short">
                <p class="name">Áo Thun & Quần Short</p>
                <p class="price">259.749₫</p>
                <button class="btn-add">Thêm vào giỏ</button>
            </div>
            <div class="suggested-item">
                <img src="../img/aoghile.jpg" alt="Áo ghile phối đồ vest">
                <p class="name">Áo ghile phối đồ vest</p>
                <p class="price">259.749₫</p>
                <button class="btn-add">Thêm vào giỏ</button>
            </div>
        </div>
        <a href="listqabt.html" class="btn-view-more">Xem thêm</a>
    </section>
</main>

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

<!-- Toast thông báo thêm giỏ hàng -->
<div id="toast"></div>

</body>
<script src="javaScript/pageatxl.js"></script>
<script src="javaScript/header.js"></script>
<script src="javaScript/thongBao.js"></script>
<script src="javaScript/search.js"></script>
<script src="javaScript/themvaogiohang.js"></script>
</html>

