<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>


<%
    request.setAttribute("pageCss", "style.css");
    request.setAttribute("pageTitle" , "Trang chủ");
%>

<%@include file="header.jsp"%>


<!-- ========== BANNER ========== -->
<section class="banner">

    <div class="slider">
        <div class="img-slides">
            <c:forEach var="b" items="${banners}">
                <div class="slide">
                    <a href="${b.navigateTo}">
                        <img src="${b.imageUrl}" alt="${b.title}">
                    </a>
                </div>
            </c:forEach>


        </div>
        <button class="prev">&#10094;</button>
        <button class="next">&#10095;</button>
    </div>

    <!-- <div class="banner-text">
      <button class="btn-primary">Mua ngay</button>
      </div> -->
</section>

<!-- ========== SẢN PHẨM ========== -->
<section class="products">
    <h2>Sản phẩm mới nhất</h2>
    <div class="product-list">
        <c:forEach var="p" items="${latestProducts}">
            <div class="product-card">
                <a href="${pageContext.request.contextPath}/chi-tiet-san-pham?id=${p.id}" class="link-cover"></a>
                <img src="${pageContext.request.contextPath}/${p.thumbnail}" alt="${p.name}">
                <h3>${p.name}</h3>

                <p class="price">
                        <span class="new-price">
                            <fmt:formatNumber value="${p.sale_price}" type="number"/>đ
                        </span>
                    <span class="old-price">
                            <fmt:formatNumber value="${p.price}" type="number"/>đ
                        </span>
                </p>

                <button class="btn-add">Thêm vào giỏ</button>
            </div>
        </c:forEach>
    </div>
</section>


<!-- ========== DANH MỤC ========== -->
<section class="categories">
    <h2>Danh mục nổi bật</h2>
    <!-- Bé trai -->
    <div class="category-block">
        <div class="category-title">Bé trai 👕</div>

        <div class="category-products">
            <c:forEach var="p" items="${boyProducts}">
                <div class="product-mini">
                    <a href="${pageContext.request.contextPath}/chi-tiet-san-pham?id=${p.id}" class="link-cover"></a>
                    <img src="${pageContext.request.contextPath}/${p.thumbnail}" alt="${p.name}">
                    <p>${p.name}</p>

                    <p class="price">
                        <span class="new-price">
                            <fmt:formatNumber value="${p.sale_price}" type="number"/>đ
                        </span>
                        <span class="old-price">
                            <fmt:formatNumber value="${p.price}" type="number"/>đ
                        </span>
                    </p>

                    <button class="btn-add">Thêm vào giỏ</button>
                </div>
            </c:forEach>
        </div>

        <div class="load-more">
            <a href="san-pham">Xem thêm</a>
        </div>
    </div>


    <!-- Bé gái -->
    <div class="category-block">
        <div class="category-title">Bé gái 👗</div>

        <div class="category-products">
            <c:forEach var="p" items="${girlProducts}">
                <div class="product-mini">
                    <a href="${pageContext.request.contextPath}/chi-tiet-san-pham?id=${p.id}" class="link-cover"></a>
                    <img src="${pageContext.request.contextPath}/${p.thumbnail}" alt="${p.name}">
                    <p>${p.name}</p>

                    <p class="price">
                        <span class="new-price">
                            <fmt:formatNumber value="${p.sale_price}" type="number"/>đ
                        </span>
                        <span class="old-price">
                            <fmt:formatNumber value="${p.price}" type="number"/>đ
                        </span>
                    </p>

                    <button class="btn-add">Thêm vào giỏ</button>
                </div>
            </c:forEach>
        </div>

        <div class="load-more">
            <a href="san-pham">Xem thêm</a>
        </div>
    </div>


    <!-- Phụ kiện -->
    <div class="category-block">
        <div class="category-title">Phụ kiện 🎒</div>

        <div class="category-products">
            <c:forEach var="p" items="${accessoryProducts}">
                <div class="product-mini">
                    <a href="${pageContext.request.contextPath}/chi-tiet-san-pham?id=${p.id}" class="link-cover"></a>
                    <img src="${pageContext.request.contextPath}/${p.thumbnail}" alt="${p.name}">
                    <p>${p.name}</p>

                    <p class="price">
                        <span class="new-price">
                            <fmt:formatNumber value="${p.sale_price}" type="number"/>đ
                        </span>
                        <span class="old-price">
                            <fmt:formatNumber value="${p.price}" type="number"/>đ
                        </span>
                    </p>

                    <button class="btn-add">Thêm vào giỏ</button>
                </div>
            </c:forEach>
        </div>

        <div class="load-more">
            <a href="san-pham">Xem thêm</a>
        </div>
    </div>



    <!-- ========== Khi nhấn thêm vào giỏ hàng-->
    <div id="toast"></div>
</section>


<%@include file="footer.jsp"%>



