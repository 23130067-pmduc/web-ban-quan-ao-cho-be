<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%@ page import="vn.edu.nlu.fit.shopquanao.Service.ProductService" %>
<%@ page import="vn.edu.nlu.fit.shopquanao.Service.CategoryService" %>
<%@ page import="vn.edu.nlu.fit.shopquanao.model.Product" %>
<%@ page import="vn.edu.nlu.fit.shopquanao.model.Category" %>
<%@ page import="java.util.List" %>

<%
    // Lấy tham số category từ URL (nếu có)
    String categoryParam = request.getParameter("category");
    Integer categoryId = null;
    if (categoryParam != null && !categoryParam.isEmpty()) {
        try {
            categoryId = Integer.parseInt(categoryParam);
        } catch (NumberFormatException e) {
            // Ignore invalid category
        }
    }
    
    // Lấy dữ liệu sản phẩm từ database
    try {
        ProductService productService = new ProductService();
        CategoryService categoryService = new CategoryService();
        
        // Lấy danh sách danh mục
        List<Category> categories = categoryService.getAllCategories();
        request.setAttribute("categories", categories);
        
        // Lấy danh sách sản phẩm (theo category nếu có, ngược lại lấy tất cả)
        List<Product> list;
        if (categoryId != null) {
            list = productService.getProductsByCategory(categoryId);
            Category selectedCategory = categoryService.getCategoryById(categoryId);
            request.setAttribute("selectedCategory", selectedCategory);
        } else {
            list = productService.getAllProducts();
        }
        request.setAttribute("list", list);
        
        // Debug log CHI TIẾT
        System.out.println("========================================");
        System.out.println("=== SANPHAM.JSP DEBUG ===");
        System.out.println("Thời gian: " + new java.util.Date());
        System.out.println("Category ID: " + (categoryId != null ? categoryId : "Tất cả"));
        System.out.println("Số danh mục: " + (categories != null ? categories.size() : "NULL"));
        System.out.println("Số sản phẩm lấy được: " + (list != null ? list.size() : "NULL"));
        
        if (list != null && !list.isEmpty()) {
            System.out.println("\n5 sản phẩm đầu tiên:");
            for (int i = 0; i < Math.min(5, list.size()); i++) {
                Product p = list.get(i);
                System.out.println("  " + (i+1) + ". [ID:" + p.getId() + "] " + p.getName() 
                    + " - Giá: " + p.getPrice() + " - Status: " + p.getStatus());
            }
        } else {
            System.out.println("⚠️ CẢNH BÁO: Danh sách sản phẩm RỖNG!");
        }
        System.out.println("========================================");
        
    } catch (Exception e) {
        System.err.println("❌ LỖI KHI LẤY SẢN PHẨM:");
        e.printStackTrace();
        request.setAttribute("list", new java.util.ArrayList<Product>());
        request.setAttribute("categories", new java.util.ArrayList<Category>());
        request.setAttribute("error", e.getMessage());
    }
%>

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


<!-- ========== DANH SÁCH SẢN PHẨM ========== -->
<section class="products">
    <h2>SẢN PHẨM
        <c:if test="${not empty selectedCategory}">
            - ${selectedCategory.name}
        </c:if>
    </h2>
    
    <!-- Thanh lọc sản phẩm -->
    <div class="filter-bar">
        <!-- Danh mục sản phẩm -->
        <div class="filter-category">
            <a href="sanpham.jsp">
                <button class="${empty param.category ? 'active' : ''}">Tất cả</button>
            </a>
            <c:forEach var="cat" items="${categories}">
                <a href="sanpham.jsp?category=${cat.id}">
                    <button class="${param.category eq cat.id ? 'active' : ''}">${cat.name}</button>
                </a>
            </c:forEach>
        </div>
    </div>

    <div class="product-list">
        <%-- Debug: Kiểm tra list có tồn tại không --%>
        <% 
            System.out.println(">>> TRƯỚC FOREACH: list = " + request.getAttribute("list")); 
            Object listObj = request.getAttribute("list");
            if (listObj != null) {
                System.out.println(">>> Kiểu dữ liệu: " + listObj.getClass().getName());
                if (listObj instanceof java.util.List) {
                    System.out.println(">>> Kích thước list: " + ((java.util.List)listObj).size());
                }
            }
        %>

        <c:forEach var="p" items="${list}" >


        <div class="product-card">
            <a href="pageatxl.jsp" class="link-cover">
                <img src="${p.thumbnail}" alt="${p.name}">
            </a>
            <h3><a href="pageatxl.jsp">${p.name}</a></h3>
            <p><a href="pageatxl.jsp">${p.description}</a></p>
            
            <fmt:setLocale value="vi_VN"/>
            <span><a href="pageatxl.jsp">
                <fmt:formatNumber value="${p.price}" pattern="#,###" groupingUsed="true"/>đ
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