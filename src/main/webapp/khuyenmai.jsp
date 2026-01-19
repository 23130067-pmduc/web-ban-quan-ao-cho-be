<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Khuyến mãi</title>

    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/khuyenmai.css">

    <!-- ICON -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
</head>
<body>

<!-- HEADER -->
<%@ include file="/header.jsp" %>

<!-- TITLE -->
<div class="title">
    <span>KHUYẾN MÃI</span>
</div>

<!-- HERO -->
<section class="hero-banner">
    <div class="hero-content">
        <h1>
            <i class="fas fa-fire"></i>
            KHUYẾN MÃI ĐẶC BIỆT
        </h1>
        <p>Giảm giá lên đến 50% - Thời trang trẻ em chất lượng cao</p>
        <a href="${pageContext.request.contextPath}/san-pham" class="btn-hero">Mua ngay</a>
    </div>
</section>

<!-- FLASH SALE -->
<section class="flash-sale">
    <div class="flash-header">
        <h2>
            <i class="fas fa-fire"></i>
            FLASH SALE - SỐC HÔM NAY
        </h2>
    </div>

    <div class="flash-products">
        <c:forEach items="${flashSaleProducts}" var="p">
            <div class="product-card">
                <span class="badge flash">
                    SALE -${p.discountPercent}%
                </span>

                <img src="${p.thumbnail}" alt="${p.name}">
                <h3>${p.name}</h3>

                <p class="price">
                    <span class="new-price">${p.sale_price}đ</span>
                    <span class="old-price">${p.price}đ</span>
                </p>

                <button class="btn-add">Thêm vào giỏ</button>
            </div>
        </c:forEach>
    </div>
</section>

<!-- ALL DISCOUNT PRODUCTS -->
<section class="products">
    <h2>TẤT CẢ SẢN PHẨM GIẢM GIÁ</h2>

    <div class="product-grid">
        <c:forEach items="${discountProducts}" var="p">
            <div class="product-card">
                <span class="badge flash">
                    SALE -${p.discountPercent}%
                </span>

                <img src="${p.thumbnail}" alt="${p.name}">
                <h3>${p.name}</h3>

                <p class="price">
                    <span class="new-price">${p.sale_price}đ</span>
                    <span class="old-price">${p.price}đ</span>
                </p>

                <button class="btn-add">Thêm vào giỏ</button>
            </div>
        </c:forEach>
    </div>
</section>

<!-- FOOTER -->
<%@ include file="/footer.jsp" %>

<!-- JS -->
<script src="${pageContext.request.contextPath}/javaScript/khuyenmai.js"></script>
<script src="${pageContext.request.contextPath}/javaScript/thongBao.js"></script>
<script src="${pageContext.request.contextPath}/javaScript/search.js"></script>
<script src="${pageContext.request.contextPath}/javaScript/themvaogiohang.js"></script>

</body>
</html>
