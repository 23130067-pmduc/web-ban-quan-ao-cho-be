<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Khuyến mãi</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/khuyenmai.css">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
</head>
<body>

<%@ include file="/header.jsp" %>

<div class="title">
</div>

<!-- HERO -->
<section class="hero-banner">
    <div class="hero-content">
        <h1><i class="fas fa-fire"></i> KHUYẾN MÃI ĐẶC BIỆT</h1>
        <p>Giảm giá lên đến 50% - Thời trang trẻ em chất lượng cao</p>
        <a href="${pageContext.request.contextPath}/san-pham" class="btn-hero">Mua ngay</a>
    </div>
</section>

<!-- FLASH SALE -->
<section class="flash-sale">
    <div class="flash-header">
        <h2><i class="fas fa-fire"></i> FLASH SALE - SỐC HÔM NAY</h2>
    </div>

    <div class="flash-products">
        <c:forEach items="${flashSaleProducts}" var="p">
            <div class="product-card" data-product-id="${p.id}" data-sale-price="${p.sale_price}">
                <span class="badge flash">SALE -${p.discountPercent}%</span>
                <img src="${p.thumbnail}" alt="${p.name}">
                <h3>${p.name}</h3>
                <p class="price">
                    <span class="new-price"><fmt:formatNumber value="${p.sale_price}" type="number" groupingUsed="true"/>₫</span>
                    <span class="old-price"><fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/>₫</span>
                </p>
                <a href="${pageContext.request.contextPath}/chi-tiet-san-pham?id=${p.id}" class="btn-add">Thêm vào giỏ</a>
            </div>
        </c:forEach>
    </div>
</section>

<!-- TẤT CẢ SẢN PHẨM GIẢM GIÁ -->
<section class="products">
    <h2>TẤT CẢ SẢN PHẨM GIẢM GIÁ</h2>

    <!-- 👇 QUAN TRỌNG: discount-grid -->
    <div class="product-grid discount-grid">
        <c:forEach items="${discountProducts}" var="p">
            <div class="product-card" data-product-id="${p.id}" data-sale-price="${p.sale_price}">
                <span class="badge flash">SALE -${p.discountPercent}%</span>
                <img src="${p.thumbnail}" alt="${p.name}">
                <h3>${p.name}</h3>
                <p class="price">
                    <span class="new-price"><fmt:formatNumber value="${p.sale_price}" type="number" groupingUsed="true"/>₫</span>
                    <span class="old-price"><fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/>₫</span>
                </p>
                <a href="${pageContext.request.contextPath}/chi-tiet-san-pham?id=${p.id}" class="btn-add">Thêm vào giỏ</a>
            </div>
        </c:forEach>
    </div>

    <!-- NÚT XEM THÊM -->
    <div class="load-more-wrapper">
        <button id="load-more" class="btn-load-more">Xem thêm</button>
    </div>
</section>

<%@ include file="/footer.jsp" %>

<!-- Toast thông báo -->
<div id="toast"></div>

<script src="${pageContext.request.contextPath}/javaScript/khuyenmai.js?v=2.0"></script>
<script src="${pageContext.request.contextPath}/javaScript/themvaogiohang.js?v=2.0"></script>

</body>
</html>
