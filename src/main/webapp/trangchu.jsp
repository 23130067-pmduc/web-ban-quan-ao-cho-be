<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shop quần áo trẻ em SunnyBear Kids</title>
    <link rel="stylesheet" href="./css/style.css">
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
                <li ><a href="sanpham.jsp">Sản phẩm ▾</a>
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

  <!-- ========== BANNER ========== -->
  <section class="banner">
    <div class="slider">
        <div class="img-slides">

            <div class="slide">
                <a href="sanpham.jsp">
                    <img src="./img/banner1.png" alt="Slide 1">
                </a> 
            </div>

            <div class="slide">
                <a href="sanpham.jsp">
                    <img src="./img/ab.png" alt="Banner - Tên website">
                </a> 
            </div>

            <div class="slide">
                <a href="sanpham.jsp">
                    <img src="./img/dodep1.png" alt="Slide 2">
                </a> 
            </div>

            <div class="slide">
                <a href="sanpham.jsp">
                    <img src="./img/ban.png" alt="Slide 3">
                </a> 
            </div>

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
                  <img src="${pageContext.request.contextPath}/${p.thumbnail}"
                       alt="${p.name}">
                  <a href="product-detail?id=${p.id}" class="link-cover"></a>
                  <h3>${p.name}</h3>

                  <p>
                      Giá:
                      <span class="old-price">
                    <fmt:formatNumber value="${p.price}" type="number"/>đ
                </span>
                      <span class="new-price">
                    <fmt:formatNumber value="${p.sale_price}" type="number"/>đ
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
      <div class="category-products">
          <c:forEach var="p" items="${boyProducts}">
              <div class="product-mini">
                  <a href="product-detail?id=${p.id}" class="link-cover"></a>
                  <img src="${pageContext.request.contextPath}/${p.thumbnail}"
                       alt="${p.name}">
                  <p>${p.name}</p>
                  <p class="price">
                <span class="old-price">
                    <fmt:formatNumber value="${p.price}" type="number"/>đ
                </span>
                      <span class="new-price">
                    <fmt:formatNumber value="${p.sale_price}" type="number"/>đ
                </span>
                  </p>
                  <button class="btn-add">Thêm vào giỏ</button>
              </div>
          </c:forEach>
      </div>

      <!-- Bé gái -->
      <div class="category-products">
          <c:forEach var="p" items="${girlProducts}">
              <div class="product-mini">
                  <a href="product-detail?id=${p.id}" class="link-cover"></a>

                  <img src="${pageContext.request.contextPath}/${p.thumbnail}"
                       alt="${p.name}">

                  <p>${p.name}</p>

                  <p class="price">
                <span class="old-price">
                    <fmt:formatNumber value="${p.price}" type="number"/>đ
                </span>
                      <span class="new-price">
                    <fmt:formatNumber value="${p.sale_price}" type="number"/>đ
                </span>
                  </p>

                  <button class="btn-add">Thêm vào giỏ</button>
              </div>
          </c:forEach>
      </div>


      <!-- Phụ kiện -->
      <div class="category-products">
          <c:forEach var="p" items="${girlProducts}">
              <div class="product-mini">
                  <a href="product-detail?id=${p.id}" class="link-cover"></a>

                  <img src="${pageContext.request.contextPath}/${p.thumbnail}"
                       alt="${p.name}">

                  <p>${p.name}</p>

                  <p class="price">
                <span class="old-price">
                    <fmt:formatNumber value="${p.price}" type="number"/>đ
                </span>
                      <span class="new-price">
                    <fmt:formatNumber value="${p.sale_price}" type="number"/>đ
                </span>
                  </p>

                  <button class="btn-add">Thêm vào giỏ</button>
              </div>
          </c:forEach>
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
            <a href="trangchu.jsp">Trang chủ</a>
            <a href="sanpham.jsp">Sản Phẩm</a>
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
               <a href="#."><img src="./img/zalo.webp" alt="Zalo"></a>
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
<script src="./javaScript/header.js"></script>
<script src="./javaScript/slider.js"></script>
<script src="./javaScript/thongBao.js"></script>
<script src="./javaScript/search.js"></script>
<script src="./javaScript/themvaogiohang.js"></script>
</html>