<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="./css/user.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">


</head>
<body>
<div class="user">
    <aside class="sidebar">
        <img src="./img/gau.jpg" alt=""Logo>
        <p>ADMIN</p>

        <div class="nav">
            <a href="dashboard" class="nav-item active">Dashboard</a>
            <a href="sanpham.jsp" class="nav-item">Sản phẩm</a>
            <a href="order-admin" class="nav-item">Đơn hàng</a>
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
            <h1 id="pageTitle">Dashboard</h1>
            <div class="actions">
                <button id="logout">Đăng xuất</button>
            </div>
        </header>



        <main id="page">
            <!-- DASHBROAD -->
            <section id="dashboard" class="page active">
                <div class="cards">
                    <div class="card">
                        Tổng đơn hàng
                        <span>${totalOrders}</span>
                    </div>

                    <div class="card">
                        Doanh thu
                        <span>
                            <fmt:formatNumber value="${totalRevenue}"/>đ
                        </span>
                    </div>

                    <div class="card">
                        Sản phẩm
                        <span>${totalProducts}</span>
                    </div>

                    <div class="card">
                        Người dùng
                        <span>${totalUsers}</span>
                    </div>
                </div>

                <h2 style="margin-bottom: 12px;">Đơn hàng mới nhất</h2>

                <div class="user-table-wrapper">
                    <table class="order-table">
                        <tr>
                            <th>Mã</th>
                            <th>Người nhận</th>
                            <th>Tổng tiền</th>
                            <th>Trạng thái</th>
                        </tr>

                        <c:forEach items="${latestOrders}" var="o">
                            <tr>
                                <td>#${o.id}</td>
                                <td>${o.receiverName}</td>
                                <td>
                                    <fmt:formatNumber value="${o.totalPrice}"/>đ
                                </td>
                                <td>
                    <span class="order-status ${o.orderStatus}">
                            ${o.orderStatus}
                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>

            </section>

        </main>
    </section>
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
