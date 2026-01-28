<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Banner</title>
    <link rel="stylesheet" href="./css/banner.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
</head>
<body>
<div class="user">
    <aside class="sidebar">
        <img src="./img/gau.jpg" alt=""Logo>
        <p>ADMIN</p>

        <div class="nav" id="menu">
            <div class="nav" id="menu">
                <a href="dashboard" class="nav-item">Dashboard</a>
                <a href="sanpham.jsp" class="nav-item">Sản phẩm</a>
                <a href="order-admin" class="nav-item active">Đơn hàng</a>
                <a href="user-admin" class="nav-item">Người dùng</a>
                <a href="magiamgia" class="nav-item">Mã giãm giá</a>
                <a href="banner-admin" class="nav-item">Banner</a>
                <a href="news-admin" class="nav-item">Tin tức</a>
                <a href="contact-admin" class="nav-item">Liên hệ</a>
                <a href="settings.jsp" class="nav-item">Cài đặt</a>
            </div>
    </aside>

    <section class="content">
        <!-- PHẦN HEADER -->
        <header class="topbar">
            <h1 id="pageTitle">Banner</h1>
            <div class="actions">
                <button id="logout">Đăng xuất</button>
            </div>
        </header>



        <main id="page">
            <!-- DASHBROAD -->
            <section id="dashboard" class="page active">
                <div class="cards">
                    <div class="card">Tổng banner<br><span id="dashboard-total-banner">${total}</span></div>
                    <div class="card">Đang hoạt động<br><span id="dashboard-total-banner-active">${totalActive}</span></div>
                </div>

                <div class="banner-toolbar">
                    <a href="banner-admin?mode=add" class="btn-add">
                        <i class="fa fa-plus"></i> Thêm banner
                    </a>
                </div>


                <div class="banner-table-wrapper">
                    <!-- TABLE USER -->
                    <table class="banner-table">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Ảnh</th>
                            <th>Liên kết đến</th>
                            <th>Tiêu đề</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>
                        <tbody id="bannerTableBody">
                        <!-- demo data -->
                        <c:forEach items="${banners}" var="b">
                            <tr>
                                <td>${b.id}</td>
                                <td><img src="${b.imageUrl}" alt="" class="banner-thumb"></td>
                                <td>${b.navigateTo}</td>
                                <td>${b.title}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${b.status}">
                                            <span class="status active">Hoạt động</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status blocked">Bị khóa</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="actions">
                                    <a href="banner-admin?mode=edit&id=${b.id}"
                                       class="icon-btn edit" title="Chỉnh sửa">
                                        <i class="fa fa-pen"></i>
                                    </a>

                                    <c:if test="${b.status}">
                                        <button type="button"
                                                class="icon-btn delete"
                                                title="Tắt banner"
                                                onclick="openConfirmModal(${b.id})">
                                            <i class="fa fa-trash"></i>
                                        </button>
                                    </c:if>
                                </td>

                            </tr>
                        </c:forEach>

                        </tbody>
                    </table>
                </div>
            </section>
        </main>
    </section>
    <!-- MODAL CONFIRM -->
    <div id="confirmModal" class="modal-overlay">
        <div class="modal">
            <h3>Xác nhận</h3>
            <p>Bạn có chắc muốn <b>tắt banner</b> này không?</p>

            <form id="confirmForm" method="post" action="banner-admin">
                <input type="hidden" name="action" value="block">
                <input type="hidden" name="id" id="confirmUserId">

                <div class="modal-actions">
                    <button type="button" class="btn-secondary" onclick="closeModal()">Hủy</button>
                    <button type="submit" class="btn-danger">Tắt</button>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
<script>
    function openConfirmModal(userId) {
        document.getElementById("confirmUserId").value = userId;
        document.getElementById("confirmModal").style.display = "flex";
    }

    function closeModal() {
        document.getElementById("confirmModal").style.display = "none";
    }
</script>
</html>