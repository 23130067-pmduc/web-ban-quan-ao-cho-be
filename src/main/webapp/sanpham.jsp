<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sản phẩm</title>
    <link rel="stylesheet" href="./css/sanpham.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">

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
                <li><a href="trangchu.jsp">Trang chủ</a></li>
                <li ><a href="san-pham">Sản phẩm</a>

                    <ul class="sub">
                        <li class="subItem"> <a href="san-pham?group=betrai">Quần áo bé trai</a> </li>
                        <li class="subItem"> <a href="san-pham?group=begai">Quần áo bé gái</a> </li>
                        <li class="subItem"> <a href="san-pham?group=phukien">Phụ kiện</a> </li>
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
                    <li><a href="login.jsp">Đăng nhập</a></li>
                    <li><a href="register.jsp">Đăng ký</a></li>
                </ul>
            </div>
            <a href="giohang.jsp" class="iconCart"><i class="fa-solid fa-cart-shopping"></i></a>
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


<!-- ========== DANH SÁCH SẢN PHẨM ========== -->
<section class="products">
    <h2>SẢN PHẨM</h2>
    
    <!-- Thanh lọc sản phẩm -->

    <div class="filter-bar">

        <!-- ===== PHẦN TRÊN: SORT ===== -->
        <div class="filter-sort">
            <div class="sort-buttons">

                <a href="san-pham?group=${param.group}&category=${param.category}&sort=new">
                    <button class="${param.sort eq 'new' || empty param.sort ? 'active' : ''}">
                        Mới nhất
                    </button>
                </a>

                <a href="san-pham?group=${param.group}&category=${param.category}&sort=best">
                    <button class="${param.sort eq 'best' ? 'active' : ''}">
                        Bán chạy
                    </button>
                </a>

                <a href="san-pham?group=${param.group}&category=${param.category}&sort=sale">
                    <button class="${param.sort eq 'sale' ? 'active' : ''}">
                        Khuyến mãi
                    </button>
                </a>

                <!-- Dropdown: GIÁ -->
                <div class="dropdown">
                    <button class="dropbtn
                        ${param.sort eq 'price_asc' || param.sort eq 'price_desc' ? 'active' : ''}">
                        Giá <i class="fa-solid fa-caret-down"></i>
                    </button>
                    <div class="dropdown-content">
                        <a class="${param.sort eq 'price_asc' ? 'active' : ''}"
                           href="san-pham?group=${param.group}&category=${param.category}&sort=price_asc">
                            Giá thấp đến cao
                        </a>

                        <a class="${param.sort eq 'price_desc' ? 'active' : ''}"
                           href="san-pham?group=${param.group}&category=${param.category}&sort=price_desc">
                            Giá cao đến thấp
                        </a>
                    </div>

                </div>

            </div>
        </div>

        <div class="filter-category">

            <!-- ===== TẤT CẢ ===== -->
            <a href="san-pham?sort=${param.sort}">
                <button class="${empty param.group && empty param.category ? 'active' : ''}">
                    Tất cả
                </button>
            </a>

            <!-- ===== BÉ TRAI ===== -->
            <div class="dropdown">
                <button class="dropbtn ${param.group eq 'betrai' ? 'active' : ''}">
                    Bé trai <i class="fa-solid fa-caret-down"></i>
                </button>
                <div class="dropdown-content">
                    <a class="${param.group eq 'betrai' && param.category eq '1' ? 'active' : ''}"
                       href="san-pham?group=betrai&category=1&sort=${param.sort}">
                        Áo
                    </a>
                    <a class="${param.group eq 'betrai' && param.category eq '2' ? 'active' : ''}"
                       href="san-pham?group=betrai&category=2&sort=${param.sort}">
                        Quần
                    </a>
                    <a class="${param.group eq 'betrai' && param.category eq '3' ? 'active' : ''}"
                       href="san-pham?group=betrai&category=3&sort=${param.sort}">
                        Đồ bộ
                    </a>
                    <a class="${param.group eq 'betrai' && param.category eq '9' ? 'active' : ''}"
                       href="san-pham?group=betrai&category=9&sort=${param.sort}">
                        Giày dép
                    </a>
                </div>
            </div>

            <!-- ===== BÉ GÁI ===== -->
            <div class="dropdown">
                <button class="dropbtn ${param.group eq 'begai' ? 'active' : ''}">
                    Bé gái <i class="fa-solid fa-caret-down"></i>
                </button>
                <div class="dropdown-content">
                    <a class="${param.group eq 'begai' && param.category eq '1' ? 'active' : ''}"
                       href="san-pham?group=begai&category=1&sort=${param.sort}">
                        Áo
                    </a>
                    <a class="${param.group eq 'begai' && param.category eq '2' ? 'active' : ''}"
                       href="san-pham?group=begai&category=2&sort=${param.sort}">
                        Quần
                    </a>
                    <a class="${param.group eq 'begai' && param.category eq '6' ? 'active' : ''}"
                       href="san-pham?group=begai&category=6&sort=${param.sort}">
                        Váy / Đầm
                    </a>
                    <a class="${param.group eq 'begai' && param.category eq '3' ? 'active' : ''}"
                       href="san-pham?group=begai&category=3&sort=${param.sort}">
                        Đồ bộ
                    </a>
                    <a class="${param.group eq 'begai' && param.category eq '9' ? 'active' : ''}"
                       href="san-pham?group=begai&category=9&sort=${param.sort}">
                        Giày dép
                    </a>
                </div>
            </div>

            <!-- ===== PHỤ KIỆN ===== -->
            <div class="dropdown">
                <button class="dropbtn ${param.group eq 'phukien' ? 'active' : ''}">
                    Phụ kiện <i class="fa-solid fa-caret-down"></i>
                </button>
                <div class="dropdown-content">
                    <a class="${param.group eq 'phukien' && param.category eq '8' ? 'active' : ''}"
                       href="san-pham?group=phukien&category=8&sort=${param.sort}">
                        Phụ kiện thời trang
                    </a>
                    <a class="${param.group eq 'phukien' && param.category eq '10' ? 'active' : ''}"
                       href="san-pham?group=phukien&category=10&sort=${param.sort}">
                        Phụ kiện tiện ích
                    </a>
                </div>
            </div>

        </div>


    </div>






    <div class="product-list">

        <c:forEach var="p" items="${list}" >


        <div class="product-card">
            <a href="pageatxl.jsp" class="link-cover">
                <img src="${p.thumbnail}" alt="${p.name}">
            </a>
            <h3><a href="pageatxl.jsp">${p.name}</a></h3>
            <p><a href="pageatxl.jsp">${p.description}</a></p>
            
            <fmt:setLocale value="vi_VN"/>
            <span><a href="pageatxl.jsp">
                <fmt:formatNumber value="${p.price * 1000}" pattern="#,###" groupingUsed="true"/>đ
            </a></span>
            
            <button class="btn-add">Thêm vào giỏ</button>
        </div>

        </c:forEach>


    </div>
    <div class="load-more-container">
        <button id="load-more">Xem thêm</button>
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
                <p class="fa-phone"> <i class="fa-solid fa-phone"></i> Hotline: 0909 999 999</p>
                <p class="fa-mail"> <i class="fa-solid fa-envelope"></i> Email: contact@sunnybear.vn</p>
            </div>
        </section>
        <section class="s-footer-2">

            <div class="footer-danhmuc">
                <h3>Danh mục</h3>
                <a href="trangchu.jsp">Trang chủ</a>
                <a href="san-pham">Sản phẩm</a>
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
                    <a href="#"><img src="./img/zalo.webp" alt="Zalo"></a>
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
<script src="./javaScript/pageatxl.js"></script>
<script src="./javaScript/header.js"></script>
<script src="./javaScript/thongBao.js"></script>
<script src="./javaScript/search.js"></script>
<script src="./javaScript/loadMore.js"></script>
<script src="./javaScript/themvaogiohang.js"></script>
</html>