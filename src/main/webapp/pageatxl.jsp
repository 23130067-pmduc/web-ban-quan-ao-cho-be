<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%
    request.setAttribute("pageCss", "pageatxl.css");
    request.setAttribute("pageTitle" , "Chi tiết sản phẩm");
%>

<%@include file="header.jsp"%>


<main class="product-detail">
    <div class="product-container">

        <!-- ========== HÌNH ẢNH ========== -->
        <div class="product-image">
            <img id="main-image" src="./img/aox.webp" alt="Áo polo in hình khủng long">
            <div class="image-thumbs">
                <img class="thumb active" src="./img/aox.webp" data-color="xanh" alt="Xanh lá">
                <img class="thumb" src="./img/do.webp" data-color="do" alt="Đỏ">
                <img class="thumb" src="./img/den.webp" data-color="den" alt="Đen">
                <img class="thumb" src="./img/xanhnhat.webp" data-color="xanhnhat" alt="Xanh nhạt">
                <img class="thumb" src="./img/trang.webp" data-color="trang" alt="Trắng">
            </div>
        </div>

        <!-- ========== THÔNG TIN CHUNG ========== -->
        <div class="product-info">
            <h1 class="product-name">${product.name}</h1>

            <p class="product-price">Giá:
                <span><fmt:formatNumber value="${product.sale_price}" type="number"/>₫</span>
            </p>
            <div class="product-rating">⭐⭐⭐⭐☆ (128 đánh giá)</div>

            <!-- CHỌN MÀU -->
            <div class="product-colors">
                <p><strong>Màu sắc:</strong></p>
                <div class="color-options">
                    <img class="color-thumb" data-image="./img/aox.webp" src="./img/green.webp" alt="xanh">
                    <img class="color-thumb" data-image="./img/do.webp" src="./img/red.webp" alt="do">
                    <img class="color-thumb" data-image="./img/den.webp" src="./img/black.webp" alt="den">
                    <img class="color-thumb" data-image="./img/xanhnhat.webp" src="./img/xn.jpg" alt="xanhnhat">
                    <img class="color-thumb" data-image="./img/trang.webp" src="./img/t.jpg" alt="trang">

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
                <a href="thanhtoan.jsp" class="link-cover"><button class="btn-buy-now">Mua ngay</button></a>
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
        <form action="review" method="post" class="review-form">
            <input type="hidden" name="product_id" value="${product.id}">
            <input type="hidden" name="rating" id="rating-value">

            <div class="star-select">
                <span class="star" data-value="1">★</span>
                <span class="star" data-value="2">★</span>
                <span class="star" data-value="3">★</span>
                <span class="star" data-value="4">★</span>
                <span class="star" data-value="5">★</span>
            </div>

            <textarea id="review-text" name="comment" required placeholder="Nhập nhận xét của bạn..."></textarea>

            <button type="submit" id="submit-review">Gửi đánh giá</button>
        </form>

    </section>

    <!-- ========== GỢI Ý SẢN PHẨM ========== -->
    <section class="suggested-products">
        <h2>Sản phẩm phù hợp khác</h2>
        <div class="suggested-list">
            <div class="suggested-item">
                <img src="./img/somi.png" alt="Áo sơ mi bé trai">
                <p class="name">Áo sơ mi bé trai</p>
                <p class="price">175.000₫</p>
                <button class="btn-add">Thêm vào giỏ</button>
            </div>
            <div class="suggested-item">
                <img src="./img/aobalogame.jpg" alt="Áo ba lỗ hình Game Play">
                <p class="name">Áo ba lỗ hình Game Play</p>
                <p class="price">96.000₫</p>
                <button class="btn-add">Thêm vào giỏ</button>
            </div>
            <div class="suggested-item">
                <img src="./img/satvqs.jpg" alt="Set Áo Thun & Quần Short">
                <p class="name">Áo Thun & Quần Short</p>
                <p class="price">259.749₫</p>
                <button class="btn-add">Thêm vào giỏ</button>
            </div>
            <div class="suggested-item">
                <img src="./img/aoghile.jpg" alt="Áo ghile phối đồ vest">
                <p class="name">Áo ghile phối đồ vest</p>
                <p class="price">259.749₫</p>
                <button class="btn-add">Thêm vào giỏ</button>
            </div>
        </div>
        <a href="listqabt.jsp" class="btn-view-more">Xem thêm</a>
    </section>
</main>


<!-- Toast thông báo thêm giỏ hàng -->
<div id="toast"></div>

<%@include file="footer.jsp"%>