<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn hàng</title>
    <link rel="stylesheet" href="./css/user.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">


</head>
<body>
<div class="user">
    <aside class="sidebar">
        <img src="./img/gau.jpg" alt=""Logo>
        <p>ADMIN</p>

        <div class="nav" id="menu">
            <button data-page="dashboard">DashBoard</button>
            <button data-page="doanhthu">Doanh thu</button>
            <button data-page="sanpham">Sản phẩm</button>
            <button data-page="order-admin" class="active">Đơn hàng</button>
            <button data-page="nguoidung">Người dùng</button>
            <button data-page="magiamgia">Mã giảm giá</button>
            <button data-page="caidat">Cài đặt</button>
        </div>
    </aside>

    <section class="content">
        <!-- PHẦN HEADER -->
        <header class="topbar">
            <h1 id="pageTitle">Đơn hàng</h1>
            <div class="actions">
                <button id="logout">Đăng xuất</button>
            </div>
        </header>



        <main id="page">
            <!-- DASHBROAD -->
            <section id="dashboard" class="page active">
                <div class="cards">
                    <div class="card">Tổng đơn<br>${total}</div>
                    <div class="card">Đang xử lý<br>${countPending}</div>
                    <div class="card">Hoàn thành<br>${countCompleted}</div>
                </div>

                <div class="user-table-wrapper">
                    <table class="order-table">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Khách hàng</th>
                            <th>Tổng tiền</th>
                            <th>Trạng thái</th>
                            <th>Ngày tạo</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:if test="${empty orders}">
                            <tr>
                                <td colspan="6" style="text-align:center">
                                    Chưa có đơn hàng
                                </td>
                            </tr>
                        </c:if>

                        <c:forEach items="${orders}" var="o">
                            <tr>
                                <td>#${o.id}</td>
                                <td>${o.receiverName}</td>
                                <td>${o.finalAmount} đ</td>
                                <td>
                                    <span class="order-status ${o.orderStatus}">
                                            ${o.orderStatus}
                                    </span>
                                </td>

                                <td>
                                        ${o.createdAtFormatted}
                                </td>
                                <td>
                                    <a href="order-admin?mode=view&id=${o.id}" class="icon-btn view">
                                        <i class="fa fa-eye"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
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
